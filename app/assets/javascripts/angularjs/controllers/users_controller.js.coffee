
root = global ? window

UsersIndexCtrl = ($scope, User, $routeParams) ->
  $scope.current_inventory_pool_id = $routeParams.inventory_pool_id

  # TODO reimplement with angular tabs
  $scope.setRole = (r)->
    $scope.role = r
    $(".inlinetabs .tab.active").removeClass "active"
    t = if r == "" then $(".inlinetabs .tab:first") else $(".inlinetabs .tab[value='"+r+"']")
    t.addClass("active")
    $scope.fetch()

  #$scope.$watch 'search', (newValue, oldValue)->
  #  $scope.fetch()

  #$scope.$watch 'role', (newValue, oldValue)->
  #  $scope.fetch()

  $scope.$watch 'suspended', (newValue, oldValue)->
    $scope.fetch()

  $scope.fetch = (nextPage)->
    return if $scope.isLoading
    return if nextPage and $scope.pagination.current_page >= $scope.pagination.total_pages
    $scope.isLoading = true
    params =
      inventory_pool_id:
        $scope.current_inventory_pool_id
      search:
        $scope.search
      role:
        $scope.role
      suspended:
        $scope.suspended
      page:
        if nextPage then nextPage else 1
    # TODO this should be done directly by angular
    for k of params
      delete params[k] if angular.isUndefined(params[k])
    User.get(
      params
      , (response) ->
        if nextPage
          $scope.users = $scope.users.concat response.entries
        else
          $scope.users = response.entries
        $scope.pagination = response.pagination
        $scope.isLoading = false
    )

  $scope.destroy = ->
    dconfirm = confirm("Are you sure?")
    if dconfirm
      original = @user
      @user.destroy ->
        $scope.users = _.without($scope.users, original)

  # TODO move to $rootscope
  $scope._jed = (args...)->
    _jed.apply(this, args)

UsersIndexCtrl.$inject = ['$scope', 'User', '$routeParams'];

# exports
root.UsersIndexCtrl  = UsersIndexCtrl
