class ApplicationController < ActionController::API

  def set_api_cache_key(key)
    headers["X-Api-Cache-Key"] = instance_variable_get("@#{key}").try(:join,"/")
  end

  def collection_cache_key(scope)
    keys = []

    # support array of collection
    unless scope.kind_of? Array
      scope = [scope]
    end

    scope.each do |s|
      table_name = s.class.table_name

      updated_at_keys = begin
        s.pluck(
        "UNIX_TIMESTAMP(MAX(#{table_name}.updated_at)) as max_updated_at,
        UNIX_TIMESTAMP(AVG(#{table_name}.updated_at)) as avg_updated_at,
        UNIX_TIMESTAMP(MIN(#{table_name}.updated_at)) as min_updated_at,
        MAX(#{table_name}.id) as max_id,
        AVG(#{table_name}.id) as avg_id,
        MIN(#{table_name}.id) as min_id,
        COUNT(*) as query_count")
      rescue
        []
      end

      keys << table_name
      keys << updated_at_keys.flatten
    end

    keys
  end

  def cache_key(record)
    [ 
      record.class.table_name,
      record.id,
      record.updated_at.to_i
    ]
  end
end
