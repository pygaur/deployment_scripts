#!groovy

node {

    try {
        stage 'Deploy'
            sh './deployment/web_prod/release/deploy_prod.sh'
    }

    catch (err) {
        throw err
    }

}

