# name: try_bot
# about: replies to every 1st post with a canned message
# version: 0.1
# authors: Sam Saffron


after_initialize do

  MESSAGE = <<MSG
  Hello there, I am Try Bot.

  This site is **erased** every 24 hours, it is just a playground.

  If you have any specific Discourse questions, you can head over to https://meta.discourse.org or contact us via email at team@discourse.org

  Enjoy your day! :)
MSG

  DiscourseEvent.on(:post_created) do |post, params, current_user|
    first = Post.where(user_id: post.user_id).minimum(:id)
    if first == post.id
      PostCreator.new(Discourse.system_user, {
        topic_id: post.topic_id,
        reply_to_post_number: post.post_number,
        raw: MESSAGE
      }).create
    end
  end

end
