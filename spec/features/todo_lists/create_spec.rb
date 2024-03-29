require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})

		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list."

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button ("Create todo list")

	end


	it "redirects to the todo list index page on success" do

		create_todo_list

		expect(page).to have_content("My todo list")

	end

	it "Display an error when to do list has no title" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

	it "Display an error when to do list has a title less than 3 charectors" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

		it "Display an error when to do list has no description" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: "Grocery list", description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")

	end

		it "Display an error when to do list has no description" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: "Grocery list", description: "Food"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")

	end

end