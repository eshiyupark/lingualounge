// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import QueueForLoungeController from "./queue_for_lounge_controller"
application.register("queue-for-lounge", QueueForLoungeController)

import TomSelectController from "./tom_select_controller"
application.register("tom-select", TomSelectController)

import VideoCallController from "./video_call_controller"
application.register("video-call", VideoCallController)
