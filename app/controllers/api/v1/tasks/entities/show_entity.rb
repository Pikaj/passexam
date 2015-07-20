class API::V1::Tasks::Entities::ShowEntity< API::V1::BaseEntity
  root 'tasks', 'task'
  def self.entity_name
    'show_task'
  end
  expose :id, documentation: { type: 'String', desc: "ID" }, format_with: :string
  expose :name, documentation: { type: 'String', desc: "Nazwa zadania" }, format_with: :string
  expose :status, documentation: { type: 'String', desc: "Kolor zadania" }, format_with: :string
end

def status
  if current_user.task_done?(object)
    if current_user.is_verified_solution?(task)
      'done_verified'
    else
      ''
    end
end

<% if  current_user.task_done?(task) %>
<% if current_user.is_verified_solution?(task) %>
<!-- ZADANIE ZROBIONE PRZEZ CIEBIE SPRAWDZONE NA ZIELONO -->
                                                         <li>
                                                         <%= link_to task.name, subject_category_list_task_path(@subject ,task.list.category, task.list, task), :style => 'background-color: #A5D28C' %></li>
            <% else %>
                <!-- ZADANIE ZROBIONE PRZEZ CIEBIE  NIESPRAWDZONE NA ZIELONO -->
                <li>
                  <%= link_to task.name, subject_category_list_task_path(@subject ,task.list.category, task.list, task), :style => 'background-color: #F5B24E' %></li>
<% end %>
<% elsif current_user.task_too_hard?(task) %>
<!-- ZADANIE OZNACZONE PRZEZ CIEBIE JAKO ZA TRUDNE NA NIEBIESKO-->
                                                      <li>
                                                      <%= link_to task.name, subject_category_list_task_path(@subject ,task.list.category, task.list, task), :style => 'background-color: #85A7FA' %></li>
          <% elsif  task.level != nil && task.level > 1 %>
            <!-- ZADANIE NIE ZROBIONE TRUDNE NA CZERWONO-->
            <li>
              <%= link_to task.name, subject_category_list_task_path(@subject ,task.list.category, task.list, task), :style => 'background-color: #F9C8C8' %>
              </li>
<% else %>
            <!-- ZADANIE PROSTE NIE ZROBIONE -->
<li><%= link_to task.name, subject_category_list_task_path(@subject ,task.list.category, task.list, task) %></li>
          <% end %>