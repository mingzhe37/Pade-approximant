within ;
model bldsCHPtesting "Validate model ElectricalFollowing"

  package Medium = Buildings.Media.Water;

  Buildings.Fluid.CHPs.ThermalElectricalFollowing eleFol(
    redeclare package Medium = Medium,
    redeclare Buildings.Fluid.CHPs.Data.ValidationData3 per,
    m_flow_nominal=0.4,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    switchThermalElectricalFollowing=false,
    TEngIni=273.15 + 69.55,
    waitTime=0) "CHP unit with the electricity demand priority"
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));

  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    p(displayUnit="Pa"),
    nPorts=1) "Cooling water sink"
    annotation (Placement(transformation(extent={{110,-60},{90,-40}})));
  Buildings.Fluid.Sources.MassFlowSource_T cooWat(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) "Cooling water source"
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem
    "Variable temperature boundary condition in Kelvin"
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  Modelica.Blocks.Sources.CombiTimeTable valDat(
    tableOnFile=true,
    tableName="tab1",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    y(unit={"W", "kg/s", "degC", "degC", "W", "W", "W", "W", "W", "degC", "degC", "degC"}),
    offset={0,0,0,0,0,0,0,0,0,0,0,0},
    columns={2,3,4,5,6,7,8,9,10,11,12,13},
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1,
    fileName="D:/CHPlibtesting/MicroCogeneration.mos")
    "Validation data from EnergyPlus simulation"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Buildings.Controls.OBC.UnitConversions.From_degC TWatIn
    "Convert cooling water inlet temperature from degC to kelvin"
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Buildings.Controls.OBC.UnitConversions.From_degC TRoo
    "Convert zone temperature from degC to kelvin"
    annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Modelica.Blocks.Sources.BooleanConstant CHPavailable
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  parameter Buildings.Fluid.CHPs.Data.ValidationData3 per(coeEtaQ={0.66,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, coeEtaE={0.27,0.1,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
equation
  connect(eleFol.port_b, sin.ports[1]) annotation (Line(points={{70,-50},{90,
          -50}},
          color={0,127,255}));
  connect(cooWat.ports[1], eleFol.port_a) annotation (Line(points={{30,-50},{50,
          -50}},     color={0,127,255}));
  connect(preTem.port, eleFol.TRoo) annotation (Line(points={{30,-90},{40,-90},
          {40,-57},{50,-57}},   color={191,0,0}));
  connect(valDat.y[2], cooWat.m_flow_in) annotation (Line(points={{-69,0},{0,0},
          {0,-42},{8,-42}},        color={0,0,127}));
  connect(valDat.y[3], TWatIn.u) annotation (Line(points={{-69,0},{-50,0},{-50,
          -50},{-32,-50}},  color={0,0,127}));
  connect(TWatIn.y, cooWat.T_in) annotation (Line(points={{-8,-50},{0,-50},{0,
          -46},{8,-46}},       color={0,0,127}));
  connect(valDat.y[4], TRoo.u) annotation (Line(points={{-69,0},{-50,0},{-50,
          -90},{-32,-90}},  color={0,0,127}));
  connect(TRoo.y, preTem.T) annotation (Line(points={{-8,-90},{8,-90}},
          color={0,0,127}));
  connect(valDat.y[1], eleFol.PEleDem) annotation (Line(points={{-69,0},{44,0},
          {44,-47},{48,-47}},       color={0,0,127}));
  connect(CHPavailable.y, eleFol.avaSig) annotation (Line(points={{-69,-30},{34,
          -30},{34,-41},{48,-41}}, color={255,0,255}));
annotation (experiment(StopTime=10000, Tolerance=1e-6), Diagram(coordinateSystem(extent={{-180,-180},{180,100}})),
    uses(Buildings(version="7.0.0"), Modelica(version="3.2.3")));
end bldsCHPtesting;
