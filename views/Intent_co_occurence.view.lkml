view: intent_co_occurence {
derived_table: {
  sql: select t1.intent_triggered as parent_intent

                     ,t2.intent_triggered as child_intent
                     ,count( distinct t2.session_ID) as frequency from
                    (select * from    qp-qai-training-1-2021-05.looker_training_ambika.dialogflow_cleaned_logs
            where {% condition date_filter %} TIMESTAMP(date) {% endcondition %}) t1
            join  (select * from qp-qai-training-1-2021-05.looker_training_ambika.dialogflow_cleaned_logs
            where {% condition date_filter %} TIMESTAMP(date) {% endcondition %}) t2
            ON          t1.session_ID=t2.session_ID and t1.intent_triggered != t2.intent_triggered
            group by  t1.intent_triggered
                     ,t2.intent_triggered
                      ;;


}


dimension:frequency {
  type: number
  sql: ${TABLE}.frequency ;;
}


dimension: parent_intent {
  type: string
  sql: ${TABLE}.parent_intent ;;
}

  dimension: child_intent {
    type: string
    sql: ${TABLE}.child_intent ;;
  }

  filter: date_filter {
    type: date
  }

  measure:frequency1 {
    type: max
    sql: ${TABLE}.frequency ;;
  }
}
