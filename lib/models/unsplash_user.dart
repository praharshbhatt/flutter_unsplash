/// Model for Unsplash User
class UnsplashUser {
  var data;

  UnsplashUser(this.data);

  // Getter

  String getId() {
    return data['id'];
  }

  String getUsername() {
    return data['username'];
  }

  String getFirstName() {
    return data['first_name'];
  }

  String getLastName() {
    return data['last_name'];
  }

  String getInstagramUsername() {
    return data['instagram_username'];
  }

  String getTwitterUsername() {
    return data['twitter_username'];
  }

  String getPortfolioUrl() {
    return data['portfolio_url'];
  }

  getProfileImages() {
    return data['profile_image'];
  }

  String getSmallProfileImage() {
    return getProfileImages()['small'];
  }

  String getMediumProfileImage() {
    return getProfileImages()['medium'];
  }

  String getLargeProfileImage() {
    return getProfileImages()['large'];
  }

  getLinks() {
    return data['links'];
  }

  String getSelfLink() {
    return getLinks()['self'];
  }

  String getHtmlLink() {
    return getLinks()['html'];
  }

  String getPhotosLink() {
    return getLinks()['photos'];
  }

  String getLikesLink() {
    return getLinks()['likes'];
  }

  getCurrentUserCollections() {
    return data['current_user_collections'];
  }
}
