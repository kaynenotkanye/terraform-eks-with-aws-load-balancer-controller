const puppeteer = require('puppeteer');
const $ = require('cheerio');

var BASE_URL = process.env.BASE_URL;

var url = `http://${BASE_URL}`;
global.globalArray  = [];

puppeteer
.launch({ args: ['--no-sandbox', '--ignore-certificate-errors', '--enable-features=NetworkService'] })
  .then(function(browser) {
    return browser.newPage();
  })
  .then(function(page) {
    return page.goto(url).then(function() {
      return page.content();
    });
  })
  .then(function(html) {
    //console.log(html);
    $('p', html).each(function() {
      if ($(this).text().includes('the'))
      {
        //console.log($(this).text());
        globalArray.push($(this).text());
      }
    });
  })
  .catch(function(err) {
    //handle error
    console.log(err);
  })
  .finally(() => {
    if (globalArray.length > 0) {
      console.log("Array of text: ", globalArray);
      let specificStringCounter = 0;
      for (let i = 0; i < globalArray.length; i++) {
        if (globalArray[i].includes('This site is the official version')) {
          specificStringCounter = specificStringCounter + 1;
        }
      } // end for
    console.log(`Specific string found: ${specificStringCounter} times.`);
    } else {
      console.log("ERROR: Filtered HTML tags were not found. Exit code 1");
      process.exit(1);
    }

    setTimeout(process.exit, 2000);
    });
