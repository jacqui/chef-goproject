goproject Cookbook
====================
installs a go project via git along with dependencies like apt, golang, git

Requirements
------------

#### goproject::default

* [golang](https://github.com/NOX73/chef-golang)

Attributes
----------

#### goproject::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['goproject']['repository']</tt></td>
    <td>String</td>
    <td>goproject git repo</td>
    <td><tt>https://github.com/nytlabs/streamtools.git</tt></td>
  </tr>
  <tr>
    <td><tt>['goproject']['branch']</tt></td>
    <td>String</td>
    <td>git branch</td>
    <td><tt>master</tt></td>
  </tr>
</table>

Usage
-----
#### goproject::default

Your server should have a working go installation. The [golang](https://github.com/NOX73/chef-golang) cookbook works well for this. Include the recipe for `streamtools::source` - and optionally `golang` - in your node's `run_list`:

Just include `goproject` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[golang]",
    "recipe[goproject::source]"
  ]
}
```

Example
--------

`knife node edit my_server`

```json
{
  'name': 'my_server',
  'chef_environment': '_default',
  'normal': {
    'tags': [ ],  
    'goproject': {
      'repository': 'https://github.com/nytlabs/streamtools.git',
      'branch': 'master',
      'gopath': '/home/ubuntu/go'
    }
  },  
  'run_list': [
    'recipe[goproject]'
  ]
}
```


License and Authors
-------------------
Authors: Jacqui Maher, jacqui.maher@nytimes.com
