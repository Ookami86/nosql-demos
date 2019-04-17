print(db.towns.insert({
  name: "Punxsutawney",
  population: 6200,
  lastCensus: ISODate('2016-01-31'),
  famousFor: ["Punxsutawney Phil"],
  mayor: {name : "Richard Alexander" }
}));
print(db.towns.insert({
  name: "Portland",
  population: 582000,
  lastCensus: ISODate('2016-09-20'),
  famousFor: ["beer", "food", "Portlandia"],
  mayor: {name : "Ted Wheeler", party: "D" }
}));