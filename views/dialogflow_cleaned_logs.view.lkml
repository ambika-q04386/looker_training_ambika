view: dialogflow_cleaned_logs {
  sql_table_name: `looker_training_ambika.dialogflow_cleaned_logs` ;;


  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;

  }

  dimension_group: time_stamp {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      hour_of_day,
      year
    ]
    sql: ${TABLE}.time_stamp ;;

  }

  dimension_group: time {
    type: time
    timeframes: [
      raw,
      time
    ]
    sql: TIME_TRUNC(${TABLE}.time, HOUR) ;;
  }

  dimension: time_stamp_new {
    type: date_time
    sql: ${TABLE}.time_stamp ;;
  }

  dimension: time_bucket {
    type: string
    case: {
      when: {
        sql: ${time_stamp_hour_of_day}=0 ;;
        label: "12AM - 01AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=1 ;;
        label: "01AM - 02AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=2 ;;
        label: "02AM - 03AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=3 ;;
        label: "03AM - 04AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=4 ;;
        label: "04AM - 05AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=5 ;;
        label: "05AM - 06AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=6 ;;
        label: "06AM - 07AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=7 ;;
        label: "07AM - 08AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=8 ;;
        label: "08AM - 09AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=9 ;;
        label: "09AM - 10AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=10 ;;
        label: "10AM - 11AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=11 ;;
        label: "11AM - 12AM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=12 ;;
        label: "12AM - 01PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=13 ;;
        label: "01PM - 02PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=14 ;;
        label: "02PM - 03PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=15 ;;
        label: "03PM - 04PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=16 ;;
        label: "04PM - 05PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=17 ;;
        label: "05PM - 06PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=18 ;;
        label: "06PM - 07PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=19 ;;
        label: "07PM - 08PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=20 ;;
        label: "0PM - 09PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=21 ;;
        label: "09PM - 10PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=22 ;;
        label: "10PM - 11PM"
      }

      when: {
        sql: ${time_stamp_hour_of_day}=23 ;;
        label: "11PM - 12PM"
      }


    }
  }

  dimension: hour {
    type: string

  }
  dimension: intent_detection_confidence {
    type: number
    sql: ${TABLE}.intent_detection_confidence ;;
  }

  dimension: intent_triggered {
    type: string
    sql: ${TABLE}.intent_triggered ;;
  }

  dimension: is_fallback {
    type: yesno
    sql: ${TABLE}.isFallback ;;
  }


  dimension: language_code {
    type: string
    sql: ${TABLE}.language_code ;;
  }

  dimension: magnitude {
    type: number
    sql: ${TABLE}.magnitude ;;
  }

  dimension: month_number {
    type: number
    sql: ${TABLE}.month_number ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: query_text {
    type: string
    sql: ${TABLE}.query_text ;;
  }


  dimension: query_text_redacted {
    type: string
    sql: ${TABLE}.query_text_redacted ;;
  }

  dimension: response_id {
    type: string
    sql: ${TABLE}.response_ID ;;
  }

  dimension: sentiment_score {
    type: number
    sql: ${TABLE}.sentiment_score ;;
  }

  measure: average_sentiment_score {
    type: average
    sql: ${TABLE}.sentiment_score ;;
  }





  dimension: Query_sentiment_distribution {
    sql: CASE WHEN ${magnitude} <= 3 and ${sentiment_score} between 0.25 and 1 THEN 'Partially Positive'
               WHEN ${magnitude} <= 3 and ${sentiment_score} between -1 and -0.25 THEN 'Partially Negative'
              WHEN ${magnitude} <= 3 and ${sentiment_score} between -1 and 1 THEN 'Neutral'
              ELSE NULL END;;

  }


  dimension: duration {
    type: number
    sql: timestamp_diff(${TABLE}.max_timestamp,${TABLE}.min_timestamp, second) ;;
  }




  dimension: session_id {
    type: string
    sql: ${TABLE}.session_ID ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.time ;;
  }


  dimension: week_number {
    type: number
    sql: ${TABLE}.week_number ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: Total_queries {
    type: count

  }
  measure: Total_sessions {
    type: count
  }

  measure: Total_sessions_distinct {
    type: count
  }

 measure: distinct_session_id {
   type: count_distinct
  sql: ${TABLE}.distinct_session_id ;;

 }
  measure: distinct_date {
    type: count_distinct
    sql: ${date_raw} ;;
  }
  measure: Avg_sessions_per_day {
    type: number
    sql: COALESCE(${distinct_session_id}/NULLIF(${distinct_date},0),0) ;;
  }

  measure: Handled {
    type: count
    filters: [is_fallback: "No"]
  }

  measure: Success_rate {
    type: number
    sql: ${Handled}/ ${Total_queries} ;;
    value_format_name: percent_2

  }

  measure: agent_count {
    type: sum
    sql: case
    when ${intent_triggered} like "LiveAgentTransfer" then 1
    else 0
    end;;
  }

  measure: fallback_count {
    type: sum
    sql: case
    when ${is_fallback} is true then 1
    else 0
    end;;
  }
}
