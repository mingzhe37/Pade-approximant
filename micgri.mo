within ;
model micgri

  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.PVSimpleOriented pv
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Storage.Battery bat
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    annotation (Placement(transformation(extent={{140,100},{120,120}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Conversion.ACACTransformer traPV
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line line
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line line2
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line line3
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid Gri
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Generator DieGen
    annotation (Placement(transformation(extent={{40,100},{20,120}})));
  Modelica.Blocks.Sources.Sine generation(
    offset=200,
    startTime=1,
    amplitude=100,
    freqHz=0.05) "Generated power"
    annotation (Placement(transformation(extent={{80,100},{60,120}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Capacitive CapBan
    annotation (Placement(transformation(extent={{-80,0},{-100,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line line4 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-50,28})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line line5
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line line6 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-28})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loa(mode=
        Buildings.Electrical.Types.Load.VariableZ_P_input)
    annotation (Placement(transformation(extent={{-80,-90},{-100,-70}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loa1(mode=
        Buildings.Electrical.Types.Load.VariableZ_P_input)
    annotation (Placement(transformation(extent={{-80,-120},{-100,-100}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line line1 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-50,-94})));
  Modelica.Blocks.Sources.Pulse BatPro(
    offset=-500,
    amplitude=1000,
    width=50,
    period=1200)
    "Signal that indicates how much power should be stored in the battery"
    annotation (Placement(transformation(extent={{130,40},{110,60}})));
  Modelica.Blocks.Sources.Constant StaLoa(k=20000)
    annotation (Placement(transformation(extent={{-160,-100},{-140,-80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loa2(mode=
        Buildings.Electrical.Types.Load.VariableZ_P_input)
    annotation (Placement(transformation(extent={{-80,-60},{-100,-40}})));
equation

  connect(pv.terminal, traPV.terminal_p)
    annotation (Line(points={{80,70},{60,70}}, color={0,120,120}));
  connect(weaDat.weaBus, pv.weaBus) annotation (Line(
      points={{120,110},{90,110},{90,79}},
      color={255,204,51},
      thickness=0.5));
  connect(traPV.terminal_n, line.terminal_p)
    annotation (Line(points={{40,70},{20,70}}, color={0,120,120}));
  connect(bat.terminal, line3.terminal_p)
    annotation (Line(points={{60,30},{20,30}}, color={0,120,120}));
  connect(line2.terminal_p, line3.terminal_n) annotation (Line(points={{-80,50},
          {-20,50},{-20,30},{0,30}}, color={0,120,120}));
  connect(Gri.terminal, line2.terminal_n) annotation (Line(points={{-130,60},{
          -130,50},{-100,50}}, color={0,120,120}));
  connect(DieGen.terminal, line5.terminal_p)
    annotation (Line(points={{20,110},{0,110}}, color={0,120,120}));
  connect(line4.terminal_n, line2.terminal_p)
    annotation (Line(points={{-50,38},{-50,50},{-80,50}}, color={0,120,120}));
  connect(line5.terminal_n, line2.terminal_p) annotation (Line(points={{-20,110},
          {-40,110},{-40,50},{-80,50}}, color={0,120,120}));
  connect(generation.y, DieGen.P)
    annotation (Line(points={{59,110},{40,110}}, color={0,0,127}));
  connect(line6.terminal_n, line2.terminal_p)
    annotation (Line(points={{-60,-18},{-60,50},{-80,50}}, color={0,120,120}));
  connect(line.terminal_n, line2.terminal_p) annotation (Line(points={{0,70},{
          -20,70},{-20,50},{-80,50}}, color={0,120,120}));
  connect(loa.terminal, line1.terminal_p) annotation (Line(points={{-80,-80},{
          -72,-80},{-72,-94},{-60,-94}}, color={0,120,120}));
  connect(loa1.terminal, line1.terminal_p) annotation (Line(points={{-80,-110},
          {-72,-110},{-72,-94},{-60,-94}}, color={0,120,120}));
  connect(line1.terminal_n, line2.terminal_p) annotation (Line(points={{-40,-94},
          {-30,-94},{-30,50},{-80,50}}, color={0,120,120}));
  connect(BatPro.y, bat.P)
    annotation (Line(points={{109,50},{70,50},{70,40}}, color={0,0,127}));
  connect(line4.terminal_p, CapBan.terminal)
    annotation (Line(points={{-50,18},{-50,10},{-80,10}}, color={0,120,120}));
  connect(StaLoa.y, loa.Pow) annotation (Line(points={{-139,-90},{-120,-90},{
          -120,-80},{-100,-80}}, color={0,0,127}));
  connect(StaLoa.y, loa1.Pow) annotation (Line(points={{-139,-90},{-120,-90},{
          -120,-110},{-100,-110}}, color={0,0,127}));
  connect(line6.terminal_p, loa2.terminal) annotation (Line(points={{-60,-38},{
          -60,-50},{-80,-50}}, color={0,120,120}));
  connect(StaLoa.y, loa2.Pow) annotation (Line(points={{-139,-90},{-120,-90},{
          -120,-50},{-100,-50}}, color={0,0,127}));
  annotation (
    uses(
      Buildings(version="8.0.0"),
      ModelicaServices(version="3.2.3"),
      Modelica(version="3.2.3")),
    Diagram(coordinateSystem(extent={{-180,-140},{140,140}}), graphics={
        Rectangle(
          extent={{-180,-20},{-40,-120}},
          lineColor={238,46,47},
          pattern=LinePattern.Dot,
          lineThickness=0.5),
        Text(
          extent={{-178,-22},{-80,-34}},
          lineColor={238,46,47},
          textString="Residential load and Induction motor"),
        Rectangle(
          extent={{-20,140},{140,20}},
          lineColor={28,108,200},
          pattern=LinePattern.Dot,
          lineThickness=0.5),
        Text(
          extent={{78,140},{138,128}},
          lineColor={28,108,200},
          textString="Power System Source"),
        Rectangle(
          extent={{-140,40},{-40,0}},
          lineColor={244,125,35},
          pattern=LinePattern.Dot,
          lineThickness=0.5),
        Text(
          extent={{-134,38},{-88,26}},
          lineColor={244,125,35},
          textString="Capacitor bank")}),
    Icon(coordinateSystem(extent={{-180,-140},{140,140}})));
end micgri;
