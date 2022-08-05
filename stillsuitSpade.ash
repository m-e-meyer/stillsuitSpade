string distillPage = visit_url( "inventory.php?action=distill" );
visit_url( "choice.php?whichchoice=1476&option=2&pwd" );
string currentFamiliar = my_familiar();
int turncount = my_turncount();
 
matcher drams = create_matcher( "there are <b>(\\d+)</b> drams", distillPage );
matcher adventures = create_matcher( "booze producing <b>(\\d+) adventures</b>", distillPage );
matcher drunkenness = create_matcher( "adventures</b> for <b>(\\d+) Drunkenness</b>", distillPage );
matcher duration = create_matcher( "yielding these benefits for <b>(\\d+) adventures", distillPage );
 
 
string output = "";
 
if(find(drams)){
	output = '{"turncount: "' + turncount + ',"familiar": ' + currentFamiliar  + ',"drams": ' + to_int(drams.group(1));
 
}
else {
	output = "I didn't find any drams. Are you sure you've equipped a familiar with a stillsuit?";
}
 
 
matcher muscle = create_matcher ( "(\\d+) Muscle Stats Per", distillPage );
if(find(muscle)){ output = output + ',"muscle": ' + to_int(muscle.group(1));}
matcher myst = create_matcher ( "(\\d+) Mysticality Stats Per", distillPage );
if(find(myst)){ output = output + ',"myst": ' + to_int(myst.group(1));}
matcher moxie = create_matcher ( "(\\d+) Moxie Stats Per", distillPage );
if(find(moxie)){ output = output + ',"moxie": ' + to_int(moxie.group(1));}
matcher itemDrop = create_matcher ( "(\\d+)\% Item Drops", distillPage );
if(find(itemDrop)){ output = output + ',"item": ' + to_int(itemDrop.group(1));}
matcher food = create_matcher ( "(\\d+)\% Food Drops", distillPage );
if(find(food)){ output = output + ',"food": ' + to_int(food.group(1));}
matcher dr = create_matcher ( "Reduction: (\\d+)", distillPage );
if(find(dr)){ output = output + ',"dr": ' + to_int(dr.group(1));}
matcher wd = create_matcher ( "Weapon Damage \+(\\d+)", distillPage );
if(find(dr)){ output = output + ',"dr": ' + to_int(dr.group(1));}
matcher init = create_matcher ( "(\\d+) Combat Initiative", distillPage );
if(find(init)){ output = output + ',"wd": ' + to_int(init.group(1));}
matcher hotD = create_matcher ( "(\\d+) <font color=red>Hot Damage", distillPage );
if(find(hotD)){ output = output + ',"hot damage": ' + to_int(hotD.group(1));}
matcher hotS = create_matcher ( "(\\d+) Damage to <font color=red>Hot Spells", distillPage );
if(find(hotS)){ output = output + ',"hot spell damage": ' + to_int(hotS.group(1));}
matcher coldD = create_matcher ( "(\\d+) <font color=blue>Cold Damage", distillPage );
if(find(coldD)){ output = output + ',"cold damage": ' + to_int(coldD.group(1));}
matcher coldS = create_matcher ( "(\\d+) Damage to <font color=blue>Cold Spells", distillPage );
if(find(coldS)){ output = output + ',"cold spell damage": ' + to_int(coldS.group(1));}
matcher spookyD = create_matcher ( "(\\d+) <font color=gray>Spooky Damage", distillPage );
if(find(spookyD)){ output = output + ',"spooky damage": ' + to_int(spookyD.group(1));}
matcher spookyS = create_matcher ( "(\\d+) Damage to <font color=gray>Spooky Spells", distillPage );
if(find(spookyS)){ output = output + ',"spooky spell damage": ' + to_int(spookyS.group(1));}
matcher sleazeD = create_matcher ( "(\\d+) <font color=blueviolet>Sleaze Damage", distillPage );
if(find(sleazeD)){ output = output + ',"sleaze damage": ' + to_int(sleazeD.group(1));}
matcher sleazeS = create_matcher ( "(\\d+) Damage to <font color=blueviolet>Sleaze Spells", distillPage );
if(find(sleazeS)){ output = output + ',"sleaze spell damage": ' + to_int(sleazeS.group(1));}
matcher stenchD = create_matcher ( "(\\d+) <font color=green>Stench Damage", distillPage );
if(find(stenchD)){ output = output + ',"stench damage": ' + to_int(stenchD.group(1));}
matcher stenchS = create_matcher ( "(\\d+) Damage to <font color=green>Stench Spells", distillPage );
if(find(stenchS)){ output = output + ',"stench spell damage": ' + to_int(stenchS.group(1));}
 
output = output + '}' ;
 
 
 
print (output);
string outputFile = "stillsuitSpade-" + now_to_string("yyyy-MM-dd") + ".txt";
 
buffer placeholder = file_to_buffer(outputFile);
append(placeholder,output);
buffer_to_file(placeholder,outputFile);
