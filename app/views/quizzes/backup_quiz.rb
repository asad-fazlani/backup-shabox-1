<% if obj.present? %>

<table class="table table-hover mt-4">
  <thead>
    <tr>
      <th scope="col">Name</th>
      <th scope="col">Total Score</th>
      <% if type=="Submission" %>
      <th scope="col">User's Score</th>
      <% end %>
      <th scope="col">Number of questions</th>
      <% if type=="Submission" %>
      <th scope="col">Time</th>
      <% end %>
      <th scope="col">Actions</th>
    </tr>
  </thead>
  <tbody>
    <% obj.each do |quiz| %>
    <% @question_all = Question.where(quiz_id: quiz.id) %>
    <% @option_all = Option.where(question_id: Question.where(quiz_id: quiz.id)) %>
    <% quest_count=0 %>
    <% @total_score = @question_all.sum(:score) %>
    <% tscore=0 %>
    <% count=0 %>

    <% @question_all.each do |each_question| %>
    <% found = false %>
    <% if @option_all.present? %>
    <% @option_all.each do |each_option| %>
    <% if each_option.question_id == each_question.id %>
    <% count +=1 %>
    <% if each_option.is_answer == true %>
    <% found = true %>
    <% end %>
    <% end %>
    <% end %>
    <% end %>
    <% if found==true && count>=2 %>
    <% quest_count+=1 %>
    <% tscore+=each_question.score %>
    <% end %>
    <% end %>
    <% if quest_count>1 || (current_user.present? && current_user.admin?) || type=="Submission" %><!--Display only valid questions except for admin and submissions-->
    <tr>
      <% if current_user.present? && current_user.admin? %><!--For admins-->
      <td onclick="window.location='<%= quiz_path(quiz) %>'" class="clickable"><%= quiz.name %></td>
      <td onclick="window.location='<%= quiz_path(quiz) %>'" class="clickable"><%= @total_score %></td>
      <% if type=="Submission" %>
      <% @submissions.each do |sub| %><!--Display score of each submission-->
      <% if sub.quiz_id==quiz.id %>
      <td onclick="window.location='<%= quiz_path(quiz) %>'" class="clickable">
        <%= sub.score %>
      </td>
      <% end %>
      <% end %>
      <% end %>
      <td onclick="window.location='<%= quiz_path(quiz) %>'" class="clickable"><%= @question_all.length() %></td>
      <% if type=="Submission" %>
      <% @submissions.each do |sub| %><!--Display time ago of each score-->
      <% if sub.quiz_id==quiz.id %>
      <td onclick="window.location='<%= quiz_path(quiz) %>'" class="clickable">
        <%= time_ago_in_words(sub.created_at) %> ago
      </td>
      <% end %>
      <% end %>
      <% end %>
      <td><%= link_to 'Edit Quiz', edit_quiz_path(quiz), class: "btn btn-info btn-sm" %>
        <%= link_to 'Delete Quiz', quiz_path(quiz), method: :delete, data: {confirm: "Are you sure?"}, class: "btn btn-danger btn-sm ml-4" %>
        <% if @question_all.length()<2 %>
          <span class="float-right alert-icon font-weight-bold pr-4">
            <%= fa_icon "exclamation", class: "fa-2x" %>
          </span>
          <% end %>
        </td>
        <% elsif current_user.present?  %><!--For logged in users-->
        <td><%= quiz.name %></td>
        <td><%= tscore %></td>
        <% if type=="Submission" %>
        <% @submissions.each do |sub| %><!--Display score for each submission-->
        <% if sub.quiz_id==quiz.id %>
        <td>
          <%= sub.score %>
        </td>
        <% end %>
        <% end %>
        <% end %>
        <td><%= quest_count %></td>
        <% if type=="Submission" %>
        <% @submissions.each do |sub| %><!--Display time ago for each submission-->
        <% if sub.quiz_id==quiz.id %>
        <td>
          <%= time_ago_in_words(sub.created_at) %> ago
        </td>
        <% end %>
        <% end %>
        <% end %>
        <td>
          <% if quest_count>1 %>
          <% if quiz.is_free  or  current_user.payment_histories.find_by(quiz_id: quiz.id).present?  %>
          <%= link_to 'Take Quiz', quiz_path(quiz), class: "btn btn-success btn-sm" %>
          <% else %>
          <form action="/purchase" method="POST">
            <script
            src="https://checkout.razorpay.com/v1/checkout.js"
            data-key="<%= "rzp_test_Iw6dSU153m4Dss" %>"
            data-amount="1000"
            data-name="ShadBox"
            data-description="Online Quiz"
            data-prefill.name="<%= "#{current_user.display_name}" %>"
            data-prefill.email="<%= "#{current_user.email}" %>"
            data-theme.color="#041634"
            >
          </script>
          <input type="hidden" value="<%= "#{quiz.id}" %>" name="product_id">
          <input type="hidden" value="<%= "#{current_user.id}" %>" name="user_id">
        </form><% end %>
<!--           <script src="https://checkout.razorpay.com/v1/payment-button.js" data-payment_button_id="pl_HY374vSViaLETn" async> </script>
 -->        <% end %>
      </td>
      <% elsif !current_user.present?  %><!--For not logged in users-->
      <td><%= quiz.name %></td>
      <td><%= tscore %></td>
      <td><%= quest_count %></td>
      <td></td>

      <% end %>
    </tr>
    <% end %>
    <% end %>
  </tbody>
</table>

<% end %>
