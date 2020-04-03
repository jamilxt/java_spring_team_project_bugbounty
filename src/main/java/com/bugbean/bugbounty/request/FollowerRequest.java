package com.bugbean.bugbounty.request;

public class FollowerRequest {

    private boolean alreadyFollowing;
    private int totalFollowers;
    private String followingOrNot;

    public boolean isAlreadyFollowing() {
        return alreadyFollowing;
    }

    public void setAlreadyFollowing(boolean alreadyFollowing) {
        this.alreadyFollowing = alreadyFollowing;
    }

    public int getTotalFollowers() {
        return totalFollowers;
    }

    public void setTotalFollowers(int totalFollowers) {
        this.totalFollowers = totalFollowers;
    }

    public String getFollowingOrNot() {
        return followingOrNot;
    }

    public void setFollowingOrNot(String followingOrNot) {
        this.followingOrNot = followingOrNot;
    }

}
