function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    //env = 'dev';
    //karate.log('karate.env system property:', env);
    myVarName = 'someValue';
  }
  var config = {
    env: env,
    themoviedburl: 'https://api.themoviedb.org',
    api_version_old: 3,
    api_version_new: 4,
    api_access_key: '',
    SauceBaseUrl: 'https://www.saucedemo.com/',
    sauceuser: 'standard_user',
    saucepassword: 'secret_sauce',
    desktop_view: { left: 0, top: 0, width: 800, height: 700 },
    tablet_view: { left: 0, top: 0, width: 600, height: 600 }
  };
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';

  } else if (env == 'e2e') {
    // customize
  }
  karate.configure('driver', { type: 'chrome' });
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  karate.configure('retry', {count: 10, interval: 5000});
  return config;
}
