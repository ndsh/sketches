void tweet(String theTweet, File file) {
    try {
       StatusUpdate status = new StatusUpdate(theTweet);
       status.setMedia(file);
       twitter.updateStatus(status);
    }
    catch (TwitterException te) {
        System.out.println("Error: "+ te.getMessage()); 
    }
}