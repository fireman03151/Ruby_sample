#= require views/pages/base

class app.views.SimplePage extends app.views.BasePage
  prepare: ->
    for el in @findAll('pre[data-language]')
      @highlightCode el, el.getAttribute('data-language')
    return

app.views.AngularPage =
app.views.AngularjsPage =
app.views.AsyncPage =
app.views.BootstrapPage =
app.views.BowerPage =
app.views.CPage =
app.views.CakephpPage =
app.views.ChaiPage =
app.views.CodeceptionPage =
app.views.CodeceptjsPage =
app.views.CoffeescriptPage =
app.views.CordovaPage =
app.views.CrystalPage =
app.views.D3Page =
app.views.DockerPage =
app.views.DrupalPage =
app.views.ElixirPage =
app.views.EmberPage =
app.views.ExpressPage =
app.views.GoPage =
app.views.ImmutablePage =
app.views.InfluxdataPage =
app.views.JasminePage =
app.views.JestPage =
app.views.KnockoutPage =
app.views.KotlinPage =
app.views.LaravelPage =
app.views.LodashPage =
app.views.LovePage =
app.views.MarionettePage =
app.views.MdnPage =
app.views.MeteorPage =
app.views.MochaPage =
app.views.ModernizrPage =
app.views.MomentPage =
app.views.MongoosePage =
app.views.NginxPage =
app.views.NodePage =
app.views.OpenjdkPage =
app.views.PerlPage =
app.views.PhalconPage =
app.views.PhaserPage =
app.views.PhpPage =
app.views.PhpunitPage =
app.views.PostgresPage =
app.views.RamdaPage =
app.views.ReactPage =
app.views.ReduxPage =
app.views.RethinkdbPage =
app.views.RubydocPage =
app.views.RustPage =
app.views.SinonPage =
app.views.SocketioPage =
app.views.SphinxPage =
app.views.SphinxSimplePage =
app.views.TensorflowPage =
app.views.TypescriptPage =
app.views.UnderscorePage =
app.views.VagrantPage =
app.views.VuePage =
app.views.WebpackPage =
app.views.YarnPage =
app.views.YiiPage =
app.views.SimplePage
