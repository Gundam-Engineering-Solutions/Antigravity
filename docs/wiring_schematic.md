graph TD
    %% POWER SOURCE %%
    Grid[Substation Feed (High Voltage AC)] -->|Input| Rectifier[AC/DC Rectifier]
    Rectifier -->|Negative DC Pulse| Bus[Main Power Bus]

    %% CONTROL LOGIC %%
    Crystal[Jamoni SC-Cut Crystal] -->|Stable Clock Signal| HexCPU[Hexadecimal Coded CPU]
    HexSSD[Hexadecimal Coded SSD] -->|Flight Data| HexCPU
    HexCPU -->|Control Pulse| SnapBuffer[Snap Circuit: Double Latch Gate]

    %% POWER DISTRIBUTION %%
    Bus -->|High Current| SnapBuffer
    SnapBuffer -->|Gated Negative Charge| Hub[Central Hub Distributor]
    
    %% HULL PLATES %%
    Hub -->|Segment 0-90| PlateFront[Ventral Plates: Front]
    Hub -->|Segment 91-180| PlateRight[Ventral Plates: Right]
    Hub -->|Segment 181-270| PlateBack[Ventral Plates: Back]
    Hub -->|Segment 271-359| PlateLeft[Ventral Plates: Left]

    %% FEEDBACK LOOP %%
    PlateFront -.->|Field Strength Data| HexSensor[Field Sensor]
    HexSensor -.->|Feedback| HexCPU
