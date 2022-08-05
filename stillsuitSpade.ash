int turncount = my_turncount();

string distillPage = visit_url( "inventory.php?action=distill" );

matcher checkChoice = create_matcher( "I'll check back", distillPage );
if (find(checkChoice)) {
	visit_url( "choice.php?whichchoice=1476&option=2&pwd" );
}

string currentFamiliar = "";

print(familiar_equipped_equipment(my_familiar()));




if (familiar_equipped_equipment(my_familiar()) != $item[tiny stillsuit] ) {
	buffer famPage = visit_url( "familiar.php" );
	famPage = famPage.replace_string( "</tr>", "</tr>|");
	matcher famrow = create_matcher( '<tr class="frow([^|]*)', famPage);
	while (find(famRow)) {
	    matcher frow = create_matcher( "(\\d+)-pound ([^(]*).*stillsuit", famrow.group(1) );
	    if (find(frow)) {
	        currentFamiliar = frow.group(2);
	        print("suitedFam: " + frow.group(2));
	        break;
	    }
	}
	if (currentFamiliar == "") {
		print( "Didn't find a stillsuit equipped on any of your familiars. Aborting." );
		exit;
	}
}
else {
	currentFamiliar = my_familiar();
}
 
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



//<tr class="frow " data-.* data-attack="1"><td valign=center><input type=radio name=newfam value=(\\d+)></td><td valign=center><img onClick='fam \((\\d+)\)' src="/images/itemimages/familiar(\\d+).gif" width=30 height=30 border=0></td><td valign=top style='padding-top: .45em;'><b>(\\[sS]+)</b>, the (\\d+)-pound (^(*) \(.*\) <font size="1"><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="fave" href="familiar.php?.*">[favorite]</a>&nbsp;&nbsp;<a class="fave" href="familiar.php?&action=.*">[take with you]</a></font></td><td valign=center nowrap><center><b> (</b><img src="/images/itemimages/stillsuit.gif"
