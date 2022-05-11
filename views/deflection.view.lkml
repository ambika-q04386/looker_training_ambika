view: deflection {
  derived_table: {
    explore_source: dialogflow_cleaned_logs {
      column: session_id {
        field: dialogflow_cleaned_logs.session_id
      }
      column: fallback_count {
        field: dialogflow_cleaned_logs.fallback_count
      }
      column: agent_count {
        field: dialogflow_cleaned_logs.agent_count

      }
      bind_all_filters: yes

    }
  }


dimension: session_id {
  type: string
  primary_key: yes
  sql: ${TABLE}.session_id ;;
}

dimension: fallback_count {
  type: number
  sql: ${TABLE}.fallback_count ;;
}

  dimension: agent_count {
    type: number
    sql: ${TABLE}.agent_count ;;
  }


dimension: deflection {
  type: string
  case: {
    when: {
      sql: ${fallback_count}=0 and ${agent_count}=0 ;;
      label: "Number of sessions that were successfully handled by bot end to end"
    }

    when: {
      sql: ${fallback_count}>0 and ${agent_count}=0 ;;
      label: "Number of sessions that were partially handled by the bot and had atleast one query unanswered but not transferred to live agent"
    }

    when: {
      sql: ${fallback_count}>0 and ${agent_count}>0 ;;
      label: "Number of sessions that were transferred to live agnet and has atleast one fallback query"
    }

    when: {
      sql:  ${fallback_count}=0 and ${agent_count}>0;;
    label: "Number of sessions that were transferred to live agent as per expected flow but had not fallback query"
    }

  }
}

dimension: deflection_rate {
  type: string
  case: {
    when: {
      sql: ${deflection}="Number of sessions successfully handled by bot end to end" or
      ${deflection}="Number of sessions that were successfully handled by bot and had atleast one query unanswered but not transferred to live agent";;
      label: "Fully Deflected"
    }

    when: {
      sql: ${deflection}="Number of sessions that were transferred to live agnet and has atleast one fallback query""Number of sessions that were transferred to live agnet and has atleast one fallback query" ;;
      label: "Partially Deflected"
    }

    when: {
      sql: ${deflection}="Number of sessions that were transferred to live agent as per expected flow but had not fallback query" ;;
      label: "Not Deflected"
    }
  }
}

  measure: total_sessions {
    type: count_distinct
    sql: ${TABLE}.total_sessions ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
