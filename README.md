# Project Architecture

## MVC+C is the base pattern on the project. Main actors are:
 
 * **Model** - Data container, persistance object;
 * **View** - Object to represent data on UI.
 * **Controller** - Object, which acts as the intermediary between the application's view objects and its model objects.
 * **Coordinator** - Object, which allows to manage all controllers and sub-coordinators.
 
 ### Coordinator's roles:
 * Incapsulates dependencies;
 * Provides dependency injection role;
 * Init controllers;
 * Navigate controllers;
 * Subscribes on controller's events and react on events;
 
  ### Controller's  roles:
 * define view to display data;
 * generate events for coordinator about user's action;
 * Mediates between ViewControllers and Networking;
 * Generates events for coordinator about user's action;
 * Retrieves data from model;
 
