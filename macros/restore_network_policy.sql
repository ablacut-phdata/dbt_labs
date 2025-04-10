{% macro turnoff_network_policy(entity_type='account', entity_name=none) %}

    {% if entity_type|lower == 'account' %}
        {% set sql %}
        ALTER ACCOUNT SET NETWORK_POLICY = NULL;
        {% endset %}
    {% elif entity_type|lower == 'user' and entity_name is not none %}
        {% set sql %}
        ALTER USER {{ entity_name }} SET NETWORK_POLICY = NULL;
        {% endset %}
    {% elif entity_type|lower == 'role' and entity_name is not none %}
        {% set sql %}
        ALTER ROLE {{ entity_name }} SET NETWORK_POLICY = NULL;
        {% endset %}
    {% else %}
        {{ exceptions.raise_compiler_error("Invalid parameters. Entity type must be 'account', 'user', or 'role'. For user and role, entity_name must be provided.") }}
    {% endif %}

    {% do run_query(sql) %}
    {{ log("Network policy turned off for " ~ entity_type ~ (": " ~ entity_name if entity_name is not none else ""), info=True) }}

{% endmacro %}