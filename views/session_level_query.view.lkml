view: session_level_query {
  sql_table_name: `qp-qai-training-1-2021-05.looker_training_ambika.session_level_query`
    ;;

  dimension: entry_intent {
    type: string
    sql: ${TABLE}.entry_intent ;;
  }

  dimension: exit_intent {
    type: string
    sql: ${TABLE}.exit_intent ;;
  }

  dimension: language_code {
    type: string
    sql: ${TABLE}.language_code ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: second_last_exit_intent {
    type: string
    sql: ${TABLE}.second_last_exit_intent ;;
  }

  dimension: session_duration {
    type: number
    sql: ${TABLE}.session_duration ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_minutes {
    type: number
    sql: ${TABLE}.session_minutes ;;
  }

  measure: average_Session_duration {
    type: average
    sql:(${session_duration}/86400.0) ;;
    value_format: "[mm]\" m \"ss\" s\""
  }

  dimension_group: session_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_start ;;
  }
  measure: Total_sessions{
    type: count
  }
  measure: count {
    type: count
    drill_fields: []
  }
}
