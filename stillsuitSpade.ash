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
    output = '{"turncount: "' + turncount + ',"familiar": ' + currentFamiliar + ',"drams": ' + to_int(drams.group(1));
 
}
else {
    output = "I didn't find any drams. Are you sure you've equipped a familiar with a stillsuit?";
}
 
string[string] dictionary = {
    "muscle": "(\\d+) Muscle Stats Per",
    "myst": "(\\d+) Mysticality Stats Per",
    "moxie": "(\\d+) Moxie Stats Per",
    "item": "(\\d+)\% Item Drops",
    "food": "(\\d+)\% Food Drops",
    "dr": "Reduction: (\\d+)",
    "wd": "Weapon Damage \\+(\\d+)",
    "init": "(\\d+) Combat Initiative",
    "hot damage": "(\\d+) <font color=red>Hot Damage",
    "hot spell damage": "(\\d+) Damage to <font color=red>Hot Spells",
    "cold damage": "(\\d+) <font color=blue>Cold Damage",
    "cold spell damage": "(\\d+) Damage to <font color=blue>Cold Spells",
    "spooky damage": "(\\d+) <font color=gray>Spooky Damage",
    "spooky spell damage": "(\\d+) Damage to <font color=gray>Spooky Spells",
    "sleaze damage": "(\\d+) <font color=blueviolet>Sleaze Damage",
    "sleaze spell damage": "(\\d+) Damage to <font color=blueviolet>Sleaze Spells",
    "stench damage": "(\\d+) <font color=green>Stench Damage",
    "stench spell damage": "(\\d+) Damage to <font color=green>Stench Spells"
};
 
foreach tag, pattern in dictionary {
    matcher m = create_matcher ( pattern, distillPage );
    if(find(m))
        output = output + `,"{tag}": ` + to_int(m.group(1));
}
 
output = output + '}\n' ;
 
print (output);
string outputFile = "stillsuitSpade-" + now_to_string("yyyy-MM-dd") + ".txt";
 
buffer placeholder = file_to_buffer(outputFile);
append(placeholder,output);
buffer_to_file(placeholder,outputFile);