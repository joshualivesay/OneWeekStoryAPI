class NotifyMailer < ApplicationMailer
  default :from => 'invitations@oneweekstory.com'

  def send_invitation(invitation)
    @invitation = invitation
    @story = Story.find(@invitation.story_id)
    mail ({
          :to => @invitation.email,
          :subject => "Please, Help me write '#{@story.title}'",
          :from => @story.owner.email
    })
  end

  def starting(story, user)
    @story = story
    @user = user
    @order =  story.story_users.find_by_user_id(user).order
    @yourturn = (@story.on_turn == @order) ? true : false

    subject = (@yourturn) ? "... and it's your turn!" : ""

    mail ({
        :to => @user.email,
        :subject => "'#{@story.title}' is starting!" + subject,
        :from => @story.owner.email
    })
  end

  def turn_reminder(story, user)
    @story = story
    @user = user

    subject = "It's your turn!"

    mail ({
        :to => @user.email,
        :subject => subject,
        :from => @story.owner.email
    })

  end

  def send_test
    mail ({
        :to => 'joshualivesay@gmail.com',
        :subject => "Please, Help me TEST",
        :from => 'test@oneweekstory.com'
    })
  end

end
