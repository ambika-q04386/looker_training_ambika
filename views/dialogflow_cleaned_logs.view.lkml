view: dialogflow_cleaned_logs {
  sql_table_name: `looker_training_ambika.dialogflow_cleaned_logs`
    ;;

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

  measure: Handled {
    type: count
    filters: [is_fallback: "No"]
  }
  measure: Success_rate {
    type: number
    sql: ${Handled}/ ${Total_queries} ;;

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

  dimension: Query_sentiment_distribution {
    sql: CASE WHEN ${magnitude} <= 3 and ${sentiment_score} between 0.25 and 1 THEN 'Partially Positive'
               WHEN ${magnitude} <= 3 and ${sentiment_score} between -1 and -0.25 THEN 'Partially Negative'
              WHEN ${magnitude} <= 3 and ${sentiment_score} between -1 and 1 THEN 'Neutral'
              ELSE NULL END;;

  }
  dimension: session_id {
    type: string
    sql: ${TABLE}.session_ID ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.time ;;
  }
  dimension: duration {
    type: number
    sql: timestamp_diff(${TABLE}.max_time_stamp,${TABLE}.min_time_stamp,minute) ;;
  }
  dimension_group: time_stamp {
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
    sql: ${TABLE}.time_stamp ;;
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
}
