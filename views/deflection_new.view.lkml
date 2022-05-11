view: deflection_new {
  sql_table_name: `qp-qai-training-1-2021-05.looker_training_ambika.deflection_new`
    ;;



  dimension: deflection_bucket {
    type: string
    sql: ${TABLE}.deflection_bucket ;;
  }

  dimension: total_sessions {
    type: number
    sql: ${TABLE}.total_sessions ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
