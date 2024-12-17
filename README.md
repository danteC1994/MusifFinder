# MusicFinder

## Introduction

Welcome to MusicFinder! This app allows you to search for artists and explore their albums using the Discogs API. Before you start using the app, you need to configure your User-Agent and API token. Please follow the steps outlined below:

## Configuration Steps

1. **Create Your User-Agent**:
   - Visit the API documentation to learn how to create a User-Agent in the [General section](https://www.discogs.com/developers/#page:home,header:home-general-information).

2. **Generate Your API Token**:
   - To create your API token, register for a Discogs account and follow the instructions provided in the [Authentication section](https://www.discogs.com/developers/#page:authentication,header:authentication-discogs-auth-flow) of the API documentation.

3. **Add Environment Variables in Xcode**:
   - Set environment variables in your Xcode project by configuring the scheme settings:
     - Go to `Product` > `Scheme` > `Edit Scheme...`.
     - Select the `Run` action from the list on the left side.
     - Navigate to the `Arguments` tab.
     - In the **Environment Variables** section, click the `+` button to add your variables:
       - `DISCOGS_API_TOKEN`: Your API token
       - `DISCOGS_USER_AGENT`: Your User-Agent

## Usage

Once configured, you can run the app, search for artists, and explore their discography. If you encounter any issues or have questions, please refer to the API documentation or reach out for support.

