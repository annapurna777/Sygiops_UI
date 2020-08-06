App.notification = App.cable.subscriptions.create("SygiopsSupport::NotificationChannel", {
  connected: function() {
    // alert('connected now');
  },

  disconnected: function() {
    console.log("disconnected!")
    alert("disconnected")
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    return alert("data");
    console.log(data);
    // $("#play_music").click();
    // appendData(data);
  }
});
