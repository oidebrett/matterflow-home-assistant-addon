"use strict";

const express = require('express'),
      log4js = require('log4js'),
      fs = require('fs').promises;


async function main() {
    let app = express();
    // Configure logging
    log4js.configure({
        appenders: {console: {type: 'console'}},
        categories: {default: {appenders: ['console'], level: 'debug'}}
    });
    const logger = log4js.getLogger('app');
    app.use(log4js.connectLogger(log4js.getLogger('express'), {level: 'info'}));

    // Lookup Supervisor config
    logger.debug(`Attempting to query Supervisor configuration...`);
    const suconfig = await bent({'Authorization': `Bearer: ${process.env.SUPERVISOR_TOKEN}`}, 'json')('http://supervisor/addons/self/info');

    // Lookup Add-on config
    logger.debug(`Attempting to read local configuration from options.json`);
    const aoconfig = JSON.parse(await fs.readFile('/data/options.json', 'utf8'));

    // Configure web application
    app.use('/', async (req, res) => {
        res.send(`HTTP Response successful..`);
    });
    if (suconfig.data.ingress === true) {
        app.listen(suconfig.data.ingress_port);
        logger.debug(`Web interface is listening on port ${suconfig.data.ingress_port}`);
    }
    
}

main();