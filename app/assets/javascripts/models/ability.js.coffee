DS.StringArrayTransform = DS.Transform.extend
  deserialize: (serialized)->
    if Ember.typeOf(serialized) == 'array' then serialized else []
  serialize: (deserialized)->
    switch Ember.typeOf(deserialized)
      when 'array'  then deserialized
      when 'string' then deserialized.split(',').map (item) -> $.trim(item)
      else []

CancanEmberRails.register("transform:string_array", DS.StringArrayTransform);

CancanEmberRails.RuleSerializer = DS.ActiveModelSerializer.extend
  normalize: (type, hash)->
    hash.id = "#{hash.can}#{hash.actions}#{hash.subjects}#{hash.conditions}"
    @_super type, hash

CancanEmberRails.Rule = DS.Model.extend
    can:        DS.attr 'boolean'
    actions:    DS.attr 'string_array'
    subjects:   DS.attr 'string_array'
    conditions: DS.attr 'string_array'