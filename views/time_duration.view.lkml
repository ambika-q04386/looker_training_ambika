view: time_duration {
derived_table: {
  explore_source: dialogflow_cleaned_logs {
    column: session_id {
      field: dialogflow_cleaned_logs.session_id
    }
    column: timestamp {
      field: dialogflow_cleaned_logs.time_stamp_new
    }
    derived_column: min_timestamp {
      sql: min(time_stamp) over (partition by session_id) ;;

    }
    derived_column: max_timestamp {
      sql: max(time_stamp) over (patrtition by session_id ) ;;

    }
    bind_all_filters: yes
  }


}

dimension: session_id {
  type: string
  primary_key: yes
  sql: ${TABLE}.session_id ;;
}

dimension: session_duration_sec {
  type: number
  sql: timestamp_diff(${TABLE}.max_timestamp,${TABLE}.min_timestamp,second) ;;
  }

  dimension: session_duration_min {
    type: number
    sql: timestamp_diff(${TABLE}.max_timestamp,${TABLE}.min_timestamp,minute) ;;
  }

  dimension: session_duration_distribution {
    type: string
    sql: case
    when ${session_duration_sec} < 60 then "<1 min"
    when ${session_duration_sec} >=60 and ${session_duration_sec} < 180 then "1-3min"
    when ${session_duration_sec} >=180 and ${session_duration_sec} < 300 then "3-5min"
    when ${session_duration_sec} >=300 and ${session_duration_sec} < 420 then "5-7min"
    Else ">7min"
    End;;
  }
}
