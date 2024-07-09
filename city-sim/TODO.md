# TODO List for Simplified RCI City Builder Game in PICO-8

## Core Mechanics
- [ ] Define the grid system for the city
    - [ ] Implement grid-based map representation
    - [ ] Create tile types for R (Residential), C (Commercial), I (Industrial), and Roads
- [ ] Design building placement system
    - [ ] Define placement rules for RCI zones and roads
    - [ ] Implement zone and road placement tool
- [ ] Implement primary resources management (money, population)
    - [ ] Create resource generation and consumption systems
- [ ] Define basic demand fluctuation system
    - [ ] Implement demand indicators for RCI zones
    - [ ] Design growth/decline mechanics based on demand and connectivity

## User Interface (UI)
- [ ] Design essential HUD elements
    - [ ] Create main HUD displaying money, population, and RCI demand levels
- [ ] Implement controls for cursor movement and selection
    - [ ] Use d-pad for cursor movement
    - [ ] Use Button 1 for select/confirm
    - [ ] Use Button 2 for cancel/deselect
- [ ] Develop feedback and notification system
    - [ ] Use visual feedback for zone status and connectivity

## Detailed Example: Residential Zone Design
- [ ] Implement residential zone mechanics
    - [ ] Define placement rules and connectivity requirements
    - [ ] Ensure residential zones generate population when connected by roads
- [ ] Develop agent behavior related to residential zones
    - [ ] Implement basic commuting between RCI zones
- [ ] Create economic impact of residential zones
    - [ ] Generate basic tax revenue from population
- [ ] Manage basic infrastructure for residential zones
    - [ ] Ensure access to roads for functionality
- [ ] Design UI elements for residential zones
    - [ ] Create placement tool with simple zone impact preview
    - [ ] Implement basic information panel showing population and connectivity
