import * as React from "react";
import * as Oni from "oni-api";

export const activate = (oni: Oni.Plugin.Api) => {
  console.log("config activated");

  oni.input.unbind("<c-tab>");
  oni.input.bind("<c-§>", "sidebar.toggle");
};

export const deactivate = (oni: Oni.Plugin.Api) => {
  console.log("config deactivated");
};

export const configuration = {
  "ui.colorscheme": "nord",
  "editor.fontSize": "13px",
  "editor.fontFamily": "DejaVu Sans Mono",
  "tabs.mode": "buffers",
  "tabs.height": "2.1em",

  // UI customizations
  "ui.animations.enabled": true,
  "ui.fontSmoothing": "auto",
};
