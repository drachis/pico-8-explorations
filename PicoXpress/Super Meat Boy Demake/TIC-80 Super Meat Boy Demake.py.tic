-- title:  Super Meat Boy TIC-80 demake
-- author: nequ16
-- desc:   a TIC-80 demake of a platformer game "Super Meat Boy"
-- script: lua
-- saveid: meatboy

-- .-----------------------.
-- |Feel free to play with |
-- |the code all you want! |
-- |Though I'd ask not to  |
-- |reupload the cartridge,|
-- |even if it has been    |
-- |modified in any way.   |
-- `-----------------------'

-- TIC80 - https://nesbox.itch.io/tic80

t=0
p={
 x=0,       -- X pos
	y=0,       -- Y pos
	vx=0,      -- X velocity
	vy=0,      -- Y velocity
	mvx=4,     -- max X speed
	svx=0.02,  -- X speed stopping
	fvy=0.15,  -- falling speed
	hbx=5,     -- hitbox width
	hby=5,     -- hitbox height
	of=false,  -- is on floor
	owl=false, -- is on wall on the left
	orl=false, -- is on wall on the right
	run=false, 
	dir=false  -- facing direction
}

abt=0 -- how long jump btn is pressed
cm=0 -- current map id
cx=0 -- camera x
cy=0 -- camera y
dmgobj={} -- projectile damaging objects
dstr={} -- blocks to destroy queue
ff=false -- "to not jump higher than from floor when near wall but not on wall"
st=0 -- level time
pt={} -- particles
bl={} -- blood on tiles
sbl={} -- blood on saws
for i=1,64*16 do sbl[i]=false end
dead=false
dt=0 -- death anim timer
lvlend=false
ft=0 -- level end anim timer
dwt=0 -- additional transition timer
lnt=0 -- level name timer
clvlt=0 -- stopwatch
lvlbt={} -- level record time
for i=1,31 do lvlbt[i]=0 end
lvlat={3,5,9,7,5,4,8,8,7,8,10,9,4,20,24,0,3,4,10,7,6,6,10,11,12,14,18,12,5,17,25} -- level time for A+
lvlname={"HELLO WORLD","UPWARD","NUTSHELL","BLADECATCHER","DIVERGE","THE BIT","SAFETY THIRD","THE LEVEE","TOMMY'S CABIN","BLOOD MOUNTAIN","CACTUS JUMPER","MORNINGSTAR","ALTAMONT","INTERMISSION","THE TEST","LIL SLUGGER","OH, HELLO","ONWARD","PLUM RAIN","I AM THE NIGHT","TWO ROADS","BIG RED","SO CLOSE","WALLS","TOMMY'S CONDO","MYSTERY SPOT","KICK MACHINE","THE CLOCK","WHITEWASH","THE QUEENER","A PERFECT END"}
playback=false -- replay
pbt=0 -- replay frame
pbdata={}
pbtry=0
ctrl={mleft,mright,jump,run,up,down,left,right,ok,back,spec,pause}
usekb=true -- use keyboard controls
csfx=-1 -- current sound
nsfx={run=0,hit_grn=1,jump=2,lvlend=3,dr_dis=4,death=5,rsp=6,fb=7,throw=8,sawh=9,ms=10,exp=11,fw=12,sg=13,mc=14}
vol={m=3,s=4}
cpic=1

gstat="stscr" -- game state

-- maps data
Maps={
 {id={0,0},wh={1,1},sp={3,15},bp={14,8}},
 {id={1,0},wh={1,1},sp={33,15},bp={46,4}},
 {id={2,0},wh={1,2},sp={70,30},bp={74,3}},
 {id={3,0},wh={1,2},sp={100,28},bp={100,11}},
 {id={4,0},wh={1,1},sp={121,15},bp={147,3}},
	{id={4,1},wh={1,1},sp={122,28},bp={147.5,28}},
	{id={5,0},wh={1,2},sp={156,29},bp={165,5}},
	{id={6,0},wh={1,1},sp={184,13},bp={184,6}},
	{id={7,0},wh={1,2},sp={221,30},bp={231,10}},
 {id={0,1},wh={1,2},sp={8,48},bp={14,40}},
	{id={1,1},wh={1,2},sp={35,47},bp={37,25}},
	{id={6,1},wh={1,2},sp={189,49},bp={204.5,23}},
	{id={7,2},wh={1,1},sp={211,42},bp={238,39}},
	{id={2,2},wh={4,1},sp={66,49},bp={172,46}},
	{id={0,3},wh={2,1},sp={11,65},bp={42,65}},
	{id={2,3},wh={6,1},sp={65,65},bp={-1,-1}},
	{id={0,4},wh={1,1},sp={4,83},bp={14,77}},
	{id={1,4},wh={1,1},sp={38,83},bp={46,72}},
	{id={2,4},wh={1,2},sp={69,99},bp={74,71}},
	{id={3,4},wh={1,2},sp={101,96},bp={99.5,79}},
	{id={4,4},wh={1,1},sp={122,83},bp={147,71}},
	{id={4,5},wh={1,1},sp={121,95},bp={148,95}},
	{id={5,4},wh={1,2},sp={155,97},bp={167.5,73}},
	{id={6,4},wh={1,1},sp={182.5,81},bp={182.5,74}},
	{id={7,4},wh={1,2},sp={217,98},bp={231,92}},
	{id={0,5},wh={1,2},sp={8,116},bp={25,98}},
	{id={1,5},wh={1,2},sp={35,115},bp={37,93}},
	{id={6,5},wh={1,2},sp={189,117},bp={204,91}},
	{id={7,6},wh={1,1},sp={211,110},bp={238,107}},
	{id={2,6},wh={4,1},sp={69,117},bp={172,114}},
	{id={0,7},wh={2,1},sp={11,133},bp={42,133}}
}

Saws={
 {
  
 },
 {
	 "049500852b",
  "048000703b",
 },
 {
  "083501353f",
  "064501654b",
  "083500454b",
 },
	{
	 "105501154b",
  "110501803b",
  "106502403b",
	},
	{
  "125000253b",
  "130500803b",
  "144000754b",
	},
	{
  "125501853b",
  "143501853b",
  "122503103f",
  "146503103f",
  "124503153b",
  "144503153b",
  "126503102b",
  "142503102b",
  "128503153b",
  "140503153b",
  "130503102b",
  "138503102b",
  "132503153b",
  "136503153b",
  "134503103b",
  "134502753b",
	},
	{
  "169503253b",
  "172503253b",
  "175503253b",
  "176502953b",
  "176502653b",
  "176502353b",
  "176502053b",
  "176501753b",
  "176501453b",
  "159002153b",
  "155702153b",
  "152502153b",
  "152001903b",
  "152001603b",
  "152001303b",
  "152001003b",
  "152000703b",
  "160000803b",
  "160201003b",
  "161001203b",
	},
	{
  "195001653b",
  "193500752b",
  "196500752b",
  "195000753b",
	},
	{
  "217501453b",
  "226001103b",
  "226000104b",
	},
	{
  "014003572b",
  "005203703b",
  "010702903b",
	},
	{
  "049504152b",
  "038004152b",
  "029503902b",
  "057503202b",
  "049503303b",
	},
	{
  "202503904f",
  "197004202f",
  "194002103f",
	},
	{
  "217503952f",
  "225003952f",
  "232503952f",
  "220504452f",
  "229504452f",
	},
	{
  "077504554f",
  "092004903f",
  "099004853f",
  "108004802f",
  "117504553f",
  "125004402f",
  "130004302f",
  "125004852f",
  "130004702f",
  "151004504f",
  "159504604f",
  "166004504f",
  "095503953f",
  "108003753f",
	},
	{
  "011506204b",
  "011505953b",
  "011505704b",
  "016006554b",
  "020006554b",
  "024006554b",
  "029006554b",
  "033006554b",
  "037006554b",
  "018006552b",
  "022006552b",
  "026506553b",
  "031006552b",
  "035006552b",
	},
	{
  "075506553b",
  "085506553b",
  "085506053f",
  "095506553b",
  "107506403f",
  "113006204f",
  "119006503f",
  "131005904f",
  "132006552f",
  "136006553f",
  "134006553f",
  "153506553f",
  "173005952f",
  "165006253f",
  "173006453f",
  "181006253f",
  "187505902f",
  "189505902f",
  "190006602f",
  "191506603f",
  "211006603f",
  "209506653f",
  "212506653f",
  "221505953f",
  "230006053f",
  "230006603f",
	},
	{
  "014007404f",
  "011007853f",
  "017007853f",
	},
	{
  "049507652b",
  "048007503b",
  "045007603b",
  "048508403b",
  "050507953b",
  "055508353b",
  "055507653b",
  "050507353b",
  "055007003b",
	},
	{
  "067510254f",
  "072010254f",
  "076510254f",
  "081010254f",
  "076009354b",
  "064508854b",
  "064508853b",
  "083508253f",
  "083507254b",
  "083507253b",
  "068507853b",
  "072507653b",
  "075507853b",
  "072508353b",
  "075508553b",
  "079508503b",

	},
	{
  "112509653b",
  "100509203b",
  "102009202b",
  "104009254b",
  "104009204b",
  "106509203b",
  "105508603b",
  "107508654b",
  "107508604b",
  "109508603b",
  "102007953b",
  "107007953b",
  "103507904b",
  "105507904b",
	},
	{
  "125007053b",
  "130507603b",
  "133507603b",
  "138508253b",
  "138507703b",
  "144507503b",
  "132006854b",
	},
	{
  "122509753f",
  "124509853b",
  "126509803b",
  "128509853b",
  "130509803f",
  "132509853b",
  "136509853b",
  "134509803b",
  "138509803b",
  "140509853b",
  "142509803b",
  "144509853b",
  "146509753f",
  "127008503f",
  "142008503f",
  "130508654f",
  "138508654f",
  "134508954b",
  "134508952f",
  "134509554b",
  "127009403b",
  "127509252b",
  "127509552b",
  "142009403b",
  "141509252b",
  "141509552b",
	},
	{
  "169510053b",
  "172510053b",
  "175510053b",
  "176509753b",
  "176509453b",
  "176509153b",
  "176508853b",
  "176508553b",
  "176508253b",
  "159008953b",
  "155708953b",
  "152508953b",
  "152008703b",
  "152008453b",
  "152008203b",
  "152007753b",
  "152007503b",
  "160007603b",
  "160207803b",
  "161008003b",
  "161509553f",
  "160007403b",
  "161506903b",
  "165007353b",
  "153506753b",
	},
	{
  "186508402b",
  "189508402b",
  "192508402b",
  "195508402b",
  "198508402b",
  "201508402b",
  "188008403b",
  "191008403b",
  "194008403b",
  "197008403b",
  "200008403b",
  "186507552b",
  "189507552b",
  "192507552b",
  "195507552b",
  "198507552b",
  "201507552b",
  "188007553b",
  "191007553b",
  "194007553b",
  "197007553b",
  "200007553b",
	},
	{
  "228008573b",
  "213508453b",
  "222007603b",
  "222008103b",
  "228507702b",
  "231007702b",
  "233507702b",
  "217507404b",
  "222007104b",
	},
	{
  "005510153b",
  "010510653b",
  "012009503b",
  "005510502b",
  "010509702b",
  "015009872b",
  "014010372b",
  "024010102b",
	},
	{
  "049510952b",
  "038010952b",
  "029510702b",
  "057510002b",
  "049510103b",
  "040011703b",
  "050011703b",
  "033010803b",
  "042010803b",
  "043009903b",
	},
	{
  "202510704f",
  "197011002f",
  "194008803f",
  "194009102f",
  "194010304f",
  "194009803f",
  "204010404b",
	},
	{
  "217011003f",
  "233011003f",
  "225011004f",
  "225010503f",
  "220511252f",
  "229511252f",
	},
	{
  "077511354f",
  "092011703f",
  "099011653f",
  "108011602f",
  "117511353f",
  "125011202f",
  "130011102f",
  "125011652f",
  "130011502f",
  "151011304f",
  "159511404f",
  "166011304f",
  "095510753f",
  "108011553f",
  "148511803f",
  "155511803f",
  "060010253f",
  "060010603f",
  "060010953f",
  "060011303f",
  "060011653f",
	},
	{
  "011513004b",
  "011512753b",
  "011512504b",
  "016013354b",
  "020013354b",
  "024013354b",
  "029013354b",
  "033013354b",
  "037013354b",
  "018013352b",
  "022013352b",
  "026513353b",
  "031013352b",
  "035013352b",
  "026512254b",
  "026512954b",
	}
}

Pipes={
 {
	 
	},
	{
		"04700110f3321",
	},
	{
		"07200280b58698",
  "07800240b333",
  "07800140b666",
  "06700150b363632223222",
  "07800000b899669",
  "05950175f596633666",
  "08150205f33223",
  "08350135f2322",
  "06200100f363322",
  "08850055f574411444",
	},
	{
		"11700290b112221",
  "10500290b2212",
  "11300210b112233",
  "10600180b222222422122",
  "09150145f696633666666632477",
  "11950160f5487884471141",
  "10350290f52222636",
	},
	{
		"12600110b66332662221141",
  "12600015f57",
  "14500075f548",
	},
	{
		"12400215b7777",
  "12200210b8787",
  "14500215b9999",
  "14700210b8989",
  "13200335b2122266",
  "13800335b2222244",
  "12250310f888",
  "12450315f89",
  "12650320f52",
  "12850315f888",
  "13050310f888",
  "13250315f888",
  "13450310f888",
  "14650310f888",
  "14450315f87",
  "14250320f52",
  "14050315f888",
  "13850310f888",
  "13650315f888",
  "11850310f6666696",
  "15050310f4444474",
  "12650330f536636666",
  "14250330f514414444",
	},
	{
		"15300260b332",
  "15300270b636323",
  "16200300b1222322",
  "17100330b22339696414122323323",
  "16500190b332233",
  "15700220b2322223223636",
  "15300045b5888888887",
  "16200320f669666",
  "15000270f33222",
  "15900220f66366",
  "17550325f223",
  "17650215f12223",
  "17700150f12144",
  "16500130f66366",
  "15200070f2221211",
  "16300100f57712",
	},
	{
		"19400090b58888898",
	},
	{
		"22000160b7887877",
  "22600120b899887",
  "22500115b777",
  "23300075b544444444444444448888488688",
  "22900060b112218888",
  "21700165f22991166666",
  "22550060b88888",
  "22650060b88888",
  "22600062f88888",
  "22200060f3662322",
	},
	{
		"01500410b928887888888",
  "02100320b7744474414474477",
  "00450370f88888744744",
  "00550370f88888",
  "01150340f9966",
  "01050290f88888",
  "01150290f88888",
	},
	{
		"03700430b899697473636698213223",
  "05100430b998988",
  "05400350b88989",
  "04400350b88878",
  "03800350b88898",
  "03300280b888888888888",
  "04700270b74787",
  "03950435b666666666",
  "03700500f9",
  "05500490f36",
  "05900400f8788898",
  "03800430f66666636",
  "05000410f5714444",
  "03100390f8877",
  "03350435f78",
  "05350350f5969",
  "03250375f89",
  "03450285f478",
  "04750270f59",
  "04000340f66663666",
  "05100330f666696666",
	},
	{
		"19050500b22323",
  "19700450b63633",
  "18600400b69736636632",
  "19350380b53363",
  "20300400b2122122141414122",
  "19200450f66666",
  "20500500f221222323969",
  "20650410f54141",
  "19400260f666966669669",
  "19450265f5963",
  "20100270f889969",
	},
	{
		"21750430b588888888",
  "21750460b58",
  "22500430b588888888",
  "22500460b58",
  "23250430b588888888",
  "23250460b58",
  "22050480f5888",
  "22950480f5888",
  "21800430b57887",
  "22500470b78",
  "23250470b9989",
	},
	{
		"07750455f88889",
  "09200490f99",
  "09900485f77",
  "09500445b78788",
  "10800480f888",
  "11750455f878788",
  "10900420b6366666888822226666666664433",
  "12500440b89888",
  "13600420b88878888",
  "12500410f888",
  "12800390f9988",
  "12500485f999",
  "13000470f88",
  "14750445b6333",
  "14450455b666669999",
  "14800420b9666698966666366366633",
  "16950435b888788",
  "16050450b2233",
  "15500490f588",
  "15100450f12212122",
  "15200420f588",
  "15850420f5888",
  "15850400f5988888",
  "16500380f58889888",
  "16650415b88",
  "16800400f87887",
	},
	{
		"00700510b88787",
  "00500560f77888",
  "01400590f888",
  "01250560f79",
  "01350620f449",
  "03900590b7888",
  "01400620b9966696666663666696669",
  "01400635f5968266668266668266966663966663",
  "03900645f54",
  "01200510f66369",
  "03900560f89888",
  "04100660f669666",
  "05600530f8784",
  "04500595f6666",
  "05400625f5444",
  "05400610f666",
  "05450650f9699",
  "04300510b88",
  "04800510b88",
  "05300530b889",
  "04100560b6363",
  "05000570b878878888",
	},
	{
		"07550655f888",
  "08550605f888887886622221",
  "09550655f988",
  "10450660f53638878",
  "11200580f589228888",
  "11900650f888",
  "13500540f4478788",
  "13200655f778233888",
  "13400655f878",
  "13600655f888",
  "15350655f888",
  "17200570f12",
  "18750590f66",
  "18850660f6666",
  "20950665f666",
  "21800600f888",
  "21800630f888",
  "22150600f888",
  "22050660f5232888",
  "22500600f888",
  "22500630f888",
  "07150600f588",
  "06950620f66",
  "07150615f5869866",
  "07150615b5888766",
	},
	{
	 "00600840b239136633222326888988969669",
  "01100785f696663",
  "01300790f88988331119996698",
  "01300790f3391212",
	},
	{
	 "04900740f78977212",
  "05500760f599998889",
  "05500700f41411",
  "04700680b889698444777899887873298",
	},
	{
	 "06200990f69969",
  "08201020f266366636",
  "07500925f93",
  "08150885f32332122322",
  "05950855f596996",
  "07150860f66",
  "07450845f694",
  "07500830f52212",
  "07700780f97888",
  "08750705f5747499",
  "07150685f7447",
  "06751000b77",
  "08151000b99",
  "07000920b8782396964889889188",
  "07100910b32666898",
  "06700910b696447",
  "06550865b99664477",
  "06300880b663636323322322",
  "07700790b878739",
  "08250700b87898",
  "07150680b899978788",
  "07300680b866968888988",
  "06850680b887",
	},
	{
	 "10300935f82888",
  "10400970b2636621121221",
  "09750910b6323236666236633232332244784787",
	},
	{
		"12600790b66332662221141",
  "12600695f57",
  "14350760f53",
  "13450700b898878789896968",
  "13950690b988787323896989",
	},
	{
  "11950965f59668888",
  "11900970f6",
  "14950965f57448888",
  "15000970f4",
  "12450985f89",
  "14450985f87",
  "12650990f52",
  "14250990f52",
  "13050980f8887",
  "13850980f8889",
  "13350975f7889",
  "13550975f9887",
  "13450980f888739",
  "12250975f966",
  "14650975f744",
  "12850990f636666",
  "14050990f414444",
  "12851000f966366",
  "14051000f744144",
  "12750925f888",
  "14150925f888",
  "12400850f5666",
  "14500850f5444",
  "13050865f9699",
  "13850865f7477",
  "12700850b696",
  "14200850b474",
  "13050865b6669",
  "13850865b4447",
  "13300905b8888",
  "13600905b8888",
  "13300950b478",
  "12700980b2398",
  "14200980b2178",
	},
	{
  "15300940b332",
  "15300950b636323",
  "16200980b1222322",
  "17101010b22339696414122323323",
  "16500870b332233",
  "15700900b2322223223636",
  "15300725b5888888887",
  "16201000f669666",
  "15100950f23222",
  "15900900f66366",
  "17551005f223",
  "17650895f12223",
  "17700830f12144",
  "16500810f66366",
  "15200750f2221211",
  "16300780f57712",
  "16050975f2389",
  "16050670f8923",
	},
	{
  "19200680b98889888",
  "19300770b88888982222332",
  "19800770b99988889",
  "18300815b59",
  "19100840f666666",
  "19100755f666666",
	},
	{
  "21500860b8887874",
  "23050950b98996",
  "23150770b88988",
  "21850760b36323",
  "22450760b1212",
  "22100860b8889898",
  "21350865f229166669",
  "21450880b5633666963",
  "22150760b88888",
  "22250760b88888",
  "22200762f88888",
  "22850775f8888",
  "23100775f8888",
  "23350775f8888",
  "21750740f96649",
  "22900760f449141444291222",
	},
	{
  "01551070b788788878889",
  "01601090b8888887888",
  "01101040b744747",
  "02600970b44477874744",
  "00451100f774444",
  "01151030f96",
  "00351015f212221214",
  "00451050f88888",
  "00551050f88888",
  "01050970f88888",
  "01150970f88888",
  "01900990f66",
	},
	{
  "03701110b899697473636698213223",
  "05101110b998988",
  "05401030b88989",
  "04401030b88878",
  "03801030b88898",
  "03300960b888888888888",
  "04700950b74787",
  "03951115b666666666",
  "03701180f9",
  "05501170f36",
  "05901080f8788898",
  "03801110f66666636",
  "05001090f5714444",
  "03101070f8877",
  "03351115f78",
  "05351030f5969",
  "03251055f89",
  "03450965f478",
  "04750950f59",
  "04001020f66663666",
  "05101010f666696666",
	},
	{
  "19051180b22323",
  "19701130b63633",
  "18601080b69736636632",
  "19351060b53363",
  "20301080b2122122141414122",
  "19201130f66666",
  "20501080f221222323969",
  "20651090f54141",
  "19400940f666966669669",
  "19450945f5963",
  "20100950f889969",
  "20201070f563633444",
	},
	{
  "21751110b588888888",
  "21751140b58",
  "22501100b5888888888",
  "22501140b58",
  "23251110b588888888",
  "23251140b58",
  "22051160f5888",
  "22951160f5888",
  "21801110b57887",
  "22501150b78",
  "23251150b9989",
	},
	{
  "07751135f88889",
  "09201170f99",
  "09901165f77",
  "09501125b78788",
  "10801160f888",
  "11751135f878788",
  "10901100b6366666888822226666666664433",
  "12501120b89888",
  "13601100b88878888",
  "12501090f888",
  "12801070f9988",
  "12501165f999",
  "13001150f88",
  "14751125b6333",
  "14451135b666669999",
  "14801100b9666698966666366366633",
  "16951115b888788",
  "16051130b2233",
  "15501170f588",
  "15101130f12212122",
  "15201100f588",
  "15851100f5888",
  "15851080f5988888",
  "16501060f58889888",
  "16651095b88",
  "16801080f87887",
  "14851190f29",
  "15451190f38",
  "06001015f888888888888888",
	},
	{
  "00701190b88787",
  "00501240f77888",
  "01401270f888",
  "01251240f79",
  "01351300f449",
  "03901270b7888",
  "01401300b9966696666663666696669",
  "01401315f5968266668266668266966663966663",
  "03901325f54",
  "01201190f66369",
  "03901240f89888",
  "04101340f669666",
  "05601210f8784",
  "04501275f6666",
  "05401305f5444",
  "05401290f666",
  "05451330f9699",
  "04301190b88",
  "04801190b88",
  "05301210b889",
  "04101240b6363",
  "05001250b878878888",
  "02451335f2323888822229898",
	}
}

-- tiles properties
prop={
  1,1,1, 1,1,1,0, 0,0,0,0, 0,0,0,0,
1,1,1,1, 1,1,1,0, 0,0,0,0, 0,0,0,0,
1,1,1,1, 1,1,1,0, 0,0,0,0, 0,0,0,0,
0,1,1,1, 1,0,0,0, 0,0,1,1, 1,1,1,1,

0,1,1,1, 1,0,0,0, 0,0,1,1, 1,1,1,1,
0,3,3,3, 3,3,3,0, 0,0,2,2, 2,2,1,1,
0,2,2,2, 2,2,2,0, 0,0,3,3, 3,3,1,1,
0,3,3,3, 3,3,3,0, 0,0,2,2, 2,2,0,0,

0,2,2,2, 2,2,2,0, 0,0,3,3, 3,3,0,0,
0,1,1,1, 1,1,1,0, 1,1,0,1, 1,1,0,0,
0,1,1,1, 1,1,1,1, 1,1,0,0, 0,0,1,1,
0,1,0,1, 1,1,0,0, 0,0,0,0, 1,1,1,1,

0,1,1,1, 0,0,0,0, 0,0,0,0, 1,1,1,1,
0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,0,0,
0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
}

-- map tiles layers
layers={
  1,1,1, 1,1,1,0, 0,0,0,0, 0,0,0,0,
1,1,1,1, 1,1,1,0, 0,0,0,0, 0,0,0,0,
1,1,1,1, 1,1,1,0, 0,0,0,0, 0,0,0,0,
0,1,1,1, 1,0,0,0, 0,0,1,1, 1,1,1,1,

0,1,1,1, 1,0,0,0, 0,0,1,1, 1,1,1,1,
0,1,1,1, 1,1,1,0, 0,0,1,1, 1,1,1,1,
0,1,1,1, 1,1,1,0, 0,0,1,1, 1,1,1,1,
0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,

0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
0,1,1,1, 1,1,1,0, 1,1,0,0, 1,1,0,0,
0,1,1,1, 0,1,0,0, 0,1,0,0, 0,0,1,1,
0,0,0,0, 1,1,0,0, 0,0,0,0, 0,0,1,1,

0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,0,0,
0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
}

-- this is taking too much space ahhaha
pics={
"ppmhhhlllhlllkmmpppmkkhkkmmmP05mmpppmllkM08hllhkkhhlhhhL06hhllhhM07kL04hM0eK05mkH06kM09klllpmkH07lllkmmmppkH05kP07mpppmhlllhkM05phlllhhhlllhL04fllhlhllhkkkM04kL04dM14khhlllhkkM08klllhhhllkmkkklllkmmmpmH08mP05mppkhhfL04hkmmmphlllhhhllhhL04flH05llH04kmmhL05kM13khhhL04hhkM06klllhhlllkmmmklllkmppmkH09kmpppmpmkmklddL04dhhmhlllH04L08H04lhL06hhkL06kM11khhhlH07M07kL08kmmmklllkmmmkH0cmppmpmmmklhmkhdhkkmphlllH04L07H05lllhhL04hL07hM09K07hL05kM0dklllhhkllkmmmklllkmkH0ekM06khlhmkM07hlllH05L08hhlfllhhhlllhL08kM07dA0afflhM0dhlllkmkllkmmmklllkmkH0fkM04kkklhkhkM06hlllH05llfL06hL04H06L09dkM05kA0fdkM0akhlllkmkllkmmmklllkmkH10kM05klhkhhkmK04hlllH05L08hhL05H05L0akM05kA10hM0akhlllkkkllhmmmklllkkH11K04mmklH04kmkhhhL04H04L08hhhL05H05L0adkM04kA10kM0akL04mmkllhmmmklllkkH17lllhllhkH04L04H04lhhL04H04L06hhhllhhL08hM04kA10M0bhL04mmkllhmmmklllkkH15L05hllhkH04L04H05lhL04H05L05hhhlkkL07khlkmmmkA0fdM0akhL04mmkllhmmmklllhkH18llhlllH05L04H05lhL04H04L05H06L08hmkkmmmkA0fhM0akhL04kkkllhmmmklllhkH18llhllH06L04H07L04H04L06H04L0akmK05A0fkM0akhL04kmkllhmmmklllhkH07lH10L04hllH04L04hlH05L05hhhL06hhhL0cH06A0fkM0akhL04hhhllhK04lllhkH07lH0flflhhlllH04L05H06L05hhlfL06hhL0dH05A0fhK06M04khL04hhhlllH04lllhkH06llH0flllhL05hhhL05H05L05hhhlfL06hL0eH05A06B05aaaflhhhlllhkkmkhL04hhhlllhhhL05H06lllH0flllhlllhlhhhL05hL04fL06hlfL09H04lfhhlllflhA11ffL09hhhL04hhhlllhhhL05H05L04H0flflhlllhhlhhL1bH06lF05baafA13fL0fhhhlllhhhL05H05lhllH0flllhlllhhhlhL18hhlH05fA22ffL09hhhlllhhhlllflH05L05H0elfflhhhL1dH08A26fL08hhlhlhhhbA22flllfL19H08aaflhhK04mmmkhkH09lF04bA07fL0dhfA26fL1bH08aadkP09khpkH08lllflF06aaF08L06hbA05bG1aA06F24aakP05khdF19aaF0faaaG21baaF12aaF10aahppkdF1daaF0faaaG07A05G15baaF06dF0aapmafbabffflllffllfaaddlflfL09fL11faafL0eaaaG06aadA04G0cA05gggbaadL0ffappkabmdaL09faaffL09F07L0ffaafL0eaaaG06ampkA04G0aadkdaaaggaaadL06F07bbaadppbmppbfL08faafL08dbA08ffA05bfL05aaafL0eaaaG06akphA04G0aampmaaaggA16bkddkpbfL08faafL07faaabhkdA0cL05aaaL0faaaG06bA06bG0aadmhaaaggA05bbdeeH04kkM05baahpbaafL08faafL06daabmpppkA04bkkdfaafL05aaaL0faaaG18bA05bggaabM11kbpkeobpkaL08faafL06babmP05mdamppkdlfafL05aaaL0faaaG21aabM0bdbbbmmkdppbdbbmafL07faafL06aamP07hakdbfffaafL05aaaL0faaaG0baaG14aaababM07bmpaadmmdbddppaaafL07faafL06abbkP06mA0afL04aabL0faaaG0aaaG15aahmaaM07bhkaabmmmkeappdbL09faafL06aebaappkaaemhafffdfL07aafL0fbaaG09baaabG13aabaaaM07K05M06bhpbfL09faafL06abdakppmaammhafL0afaafL0fbaaG09bA0aG0daaeM0behM09daaL09ffaaffL05aahmmmppM04aafL0afaafL0ffaaG21aahM0bhaeM09aadL08A07fllfaheemmmkabababF06L05daafL0fbaaG21aakM0akaadM09aadL07dA08fffbkhaeeebdhbaafA07flllfaafL0eA04G21aakM07kebaekhM09bafL07fA23baaafL0cdA05G20aaaeM04dbbehM0ebafL07fA11hmA04bkA0eL0cfaaagaaG20abA04ekM13dafL07bA0ebaaabbaaabdA0eL0bfaaaggaaG1fbaM04hbaabM11hafL07A0fbaaphpdahphA0efL09daaagggaaG1faaM1akafL07A11bpppaadpkA0efL09faaagggaaG1fadM1bafL07A0fbabpphaaapkA0efL0afaaaggaaG1ebahM1bafL07bA0dbbabppA04kkA0efL0bfaaggaaG1eaaM1caaL08fA0dbabpkA04kpA0efL0cbaabaaG1eaahM1baaL09fA0cbabpmA04pphA0dfL0dA05G1ebA04dkM17baL09fA0ebppaaahppdA0dfL0ddA04G21baababkM14daL09fA0fkmdaammmdA0dfL0efaaaG05B05A0cB06gbgggbaammkeM0bkhhheeddbaafL08fA25fL0ffA26hheedB06A10fL08fbA23fL0fdA33bA0ffdL07fA0cddfaaabA0cbafL0edfA08G08aafffaaaG08aaffbaaehhkmmmeadlfA13fL06fA1fL10fA0bG07aafldaaG09aafllbaM07eadlfA14L06fA09bA15L07fL07fA0dG06aafldaaaG08aafflfahM06dafA16fL05famP07dA0cbK04mmhaL07fflllfffA16lldA0dfllfA25flbampppmmkdA0eP06haL06fA04bA19lldA0dffllF08dA1dfbabdA14kP05daL05fA18ffddlldlllffbA07bbF05dL07dA3elllffA19fllF06bA17fffA37ddF07bAffAffAffA0c",
"pppkllhllhhlllM04pmmmkmkmmmP04mmkhkpphlmpmmmpmmmklllkkkhL0bhhlhhkM07kllldM0ekH04kkklhK04M0ahllpppkhlhL07mmmppmkkhhhkmmP05mmP04hllkM07klllkhhhlllhL07hlllhkM07hL04kM0eK04mmkL05kM0ahllkkhhlhkhhhL04mmmppmkH05kP06mmppmhL05kM06lllhhhlllhhL06hlhhllhhkkmmmkL05kM05khhkkM0aklhL04kkM08hllhL04hkmmmhlllM04pkH08mP04mmpmhkdL05hkkkmmllfH04lhL08H04L05hhkmkL05hM04kA06bdhkmmmkkkhlhL04hkM07hL07hkmmmhlllmmpmkH0akpppmmpmmmhlhhL04hhkmllfH05L07H04lhhhL04hhkL07kmmmdA0bdhdH04K07M07dL04hhlhkmmmhlllmmmkH0ckM08hlkmkhkkmmmklllH05lffL04H04L04hL04hhL07kmmmbA0fflhkM0ddllhkkhlhkmmmhlllmkkH0ekM04kkkdlkkkM06kllflH04L08hhhL04hhhllhL08dkmmA12lkM0cklllkmmhlhkmmmhlllmkH08fbblH04kmmmkkmhlkhhM06kllflH04L09hhflllH05llfL07hmmA12fkM0cklllkkmhlhkmmmhlllmkH08aaafH04kM06hlkhhkmK05llflhhhlhL07hhhflllH05llfL08kkA12dkM0bkhlllkkkhlhkmmmhlllkkH08aaafH05K06llkhhhkkH04llflhhhlllhL05hhlfllflH04L0bhkA12dkM0bkhlllmmmhlhkmmmhlllkH09aaafH09L04hhhlkH05flllH04lhL04H04L07hhhlhkL09hA11flkM0bkhlllmmkhlhkmmmdlllkH09aaafH08L06hlH07flllH04L06H05L05H05khL07khfA11flkM0bkhlllkkkhlhkmmmdlllkH09aaafH0blllhllH06llflH05L05H05L05H05L09kmhA11llkM0bhhlllhkkhlhkmmmdlllkH09aaabH0blflllhlH05L04H06L05hhhL07hhhL0bkdabbA0dfllkM0bhhlllkkkhlhkmmkdlllkH18lflllhllH04L04H06L05hhhL07hhhlfL07fabA04B06A07L04kM0ahhlllhhhlllhkkkL04kH07lhfffbH0blflhhlllhhhL05hlH04L05hhhL05fA09bfffA0ebbaaafL04hK07mmmhhlllhhhlllH04L04kH06llhaaabH0blflhL04hhhlfL05hhL07hhhfL04A21L06hhL05hkkhhlllhhhlllH04lfllH06lllhlllH0clflhL05hhL05hL12A22ffL0dhhlllhhhlllH04lfllH06lllH0fL07H05L18aaalH06dfdfbA14fL0ffllhhhlllH04L04H06L04hldldF04bA08flllhL1baafkmP09mkhhddfbA0ffdL10hhlllH04ffaafbbA1bhhL19hllaafP0ckhpkH06dffA0cfL0fhhllhlA24hllfL17dllaafmpppmkhllH05kH0dldfA08fL0fhlfA0aG18baallffldaabffL07F09lfdaafhhhL04fflH06L0ffffA06F0fllbA04G1ebaaF05abhhaaF13aaaF25aaaF11baaG19A05ggbaabA05mppmaF13aabF25aabF11baaG07A05G0cahmbaaagbaaappmbakpppafffL0ffaafL0edF06L0ffaafL11faaG06admdaaaG0bapphaaagbaaaP04habbbabaaL0ffaafL0cdbA09dlllF06lllfaafL11faaG06ampkaaaG0bakmbaaagA04bmpppboobppmafL0efaafL0bfA04ehhbbaaafA08fllaaaffL10faaG06admdaaaG0bA07gaaabA06opbbaaafL05F04L05faafL0afaaakmmppemmbA0afllaaafL11faaG06A07G0bA07gA06dahhbfhkaafL06A06fllfaafL0aaabmP05hA05bkmdlfaalllaaaL12faaG06A07G05bbaagggA0adkmkappkdpppbaL05fA08lfaafL06flllaammP05mA04hppkllfaallfaaaL12faaG07A06bA0aggbbA04bkM05appmamppmaL05A0afaafL07fafabhbmP06maepmhffbA04ffaaaL13aaaG0bA11bhM08eabaaahkdbL04fA0dflllflllaehaekaaepppmmkA0bfffaabL13aaaG07bA11bhM0dhkmkbaafL04fA0dfL06dbppdekaamppkaaakA05ffddlllfaafL13aaaG07A10eM07kmmkbhM08daaL04A0ffL05fahkabmmmP04aakmkabL09baafL13aaaG06A0ebkM08kmmdakM09kaaflldA10fL05fbaaakM05pM04bafL09aaafL13baaG05aaaggA08bkM0akmdabM0baafllfA11F04dlddbaakM06eA04fL09aaaL14faaG04baaG04bA05kM0eadM0cdaaldbA1dbeH04bmmaflllfL06aaaL14faagggbaaG07aaemmkdaadM0ahM0ckaaldA24bmmbdL06fffdaaaL14daagggaaaG07aaemhA05kM08bM05kadM06aaffA1ddhbA09ffflllA07L15aaggaaaG08baamampaaaeM07heM05A04eM04haadfA19baaamdA04dhA10L15aagbaaG0aaakdhkaaabM06kbM05bahbaabM04aadlfA17bbaakabbaaadkabA0efL14aaggaG0aaaabkA05bM06dbM04haemmhaaaemmhafllldfA15babppmmaakhdaabA0efL13aaG0cA05mA04bemmmkedabM04abM05haaahmaaL06fA13babpppbaapppbabA0ebL13aaaG0abaagaaemhkmkhmdhaapmammmdakM07baemdafL06dbA10bbabppkaaahppbA10fL13baaG0aaaggbaaM04kdabmaadbaemmaeM08aammkaaL08fA0fbbadppA05ppdA10dL13baaG09aaagggaahmmmkA0ahbaM08dahmmmbafL09fA0dbaadpmA05ppdabA0eL14baaG08baaG04aabM08dahhkaaakM08abM04haaL09fA10hpmA04bppbabA0dfL13dbaaG08aaG06aaM08badhbkaeM08daM06aafL08fA10hppA04mppA10L15faaggA10eM06hebekmkbM08kadM06haffaflfaaafA10hppbaabpppA0ffL15fA15M06dmkddM0bbaM07kA05fA06bfbA0ebbaakpppA0ffL15fA11bfaahM05khkM0chahM05eA10ffA24ffL11fbA09G07aafllaabM14abmmmhbA14bA23ffL10fA0cG06aafllaaaM13kamkbA21bhdaddbA13ffL0cfllfA0eG05bafllaaaemkkM10eA1ebhkmP04kaflA14ffL07F05A19fllA04kA04bM0bdA04bA1bhP06kdA17L08fA1cbfflfffA08dM06keA04bhmkA1chmppmA15bafL09fA19L0bfA08E04dA07emmeA36pafL08dA1alfffbA1cbdbA36pabfbAffAffA90",
"P32bA16kP68haaaB0eA05mP68kaB0aA07baaaP69kA17bbhP61mhA1dkP5fmA1fhM05P5amA29dhmP47mmP08mkhA2dkP44mllmkhdbA34mP43hA28B0aA09kP41mdA17bbbdddhhkkkmmP12mkbaaakP11hkP2eA0cbdhkkmkkhfffhP21kaaakP10kllmpmmP29mA06bhkmP0bmhlhP21haaakP10lllhpkkP2aA04ffhP0fhlhP21haaakP0fkL04mkkP2aA04lflmP0ckdlllP21haaamP0fkL04hkkP2aA04lhP0dhL05mP20daaamP0fkL04K04P14mkP12mA04dP0dkhL05hP14mkP0adaaamP09kP04mL05hkmP15kkP13A04dP09mppmkhL06hP13kkmP09daaamP09kP04kL06kmP15kkP10kppbaaafmP07mkpppmL07hP13kkmP09daaamP08mkmpppmL07kP14mkkmP07mkP05mlhpbaaafdhhP05mkpppmL07kpppmkhdbbdkmP04dA05dmP07daaamP08kkkpppkL07kkP11K05mP07mkP05hllkdaaaflllP05kkmpmkL05hhmmdA0admkA09kppklppbaaamP08kkkpppL07hkmP11kkpmkkP07kkP05hflkhaaaflhlkP04kkkppmL04hpkdA11bkkbA04hmlfhpbaaamP08kkmppmL04hkhkmP12kkpmkmP07kkkP04hllkhaaaflP07kkppphflllhkbA04bhM05kbA05mppkhA04hlllpbaaamP07mkkkpppL04hpppkkP10mK05P08kkmP04ellhdA04lhP05mkkmppkkklllA04dM0abaaahpppkkdA04lllkbaaamP08mkpppkL04hppkmP12K06P06mkkP04kdlllfA04llmP05kkmpppmkllA04hmP09mA04kppmkkmA04lllmbaaaP09kkmppkkklllhkmmP0cmP05kkkmkP07mkkmppmeglllfA04llhpmpppkkP04hllfaaakmP0amA04bppmkmpbaaafllkbaaaP0akmP04klllfhpmP0ckP05K04pmP07kkpppmgglllfA04llkkkpppmkmppplllaaaemP0bmA05dkkmmmhaaaflflbaaaP04mP05kP04kL05flmP06kP0bK04ppmP06kkpppeggelfdA04lhpmkP04kpppmflfaaammP0bmA06bA08flllA04P04kmpppmmpmpmdfffL04kppmpppkpmmpmP06kkpmkmkP07kpppG04lllA04fhppmppmkmP04kdfaaemP0bmhA0fL04A04P04kkP04mpkpdA06bfkppkppmkmkkpmP06kppmpkkmmP04mmpppgooelllbaaallkmkpK09dfaahmmdbkP06kaaadbaaahhhkkkmlfL04faaaP04mP05mmkdA0ahkkmpkkmkkpmP06mkpmppmmkP04mmpmpkaaflllA04mppphmK08lffaakmkaaaP06haaammaabP05mplllflldaaaP04mmpmppmmhA0edkkkmkkpkmmpppkpmpmpmkmkkP04mmmpmaaflllbaaakppmlmK09hhaahmmaaaP06mbahmmaadppmpkpmL05kkaaampppmppkppkhA11bhkkkmmpkmppkpppmppmpmP05mkmppfaflllfaaalkkhlK0bdaaemmkhmP07M04eaahppmpppL06hkaaakpppmppkkkfA15dkkkpkkppkpmpmppmpmmpkppmkkpphafflkkaaaflkllhK09aabaammmP06M06kaaakppmppmL07haaakpppmpkkkA08dddbbA0cbhmkkppkkkmkppmpmpmkmmK06aallppaaafL05K08dampmaeM0dkaaaflkmmpppkL06kaaakmpppmkdA08dE06dbA0bpkkppK06pmK0chaadlhpaaafL06K07fbppmbaeM0beA04flhkkmP04hlllkfaaahkkmmkbA07bE0bdbA08K04mK0chK06hA05hpbaafL05K08bakmhaaabkM05khbA05ffflkkkmmpkfffdhA04hK04A08dE0edbA06pK0fhlK06A07baaabkkkllhK07hA2ahkkdA08dE12bA04pK0fhlhK04hA0bbkkklK08hdbA29hkfA07bE16daaK10dlhK04A0dbhllhhdfA17bhhbA15dA08dE19dhhK0elllkkkhA22kmphA06bpmaabbbA19dE1bhhK04lK09llfkkkA20baaakpA08daaabbbA17bE1dH05llK08dlllhkhA1ebbaaabaaamA04bpadkaabbbA15dE1eH05llK08L05kbA1dbbbaaapkbapkaaaP05A19dE1fH04lllK07hL04hkA1dB04aaaP05haaamP04A17bE21H04lllhK07hlllkdA20baaaP05A05P04A16dE22H04lllhK07L05A21baaaP04kA05hpppbaabA11dE23H04lllhK05hL05fA21baaampppbA06pppdaabbA0fdE24L06flH06llhlhllA1fbbaaampppA07mpphaabbA0edE25F07L0aflllfA1ebbaaakppkA07pppkaabA0edE26F18A1cbbaaakppdA06bpppkaabA0ddE27F11lffL05ffA19bbbaahppkA06hppphA0fdE28L1cfA18bbaadpppA06P04hA0edE29L1effA16baabppphA04bP04kA0cbE2bfL0dfllfL0fA15baabP04A04kpmkbA09bdddE2cffllfL06fL04fL10bA18D04A10bdE30L17F0abA29bdE33L17A32bdE35L12fL04A2fbdE38L17aaG09A22bdE3aL0cfbbbF07aaG09A1fbdE3dffL0aA0dG0cA1abdE3fffL0aA0dG0cA17bdE42L0caaG09aaG0cA15bdE44",
"G11A06G0dA06G21A05G0eA06G2dA06G0cbA06G20A07G0dA06G2dA06G0cA08G1fA07G0cA06G2eA07G0bbA07G1eA08G0cA07G26aaG04A08G0bA09G1dA09G0bA07G26aaagggA08G0bA09G1dA09G0bA08G24A04ggA09G0abA42G20aaggA04gggA08G07A46G1fA04gA04gggA09gggA49G1fA04gA05G04A07ggA4bG12aaG0aA04ggA04G05A53G12aaaG04aG04A04ggA04G04A20G1eA16G12aaaG04aG04A04gA04G04A11gggA0eG1bbA0eggA07G08aaG07A04G04aG04A09gggA0fG05bA0fG19bA0fG04A05G07aaaG07A07gagggA06gaaagggA0fG05aabhdA0cG18aakmkbA0bgggA05G07aaaG07A07gagggA0aggA11gggaadpppmA0cG16aahP04A0cggA05G07aaaG07aaagaaagaggA0bggA11gggaakP04A0cG16aamP04A0cggA05G07A04G07A08ggA0bggA11gggaakP04A0cG16aakP04A0cggA05G07A04G06A09ggA07gaaaggA11ggbaabppphA0cG16aaamppbA0cggA05G07A04G06A0agA07gaaG04aabA06gA06ggbA04bbA0dG16A13gbA05G07aaaG07A12gaaaggA11ggA14G16A13gA06G07aaaG05aaggA10gaaaggA0agA06ggA14G16A13gA06G07aaaG04A15gA04gA0agA06gggA13G16A13gA06G06agaaG04A06gA1egA06gggA0fbbaaG16A13gA08G04agaagggA07gA1egA06gggA0fbbaG18A0ebbaagA08G04aaaG04A05gagA25G04A0dbbaaG18A0ebbaagA08G04aaaggagA05gaggA1dbA06G04A0dbaaG06A0dG07A0cbbaaggA09ggA05gagA05gaggA1dbA06G05A0fG04A11G06A0egggA38bbA06G06A0dG04A13G06A0cG04A38bgA06G08A09G05A16G06A08G06A06bA31bbA06G15A18G13A2abA0cbgbbA05G14A19G13A06bA13bA0fbaabA09bgbA06G13A1bG12A06bbA04bA0dbaabA0cgA0bbbgbA06G13A1cG11A06bgA04bA0dgA0dbbgA0bbbgbbA05G12A1dG05aaG0aA06bgbaaagbA0abbgA0dbgbaaabA06bgbggbbA04G12A1egggA04G09A06bggbabbbA0abgbaaabA07bgggbabA05baabgbggbbA04G0aaaG05A1fggA06G08A06bggbabggbA07bgggbabA08bbgggbA07bA04bgggbA04G09A04G04A28G07A04babggbbaggbbA05bbgggbA0abbgggbabbA09bgggbA04G08A07gA2aG06A04bbeggbbabgbA06bbgggbabbA08bG04bbbabA07bgggbA04G07A2dgA06G05A04bG04bbbggbA07bG04bbbabA06eG06babA07G04eA04G07A2cgggA06G04A04bG04bbgggbA07G07bbbA06G07bbbA06bG05A04G06A05ggA25G05A06gggA04bG04bbgggbA07G07bbbA05bG09bA06G06A04G05A06gggA07dkkM12dA05G08A05gggA04bG0aA06bG09bA04bG0abbbaaabG06A04G04A06G06A05bP13hA05G0aA05ggA04bG0aeA04bG0abA04G0bbbbgaaaG06A04G04A05G08A06kmmP09mmkkhbA05G0cA05gA04bggeeegE05aabbE0cbbaaE0egfbbE04gebaaagggA05G0bA1aG0dbA09fD04egeD25egeD04eeegfaaagggA04G0dA18G0fbA08deedE04llE15ddeD09E07degeeogaaaggA05G0eA16G11A08eeeleehheeeggE08dE0aD05eedE05ggedeeegeeogaaagA05G11A13G13A07E06ooE0ddE04lE07deeeleeleeeoogeehhgggogaaagA04G13A04G09A04G15A06fE05ooeeegeedE06lE0cdE06geeeoogeeO06gA07G14A04G09A05G15A05fhG04oogedegE07deedelelE10gO0beA07G13A04G0bA05G15A04eO07lE05hE0adeehE05lE04heedeeO0beA06G13A05G0cA05G14baaaeO06geeleeglE07dE04gE05dE04hgedeeehgO09eA05G14A04G0dbA04G15aaabO06gE05glE05dE06oE04lE06G04eegO0aeA04G14A05G0eA05G14aaabO06geeggoohE07gE04oedgedE06ooogeegO0aeA04G13bA04G10A05G13aaabO06geeO04ggE06gE04oeegE04legO05eegO0aeaaaG14A04G12A05G12A04O06geeO06egeleeoE04geegE04gegO05eegO0aeaaaG13A05G13A05G11A04O06geeO06egE09gedeeedegeO06eegO0aeaaaG13A04G14A05G11A04O06gogO06ggeddeedleeoE04deeggO08gO0aeaaaG12A04G16A05G10A04O0fggE09oE07ggO13eaaaG12A04G17A05G0fA04gO0fgE06geegoE06gO14eaaaG11A04G19A04G0fA04gO10gE05oeegogE04gO15eaaaG11aaaG1bA04G0eA04gO10gE04goeeoogegeegO15fA04G0faaaG1daaaG0eA04gO10geegghO04",
"B22A21G08A09bbA1eG0cB22A32B04A1dG0bB21A35B04A1cG0aB21A05B0aA27B05A1aG0aB21A05B06D04B06G04A1fB05A17ggaG08B21A05bhmP10mG06A1bB04A16gaaG08B21A05kP14ggemmG07A16bbbA12gggA04G07B21A05kP0bmK04mmmggahppG0eA10B04A10gggA04G07B21A04bkP06mkdbbA06G04aadbG12A0ebbbA10ggA04G07B20A05bdpmkhdB06A06G04A04G14A0ebbA09gA06gA04G07B20A05B0eA06gggA04G14A0fbbA14G07B20A05B0eA06gggA04G14A10bA15G06B20A05B0fA06gA05G15aaabeA0fbbA10G05B20A05B0fA06gA06G13A14bbbA10G05B20A05B0fA0dG12A15bbbA10G05B20A05B10A0dG11A05gA11baagA0cG06B20A04B11A13G0bbaagA23G06B20A04B12A16G08bbgA04ggA1dG06B1fA05B12A17G04aaagbbaggA14ggA0aG06B1fA05B12A0dB04A07G04abgbaaggA10baaaggA0bG05B1fA05B13A09hM08hA05G04agggbgbaaeA0aB04A10G05B1fA05B13A07hmmmP04mmmkeeA04ggaabbbA0fB05A0fG06B1fA05B14A04bmmP09mammhA04bA14B05A08gA06G06B1fA05B14aaabmmP0amaemmbA18B05A08gA05G05agB1fA04B14A04mmmP0baadhbA18B05A04gaaagaaabaagggaagB0cA04B0fA04B14aaaemmP0cbA08begmmmggA0cB06A07gbaaeaaggA04B0bA07B0dA04B14aaammP0dkA07eoP05ogA0cB06aagA04gbbabaaggA04B0aA0aB0bA04B14aaammekP0ckhebaaamP04O04gA0bB06aagA04gggA04gggaagB09A0cB0aA04B14aaammeaakP0bmmbaaapppO06gA0cB05aagA06gA05gbaagB08A07bA07B08A04B14aaammmaaadP07kebabbaaaeooggeebbA0dB05A09eggbaagbaaaB07A07dhbA07B07A04B14aaammmA04hP04mbaaaemkA16eaaB05A08bgoogbA06B06A07dhhhbA07B06A04B14A04emaaabmP04mA04mmkA0fbbA05eaaB05A06ebgO04gA06B05A07dH05bA07B05A04B13aabdbabkbbmmP05baaammbA09egebbA0bB05A0aB04aaabaaB04A07dH07bA07bbbA06B12abpppeaM0akaaamhA1aB05A14bbbA07dH09dA07bbA19dmmmhaM0bhabdA1bB05A14bbA07dH0bdA07bA20dhkM06eA07bbbA15B05A14bA07dH0eA2cbeedaeppkaaB06A13B05A1bdH10bA2fbhkmbaB08A05B04A04B17A0cdH12bA1fbmmkhA12B0fA04B1dA05dH14bA18B04aaabppdA07bbA0fB08A05B1dA04dH16bA16B04aaababhA08bppmA12bbA05B1eaaaH19bA14B05aaaphaabkA07mkaaabA16B1eaaH1bbA16bbaaappkakpbA04kdA05bbbA14B1eaH1ddA16baabP06baaampmbmkaabbbA14B1eH1fdA18dP05hA04P05haabbbA14B1eH20bA17kP04mA05kP04haabA16B1eH21bA16kP04bA05bP04dA19B1eH22bA15mppphA07P04dA19B1eH23bA14P04A08kpppbA19B1eH24bA13ppphA08kpppbA18B1fH25bA11bpppbA08mpppA19B1fH26bA10bpppdA07bP04A19B1fH27bA0fdppphA07mpppmaaabA15B1fH28bA0ehpppmA06hP04hA38H29bA0dkP04A06P05dA38H2abA0dbhkpA05mP05A39H2bA16mmP04A39H2cA1abA39H2dA53H2eA52H2fA4fbbH30A3dB05D05H3aA2aB05D06H4cA1cbbbdddH2c",
"G11A06G0dA06G21A07G0cA07G2cA06G0cA08G20A07G0aagA06G2dA07G0bA08G1fA08G09A09G2dA07G0cA08G1dA09G08A0bG22aaaG06A08G0bA09G1dA09G04aaggA0cG21aaaG05A09G0bA09G1eA09ggaaaggA0cG1fA05G05A09G0bA08G1caagA09ggA11G1eA07G05A09G0aA06gggA28gA11G1eA07G05A09G09A43G1fA07G08A07G08A41G21A08G07A07G08A42G20A07G07A08G0aA09G25A12G20A07G06A0aG08A05G2fA07gA05G1fA08G05A0bG08A05G07A05G23A0fG08aG14A08G04A0cG08A05G06A08G14A07G06A06bA08G07aaaG0fagggA07G05A0cG08A05G05aahhA06G12aahhA05G05A0fG07aaaG0faggA09G04A0bG0aA04G04aakppkA05G11aampphA04G05A04gA0bG06A04G0eaggA09G04A0cG09A04G04aamppmA05G11aappphA04G05A04gA0bgaaggA05G0eaggA07G06A0bG07agA05G04aabppbA05G11aadpmA05G05A04gagA07gggaaggA05G0eaggA08G04aaggA08G05aaaggA04G04A0bG11A0aG05A04gA08G04aaagA04G0fagA0agggA0cG04A04ggA04G04A0bG12A09G05A0eggA0aG05aG08agA0aggA0agaG05A05gA04G05A09G13A08G06A10gaaagA04G06aG07aagA18ggagA06gA04G2ebA10gA04gaaaG06aaG06A1cgA0dG21aaaG0abA13G04aaG05A04G05aaaggA16bgaaggA09G21A05G08A19G06A04G05aaaggA1aggA09G23A04G07bA04bbA12gaG04A04G05A25bA04G22A05G07A1bgggA06ggA24baabA04G21A06G07A1cggA06gA07gA1dbaabA04G1eA06ggaG07A1cggA2cbA07G19A09G0cA11bA31bA0eG17A07G10A05bA3dbabaaabA08G2ebA04bbA3bbaabaaabaaabA04G2ebaaabbaabbA38bA06bA08G2ebA08bA38baabA0cG2fA10bA22bA0dbbabA0cG2fA08bA05baabbaaabA0dbA0dbbaabA0abbabA08gaaaG2faaabA04bA09bababA0cbbaabA09bA04bA08bbggbbaabA04ggaaaG2faaagbA08bA04bA04bA0abA04bA09bA05bA07bbggbbbA05gggbaaG2faaaggbA07bbabbbA04bA0abA05bA08bbbaaabA07bbggbbbA04G04baaG2faaagggbA06baabgbbaaebA0abbbaaabA07bgggbA0bbggbbbA04G04aaaG2faaaG04A06babgggbbbggbA08bgggbA08bbG05A06bA04bgggbbA04G04aaaG2faaagggA04baabbbgggbabggbA06bbG05bA07bbG05B04aabA04G05A06gggA04G2eaaaggbaaabaaabbG05bgggbA06bbG05bbbA06G08bbA06bG05bbbA04ggA04G2eaaaggaaabgaaabG0abA07bG07bA05bG09bA06bG05bbbeA04gA04G2eaaagA04bbbaaB0cA06B0aA04B0cA06B09A05gA04G2eA52G2eA52G2eA52G2eA52G2eAffAffA58G0dA0bG0cA5cG0dA0bG0cA5dG0cA0bG0cA5dG0cA0bG0bAffAffAffA33"
}


lp=0
np=0
et=0
fps=0
etg={}
for i=1,20 do table.insert(etg,0) end

function FPS()
	if t%12==0 then
		for i=1,19 do
		 etg[i]=etg[i+1]
		end
		etg[20]=math.floor(et)
		fps=math.floor(1/(et/1000))
	end
	if fps>60 then fps=60 end
 rect(4,4,34,7,0)
 print("FPS:",5,5,10)
 print(fps,26,5,15)
	rect(4,11,13,7,0)
	print("et:",5,12)
	rect(18,11,21,1,15)
	rect(38,11,1,etg[20]/2+1,9)
	for i=1,20 do
	 local c=11
		if etg[i]>20 then c=4 end
		if etg[i]>25 then c=6 end
	 rect(17+i,12,1,etg[i]/2,c)
	end
	print(math.floor(1000/fps),19,13)
	pix(37,etg[20]/2+11,9)
end

function recolor(r,g,b,rev)
 rev=rev and rev or false
 local bgc=(rev and {13,9,2} or {2,9,13})
 for i=0,2 do
	 rh=(r*3)/2*i+r*13
	 gh=(g*3)/2*i+g*13
	 bh=(b*3)/2*i+b*13
		rh=rh>255 and 255 or rh
	 gh=gh>255 and 255 or gh
	 bh=bh>255 and 255 or bh
		rh=rh<0 and 0 or rh
		gh=gh<0 and 0 or gh
		bh=bh<0 and 0 or bh
  poke(0x03FC0+bgc[i+1]*3,rh)
 	poke(0x03FC1+bgc[i+1]*3,gh)
 	poke(0x03FC2+bgc[i+1]*3,bh)
 end
end

obgpal={}
for i=0,16*3-1 do table.insert(obgpal,peek(0x3FC0+i)) end
function filter(r,g,b,l)
 l=l and l or "all"
	local bgpal={2,9,13}
	for i=(l=="all" or l=="bg") and 1 or 3,(l=="all" or l=="fg") and 14 or 1 do
	 if i~=bgpal[1] and i~=bgpal[2] and i~=bgpal[3] then
 	 poke(0x3FC0+i*3,obgpal[i*3+1]*r<0xDE and obgpal[i*3+1]*r or 0xDE)
 		poke(0x3FC1+i*3,obgpal[i*3+2]*g<0xEE and obgpal[i*3+2]*g or 0xEE)
 		poke(0x3FC2+i*3,obgpal[i*3+3]*b<0xD6 and obgpal[i*3+3]*b or 0xD6)
			poke(0x3FC0+i*3,peek(0x3FC0+i*3)>0x14 and peek(0x3FC0+i*3) or 0x14)
			poke(0x3FC1+i*3,peek(0x3FC1+i*3)>0x0C and peek(0x3FC1+i*3) or 0x0C)
			poke(0x3FC2+i*3,peek(0x3FC2+i*3)>0x1C and peek(0x3FC2+i*3) or 0x1C)
		end
	end
end

function cbgc(m)
 if m==1  then recolor(14,16,15)
	elseif m==2  then recolor(14,16,15)
	elseif m==3  then recolor(16,15,12) filter(0.9,0.9,0.9)
	elseif m==4  then recolor(14,16,16)
	elseif m==5  then recolor(14,16,15) filter(1,1,0.9,"bg")
	elseif m==6  then recolor(15,12,9) filter(1.1,1.3,0.9,"bg")
	elseif m==7  then recolor(15,11,7) filter(1,1.1,0.9,"bg")
	elseif m==8  then recolor(14,8,5) filter(1.3,1,0.7,"bg")
	elseif m==9  then recolor(2,1,4,true) filter(0.7,0.7,0.8)
	elseif m==10 then recolor(4,3,6,true) filter(0.7,0.7,0.8) filter(0.7,0.7,0.7,"bg")
	elseif m==11 then recolor(14,16,15) mh=-2 filter(0.9,0.9,0.9)
	elseif m==12 then recolor(14,16,15) mh=-1 filter(0.9,1,0.9,"bg")
	elseif m==13 then recolor(15,16,15) filter(1,1.2,1.1,"bg")
	elseif m==14 then recolor(15,13,12) filter(1,0.9,0.9) filter(1,0.9,0.8,"bg")
	elseif m==15 then recolor(4,2,3) filter(0.9,0.9,0.9) filter(0.9,0.9,0.8,"bg")
	elseif m==16 then recolor(5,1,1,true) filter(0.9,0.8,0.8) filter(1.3,0.4,0.3,"bg")
	elseif m==17 then recolor(5,2,2) filter(0.8,0.7,0.7)
	elseif m==18 then recolor(1,2,5,true) filter(0.7,0.7,0.8) filter(0.5,0.5,0.7,"bg") mh=2
	elseif m==19 then recolor(4,2,3) filter(0.8,0.7,0.8) filter(0.7,0.5,0.6,"bg")
	elseif m==20 then recolor(13,15,16) filter(0,0,0) filter(0.4,1.3,2,"bg")
	elseif m==21 then recolor(12,14,13) filter(0.9,0.9,0.9) filter(0.8,1.4,0.8,"bg")
	elseif m==22 then recolor(7,2,1,true) filter(1,0.8,0.7) filter(0.6,0.4,0.2,"bg")
	elseif m==23 then recolor(15,12,12) filter(0.8,0.8,0.8) filter(0.8,0.5,0.7,"bg")
	elseif m==24 then recolor(1,1,3) filter(0.9,0.9,0.9) filter(0.6,1.2,1.6,"bg")
	elseif m==25 then recolor(4,2,4) filter(0.8,0.8,0.8) filter(0.5,0.4,0.6,"bg")
	elseif m==26 then recolor(6,3,4) filter(0.8,0.7,0.7) filter(0.9,0.8,0.7,"bg")
	elseif m==27 then recolor(9,12,15) filter(0.8,0.8,0.9) filter(0.7,0.8,0.9,"bg") mh=-2
	elseif m==28 then recolor(7,10,12) filter(0.9,0.9,0.9) filter(0.8,1,0.9,"bg")
	elseif m==29 then recolor(4,13,16,true) filter(8,8,8) filter(2,5,5.2,"bg") mh=1
	elseif m==30 then recolor(2,2,2,true) filter(0.7,0.7,0.7) filter(0.6,0.7,0.6,"bg")
	elseif m==31 then recolor(6,3,4) filter(0.9,0.9,0.9) filter(0.8,0.8,0.7,"bg") end
end

function tget(x,y)
 local cwith=0
 -- 0 - empty
	-- 1 - solid
	-- 2 - solid lower diagonal
	-- 3 - solid upper diagonal
	-- 4 - deals damage (never used lol)
	
	for i,j in pairs({3,2,1,4}) do
	 if cold(x,y,j) then
		 cwith=j
		end
	end
		
	return cwith
end

function loadmap(id)	
 cm=id
	
	mh=0
	filter(1,1,1)
	cbgc(cm)
	rfs={math.random(0,120),math.random(0,120)} -- random parallax bg offset
	bl={} sbl={} -- remove blood
	respawn()
	dt=40 -- reset death
	ft=40 -- and level end time
	lnt=cm==16 and 0 or 80
	pbdata={} -- erase last replay
	pbtry=0
end

function respawn()
	for iy=Maps[cm].id[2]*17,(Maps[cm].id[2]*17)+Maps[cm].wh[2]*17-1 do
	 for ix=Maps[cm].id[1]*30,(Maps[cm].id[1]*30)+Maps[cm].wh[1]*30-1 do
		 if mget(ix,iy)==154 then
 			mset(ix,iy,152)
			end
			if mget(ix,iy)==144 then
			 mset(ix,iy,153)
			end
		end
	end

 p.x=Maps[cm].sp[1]*8+4-p.hbx/2
	p.y=Maps[cm].sp[2]*8
	p.vx=0
	p.vy=0
	cx=p.x-116
	cy=p.y-64
	dmgobj={}
	dstr={}
	st=-28
	pbtry=pbtry+1
	clvlt=0
end

function die()
 if not dead and not playback then
  dead=true
		dt=0
		psfx(nsfx.death,15,36+math.random(0,4))
		for i=1,40 do
		 addPt(p.x+p.hbx/2,p.y+p.hby/2,"dth")
		end
	end
end

function initSaws()
 for i=1,#Saws do
  for j=1,#Saws[i] do
 	 local h=Saws[i][j]
 	 Saws[i][j]={pos={tonumber(string.sub(h,1,3))+tonumber(string.sub(h,4,4))/10,tonumber(string.sub(h,5,7))+tonumber(string.sub(h,8,8))/10},s=tonumber(string.sub(h,9,9)),l=string.sub(h,10,10).."g"}
 	end
	end
end

function initPipes()
 for i=1,#Pipes do
  for j=1,#Pipes[i] do
 	 local h=Pipes[i][j]
 		local p={}
 		for k=10,string.len(h) do
 		 table.insert(p,tonumber(string.sub(h,k,k)))
 		end
 		Pipes[i][j]={sp={tonumber(string.sub(h,1,3))+tonumber(string.sub(h,4,4))/10,tonumber(string.sub(h,5,7))+tonumber(string.sub(h,8,8))/10},path=p,l=string.sub(h,9,9).."g"}
 	end
	end
end

function decompic()
	for j=1,6 do
	 local c,q,i,p,buf=0,0,0,0,""
 	buf=pics[j]
 	pics[j]={}
  while p<128*64 do
   if q>0 then
    pics[j][p+1]=c-string.byte('a')
    q=q-1
   else
    c=string.byte(string.sub(buf,i+1,i+1))
    if c>=string.byte('a') and c<=string.byte('p') then
     pics[j][p+1]=c-string.byte('a')
     i=i+1
    elseif c>=string.byte('A') and c<=string.byte('P') then
     c=c+(string.byte('a')-string.byte('A'))
     q=tonumber("0x"..string.sub(buf,i+2,i+3))
     i=i+3
     p=p-1
    end
   end
   p=p+1
		end
 end
end

function pic(img,x,y)
 for i=0,128*64-1 do
	 pix(i%128+x,i//128+y,pics[img][i+1])
	end
end

function customStuff()

 if cm==9 then
	 Saws[9][1].pos[1]=217.5+math.abs((st%(65*2)-65)/16)
		Saws[9][2].pos[2]=11-math.abs((st%(75*2)-75)/16)
	
	elseif cm==10 then
	 Saws[10][1].pos[1]=18.5-math.abs((st%(85*2)-85)/18)
		Saws[10][2].pos[2]=37+math.abs((st%(80*2)-80)/16)
		Saws[10][3].pos[2]=29+math.abs((st%(80*2)-80)/16)
	
	elseif cm==12 then
	 Saws[12][2].pos[1]=197+math.sin(st/20)*3
		Saws[12][2].pos[2]=45-math.cos(st/20)*3
		for i=0,3 do
 		line(197*8+3-cx+i%2,45*8+3-cy+i//2,(197+math.sin((st-1)/20)*3)*8+3-cx+i%2,(45-math.cos((st-1)/20)*3)*8+3-cy+i//2,10)
		end
		Saws[12][3].pos[1]=194+math.sin(st/45)*5
		Saws[12][3].pos[2]=26-math.cos(st/45)*5
		for i=0,3 do
 		line(194*8+3-cx+i%2,26*8+3-cy+i//2,(194+math.sin((st-1)/45)*5)*8+3-cx+i%2,(26-math.cos((st-1)/45)*5)*8+3-cy+i//2,10)
		end
	
 elseif cm==13 then
	 Saws[13][1].pos[1]=217.5+math.sin(st/15)*3
		Saws[13][1].pos[2]=42.5-math.cos(st/15)*3
		for i=0,3 do
 		line(217.5*8+3-cx+i%2,42.5*8+3-cy+i//2,(217.5+math.sin((st-1)/15)*3)*8+3-cx+i%2,(42.5-math.cos((st-1)/15)*3)*8+3-cy+i//2,10)
		end
		Saws[13][2].pos[1]=225+math.sin(st/15)*3
		Saws[13][2].pos[2]=42.5-math.cos(st/15)*3
		for i=0,3 do
 		line(225*8+3-cx+i%2,42.5*8+3-cy+i//2,(225+math.sin((st-1)/15)*3)*8+3-cx+i%2,(42.5-math.cos((st-1)/15)*3)*8+3-cy+i//2,10)
		end
		Saws[13][3].pos[1]=232.5+math.sin(st/15)*3
		Saws[13][3].pos[2]=42.5-math.cos(st/15)*3
		for i=0,3 do
 		line(232.5*8+3-cx+i%2,42.5*8+3-cy+i//2,(232.5+math.sin((st-1)/15)*3)*8+3-cx+i%2,(42.5-math.cos((st-1)/15)*3)*8+3-cy+i//2,10)
		end
		Saws[13][4].pos[1]=220.5+math.sin(st/15)*3
		Saws[13][4].pos[2]=47.5-math.cos(st/15)*3
		for i=0,3 do
 		line(220.5*8+3-cx+i%2,47.5*8+3-cy+i//2,(220.5+math.sin((st-1)/15)*3)*8+3-cx+i%2,(47.5-math.cos((st-1)/15)*3)*8+3-cy+i//2,10)
		end
		Saws[13][5].pos[1]=229.5+math.sin(st/15)*3
		Saws[13][5].pos[2]=47.5-math.cos(st/15)*3
		for i=0,3 do
 		line(229.5*8+3-cx+i%2,47.5*8+3-cy+i//2,(229.5+math.sin((st-1)/15)*3)*8+3-cx+i%2,(47.5-math.cos((st-1)/15)*3)*8+3-cy+i//2,10)
		end
	
	elseif cm==14 then
	 Saws[14][13].pos[1]=95.5+math.sin(st/16)*3.8
		Saws[14][13].pos[2]=43.5-math.cos(st/16)*3.8
		for i=0,3 do
		 line(95.5*8+3-cx+i%2,43.5*8+3-cy+i//2,(95.5+math.sin((st-1)/16)*3.8)*8+3-cx+i%2,(43.5-math.cos((st-1)/16)*3.8)*8+3-cy+i//2,10)
		end
		Saws[14][14].pos[1]=108+math.sin((st-10)/16)*4
		Saws[14][14].pos[2]=41.5-math.cos((st-10)/16)*4
		for i=0,3 do
		 line(108*8+3-cx+i%2,41.5*8+3-cy+i//2,(108+math.sin((st-11)/16)*4)*8+3-cx+i%2,(41.5-math.cos((st-11)/16)*4)*8+3-cy+i//2,10)
		end
	
	elseif cm==16 then
	 Saws[16][14].pos[1]=165+math.sin(st/16)*3.5
		Saws[16][14].pos[2]=66-math.cos(st/16)*3.5
		for i=0,3 do
		 line(165*8+3-cx+i%2,66*8+3-cy+i//2,(165+math.sin((st-1)/16)*3.5)*8+3-cx+i%2,(66-math.cos((st-1)/16)*3.5)*8+3-cy+i//2,10)
		end
		Saws[16][15].pos[1]=173-math.sin((st-8)/16)*5
		Saws[16][15].pos[2]=59.5+math.cos((st-8)/16)*5
	 for i=0,3 do
		 line(173*8+3-cx+i%2,59.5*8+3-cy+i//2,(173-math.sin((st-9)/16)*5)*8+3-cx+i%2,(59.5+math.cos((st-9)/16)*5)*8+3-cy+i//2,10)
		end
		Saws[16][16].pos[1]=181+math.sin((st-4)/16)*3.5
		Saws[16][16].pos[2]=66-math.cos((st-4)/16)*3.5
		for i=0,3 do
		 line(181*8+3-cx+i%2,66*8+3-cy+i//2,(181+math.sin((st-5)/16)*3.5)*8+3-cx+i%2,(66-math.cos((st-5)/16)*3.5)*8+3-cy+i//2,10)
		end
		Saws[16][24].pos[1]=221.5+math.sin(st/16)*3.5
		Saws[16][24].pos[2]=63-math.cos(st/16)*3.5
		for i=0,3 do
		 line(221.5*8+3-cx+i%2,63*8+3-cy+i//2,(221.5+math.sin((st-1)/16)*3.5)*8+3-cx+i%2,(63-math.cos((st-1)/16)*3.5)*8+3-cy+i//2,10)
		end
		
	 if st>16 then
		 if st<1414 then
  		rx=56+st/8
  		ry=62+math.sin(math.rad(st/62*360))/4
				if st==1413 then rx=233.5 end
			else
			 rx=233+((st/4)%2)/8
  		ry=62.5
			end
		else
 	 rx=58
 		ry=62.5-st/32
		end
		if st>16 and st<1414 then
 		if (st//12)%5==0 then Pipes[16][24]={sp={rx,61.5},path={5,8,9,8,7,6,6},l="fg"} end
 		if (st//12)%5==1 then Pipes[16][24]={sp={rx,61.5},path={5,8,8,8,7,6,6},l="fg"} end
 	 if (st//12)%5==2 then Pipes[16][24]={sp={rx,61.5},path={5,8,8,7,7,6,6},l="fg"} end
 		if (st//12)%5==3 then Pipes[16][24]={sp={rx,61.5},path={5,8,9,7,6,6},l="fg"} end
 		if (st//12)%5==4 then Pipes[16][24]={sp={rx,61.5},path={5,8,6,9,8,6,6},l="fg"} end
 		
 		if (st//12)%5==3 then Pipes[16][25]={sp={rx,61.5},path={5,8,9,8,7,6,6},l="bg"} end
 		if (st//12)%5==4 then Pipes[16][25]={sp={rx,61.5},path={5,8,8,8,7,6,6},l="bg"} end
 		if (st//12)%5==0 then Pipes[16][25]={sp={rx,61.5},path={5,8,8,7,7,6,6},l="bg"} end
 		if (st//12)%5==1 then Pipes[16][25]={sp={rx,61.5},path={5,8,9,7,6,6},l="bg"} end
 		if (st//12)%5==2 then Pipes[16][25]={sp={rx,61.5},path={5,8,6,9,8,6,6},l="bg"} end
		 if 8*(rx-1.5)-cx+8*16>0 and st%30==0 then psfx(nsfx.ms,5,36+math.random(-2,4)) end
	 else
		 Pipes[16][24]={sp={rx,61.5},path={5,8,9,8,7,6,6},l="fg"}
		 Pipes[16][25]={sp={rx,61.5},path={5,8,8,7,7,6,6},l="bg"}
		end
		
		Pipes[16][22]={sp={rx,ry-2},path={5,8,8},l="fg"}
	 Pipes[16][23]={sp={rx-2,ry},path={6,6},l="fg"}
		spr(400+((st%6)//2)*3,(rx-2.25)*8-cx,(ry-1.25)*8-cy,0,1,0,0,3,3)
		map(180,119+((st//4)%2)*4,10,4,8*(rx-1.5)-cx,8*(ry-2)-cy,8)
		spr(400+((st%6)//2)*3,(rx-1)*8-cx,(ry-1)*8-cy,0,1,0,0,3,3)
		if st<1414 then if (p.x+p.hbx>8*(rx-2) and p.x<8*(rx-2)+8*10 and p.y+p.hby>8*(ry-1) and p.y<8*(ry-1)+8*2) or (p.x+p.hbx>8*(rx-1) and p.x<8*(rx-1)+8*5 and p.y+p.hby>8*(ry+1) and p.y<8*(ry+1)+8*3) then die()	end end
		
		if st>707 then
		 if math.random(0,64)==0 then
			 local rrx,rry=math.random(-16,16),math.random(-8,8)
				for i=1,5 do
				 addPt(rx*8+rrx,ry*8+rry,"sk")
				end
			end
		end
		if st>1414 then
		 if math.random(0,32)==0 then
			 local rrx,rry=math.random(-16,16),math.random(-8,8)
				for i=1,20 do
				 addPt(rx*8+rrx,ry*8+rry,"exp")
				end
				psfx(nsfx.exp,12,36+math.random(-2,4))
			end
		end
		
		if st>1564 then svol(1-(st-1564)/500) mvol(1-(st-1564)/300) end
		if st>1764 then filter(1,1,1) cpic=3 gstat="showpic" st=0 end
	
	elseif cm==25 then
	 Saws[25][1].pos[1]=228+math.abs((st%90-45)/15)
		Saws[25][2].pos[1]=213.5+math.abs((st%120-60)/15)
		Saws[25][3].pos[2]=76+math.abs(((st+60)%200-100)/20)
		Saws[25][4].pos[2]=81-math.abs(((st+60)%200-100)/20)
		Saws[25][5].pos[2]=77+math.abs((st%160-80)/20)
		Saws[25][6].pos[2]=77+math.abs((st%160-80)/20)
		Saws[25][7].pos[2]=77+math.abs((st%160-80)/20)
	
	elseif cm==26 then
	 Saws[26][4].pos[2]=105+math.abs((st%150-75)/15)
		Saws[26][5].pos[2]=97+math.abs((st%150-75)/15)
		Saws[26][6].pos[1]=15+math.abs((st%150-75)/15)
		Saws[26][7].pos[1]=14+math.abs((st%150-75)/15)
		Saws[26][8].pos[2]=101+math.abs((st%150-75)/15)
	
	elseif cm==27 then
	 Saws[27][6].pos[1]=40+math.abs((st%120-60)/10)
		Saws[27][7].pos[1]=50+math.abs((st%120-60)/10)
		Saws[27][8].pos[1]=33+math.abs((st%120-60)/10)
		Saws[27][9].pos[1]=42+math.abs((st%120-60)/10)
		Saws[27][10].pos[1]=43+math.abs((st%120-60)/10)
	
	elseif cm==28 then
	 Saws[28][2].pos[1]=197+math.sin(st/20)*3
		Saws[28][2].pos[2]=113-math.cos(st/20)*3
		for i=0,3 do
 		line(197*8+3-cx+i%2,113*8+3-cy+i//2,(197+math.sin((st-1)/20)*3)*8+3-cx+i%2,(113-math.cos((st-1)/20)*3)*8+3-cy+i//2,10)
		end
		Saws[28][3].pos[1]=194+math.sin(st/45)*5
		Saws[28][3].pos[2]=93-math.cos(st/45)*5
		for i=0,3 do
 		line(194*8+3-cx+i%2,93*8+3-cy+i//2,(194+math.sin((st-1)/45)*5)*8+3-cx+i%2,(93-math.cos((st-1)/45)*5)*8+3-cy+i//2,10)
		end
		Saws[28][4].pos[1]=194+math.sin(st/20)*3
		Saws[28][4].pos[2]=93-math.cos(st/20)*3
		for i=0,3 do
 		line(194*8+3-cx+i%2,93*8+3-cy+i//2,(194+math.sin((st-1)/20)*3)*8+3-cx+i%2,(93-math.cos((st-1)/20)*3)*8+3-cy+i//2,10)
		end
		Saws[28][6].pos[1]=194+math.sin(st/50)*6
		Saws[28][6].pos[2]=103-math.cos(st/50)*6
		for i=0,3 do
 		line(194*8+3-cx+i%2,103*8+3-cy+i//2,(194+math.sin((st-1)/50)*6)*8+3-cx+i%2,(103-math.cos((st-1)/50)*6)*8+3-cy+i//2,10)
		end
	
	elseif cm==29 then
	 Saws[29][4].pos[1]=225+math.sin(st/45)*5
		Saws[29][4].pos[2]=110-math.cos(st/45)*5
		for i=0,3 do
 		line(225*8+3-cx+i%2,110*8+3-cy+i//2,(225+math.sin((st-1)/45)*5)*8+3-cx+i%2,(110-math.cos((st-1)/45)*5)*8+3-cy+i//2,10)
		end
		Saws[29][5].pos[1]=220.5+math.sin(st/15)*3
		Saws[29][5].pos[2]=115.5-math.cos(st/15)*3
		for i=0,3 do
 		line(220.5*8+3-cx+i%2,115.5*8+3-cy+i//2,(220.5+math.sin((st-1)/15)*3)*8+3-cx+i%2,(115.5-math.cos((st-1)/15)*3)*8+3-cy+i//2,10)
		end
		Saws[29][6].pos[1]=229.5+math.sin(st/15)*3
		Saws[29][6].pos[2]=115.5-math.cos(st/15)*3
		for i=0,3 do
 		line(229.5*8+3-cx+i%2,115.5*8+3-cy+i//2,(229.5+math.sin((st-1)/15)*3)*8+3-cx+i%2,(115.5-math.cos((st-1)/15)*3)*8+3-cy+i//2,10)
		end
	
	elseif cm==30 then
	 Saws[30][13].pos[1]=95.5+math.sin(st/16)*3.8
		Saws[30][13].pos[2]=111.5-math.cos(st/16)*3.8
		for i=0,3 do
		 line(95.5*8+3-cx+i%2,111.5*8+3-cy+i//2,(95.5+math.sin((st-1)/16)*3.8)*8+3-cx+i%2,(111.5-math.cos((st-1)/16)*3.8)*8+3-cy+i//2,10)
		end
		Saws[30][14].pos[1]=108+math.sin((st-10)/16)*4
		Saws[30][14].pos[2]=109.5-math.cos((st-10)/16)*4
		for i=0,3 do
		 line(108*8+3-cx+i%2,109.5*8+3-cy+i//2,(108+math.sin((st-11)/16)*4)*8+3-cx+i%2,(109.5-math.cos((st-11)/16)*4)*8+3-cy+i//2,10)
		end
		for i=0,4 do Saws[30][17+i].pos[1]=60+(st+28)/12 end
		Pipes[30][29].sp[1]=60+(st+27)/12
	end
end

function pipes(layer)
	sps={0,0,0}
	if layer=="bg" then
 	sps={446,447,492,494}
	elseif layer=="fg" then
	 sps={444,445,460,462}
	end
	
	for i,pipe in pairs(Pipes[cm]) do
	 if pipe.l==layer then
 	 px=pipe.sp[1]*8-cx
 		py=pipe.sp[2]*8-cy
 		for j=1,#pipe.path do
 		 -- pipe start
 		 if j==1 then
 			 if pipe.path[1]==1 then spr(sps[3],px-8,py-8,0,1,0,0,2,2)
 				elseif pipe.path[1]==2 then spr(sps[1],px,py,0,1)
 				elseif pipe.path[1]==3 then spr(sps[3],px,py-8,0,1,0,1,2,2)
 				elseif pipe.path[1]==4 then spr(sps[1],px,py,0,1,0,3)
 				elseif pipe.path[1]==6 then spr(sps[1],px,py,0,1,0,1)
     elseif pipe.path[1]==7 then spr(sps[3],px-8,py,0,1,0,3,2,2)
	 			elseif pipe.path[1]==8 then spr(sps[1],px,py,0,1,0,2)
 				elseif pipe.path[1]==9 then spr(sps[3],px,py,0,1,0,2,2,2)	end
 			end
 			-- move through the path
 			if pipe.path[j]==1 then px=px-8 py=py-8
 			elseif pipe.path[j]==2 then py=py-8
 			elseif pipe.path[j]==3 then px=px+8 py=py-8
 			elseif pipe.path[j]==4 then px=px-8
 			elseif pipe.path[j]==6 then px=px+8
 			elseif pipe.path[j]==7 then px=px-8 py=py+8
 			elseif pipe.path[j]==8 then py=py+8
 			elseif pipe.path[j]==9 then px=px+8 py=py+8	end
 			-- pipe main
 			if j~=#pipe.path then
 			 if pipe.path[j]==pipe.path[j+1] or pipe.path[j]==5 then
 				 if pipe.path[j]==1 then spr(sps[4],px-4,py-4,0,1,0,0,2,2)
 				 elseif pipe.path[j]==2 then spr(sps[2],px,py,0,1,0,1)
 				 elseif pipe.path[j]==3 then spr(sps[4],px-4,py-4,0,1,0,1,2,2,0,1)
 				 elseif pipe.path[j]==4 then spr(sps[2],px,py,0,1)
 				 elseif pipe.path[j]==6 then spr(sps[2],px,py,0,1)
      elseif pipe.path[j]==7 then spr(sps[4],px-4,py-4,0,1,0,3,2,2)
 				 elseif pipe.path[j]==8 then spr(sps[2],px,py,0,1,0,1)
 				 elseif pipe.path[j]==9 then spr(sps[4],px-4,py-4,0,1,0,0,2,2)	end
 				else
  			 if pipe.path[j]==9 then spr(sps[3],px-8,py-8,0,1,0,0,2,2)
 				 elseif pipe.path[j]==8 then spr(sps[1],px,py,0,1)
 				 elseif pipe.path[j]==7 then spr(sps[3],px,py-8,0,1,0,1,2,2)
 				 elseif pipe.path[j]==6 then spr(sps[1],px,py,0,1,0,3)
 				 elseif pipe.path[j]==4 then spr(sps[1],px,py,0,1,0,1)
      elseif pipe.path[j]==3 then spr(sps[3],px-8,py,0,1,0,3,2,2)
 				 elseif pipe.path[j]==2 then spr(sps[1],px,py,0,1,0,2)
 				 elseif pipe.path[j]==1 then spr(sps[3],px,py,0,1,0,2,2,2) end
  			 
 				 if pipe.path[j+1]==1 then spr(sps[3],px-8,py-8,0,1,0,0,2,2)
 				 elseif pipe.path[j+1]==2 then spr(sps[1],px,py,0,1)
 				 elseif pipe.path[j+1]==3 then spr(sps[3],px,py-8,0,1,0,1,2,2)
 				 elseif pipe.path[j+1]==4 then spr(sps[1],px,py,0,1,0,3)
 				 elseif pipe.path[j+1]==6 then spr(sps[1],px,py,0,1,0,1)
      elseif pipe.path[j+1]==7 then spr(sps[3],px-8,py,0,1,0,3,2,2)
 				 elseif pipe.path[j+1]==8 then spr(sps[1],px,py,0,1,0,2)
  			 elseif pipe.path[j+1]==9 then spr(sps[3],px,py,0,1,0,2,2,2)	end
 				end
 			end
 			-- pipe end
 			if j==#pipe.path then
 			 if pipe.path[#pipe.path]==9 then spr(sps[3],px-8,py-8,0,1,0,0,2,2)
 				elseif pipe.path[#pipe.path]==8 then spr(sps[1],px,py,0,1)
 				elseif pipe.path[#pipe.path]==7 then spr(sps[3],px,py-8,0,1,0,1,2,2)
 				elseif pipe.path[#pipe.path]==6 then spr(sps[1],px,py,0,1,0,3)
 				elseif pipe.path[#pipe.path]==4 then spr(sps[1],px,py,0,1,0,1)
     elseif pipe.path[#pipe.path]==3 then spr(sps[3],px-8,py,0,1,0,3,2,2)
 				elseif pipe.path[#pipe.path]==2 then spr(sps[1],px,py,0,1,0,2)
 				elseif pipe.path[#pipe.path]==1 then spr(sps[3],px,py,0,1,0,2,2,2)	end
 			end
 		end
		end
	end
end

clouds={} cpb=0
function addCloud()
 local c={}
 c.p=#clouds>0 and clouds[#clouds].p*-1 or 1
 c.x=240
 c.y=math.random(0,16)*c.p
 c.s=math.random(4,8)/10
 c.d={}
 for i=-4,4 do
  for j=1,math.random(0,12) do
   table.insert(c.d,4-math.abs(i))
  end
 end
 table.insert(clouds,c)
end

function ticCloud()
 for k,c in pairs(clouds) do
  if gstat=="ingame" then c.x=c.x-c.s*(cm<16 and 0.75 or 1) end
  if c.x<#c.d*-2 then table.remove(clouds,k) end
  for i=0,#c.d*2-1 do
   for j=-c.d[i//2+1],c.d[i//2+1]//2 do
    pix(c.x+i,(8*3)-((cy-mh*17*8)-(Maps[cm].id[2])*17*8-(Maps[cm].wh[2]-1)*17*8)/8+c.y+j*2+(i+c.x+1)%2,9)
   end
  end
 end
end

function addPt(x,y,type)
 local par={}
	par.x=x
	par.y=y
	par.type=type
 
	if type=="bl_run" then
 	par.vx=math.random(1,10)/10*(p.dir and -1 or 1)
 	par.vy=-math.random(5,10)/10
 	par.lt=10
		
	elseif type=="bl_jump" then
 	par.vx=math.random(5,10)/10*(#pt>0 and (pt[#pt].vx>0 and -1 or 1) or 1)
 	par.vy=-math.random(1,5)/10
 	par.lt=12
	
	elseif type=="bl_jump_wl" or type=="bl_jump_wr" then
	 par.vx=math.random(0,10)/10*(type=="bl_jump_wr" and -1 or 1)
		par.vy=math.random(-4,2)/10
		par.lt=12
	
	elseif type=="sk" then
	 par.vx=math.random(-10,10)/10
		par.vy=math.random(-10,10)/10
		par.lt=8+math.random(0,4)
	
	elseif type=="fb" then
	 par.x=par.x+math.random(-2,2)
		par.y=par.y+math.random(-2,2)
	 par.vx=0
		par.vy=0
		par.lt=25+math.random(0,5)
	
	elseif type=="dth" then
	 par.vx=math.random(-20,20)/10+p.vx/2
		par.vy=math.random(-20,20)/10+p.vy/2
		par.lt=40+math.random(0,10)
	
	elseif type=="rsp" then
	 par.x=x+math.random(-30,30)
		par.y=y+math.random(-30,30)
		par.vx=((p.x+p.hbx/2)-par.x)/50
		par.vy=((p.y+p.hby/2)-par.y)/50
		par.lt=20+math.random(0,10)
	
	elseif type=="dis" then
	 par.vx=math.random(-12,12)/10
		par.vy=-0.8+math.random(-8,0)/10
		par.lt=20+math.random(0,5)
	
	elseif type=="exp" then
	 local angle=math.random(0,359)
	 par.vx=math.sin(math.rad(angle))*math.random(0,20)/10
		par.vy=math.cos(math.rad(angle))*math.random(0,20)/10
		par.lt=20+math.random(0,10)
	
	elseif type=="fw" then
	 par.vx=math.random(-20,20)/30
		par.vy=math.random(-20,-16)/10
		par.lt=30+math.random(0,10)
	end
	
	if (string.sub(type,1,2)~="bl") or (dt==0 and ft==0) or type=="fw" then
  table.insert(pt,par)
	end
end

function ticPt()
 for i,par in pairs(pt) do
	 par.x=par.x+par.vx
		par.y=par.y+par.vy
		par.lt=par.lt-1
		
		if par.type=="bl_run" then
		 par.vy=par.vy+0.1
		 rect(par.x-cx,par.y-cy,par.lt>3 and 2 or 1,par.lt>3 and 2 or 1,par.lt>2 and 6 or 1)
  
		elseif par.type=="bl_jump" or par.type=="bl_jump_wl" or par.type=="bl_jump_wr" then
		 par.vy=par.vy+0.05
		 rect(par.x-cx,par.y-cy,par.lt>3 and 2 or 1,par.lt>3 and 2 or 1,par.lt>2 and 6 or 1)
		
		elseif par.type=="sk" then
		 par.vy=par.vy+0.05
		 rect(par.x-cx,par.y-cy,par.lt>3 and 2 or 1,par.lt>3 and 2 or 1,par.lt>4 and 14 or 10)
	 
		elseif par.type=="fb" then
		 par.vy=par.vy+0.02
		 circ(par.x-cx,par.y-cy,par.lt/12,par.lt>15 and 7 or 4)
		
		elseif par.type=="dth" then
		 par.vy=par.vy+0.1
			rect(par.x-cx,par.y-cy,par.lt>20 and 2 or 1,par.lt>20 and 2 or 1,par.lt>10 and 6 or 1)
		
		elseif par.type=="rsp" then
		 par.vx=par.vx+((p.x+p.hbx/2)-par.x)/700
			par.vy=par.vy+((p.y+p.hby/2)-par.y)/700
			rect(par.x-cx,par.y-cy,par.lt<10 and 2 or 1,par.lt<10 and 2 or 1,par.lt>15 and 1 or 6)
		
		elseif par.type=="dis" then
		 par.vx=par.vx/1.1
		 par.vy=par.vy/1.1
			rect(par.x-cx,par.y-cy,par.lt>10 and (par.lt>20 and 3 or 2) or 1,par.lt>10 and (par.lt>20 and 3 or 2) or 1,par.lt>10 and 0 or 1)
		
		elseif par.type=="exp" then
		 par.vx=par.vx/1.1
		 par.vy=par.vy/1.1
			par.vy=par.vy-0.01
			local explt={15,14,6,4,3,1}
			rect(par.x-cx,par.y-cy,par.lt/5,par.lt/5,explt[6-par.lt//5])
		
		elseif par.type=="fw" then
		 par.vx=par.vx/1.1
			par.vy=par.vy/1.1
			line(par.x-cx,par.y-cy,par.x-par.vx*2-cx,par.y-par.vy*2-cy,10)
			if par.lt==0 then for i=1,8 do addPt(par.x,par.y,"exp") end psfx(nsfx.exp,math.random(6,10),38+math.random(-2,4)) end
		end
		
		if par.lt<0 then
		 table.remove(pt,i)
		end
	end
end

function addBl(side)
 local tt=side
	local ox=side==1 and -1 or (side==3 and 1 or 0)
	local oy=side==0 and 1 or (side==2 and -1 or 0)
	
	if prop[mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy))]==2 then
	 if (mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy)))%2==0 then
		 tt=4
		else tt=5	end
	end
 if prop[mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy))]==3 then
	 if (mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy)))%2==1 then
		 tt=6
		else tt=7	end
	end
	
	if prop[mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy))>0 and mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy)) or 48]>0 and prop[mget((p.x+p.hbx/2)//8,((p.y+p.hby/2)//8))>0 and mget((p.x+p.hbx/2)//8,((p.y+p.hby/2)//8)) or 48]==0 then
	 if mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy))~=dspr[1] and mget((p.x+p.hbx/2)//8+ox,((p.y+p.hby/2)//8+oy))~=dspr[2] then
			bl[((p.y+p.hby/2)//8+oy-Maps[cm].id[2]*17)*Maps[cm].wh[1]*30+(p.x+p.hbx/2)//8+ox-Maps[cm].id[1]*30+(Maps[cm].wh[1]*30+Maps[cm].wh[2]*17)*tt*4]=tt
		end
	end
end

function adddmgobj(x,y,type)
 local k={}
	 k.x=x
	 k.y=y
		if type>=0 and type<=3 then
 	 k.vx=0
 	 k.vy=0
 		k.t=0
 	 if type==0 then k.vy=-2.5
 	 elseif type==1 then k.vy=2.5
 	 elseif type==2 then k.vx=-2.5
 	 elseif type==3 then k.vx=2.5 end
		end
	table.insert(dmgobj,k)
end

function ticdmgobj()
 for i,k in pairs(dmgobj) do
		-- remove if hit wall
		if k.t>1 then
 		if tget((k.x+k.vx)//8*8,(k.y+k.vy)//8*8)>0 then
			 for j=1,6 do
	 		 addPt(k.x,k.y,"sk")
	 		end
				if k.x-cx>-4 and k.x-cx<244 and k.y-cy>-4 and k.y-cy<140 then	psfx(nsfx.sawh,11,36+math.random(-4,4)) end
 		 table.remove(dmgobj,i)
 		end
		end
	 
	 if k.t>300 then
		 table.remove(dmgobj,i)
		end
	 
		spr(430,k.x-cx-4,k.y-cy-4,0,1,(st%4)//2)
		
		-- hit player
		if k.x>p.x-4 and k.x<p.x+p.hbx+4 and k.y>p.y-4 and k.y<p.y+p.hby+4 then
		 if ft==0 and dt==0 then
 		 die()
			end
		end
	end
end

function cold(x,y,tile)

 collides=false

 for iy=0,1 do
	 for ix=0,1 do
		 if mget((x+ix*p.hbx)/8,(y+iy*p.hby)/8)~=0 then
  	 if prop[mget((x+ix*p.hbx)/8,(y+iy*p.hby)/8)]==tile then
				 if (x+ix*p.hbx)/8>Maps[cm].id[1]*30 and (x+ix*p.hbx)/8<Maps[cm].id[1]*30+Maps[cm].wh[1]*30 and (y+iy*p.hby)/8>Maps[cm].id[2]*17 and (y+iy*p.hby)/8<Maps[cm].id[2]*17+Maps[cm].wh[2]*17 then
 	 			collides=true
					end
    end
			end
		end
	end

 return collides
end

function controls()
 if usekb then
	 ctrl.mleft=key(60)
		ctrl.mright=key(61)
		ctrl.jump=key(48)
		ctrl.run=key(64)
	 ctrl.up=keyp(58)
		ctrl.down=keyp(59)
		ctrl.left=keyp(60)
		ctrl.right=keyp(61)
		ctrl.ok=keyp(50) and keyp(50) or keyp(48)
		ctrl.back=keyp(44)
		ctrl.spec=keyp(49)
		ctrl.pause=keyp(44)
	else
	 ctrl.mleft=btn(2)
		ctrl.mright=btn(3)
		ctrl.jump=btn(4)
		ctrl.run=true
	 ctrl.up=btnp(0)
		ctrl.down=btnp(1)
		ctrl.left=btnp(2)
		ctrl.right=btnp(3)
		ctrl.ok=btnp(4)
		ctrl.back=btnp(5)
		ctrl.spec=btnp(6)
		ctrl.pause=btnp(7)
	end
end

function psfx(n,vol,note)
 n=n and n or -1
	vol=vol and vol or 15
	note=note and note or 36
	if (n>2 and n~=nsfx.fb and n~=nsfx.ms) or csfx==-1 or (csfx==nsfx.fb and n==nsfx.fb) or (csfx==nsfx.fb and n<=2) then sfx(n,note,-1,3,vol) csfx=n end
end

function eng()
 if t%6==0 then if peek4(0xFF9C*2+36*3+3)==0 then csfx=-1 end end
	ofp=p.of
	owlp=p.owl
	owrp=p.owr
	
	-- movement
	if ctrl.run then p.run=true else p.run=false end
	if ctrl.mleft then
	 if dt==0 and ft==0 and not ctrl.mright then p.dir=false end
	 p.vx=p.vx-(p.of and 0.14 or 0.10)*(p.run and 1.4 or 0.9)
	end
	if ctrl.mright then
	 if dt==0 and ft==0 and not ctrl.mleft then p.dir=true end
	 p.vx=p.vx+(p.of and 0.14 or 0.10)*(p.run and 1.4 or 0.9)
	end
	if not lvlend and ft==0 and dt==0 and (ctrl.mright or ctrl.mleft) and not (ctrl.mright and ctrl.mleft) and p.of and t%(p.run and 6 or 8)==0 then psfx(nsfx.run,p.run and 5 or 4,36+math.random(-2,2)) end
	if ctrl.jump then
 	abt=abt+1
		if abt==0 and not p.of and not p.owl and not p.owr then
		 abt=-1
		end
		if not p.owl and not p.owr then
 		ff=true
		end
	else
	 if abt>-1 and abt<8 then abt=abt+1 end
	 if abt>=8 then
 	 if ff then
 		 if abt>20 then abt=20 end
  	 p.vy=p.vy+(p.vy<0 and (20-abt)^2/100 or 0)
 			ff=false
 		end
  	abt=-1
		end
	end
	if ctrl.jump and not p.of and not p.owl and not p.owr and abt==-1 then abt=21 end
	if abt>21 then abt=21 end
	if abt>20 then p.vy=p.vy+(p.vy<0 and 0 or 0) end
	
 if abt==0 then
	 addBl(0)
		psfx(nsfx.jump,12)
	 p.vy=((p.owl or p.owr) and p.of) and -1.6 or -1.8
		if not p.of then
 	 if p.owl then
 		 p.vx=2.0*(run and 1.5 or 1)
 		end
 		if p.owr then
 		 p.vx=-2.0*(run and 1.5 or 1)
 		end
		end
	end
	
 if abt>2 and abt<20 then
	 p.vy=p.vy-0.06
		if abt>16 then
		 ff=false
		end
	end
 
	-- X vel stopping
	if math.abs(p.vx)>0 then
		p.vx=p.vx/(1+p.svx)
	end
	if ((not ctrl.mleft and not ctrl.mright) or (ctrl.mleft and ctrl.mright)) and p.of then
	 p.vx=p.vx/4
	end
	
	-- gravity
 p.vy=p.vy+p.fvy
	if not p.of and tget(p.x,p.y-1)==1 then p.vy=p.vy-p.fvy/4 end
	
	-- X vel limit
	if math.abs(p.vx)>p.mvx then
		p.vx=p.mvx*(p.vx/math.abs(p.vx))
	end
	
	-- Y vel fall limit
	if math.abs(p.vy)>5 then
	 p.vy=5*(p.vy/math.abs(p.vy))
	end
	
	-- check collision
	for i=1,16 do
	 -- solid
 	if tget(p.x+p.vx/16,p.y)==1 then
	 	addBl(p.vx<=0 and 1 or 3)
 	 p.vx=0
 	end
 	if tget(p.x,p.y+p.vy/16)==1 then
		 addBl(p.vy>=0 and 0 or 2)
 	 p.vy=0
 	end
 	if not tget(p.x,p.y+p.vy/16)==1
 	and not tget(p.x+p.vx/16,p.y)==1
 	and tget(p.x+p.vx/16,p.y+p.vy/16)==1 then
 	 p.vx=0 p.vy=0
 	end
		
		-- solid but not
		if tget(p.x+p.vx/16,p.y)==2 then
		 addBl(p.vx<=0 and 1 or 3)
			p.vy=0
			p.y=p.y-0.2
 	end
		if tget(p.x+p.vx/16,p.y)==3 then
 		addBl(p.vx<=0 and 1 or 3)
 		p.vy=0.8
 		p.y=p.y+0.2
 	end
 	if tget(p.x,p.y+p.vy/16)==2 or tget(p.x,p.y+p.vy/16)==3 then
	 	addBl(p.vy>=0 and 0 or 2)
		 p.vy=0
 	end
		if not cold(p.x,p.y+p.vy/16)==2
 	and not cold(p.x+p.vx/16,p.y)==2
 	and cold(p.x+p.vx/16,p.y+p.vy/16)==2 then
 	 p.vx=0 p.vy=0
 	end
	
	 if dt==0 and ft==0 and not playback then
 	 if math.abs(p.vx)>1/16 then
  		p.x=p.x+p.vx/16
 		end
 	 p.y=p.y+p.vy/16
		else
		 p.vx=0
			p.vy=0
			abt=-2
			if ft>0 then
			 if tget(p.x,p.y+1/16)==0 then p.y=p.y+1/16 end
			end
		end
	end
	
	-- check for damage tiles
	if tget(p.x, p.y)==4 then
	 die()
	end
	
	-- check for damage from saw
	for i,saw in pairs(Saws[cm]) do
	 if math.sqrt(((p.x+p.hbx/2)-(saw.pos[1]+0.5)*8)*((p.x+p.hbx/2)-(saw.pos[1]+0.5)*8)+((p.y+p.hby/2)-(saw.pos[2]+0.5)*8)*((p.y+p.hby/2)-(saw.pos[2]+0.5)*8))<saw.s*4+2 then
		 sbl[cm*64+i]=true
		 die()
		end
	end
	
	-- check if is on floor
	if tget(p.x,p.y+1)==1 or tget(p.x,p.y+1)==2 then
	 p.of=true
	else
	 p.of=false
	end
	
	-- check if hit ceiling
	if tget(p.x,p.y-1)==1 and abt<20 then
	 abt=20
		psfx(nsfx.hit_grn,6)
	end
	
	-- check if is on wall to left
	if tget(p.x-1,p.y)==1 and p.x-cx<240 then
		p.owl=true
		addBl(1)
	else
	 p.owl=false
	end
	
	-- check if is on wall to right
	if tget(p.x+1,p.y)==1 and p.x-cx>0 then
	 addBl(3)
	 p.owr=true
	else
	 p.owr=false
	end
	
	-- hit sound
	if not lvlend and ft==0 and dt==0 and p.of and not ofp or p.owl and not owlp or p.owr and not owrp then psfx(nsfx.hit_grn,10) end
	
	-- change maximum x speed
	p.mvx=p.run and 2.6 or 2
	
	if p.of then
	 p.svx=0.1
	else
	 p.svx=0.04
	end
	
	if (p.owl or p.owr) then
	 if p.vy>0 then
 	 p.fvy=0.07
		else
		 p.fvy=0.09
		end
	else
	 p.fvy=0.09
	end
	
	-- spawn dynamic dmg objects
	for iy=Maps[cm].id[2]*17,(Maps[cm].id[2]*17)+Maps[cm].wh[2]*17-1 do
	 for ix=Maps[cm].id[1]*30,(Maps[cm].id[1]*30)+Maps[cm].wh[1]*30-1 do
		 if st%120==10 then
			 if mget(ix,iy)==188 then
			  adddmgobj(ix*8+4,iy*8+4,2)
			 end
				if mget(ix,iy)==189 then
			  adddmgobj(ix*8+4,iy*8+4,0)
			 end
				if mget(ix,iy)==204 then
			  adddmgobj(ix*8+4,iy*8+4,1)
			 end
				if mget(ix,iy)==205 then
			  adddmgobj(ix*8+4,iy*8+4,3)
			 end
				if mget(ix,iy)==188 or mget(ix,iy)==189 or mget(ix,iy)==204 or mget(ix,iy)==205 and ix>=cx//8-2 and ix<cx//8+30+2 and iy>=cy//8-2 and iy<cy//8+17+2 then psfx(nsfx.throw,7) end
			end
		end
	end
	for i,k in pairs(dmgobj) do
	 k.x=k.x+k.vx
		k.y=k.y+k.vy
		k.t=k.t+1
	end
	
	-- check for level end
	if not dead and p.x>Maps[cm].bp[1]*8-p.hbx-4 and p.x<Maps[cm].bp[1]*8+8+4 and p.y>Maps[cm].bp[2]*8-p.hby and p.y<Maps[cm].bp[2]*8+8 then
	 lvlend=true
		if ft==1 then psfx(nsfx.lvlend) end
	end
	
	-- kill if out of screen edges
 if p.x+p.hbx/2<Maps[cm].id[1]*30*8-16 or p.x+p.hbx/2>Maps[cm].id[1]*30*8+Maps[cm].wh[1]*30*8+16 or p.y+p.hby/2<Maps[cm].id[2]*17*8-32 or p.y+p.hby/2>Maps[cm].id[2]*17*8+Maps[cm].wh[2]*17*8+16 then
	 die()
	end
	
	-- blood particles
	if (ctrl.mleft or ctrl.mright) and not (ctrl.mleft and ctrl.mright) and p.of then
 	if t%(p.run and 2 or 4)==0 then addPt(p.x+p.hbx//2,p.y+p.hby,"bl_run") end
	end
	
	if ctrl.jump and abt==0 then
	 if not owlp and not owrp then
  	for i=1,2 do
    addPt(p.x+p.hbx//2,p.y+p.hby,"bl_jump")
  	end
		end
		if owlp then
		 for i=1,3 do
 		 addPt(p.x,p.y+p.hby//2,"bl_jump_wl")
			end
		end
		if owrp then
		 for i=1,3 do
		  addPt(p.x+p.hbx,p.y+p.hby,"bl_jump_wr")
		 end
		end
	end
	
	if p.of and not ofp then
	 for i=1,8 do
 	 addPt(p.x+p.hbx//2,p.y+p.hby,"bl_jump")
		end
	end
	if not owlp and p.owl then
	 for i=1,4 do
 		addPt(p.x,p.y+p.hby//2,"bl_jump_wl")
		end
	end
	if not owrp and p.owr then
	 for i=1,4 do
 		addPt(p.x,p.y+p.hby//2,"bl_jump_wr")
		end
	end
	
	-- detect destroying objects
	dspr={152,153}
	for i,d in pairs(dspr) do
	 if p.of then
  	if mget((p.x+1)/8,(p.y+p.hby+1)/8)==d then
  	 table.insert(dstr,{math.floor(p.x/8),math.floor(p.y/8)+1,0})
  	end
  	if mget((p.x+p.hbx-1)/8,(p.y+p.hby+1)/8)==d then
  	 table.insert(dstr,{math.floor((p.x+p.hbx)/8),math.floor(p.y/8)+1,0})
  	end
		end
 	
  if mget((p.x+1)/8,(p.y-1)/8)==d then
 	 table.insert(dstr,{math.floor(p.x/8),math.floor(p.y/8)-1,0})
 	end
 	if mget((p.x+p.hbx-1)/8,(p.y-1)/8)==d then
 	 table.insert(dstr,{math.floor((p.x+p.hbx)/8),math.floor(p.y/8)-1,0})
 	end
 	
		if p.owl then
  	if mget((p.x-1)/8,(p.y+1)/8)==d then
  	 table.insert(dstr,{math.floor(p.x/8)-1,math.floor(p.y/8),0})
  	end
  	if mget((p.x-1)/8,(p.y+p.hby-1)/8)==d then
  	 table.insert(dstr,{math.floor(p.x/8)-1,math.floor((p.y+p.hby)/8),0})
  	end
		end
 	
		if p.owr then
  	if mget((p.x+p.hbx+1)/8,(p.y+1)/8)==d then
  	 table.insert(dstr,{math.floor(p.x/8)+1,math.floor(p.y/8),0})
  	end
  	if mget((p.x+p.hbx+1)/8,(p.y+p.hby-1)/8)==d then
  	 table.insert(dstr,{math.floor(p.x/8)+1,math.floor((p.y+p.hby)/8),0})
  	end
		end
	end
 	
 -- adds timer to destroy
	for i,d in pairs(dstr) do
	 d[3]=d[3]+1
		if d[3]>30 then
		 if mget(d[1],d[2])==dspr[1] or mget(d[1],d[2])==dspr[2] then
			 psfx(nsfx.fb)
 			for j=1,4 do
  			addPt(d[1]*8+4,d[2]*8+4,"fb")
 			end
			end
		 if mget(d[1],d[2])==dspr[1] then
 		 mset(d[1],d[2],154)
			end
			if mget(d[1],d[2])==dspr[2] then
			 mset(d[1],d[2],144)
			end
			table.remove(dstr,i)
		end
	end
	
	if lvlend then ft=ft+1 else if ft>0 then ft=ft-1 end end
	if lvlend and ft>15 and ft<80 and ctrl.ok then ft=79 end
	if ft==45 then for i=1,16 do addPt(Maps[cm].bp[1]*8+4+math.random(-4,4),Maps[cm].bp[2]*8+8,"dis") psfx(nsfx.dr_dis,7) end end
	if ft>=80 then playback=true lvlend=false pbt=1 ft=0 end
	
	if dead then dt=dt+1 end
	if dt>=40 then
	 respawn()
	 dead=false
		for i=1,20 do addPt(p.x,p.y,"rsp") end
		psfx(nsfx.rsp,7,36+math.random(-4,4))
	end
	if not dead and dt>0 then dt=dt-1 if dt>30 then dt=30 end end
	
	if playback then
	 if pbt==1 then
		 for i=1,60 do
			 table.insert(pbdata[#pbdata].s,pbdata[#pbdata].s[#pbdata[#pbdata].s])
				table.insert(pbdata[#pbdata].x,pbdata[#pbdata].x[#pbdata[#pbdata].x])
				table.insert(pbdata[#pbdata].y,pbdata[#pbdata].y[#pbdata[#pbdata].y]+(tget(pbdata[#pbdata].x[#pbdata[#pbdata].x],pbdata[#pbdata].y[#pbdata[#pbdata].y]+1)==0 and 1 or 0))
			end
		 for iy=Maps[cm].id[2]*17,(Maps[cm].id[2]*17)+Maps[cm].wh[2]*17-1 do
  	 for ix=Maps[cm].id[1]*30,(Maps[cm].id[1]*30)+Maps[cm].wh[1]*30-1 do
	  	 if mget(ix,iy)==154 then
   			mset(ix,iy,152)
	  		end
		  	if mget(ix,iy)==144 then
		  	 mset(ix,iy,153)
		  	end
		  end
	  end
			st=0
		end
	 p.x=-16
		p.y=-16
		if ctrl.ok then
	  pbt=(pbt<#pbdata[#pbdata].s-20 and #pbdata[#pbdata].s-20 or pbt)
	 end
		if ctrl.back and dwt==0 then dwt=1 end
		if ctrl.spec and dwt==0 then pbt=(pbt<#pbdata[#pbdata].s-20 and #pbdata[#pbdata].s-20 or pbt) dwt=-1 end
		if dwt>0 then dwt=dwt+1 end
		if dwt>60 then playback=false gstat="lvlsel" dwt=-15 end
		if pbt-20>#pbdata[#pbdata].s and (dwt==0 or dwt==-1) then
		 if cm>16 and (lvlbt[cm-15]==0 or lvlbt[cm-15]>lvlat[cm-15]) and dwt==0 then
			 clvl=cm dwt=1
			elseif cm%16==15 and dwt==0 then
			 clvl=cm dwt=1
			else
 		 loadmap(cm+(dwt==0 and 1 or 0))
 		 playback=false
 			dwt=0
			end
		end
	else
	 while #pbdata<pbtry do table.insert(pbdata,{s={},x={},y={}}) end
		local sti=0
 	if p.of then	if (ctrl.mleft or ctrl.mright) and not (ctrl.mleft and ctrl.mright) then	sti=257+(p.run and 1 or 0)+(t%(p.run and 8 or 12))//(p.run and 4 or 6)*16-(ctrl.mright and 256 or 0)	else	sti=256-(p.dir and 256 or 0)	end	else if p.owl or p.owr then	sti=259-(p.owl and 256 or 0)	else if (ctrl.mleft or ctrl.mright) and not (ctrl.mleft and ctrl.mright) then	sti=272-(ctrl.mright and 256 or 0) else sti=256-(p.dir and 256 or 0) end	end	end
 	if not dead and dt==0 and ft==0 then
 		table.insert(pbdata[pbtry].s,sti)
 		table.insert(pbdata[pbtry].x,p.x//1)
 		table.insert(pbdata[pbtry].y,p.y//1)
		end
	end
	
	if not playback and ft==0 and st>=0 then clvlt=clvlt+1/60 end
	if lvlend and ft==1 then
 	if clvlt<lvlbt[cm] or lvlbt[cm]==0 then
   lvlbt[cm]=clvlt save()
 	end
	end
	if not ctrl.run or math.abs(p.vx)<1 then p.run=false end
end

function draw()
 --Layers:
	--   /pipes
	-- FG-saws
	--   \tiles
	--   /saws
	-- BG-pipes
	--   \tiles
	-- parallax bg
	
	-- camera follows player
	if playback then
	 if pbt==1 then
		 cx=(pbdata[#pbdata].x[1]-116)
	  cy=(pbdata[#pbdata].y[1]-64)
		else
		 cx=cx+((pbdata[#pbdata].x[pbt<=#pbdata[#pbdata].x and pbt or #pbdata[#pbdata].x]-116)-cx)/2
	  cy=cy+((pbdata[#pbdata].y[pbt<=#pbdata[#pbdata].y and pbt or #pbdata[#pbdata].y]-64)-cy)/2
		end
	else
	 cx=cx+((p.x-116)-cx)/2
	 cy=cy+((p.y-64)-cy)/2
	end
	
	-- camera bounds
	if cx<Maps[cm].id[1]*240 then
	 cx=Maps[cm].id[1]*240
	end
	if cx+240>Maps[cm].id[1]*240+Maps[cm].wh[1]*240 then
	 cx=Maps[cm].id[1]*240+Maps[cm].wh[1]*240-240
	end
	
	if cy<Maps[cm].id[2]*136 then
	 cy=Maps[cm].id[2]*136
	end
	if cy+136>Maps[cm].id[2]*136+Maps[cm].wh[2]*136 then
 	cy=Maps[cm].id[2]*136+Maps[cm].wh[2]*136-136
	end
	
	cx=math.floor(cx)
	cy=math.floor(cy)
	
	-- parallax background
	rect(0,0,240,(8*13)-((cy-mh*17*8)-(Maps[cm].id[2])*17*8-(Maps[cm].wh[2]-1)*17*8)/8,13)
	for i=0,math.floor((Maps[cm].wh[1]+2)/8)+1 do
 	map(30*7,17*7,30,9,(Maps[cm].id[1]*17*8-cx)/8+(i*30*8)-rfs[1],(8*6)-((cy-mh*17*8)-(Maps[cm].id[2])*17*8-(Maps[cm].wh[2]-1)*17*8)/8,0)
	end
	rect(0,(8*16)-((cy-mh*17*8)-(Maps[cm].id[2])*17*8-(Maps[cm].wh[2]-1)*17*8)/4,240,137-((8*16)-((cy-mh*17*8)-(Maps[cm].id[2])*17*8-(Maps[cm].wh[2]-1)*17*8)/4),2)
	for i=0,math.floor((Maps[cm].wh[1]+2)/4)+1 do
	 map(30*7,17*7+9,30,8,(Maps[cm].id[1]*17*8-cx)/6+(i*30*8)-rfs[2],(8*8)-((cy-mh*17*8)-(Maps[cm].id[2])*17*8-(Maps[cm].wh[2]-1)*17*8)/4,9)
	end
	
	if et<18 and gstat=="ingame" and math.random(0,cpb^2)==0 then addCloud() cpb=cpb+128*(cm<16 and 1.5 or 1) end
 if cpb>4 then cpb=cpb-2 end
	ticCloud()
	
	-- bg tiles
	for iy=math.floor(cy/8),math.floor(cy/8)+17 do
 	for ix=math.floor(cx/8),math.floor(cx/8)+30 do
			if layers[mget(ix,iy)]==0 then
    spr(mget(ix,iy),ix*8-cx,iy*8-cy,0,1)
			end
 	end
 end
	
	-- bg pipes
	pipes("bg")
	
	-- update dynamic dmg objects
	ticdmgobj()
	-- level end
	if ft<50 then
 	spr(260+st//30%2,Maps[cm].bp[1]*8-cx,Maps[cm].bp[2]*8-cy,8,1)
	end
	
	-- bg saws
	for i,saw in pairs(Saws[cm]) do
	 if saw.l=="bg" then
 	 sn=0 bsn=0
 	 if saw.s==2 then sn=368 bsn=374
 		elseif saw.s==3 then sn=400 bsn=263
			elseif saw.s==4 then sn=448 bsn=304 end
	 	spr(sn+(st%6)//2*saw.s,saw.pos[1]*8-saw.s*4-cx+4,saw.pos[2]*8-saw.s*4-cy+4,0,1,0,0,saw.s,saw.s)
			if sbl[cm*64+i] then spr(bsn+(st%6)//2*saw.s,saw.pos[1]*8-saw.s*4-cx+4,saw.pos[2]*8-saw.s*4-cy+4,0,1,0,0,saw.s,saw.s) end
		end
	end
	
	-- fg tiles
	for iy=math.floor(cy/8),math.floor(cy/8)+17 do
 	for ix=math.floor(cx/8),math.floor(cx/8)+30 do
			if layers[mget(ix,iy)]==1 then
   	spr(mget(ix,iy),ix*8-cx,iy*8-cy,0,1)
			end
 	end
 end
 
	-- dr.fetus
	if ft>0 and ft<50 and lvlend then
	 spr(275,Maps[cm].bp[1]*8-cx+12*(p.x<=Maps[cm].bp[1]*8 and 1 or -1)+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)*-1 or -8))*(p.x<=Maps[cm].bp[1]*8 and 1 or -1),Maps[cm].bp[2]*8-cy-6+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)//2 or 4))+(t//8-1)%3-8,8,1)
	 spr(262,Maps[cm].bp[1]*8-cx+12*(p.x<=Maps[cm].bp[1]*8 and 1 or -1)+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)*-1 or -8))*(p.x<=Maps[cm].bp[1]*8 and 1 or -1),Maps[cm].bp[2]*8-cy-6+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)//2 or 4))+(t//8-1)%3,8,1)
		if ft>4 then
		 spr(276+(st//8)%3,Maps[cm].bp[1]*8-cx+12*(p.x<=Maps[cm].bp[1]*8 and 1 or -1)+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)*-1 or -8))*(p.x<=Maps[cm].bp[1]*8 and 1 or -1)+8,Maps[cm].bp[2]*8-cy-6+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)//2 or 4))+(t//8-1)%3,8,1)
		 spr(276+(st//8)%3,Maps[cm].bp[1]*8-cx+12*(p.x<=Maps[cm].bp[1]*8 and 1 or -1)+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)*-1 or -8))*(p.x<=Maps[cm].bp[1]*8 and 1 or -1)-8,Maps[cm].bp[2]*8-cy-6+(ft<20 and 0 or ((ft>=20 and ft<28) and (ft-20)//2 or 4))+(t//8-1)%3,8,1,1)
		end
	end
	
	-- blood
	for i,b in pairs(bl) do
		spr(288+b//4,(i-(Maps[cm].wh[1]*30+Maps[cm].wh[2]*17)*b*4)%(Maps[cm].wh[1]*30)*8-cx+(Maps[cm].id[1]*30*8),(i-(Maps[cm].wh[1]*30+Maps[cm].wh[2]*17)*b*4)//(Maps[cm].wh[1]*30)*8-cy+(Maps[cm].id[2]*17*8),0,1,0,b%4)
	end
	--bl={}
	
	-- player
	if dt==0 and ft==0 then
 	if p.of then
  	if (ctrl.mleft or ctrl.mright) and not (ctrl.mleft and ctrl.mright) then
    spr(257+(p.run and 1 or 0)+(st%(p.run and 8 or 12))//(p.run and 4 or 6)*16,p.x-cx-1,p.y-cy-2,8,1,p.dir and 1 or 0)
  	else
  	 spr(256,p.x-cx-1,p.y-cy-2,8,1,p.dir and 1 or 0)
  	end
 	else
 	 if p.owl or p.owr then
 		 spr(259,p.x-cx-1,p.y-cy-2,8,1,p.owl and 1 or 0)
 		else
 	  if (ctrl.mleft or ctrl.mright) and not (ctrl.mleft and ctrl.mright) then
     spr(272,p.x-cx-1,p.y-cy-2,8,1,ctrl.mright and 1 or 0)
 		 else
  	  spr(256,p.x-cx-1,p.y-cy-2,8,1,p.dir and 1 or 0)
  	 end
 		end
 	end
	elseif dt==0 then
	 spr(256,p.x-cx-1,p.y-cy-2,8,1,p.dir and 1 or 0)
	end
	
	-- fg saws
	for i,saw in pairs(Saws[cm]) do
	 if saw.l=="fg" then
 	 sn=0 bsn=0
 	 if saw.s==2 then sn=368 bsn=374
 		elseif saw.s==3 then sn=400 bsn=263
			elseif saw.s==4 then sn=448 bsn=304 end
	 	spr(sn+(st%6)//2*saw.s,saw.pos[1]*8-saw.s*4-cx+4,saw.pos[2]*8-saw.s*4-cy+4,0,1,0,0,saw.s,saw.s)
			if sbl[cm*64+i] then spr(bsn+(st%6)//2*saw.s,saw.pos[1]*8-saw.s*4-cx+4,saw.pos[2]*8-saw.s*4-cy+4,0,1,0,0,saw.s,saw.s) end
		end
	end
	
	for iy=Maps[cm].id[2]*17,(Maps[cm].id[2]*17)+Maps[cm].wh[2]*17-1 do
	 for ix=Maps[cm].id[1]*30,(Maps[cm].id[1]*30)+Maps[cm].wh[1]*30-1 do
		 if mget(ix,iy)==188 or mget(ix,iy)==189 or mget(ix,iy)==204 or mget(ix,iy)==205 then
			 if (st-10)%120>60 then
				 spr(430,ix*8-cx,iy*8-cy,0,1)
					spr(mget(ix,iy),ix*8-cx,iy*8-cy,1,1)
				end
			end
		end
	end
	
	customStuff()
	
	-- fg pipes
	pipes("fg")
	
	--particles
	ticPt()
	
	if pbtry==1 and not lvlend and dt==0 and ft==0 and not playback then
	 howtoplay()
	end
	
	-- replays all attempts on this level
	if playback then
	 for i=1,#pbdata do
		 if pbt<#pbdata[i].s or i==#pbdata then
				spr(pbdata[i].s[pbt<=#pbdata[i].s and pbt or #pbdata[i].s]%256+256,pbdata[i].x[pbt<=#pbdata[i].x and pbt or #pbdata[i].x]-cx-1,pbdata[i].y[pbt<=#pbdata[i].y and pbt or #pbdata[i].y]-cy-2,8,1,pbdata[i].s[pbt<=#pbdata[i].s and pbt or #pbdata[i].s]//256==1 and 0 or 1)
			end
			if pbt==#pbdata[i].s and i<#pbdata then
			 for j=1,20 do
		   addPt(pbdata[i].x[pbt]+p.hbx/2,pbdata[i].y[pbt]+p.hby/2,"dth")
  		end
			end
			
			if pbt-#pbdata[#pbdata].s+60>0 then
			 spr(275,Maps[cm].bp[1]*8-cx+12*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1)+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)*-1 or -8))*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1),Maps[cm].bp[2]*8-cy-6+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)//2 or 4))+(t//8-1)%3-8,8,1)
	   spr(262,Maps[cm].bp[1]*8-cx+12*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1)+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)*-1 or -8))*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1),Maps[cm].bp[2]*8-cy-6+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)//2 or 4))+(t//8-1)%3,8,1)
		  if pbt-#pbdata[#pbdata].s+60>4 then
		   spr(276+(st//8)%3,Maps[cm].bp[1]*8-cx+12*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1)+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)*-1 or -8))*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1)+8,Maps[cm].bp[2]*8-cy-6+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)//2 or 4))+(t//8-1)%3,8,1)
		   spr(276+(st//8)%3,Maps[cm].bp[1]*8-cx+12*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1)+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)*-1 or -8))*(pbdata[#pbdata].x[#pbdata[#pbdata].x]<=Maps[cm].bp[1]*8 and 1 or -1)-8,Maps[cm].bp[2]*8-cy-6+(pbt-#pbdata[#pbdata].s+60<20 and 0 or ((pbt-#pbdata[#pbdata].s+60>=20 and pbt-#pbdata[#pbdata].s+60<28) and (pbt-#pbdata[#pbdata].s+60-20)//2 or 4))+(t//8-1)%3,8,1,1)
	  	end
  	end
		end
	 pbt=pbt+1
		if #pbdata>0 then
		 spr(443,199,7,0,1)
			spr(442,199,15,0,1)
		 print(pbt-#pbdata[#pbdata].s+60<=0 and pbt//0.6/100 or (#pbdata[#pbdata].s-60)//0.6/100+(pbtry>1 and 0.03 or 0),208,8)
		 print(((lvlat[cm])//0.01/100).."0",208,16)
		end
		
		print((usekb and "[Space]" or "(A)").." next level",6,118,15,false,1,true)
		print((usekb and "[`]" or "(B)").." back to map",6,125,15,false,1,true)
		print((usekb and "[Tab]" or "(X)").." replay level",6,6,15,false,1,true)
		spr(441,2,2,8,2,0)
		spr(441,222,2,8,2,1)
		spr(441,2,118,8,2,2)
		spr(441,222,118,8,2,3)
	end
	
	-- grade A+
	if lvlend and ft>10 and clvlt<=lvlat[cm] then
		if ft>30 then
		 circ(136,30,(ft-30<4 and ft-30 or 4)*2,cm==20 and 15 or 6)
			circ(130,24,(ft-32<2 and ft-32 or 2),cm==20 and 15 or 6)
			circ(146,36,(ft-32<2 and ft-32 or 2),cm==20 and 15 or 6)
			circ(96,26,(ft-32<2 and ft-32 or 2),cm==20 and 15 or 6)
			circ(134,18,(ft-33<1 and ft-33 or 1),cm==20 and 15 or 6)
			circ(127,38,(ft-33<1 and ft-33 or 1),cm==20 and 15 or 6)
			circ(152,34,(ft-33<1 and ft-33 or 1),cm==20 and 15 or 6)
			circ(92,34,(ft-33<1 and ft-33 or 1),cm==20 and 15 or 6)
			if ft>34 then rect(96+34-(ft-34<5 and ft-34 or 5)*6.8,26,(ft-34<5 and ft-34 or 5)*6.8,9,cm==20 and 15 or 6) end
		 print("A+",132,28,0)
		end
		print("GRADE",0+(ft-10<10 and ft-10 or 10)*12-print("GRADE A+",240,0)/2,28,0)
	end
	
	-- text borders
 if lvlend then
	 local lh=ft<12 and ft or 12
		for i,h in pairs({1,0,1,0,0,1,2,3,2,1,0,0,1,0,1}) do
 		rect((i-1)*16,136-lh-h,16,lh+h,0)
			rect((i-1)*16,0,16,lh+h,0)
		end
		print("LEVEL COMPLETE",120-print("LEVEL COMPLETE",240,0)/2,3-4+lh/3,15)
	end
	
	-- lvl name text
	if lnt>0 and cm~=16 then
	 local lh=lnt<12 and lnt or 12
		for i,h in pairs({1,0,1,0,0,1,2,3,2,1,0,0,1,0,1}) do
			rect((i-1)*16,0,16,lh+h,0)
		end
		print((cm%16)..": "..lvlname[cm],120-print((cm%16)..": "..lvlname[cm],0,-16)/2+(lh-12)*20,4,15)
		lnt=lnt-1
	end
	
	-- clvl time
	if not playback and cm~=16 then
	 line(12,0,16,4,0)
		line(13,0,17,4,0)
		line(51,0,47,4,0)
		line(50,0,46,4,0)
		line(47,0,44,4,0)
	 rect(16,4,32,9,15)
	 rectb(16,4,32,9,0)
		print((clvlt//0.01/100)..(clvlt//0.01%10==0 and "0" or ""),33-print((clvlt//0.01/100)..(clvlt//0.01%10==0 and "0" or ""),240,0)/2,6,cm==29 and 0 or 6)
	end
	
	-- back to map transition
	if playback then
	 if dwt>0 then
  	for i=0,7 do
  	 tri(240-dwt*16,i*18,240-dwt*16-18,9+i*18,240-dwt*16,18+i*18,0)
  	end
  	rect(240-dwt*16,0,240,136,0)
	 end
	end
	if dwt>15 or dwt==-15 then cls() end
	
	-- fading transition
	if dt>20 then
	 for i=0,30*17 do
		 spr(409,i%30*8,i//30*8,8,1)
		end
	end
 if dt>24 then
	 for i=0,30*17 do
		 spr(410,i%30*8,i//30*8,8,1)
		end
	end
 if dt>28 then
	 for i=0,30*17 do
		 spr(411,i%30*8,i//30*8,8,1)
		end
	end
 if dt>32 then
	 for i=0,30*17 do
		 cls()
		end
 end
	
	-- saw transition
	if playback and pbt-#pbdata[#pbdata].s>-20 then
		circ((pbt-#pbdata[#pbdata].s)*9,68,68,0)
		rect(0,0,(pbt-#pbdata[#pbdata].s)*9,136,0)
 	for i=0,16 do
 	 i=i+(t%8)/8
 	 tri((pbt-#pbdata[#pbdata].s)*9+math.sin(math.rad(360/16*i))*80,68-math.cos(math.rad(360/16*i))*80,(pbt-#pbdata[#pbdata].s)*9+math.sin(math.rad(360/16*i-10))*68,68-math.cos(math.rad(360/16*i-10))*68,(pbt-#pbdata[#pbdata].s)*9+math.sin(math.rad(360/16*i+10))*68,68-math.cos(math.rad(360/16*i+10))*68,0)
 	end
	end
	
	if not playback and not lvlend and ft>0 then
 	circ((40-ft)*9,68,68,0)
		rect((40-ft)*9,0,240-(40-ft)*9,136,0)
 	for i=0,16 do
 	 i=i+(t%8)/8
 	 tri((40-ft)*9+math.sin(math.rad(360/16*i))*80,68-math.cos(math.rad(360/16*i))*80,(40-ft)*9+math.sin(math.rad(360/16*i-10))*68,68-math.cos(math.rad(360/16*i-10))*68,(40-ft)*9+math.sin(math.rad(360/16*i+10))*68,68-math.cos(math.rad(360/16*i+10))*68,0)
 	end
	end
	
	if cm==16 then
	 if st>1684 then for i=0,30*17 do spr(425,i%30*8,i//30*8,8,1)	end end
	 if st>1704 then for i=0,30*17 do	spr(426,i%30*8,i//30*8,8,1)	end end
	 if st>1724 then for i=0,30*17 do spr(427,i%30*8,i//30*8,8,1)	end end
	 if st>1744 then for i=0,30*17 do cls(15)	end end
	end
end

function menu()
 opt=opt and opt or false
 mc=mc and mc or 1
	dwt=dwt and dwt or -30
	-- menu navigation
	if not opt and dwt==0 then
  if ctrl.up then mc=mc-1 psfx(nsfx.mc) end
 	if ctrl.down then mc=mc+1 psfx(nsfx.mc) end
		mc=(mc-1)%3+1
 	if ctrl.ok then
		 psfx(nsfx.mc)
 	 if mc==1 and dwt<1 then dwt=1 psfx(nsfx.sg,15) end
 		if mc==2 then opt=true mc=1 end
 		if mc==3 and dwt<1 then dwt=1 ft=1 end
 	end
	elseif dwt==0 then
	 if ctrl.up then mc=mc-1 psfx(nsfx.mc) end
 	if ctrl.down then mc=mc+1 psfx(nsfx.mc) end
		mc=(mc-1)%3+1
		if ctrl.left then
		 psfx(nsfx.mc)
			if mc==1 then vol.m=vol.m>0 and vol.m-1 or 0
			elseif mc==2 then vol.s=vol.s>0 and vol.s-1 or 0 end
		end
		if ctrl.right then
		 psfx(nsfx.mc)
			if mc==1 then vol.m=vol.m<4 and vol.m+1 or 4
			elseif mc==2 then vol.s=vol.s<4 and vol.s+1 or 4 end
		end
 	if ctrl.ok then
		 psfx(nsfx.mc)
 		if mc==3 then opt=false mc=2 save() end
 	end
	end
	
	if dt>=0 then if (usekb and key(52) or btn(6)) then dt=dt+1 else dt=0 end	else dt=dt+1 end
	if dt>60*3 then for i=1,31 do lvlbt[i]=0 end save() dt=-90 opt=false mc=1 end
	
	if dwt~=0 then dwt=dwt+1 end
	if dwt>60 then
		if ft==0 then cpic=1 gstat="showpic" st=0 ft=0 l2dw("lw")
		elseif ft==1 then exit() end
	end
	
	-- bg
 cls(6)
	for i=0,9*7-1 do
 	spr(290,8+(i%9)*32-(i//9%2)*16,-60+(i//9)*32+(t//2)%64,0,2,0,(i%9)+(i//9)*2)
	end
 circ(120,68,70,6)
	for i=0,16 do
	 i=i+(t%16)/16
	 tri(120+math.sin(math.rad(360/16*i))*82,68-math.cos(math.rad(360/16*i))*82,120+math.sin(math.rad(360/16*i-10))*70,68-math.cos(math.rad(360/16*i-10))*70,120+math.sin(math.rad(360/16*i+10))*70,68-math.cos(math.rad(360/16*i+10))*70,6)
	end
 circ(120,68,68,1)
	for i=0,16 do
	 i=i+(t%16)/16
	 tri(120+math.sin(math.rad(360/16*i))*80,68-math.cos(math.rad(360/16*i))*80,120+math.sin(math.rad(360/16*i-10))*68,68-math.cos(math.rad(360/16*i-10))*68,120+math.sin(math.rad(360/16*i+10))*68,68-math.cos(math.rad(360/16*i+10))*68,1)
	end
	
	-- title
	rect(0,0,240,16,0)
	rect(0,120,240,16,0)
	for i=0,25 do
	 rect(40+math.sin(i)*4+math.tan(i*2)*2+math.cos(i*2)*4,i*(((dwt<0 and dwt or 0)/-30)+1)+16+(dwt<0 and dwt or 0)*2,157,(dwt<0 and dwt or 0)/-30+1,0)
	end
	spr(396,140,6,0)
	spr(364,152,-2,0,1,0,0,4,2)
	for i=0,19 do print("MEAT BOY",117-print("MEAT BOY",0,-16)/2*3+i%4*2,14+i//4*2+(dwt<0 and dwt or 0)*2,15,false,3)	end
	for i=0,25 do print("super",92-print("super",0,-16)+i%5,3+i//5+(dwt<0 and dwt or 0)*2,15,false,2) end
	for i=0,8 do
	 print("MEAT BOY",118-print("MEAT BOY",0,-16)/2*3+i%3*2,15+i//3*2+(dwt<0 and dwt or 0)*2,0,false,3)
		print("MEAT BOY",118-print("MEAT BOY",0,-16)/2*3+i%3*2,17+i//3*2+(dwt<0 and dwt or 0)*2,0,false,3)
		print("super",93-print("super",0,-16)+i%3,4+i//3+(dwt<0 and dwt or 0)*2,0,false,2)
		print("TIC-80 demake",119-print("TIC-80 demake",0,-16)/2+i%3,37+i//3+(dwt<0 and dwt or 0)*2,0)
	end
	print("MEAT BOY",120-print("MEAT BOY",0,-16)/2*3,19+(dwt<0 and dwt or 0)*2,1,false,3)
	print("MEAT BOY",120-print("MEAT BOY",0,-16)/2*3,17+(dwt<0 and dwt or 0)*2,6,false,3)
	print("super",94-print("super",0,-16),5+(dwt<0 and dwt or 0)*2,14,false,2)
	print("TIC-80 demake",120-print("TIC-80 demake",0,-16)/2,38+(dwt<0 and dwt or 0)*2,10)
	
	-- menu
	rect(238-(dwt<0 and dwt or 0)/8,92,2,4,0)
	rect(172,118-(dwt<0 and dwt or 0)/8,4,2,0)
	rect(220,118-(dwt<0 and dwt or 0)/8,4,2,0)
	rect(162-(dwt<0 and dwt or 0)*2,86,76,32,0)
	local mt={}
	if not opt then
 	mt={"START GAME","OPTIONS","QUIT"}
	else
	 mt={"MUSIC","SFX","BACK"}
	end
	for i=0,2 do print(mt[i+1],169-(dwt<0 and dwt or 0)*2+(i+1==mc and 4 or 0),91+i*8,opt and ((i==0 and vol.m==0) and 10 or ((i==1 and vol.s==0) and 10 or 15) or 15) or 15) end
	if opt then
		rect(208,91,24,5,3)	rect(208,91,vol.m*6,5,15)
 	rect(208,99,24,5,3)	rect(208,99,vol.s*6,5,15)
	end
	spr(291,163+(t//16%4//3)-(dwt<0 and dwt or 0)*2,82+mc*8,8,1)
	
	print((usekb and "[Space]" or "(A)").." select",236-print((usekb and "[Space]" or "(A)").." select",240,0,0,false,1,true),126,10,false,1,true)
	if opt then print("Hold "..(usekb and "[Delete]" or "(X)").." to erase save data",2,126,3,false,1,true) end
	if dt<0 then print("Save data has been erased.",2,126,10,false,1,true) end

	if dwt<0 then
	 rect(0,0,240,math.abs(dwt)*3,0)
		rect(0,136-math.abs(dwt)*3,240,math.abs(dwt)*3,0)
	end
	
	if dwt>0 then
	 rect(0,0,240,136/30*dwt,0)
		for i=0,9 do
		 circ(30+i*20,136/30*dwt-12,20,0)
		end
		rect(0,0,120/30*dwt,136,0)
		rect(240-120/30*dwt,0,120/30*dwt,136,0)
		tri(120/30*dwt,0,120/20*dwt,0,120/30*dwt,136,0)
		tri(240-120/30*dwt,0,240-120/20*dwt,0,240-120/30*dwt,136,0)
		line(120/20*dwt+8,0,120/30*dwt+24-(30-dwt)/2,80+dwt*2,0) line(120/20*dwt+9,0,120/30*dwt+25-(30-dwt)/2,80+dwt*2,0)
		line(240-120/20*dwt-8,0,240-120/30*dwt-24+(30-dwt)/2,80+dwt*2,0) line(240-120/20*dwt-9,0,240-120/30*dwt-25+(30-dwt)/2,80+dwt*2,0)
	end
end

function lvlsel()
	dwt=dwt and dwt or 0
	local lpos={{82,24},{112,24},{142,24},{172,24},{172,40},{172,56},{142,56},{112,56},{82,56},{52,56},{52,72},{52,88},{82,88},{112,88},{142,88},{172,88},
	            {82,24},{112,24},{142,24},{172,24},{172,40},{172,56},{142,56},{112,56},{82,56},{52,56},{52,72},{52,88},{82,88},{112,88},{142,88}}
	ccx=ccx and ccx or lpos[1][1]
	ccy=ccy and ccy or lpos[1][2]
 clvl=clvl and clvl or 1
	lcom=0
	retm=retm and retm or false
	for i=1,15 do if lvlbt[i]>0 then lcom=lcom+1 end end
	
	-- lvl selection navigation
 if math.abs(lpos[clvl][1]-ccx)<2 and math.abs(lpos[clvl][2]-ccy)<2 and st>0 then
 	if ctrl.up then
 	 local can=false for i,p in pairs({5,6,11,12,21,22,27,28}) do if clvl==p then can=true end end
 		if can and ft==0 then clvl=clvl-1 end
 	end
 	if ctrl.down then
 	 local can=false for i,p in pairs({4,5,10,11,20,21,26,27}) do if clvl==p then can=true end end
 		if can and ft==0 then clvl=clvl+1 end
 	end
 	if ctrl.left and dwt==0 then
 	 local can=false for i,p in pairs({2,3,4,13,14,15,16,18,19,20,29,30,31}) do if clvl==p then can=true end end
 		if can and ft==0 then clvl=clvl-1 end
 		local can=false for i,p in pairs({6,7,8,9,22,23,24,25}) do if clvl==p then can=true end end
 		if can and ft==0 then clvl=clvl+1 end
 	end
 	if ctrl.right and dwt==0 then
 	 local can=false for i,p in pairs({7,8,9,10,23,24,25,26}) do if clvl==p then can=true end end
 		if can and ft==0 then clvl=clvl-1 end
 		local can=false for i,p in pairs({1,2,3,12,13,14,15,17,18,19,28,29,30}) do if clvl==p then can=true end end
 		if can and ft==0 then clvl=clvl+1 end
 	end
 	if ctrl.ok and dwt==0 and ft==0 then
 		if clvl==16 and lcom>=14 then
   	ft=1
				psfx(nsfx.sg)
 		end
 		if clvl>=17 then
 		 if lvlbt[clvl-16]~=0 and lvlbt[clvl-16]<=lvlat[clvl-16] then
 			 ft=1
					psfx(nsfx.sg)
 			end
 		end
 		if clvl<=15 then
 		 ft=1
				psfx(nsfx.sg)
 		end
 	end
 	if ctrl.spec and ft==0 and lvlbt[16]>0 then
 	 if dwt==0 then dwt=1 end
 	end
 	if ctrl.back and dwt==0 then
 	 dwt=1 retm=true
 	end
 end
	if ft==1 then ft=0 for i=1,16 do addPt(ccx+7,ccy+9,"bl_jump") end ft=1 end
	if ft>0 then ft=ft+1 end
 if ft>70 then
	 if clvl==16 then cpic=2 gstat="showpic" st=0
	 else gstat="ingame" loadmap(clvl) end
	end
	if dwt~=0 then dwt=dwt+1 end
	if dwt>15 then
	 if not retm then
 	 dwt=-15
 		clvl=clvl<17 and clvl+16 or clvl-16
 		clvl=clvl>31 and 31 or clvl
			l2dw(clvl>16 and "dw" or "lw")
		end
	end
	cx=0 cy=0
	
	-- move cursor
	ccx=ccx+(lpos[clvl][1]-ccx)/4
	ccy=ccy+(lpos[clvl][2]-ccy)/4
	ccx=math.abs(lpos[clvl][1]-ccx)>1 and ccx or lpos[clvl][1]
	ccy=math.abs(lpos[clvl][2]-ccy)>1 and ccy or lpos[clvl][2]
	
	if ft==0 then if clvl<17 then recolor(14,16,12) else recolor(14,2,1) end end
	if dwt==-14 then filter(1,1,1) end
	
 cls(13)
	map(210,119,30,10,0,8*0,0)
	map(210,129,30,7,0,8*6,9)
	rect(0,8*13,240,8*3,2)
	
	-- lines
	line(27,9,39,13,0)
	line(27,10,39,14,0)
	rect(0,9,40,2,0)
	line(200,13,212,10,0)
	line(200,14,212,11,0)
	rect(200,9,40,2,0)
	line(3,128,20,120,0)
	line(3,129,20,121,0)
	rect(20,120,10,2,0)
	rect(0,116,30,2,0)
	line(219,120,236,128,0)
	line(219,121,236,129,0)
	rect(210,120,10,2,0)
	rect(210,116,30,2,0)
	
	rect(0,0,240,8,0)
	rect(0,126,240,10,0)
	
	-- dotted lines
	for i=(clvl<17 and 1 or 17),(clvl<17 and 15 or 30) do
	 local lp={x=lpos[i][1],y=lpos[i][2]}
		while lp.x~=lpos[i+1][1] or lp.y~=lpos[i+1][2] do
		 if (lp.x+lp.y)%4<3 then pix(lp.x+7,lp.y+6,1) end
			lp.x=lp.x==lpos[i+1][1] and lp.x or (lp.x>lpos[i+1][1] and lp.x-1 or lp.x+1)
			lp.y=lp.y==lpos[i+1][2] and lp.y or (lp.y>lpos[i+1][2] and lp.y-1 or lp.y+1)
		end
	end
	
	-- draw lvl tiles
	for i=(clvl<17 and 1 or 17),(clvl<17 and 16 or 31) do
	 rectb(lpos[i][1],lpos[i][2],16,12,0)
		rect(lpos[i][1],lpos[i][2]+12,16,1,2)
	 if i~=16 then
 	 rect(lpos[i][1]+1,lpos[i][2]+1,14,10,(i<17 or (lvlbt[i-16]>0 and lvlbt[i-16]<lvlat[i-16])) and (lvlbt[i]>0 and 6 or 15) or 10)
	 	if lvlbt[i]>0 and lvlbt[i]<=lvlat[i] then spr(292,lpos[i][1]+7,lpos[i][2]+1,0,1) end
 		if i<17 or (lvlbt[i-16]>0 and lvlbt[i-16]<lvlat[i-16]) then print(i%16,lpos[i][1]+2,lpos[i][2]+5,0)
			else spr(412,lpos[i][1]+4,lpos[i][2]+2,0,1) end
		else
		 rect(lpos[i][1]+1,lpos[i][2]+1,14,10,lcom>=14 and (lvlbt[i]>0 and 10 or 15) or 10)
			if lcom<14 then spr(412,lpos[i][1]+4,lpos[i][2]+2,0,1)
			elseif lvlbt[i]==0 then spr(428,lpos[i][1]+4,lpos[i][2]+2,0,1)
		 else spr(429,lpos[i][1]+4,lpos[i][2]+2,0,1) spr(413,lpos[i][1]+7,lpos[i][2]-9,0,1) end
		end
	end
	--rectb(lpos[clvl][1],lpos[clvl][2],16,12,13)
	if ft==0 then
	 spr(396+t/16%4,ccx+4,ccy+1-t//16%2,0,1)
	else
 	rect(ccx+4,ccy+2+ft,8,7-ft,1)
	 rect(ccx+5,ccy+3+ft,6,5-ft,6)
	 cx,cy=0,0
	end
	if st<0 then if st%40==0 or st%18==0 then addPt(lpos[16][1]+7,lpos[16][2]+5,"fw") psfx(nsfx.fw,math.random(2,4),36+math.random(-4,4)) end end
	if #pt>0 then ticPt() end
	
	rect(41,5,158,10,2)
	rect(41,5,158,1,13)
	rectb(40,4,160,12,0)
	print(clvl<17 and "THE FOREST" or "THE FOREST - DARK WORLD",120-print(clvl<17 and "THE FOREST" or "THE FOREST: DARK WORLD",0,-16)/2,8,0)
	
	-- lvl info
	rect(31,107,178,22,2)
	rect(31,107,178,1,13)
	rect(33,121,130,1,9)
	rect(166,110,1,16,9)
	rectb(30,106,180,24,0)
	if clvl~=16 then
 	print((clvl%16)..(clvl>=17 and "X" or "").." "..lvlname[clvl],98-print((clvl%16)..(clvl>=17 and "X" or "").." "..lvlname[clvl],240,0)/2,112,0)
		if lvlbt[clvl]>0 and lvlbt[clvl]<=lvlat[clvl] then print("A+",176,112,9,false,3) end
		spr(442,172,110,0,1)
		spr(443,172,120,0,1)
		print(math.floor(lvlat[clvl]).."."..math.floor(lvlat[clvl]*10%10)..math.floor(lvlat[clvl]*100%10),208-print(math.floor(lvlat[clvl]).."."..math.floor(lvlat[clvl]*10%10)..math.floor(lvlat[clvl]*100%10),240,0),112,1)
		print(lvlbt[clvl]>0 and math.floor(lvlbt[clvl]).."."..math.floor(lvlbt[clvl]*10%10)..math.floor(lvlbt[clvl]*100%10) or "N/A",208-print(lvlbt[clvl]>0 and math.floor(lvlbt[clvl]).."."..math.floor(lvlbt[clvl]*10%10)..math.floor(lvlbt[clvl]*100%10) or "N/A",240,0),122,1)
	else
	 print("LIL SLUGGER",100-print("LIL SLUGGER",240,0)/2,112,0)
	end
	
	print((usekb and "[Space]" or "(A)").." select",2,130,10,false,1,true)
	print((usekb and "[`]" or "(B)").." back",239-print((usekb and "[`]" or "(B)").." back",240,0,0,false,1,true),130,10,false,1,true)
	if lvlbt[16]>0 then print((usekb and "[Tab]" or "(X)").." "..(clvl<17 and "dark" or "light").." world",34,123,clvl<17 and 11 or 1,false,1,true) end
	if st<0 then rectb(33,122,print((usekb and "[Tab]" or "(X)").." "..(clvl<17 and "dark" or "light").." world",240,0,0,false,1,true)+1,7,st//16%2==0 and 11 or 2) end
	
	if dwt>0 then
	 for i=0,7 do
		 tri(240-dwt*16,i*18,240-dwt*16-18,9+i*18,240-dwt*16,18+i*18,0)
		end
	 rect(240-dwt*16,0,240,136,0)
	end
	if dwt<0 then
	 for i=0,7 do
		 tri(0-dwt*16,i*18,0-dwt*16+18,9+i*18,0-dwt*16,18+i*18,0)
		end
	 rect(-240-dwt*16,0,240,136,0)
	end
	if ft>10 then
	 circ(lpos[clvl][1]+7,lpos[clvl][2]+5,(ft-10)*8,0)
	end
	if dwt>14 and retm then cls() end
	if dwt>44 and retm then
 	dwt=-30
		gstat="menu"
		clvl=1
		mc=1
		retm=false
	end
end

function pause()
 dt=dt and dt or 0
 dwt=dwt and dwt or 1
	dwt=dwt<12 and dwt+1 or 12
	-- pause navigation
	if not opt then
  if ctrl.up then mc=mc-1 psfx(nsfx.mc) end
 	if ctrl.down then mc=mc+1 psfx(nsfx.mc) end
		mc=(mc-1)%3+1
 	if ctrl.ok then
 		psfx(nsfx.mc)
 	 if mc==1 and dt==0 and dwt==12 then dwt=-12 end
 		if mc==2 then opt=true mc=1 end
 		if mc==3 and dt==0 then dt=1 end
 	end
	else
	 if ctrl.up then mc=mc-1 psfx(nsfx.mc) end
 	if ctrl.down then mc=mc+1 psfx(nsfx.mc) end
		mc=(mc-1)%3+1
 	if ctrl.left then
		 psfx(nsfx.mc)
			if mc==1 then vol.m=vol.m>0 and vol.m-1 or 0
			elseif mc==2 then vol.s=vol.s>0 and vol.s-1 or 0 end
		end
		if ctrl.right then
		 psfx(nsfx.mc)
			if mc==1 then vol.m=vol.m<4 and vol.m+1 or 4
			elseif mc==2 then vol.s=vol.s<4 and vol.s+1 or 4 end
		end
 	if ctrl.ok then
		 psfx(nsfx.mc)
 		if mc==3 then opt=false mc=2 save() end
 	end
	end
	if ctrl.pause and dt==0 and dwt==12 then dwt=-12 end
	if dwt==0 then gstat="ingame" opt=false end
	if dt>0 then dt=dt+1 end
	if dt>30 then dwt=-15 gstat="lvlsel" clvl=cm end
	
	-- halftone bg
	for i=0,30*17-1 do
	 spr(410,i%30*8,i//30*8,8,1)
	end
	
	-- borders
 local lh=math.abs(dwt)<12 and math.abs(dwt) or 12
	for i,h in pairs({1,0,1,0,0,1,2,3,2,1,0,0,1,0,1}) do
		rect((i-1)*16,136-lh-h,16,lh+h,0)
		rect((i-1)*16,0,16,lh+h,0)
	end
 print("PAUSE",120-print("PAUSE",0,-16)/2,4,15)
	print((usekb and "[Space]" or "(A)").." select",2,130,cm==20 and 15 or 10,false,1,true)
	print((usekb and "[`]" or "(B)").." back",239-print((usekb and "[`]" or "(B)").." back",240,0,0,false,1,true),130,cm==20 and 15 or 10,false,1,true)
	
	-- pause text
	local mt={}
	if not opt then
 	mt={"RESUME","OPTIONS","EXIT TO MAP"}
	else
	 mt={"MUSIC","SFX","BACK"}
	end
	for i=0,2 do
 	for j=0,8 do print(mt[i+1],140+(i+1==mc and 4 or 0)-1+j%3,40+i*8-1+j//3,0) end
	 print(mt[i+1],140+(i+1==mc and 4 or 0),40+i*8,opt and ((i==0 and vol.m==0) and 10 or ((i==1 and vol.s==0) and 10 or 15) or 15) or 15)
	end
	if opt then
		rect(179,39,24,5,3)	rect(179,39,vol.m*6,5,15)
 	rect(179,47,24,5,3)	rect(179,47,vol.s*6,5,15)
	end
	spr(291,134+(t//16%4//3),31+mc*8,8,1)
	if dt>0 then
 	for i,h in pairs({1,0,1,0,0,1,2,3,2,1,0,0,1,0,1}) do
 		rect((i-1)*16,136-(dt*4+12)-h,16,(dt*4+12)+h,0)
 		rect((i-1)*16,0,16,(dt*4+12)+h,0)
 	end
	end
	st=st-1
end

function howtoplay()
 if cm==1 then
	 if st<720 then
 	 if st>40 then
  	 local mtn={65,64,64,64,64,64,64,64,65,66,68,70,72,74,76,78,79,80,80,80,80,80,80,80,79,78,76,74,72,70,68,66}
				if st>240 then mtn={80} end
				rect(54,29,40,32,0) rect(53,30,42,30,0)
  	 rect(54,30,40,30,15)
				if st>240 then rect(54,30,40,30,10) end
  		rect(58,50,32,1,0)
   	spr(396,mtn[st//5%#mtn+1],43,0,1)
				if st<=240 then
   		print("[<]",55,54,10,false,1,true)
    	print("[<]",55,53+(st//40%4==3 and 1 or 0),0,false,1,true)
   		print("[>]",69,54,10,false,1,true)
    	print("[>]",69,53+(st//40%4==1 and 1 or 0),0,false,1,true)
				end
				
  		mtn={0,0,0,0,0,0,0,0,3,5,7,7,6,4,2,0,0,0,0,0,0,0,0,0}
				if st<240 or st>480 then mtn={0} end
  	 rect(100,29,40,32,0) rect(99,30,42,30,0)
  		rect(100,30,40,30,15)
				if st<240 or st>480 then rect(100,30,40,30,10) end
  		rect(104,50,32,1,0)
  		spr(396,116,43-mtn[st//5%#mtn+1],0,1)
				if st>=240 and st<=480 then
  		 print(usekb and "[Space]" or "(A)",101,54,10,false,1,true)
  		 print(usekb and "[Space]" or "(A)",101,53+(st//20%6==2 and 1 or 0),0,false,1,true)
				end
				
  		mtn={0,0,0,0,0,0,0,0,2,4,6,8,10,11,12,12,11,10,8,6,3,0,0,0}
				if st<480 then mtn={0} end
  		rect(146,29,40,32,0) rect(145,30,42,30,0)
  		rect(146,30,40,30,15)
				if st<480 then rect(146,30,40,30,10) end
  		rect(150,50,32,1,0)
  		spr(396,162,43-mtn[st//5%#mtn+1],0,1)
				if st>=480 then
   		print(usekb and "[Space]" or "(A)",147,54,10,false,1,true)
   		print(usekb and "[Space]" or "(A)",147,53+(st//40%3==1 and 1 or 0),0,false,1,true)		
				end
 		elseif st>0 then
			 rect(94-(st*2<40 and st*2 or 40),60-(st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30)),st*2<40 and st*2 or 40,st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30),15)
				rect(120-(st*2<40 and st*2 or 40)/2,60-(st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30)),st*2<40 and st*2 or 40,st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30),15)
 		 rect(146,60-(st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30)),st*2<40 and st*2 or 40,st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30),15)
 		end
		else
		 rect(54,30+(st-720)*2,40,30-(st-720)*2,15)
			rect(100,30+(st-720)*2,40,30-(st-720)*2,15)
 		rect(146,30+(st-720)*2,40,30-(st-720)*2,15)
		end
		if st<180 then
	  for i=0,8 do print((usekb and "[`]" or "(Y)").." pause",1+i%3,128+(st<15 and 15-st or (st>165 and st-165 or 0))+i//3,1,false,1,true) end
		 print((usekb and "[`]" or "(Y)").." pause",2,129+(st<15 and 15-st or (st>165 and st-165 or 0)),2,false,1,true)
		end
		
	elseif cm==2 then
	 if st<720 then
 	 if st>40 then
	   local mtn={0,0,1,2,4,6,8,10,12,14,16,18,20,22,24,26,27,28,28,28,0,1,3,6,10,14,18,22,26,27,28,28}
				if st>240 then mtn={20} end
		  rect(54,49,40,32,0) rect(53,50,42,30,0)
	   rect(54,50,40,30,15)
				if st>240 then rect(54,50,40,30,10) end
		  rect(58,70,32,1,0)
 	  spr(396,56+mtn[(st-24)//5%#mtn+1],63,0,1)
				if st<=240 then
				 if (st-24)//10%16>11 then rect(50+mtn[(st-24)//5%#mtn+1],64,4,1,0) rect(53+mtn[(st-24)//5%#mtn+1],66,2,1,0) rect(49+mtn[(st-24)//5%#mtn+1],68,3,1,0) end
 		  print(usekb and "[Shift]" or "always on",55,74,10,false,1,true)
  	  if usekb then print(usekb and "[Shift]" or "always on",55,73+((st-24)//20%8>=5 and 1 or 0),0,false,1,true) end
				end
		  
	   local mtnx={0,1,3,6,9,13,13,13,13,13,13,13,10,8,7,8,11,13,13,13}
		  local mtny={0,0,0,1,2,3,4,5,6,6,5,4,7,9,10,11,12,11,11,10}
				if st<240 or st>480 then mtnx={0} mtny={0} end
		  rect(100,49,40,32,0) rect(99,50,42,30,0)
		  rect(100,50,40,30,15)
				if st<240 or st>480 then rect(100,50,40,30,10) end
		  rect(104,70,32,1,0)	rect(136,54,1,16,0)
		  spr(396,116+mtnx[(st-40)//5%#mtnx+1],63-mtny[(st-40)//5%#mtny+1],0,1)
				if st>=240 and st<=480 then
 		  print(usekb and "[Space]" or "(A)",101,74,10,false,1,true)
 		  print(usekb and "[Space]" or "(A)",101,73+(((st-40)//12.5%8==1 or (st-40)//12.5%8==5) and 1 or 0),0,false,1,true)
				end
		  
		  local mtnx={0,1,3,6,9,13,13,13,13,13,13,13,10,7,5,3,1,0,0,0,3,6,8,10,12,13,13,13,13,13,13,13}
		  local mtny={0,0,0,1,2,3,4,5,6,6,5,4,7,9,10,11,12,11,11,10,13,15,16,17,17,18,18,17,16,14,12,10}
				if st<480 then mtnx={0} mtny={0} end
		  rect(146,49,40,32,0) rect(145,50,42,30,0)
		  clip(146,50,40,30)
		  rect(146,50,40,30,15)
				if st<480 then rect(146,50,40,30,10) end
		  rect(150,70,32,1,0)	rect(182,54,1,16,0) rect(162,54,1,8,0)
		  spr(396,162+mtnx[st//5%#mtnx+1],63-mtny[st//5%#mtny+1],0,1)
				if st>=480 then
 		  rectb(146,50,40,30,15)
 		  print(usekb and "[Space]" or "(A)",147,74,10,false,1,true)
 		  print(usekb and "[Space]" or "(A)",147,73+((st//20%8==1 or st//20%8==3 or st//20%8==5) and 1 or 0),0,false,1,true)
				end
		  clip()
			elseif st>0 then
			 rect(94-(st*2<40 and st*2 or 40),80-(st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30)),st*2<40 and st*2 or 40,st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30),15)
				rect(120-(st*2<40 and st*2 or 40)/2,80-(st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30)),st*2<40 and st*2 or 40,st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30),15)
 		 rect(146,80-(st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30)),st*2<40 and st*2 or 40,st*2-40<0 and 1 or (st*2-40<30 and st*2-40 or 30),15)
 		end
		else
		 rect(54,50+(st-720)*2,40,30-(st-720)*2,15)
			rect(100,50+(st-720)*2,40,30-(st-720)*2,15)
 		rect(146,50+(st-720)*2,40,30-(st-720)*2,15)
		end
	end
end

function showpic()
 if cpic==1 then
	 if st==0 then music(1,2) end
		if ctrl.ok and st>30 and st<60*8 then st=60*8 end
		poke4(0xFF9C*2+3+0*36,0) poke4(0xFF9C*2+3+2*36,0)
		mvol(0.5)
	 if st>60*1 then
			pic(1,56,1)
			if st<60*1.25 then for i=0,16*8-1 do spr(411-(st-60*1)//5,56+i%16*8,1+i//16*8,8,1)	end end
		end
		if st==60*4+5 then psfx(5,12) end
		if st>60*4 then
			pic(2,56,71)
			if st<60*4.25 then for i=0,16*8-1 do spr(411-(st-60*4)//5,56+i%16*8,71+i//16*8,8,1)	end end
		end
		rect(0,0,240,(st-60*8)*6.8,0)
		if st>60*8+20 then
		 gstat="lvlsel" dwt=-15 st=0 ptrack(-1) l2dw("lw")
		end
		
	elseif cpic==2 then
	 ptrack(4)
		if ctrl.ok and st>30 and st<60*7 then st=60*7 end
	 if st>60*1 then
 	 pic(3,56,1)
			if st<60*1.25 then for i=0,16*8-1 do spr(411-(st-60*1)//5,56+i%16*8,1+i//16*8,8,1)	end end
		end
		if st==60+5 then psfx(13,12,36+12) end
		if st>60*4 then
		 pic(4,56,71)
			if st<60*4.25 then for i=0,16*8-1 do spr(411-(st-60*4)//5,56+i%16*8,71+i//16*8,8,1)	end end
			if st%32==0 then psfx(13,10-math.abs(4-(st-60*4)*4//100),36-18) end
		end
		rect(0,0,240,(st-60*7)*12,0)
		if st>60*7+12 then
		 gstat="ingame" loadmap(16)
		end
		
	elseif cpic==3 then
	 ptrack(-1)
		if ctrl.ok and st>30 and st<60*7 then st=60*7 end
	 if st>60*1 then
		 if st==80 or st==100 then psfx(11,10) end
			if st==160 then psfx(4,15,36-24) end
 	 pic(5,56,1)
			if st<60*1.25 then for i=0,16*8-1 do spr(411-(st-60*1)//5,56+i%16*8,1+i//16*8,8,1)	end end
		end
		if st>60*4 then
		 pic(6,56,71)
			if st<60*4.25 then for i=0,16*8-1 do spr(411-(st-60*4)//5,56+i%16*8,71+i//16*8,8,1)	end end
		end
		rect(0,0,240,(st-60*7)*12,0)
		if st>60*7+12 then
		 gstat="lvlsel" dwt=-15 lvlbt[16]=clvlt save() clvl=1 st=-120 filter(1,1,1)
		end
	end
end

function stscr()
 if dt>0 then
	 -- sakamoto
	 local avt="000030000030000000003000603300000003330663330000000333333333006600033333333306660003f3333f333616003f0f33f0f33116003f0f33f0f33166033f0f33f0f336600333ff33ff333660003333333333660000033333333660000006661166666000000066666663300000003666663333000000336663333300"
		for i=0,255 do
		 pix(2+i%16-2+dt//16,118+i//16,tonumber("0x"..string.sub(avt,i+1,i+1))//(2^(4-dt//8)))
		end
		print("TIC-80 demake",20-8+dt//4,123,dt>=32 and 3 or (dt>=16 and 1 or 0),false,1,true)
		print("nequ16",20-4+dt//8,129,dt>=32 and 8 or (dt>=16 and 3 or 0))
	 
 	print("original game",193+8-dt//4,122,dt>=32 and 3 or (dt>=16 and 1 or 0),false,1,true)
 	print("TEAM MEAT",189+4-dt//8,129,dt>=32 and 6 or (dt>=16 and 4 or 0))
	end
	print("CH1: The Forest (LW&DW)",120-print("CH1: The Forest (LW&DW)",240,0)/2,44-8+dt//4,dt>=32 and 11 or (dt>=16 and 5 or 0))
	print("SUPER MEAT BOY",120-print("SUPER MEAT BOY",240,0),32-4+dt//8,dt>=32 and 6 or (dt>=16 and 1 or 0),false,2)
	if ft==0 then print("- press any key -",120-print("- press any key -",240,0)/2,96,st//30%2==0 and 10 or 3) end
	
	if st>60 and ft==0 then
	 if btnp(0) or btnp(1) or btnp(2) or btnp(3) or btnp(4) or btnp(5) or btnp(6) or btnp(7) then
		 usekb=false
			ft=1
			psfx(55,3,12*3)
		end
		if keyp() then
		 usekb=true
			ft=1
			psfx(55,3,12*3)
		end
	end
	if ft>0 then
		print("Controls scheme: "..(usekb and "Keyboard" or "Gamepad"),120-print("Control scheme: "..(usekb and "Keyboard" or "Gamepad"),240,0,15,false,1,true)/2,96+8-dt//4,dt>=32 and 15 or (dt>=16 and 10 or 0),false,1,true)
		print("Controls scheme: ",120-print("Control scheme: "..(usekb and "Keyboard" or "Gamepad"),240,0,15,false,1,true)/2,96+8-dt//4,dt>=32 and 10 or (dt>=16 and 3 or 0),false,1,true)
	 ft=ft+1
	end
	
	if st<32 then for i=0,30*17 do spr(409,i%30*8,i//30*8,8,1)	end	end
 if st<24 then for i=0,30*17 do spr(410,i%30*8,i//30*8,8,1)	end	end
 if st<16 then for i=0,30*17 do spr(411,i%30*8,i//30*8,8,1)	end	end
	if st<8 then cls() end
	
	if ft>=120 then gstat="menu" ft=0 dwt=-30 end
	if ft>=60 and dt>0 then dt=dt-1 end
end

function l2dw(n)
 if n=="dw" then
  if peek4((0x11164+192*9+3*4)*2+5)>>1==4 then
   for j=0,2 do for i=0,63 do if peek4((0x11164+192*(9+j)+3*i)*2+5)>>1>0 then poke4((0x11164+192*(9+j)+3*i)*2+5,(peek4((0x11164+192*(9+j)+3*i)*2+5)&0x1)|(((peek4((0x11164+192*(9+j)+3*i)*2+5)>>1)-1)<<1)) end end end
   for j=0,2 do for i=0,63 do if peek4((0x11164+192*(9+j)+3*i)*2+4)>0 then poke4((0x11164+192*(9+j)+3*i)*2+4,0x6) end end end
   for j=0,1 do for i=0,63 do if peek4((0x11164+192*(6+j)+3*i)*2+5)>>1>0 then poke4((0x11164+192*(6+j)+3*i)*2+5,(peek4((0x11164+192*(6+j)+3*i)*2+5)&0x1)|(((peek4((0x11164+192*(6+j)+3*i)*2+5)>>1)-1)<<1)) end end end
   for j=0,1 do for i=0,63 do if peek4((0x11164+192*(6+j)+3*i)*2+4)>0 then poke4((0x11164+192*(6+j)+3*i)*2+4,0x8) end end end
  end
 elseif n=="lw" then
  if peek4((0x11164+192*9+3*4)*2+5)>>1==3 then
   for j=0,2 do for i=0,63 do if peek4((0x11164+192*(9+j)+3*i)*2+5)>>1>0 then poke4((0x11164+192*(9+j)+3*i)*2+5,(peek4((0x11164+192*(9+j)+3*i)*2+5)&0x1)|(((peek4((0x11164+192*(9+j)+3*i)*2+5)>>1)+1)<<1)) end end end
   for j=0,2 do for i=0,63 do if peek4((0x11164+192*(9+j)+3*i)*2+4)>0 then poke4((0x11164+192*(9+j)+3*i)*2+4,0x7) end end end
   for j=0,1 do for i=0,63 do if peek4((0x11164+192*(6+j)+3*i)*2+5)>>1>0 then poke4((0x11164+192*(6+j)+3*i)*2+5,(peek4((0x11164+192*(6+j)+3*i)*2+5)&0x1)|(((peek4((0x11164+192*(6+j)+3*i)*2+5)>>1)+1)<<1)) end end end
   for j=0,1 do for i=0,63 do if peek4((0x11164+192*(6+j)+3*i)*2+4)>0 then poke4((0x11164+192*(6+j)+3*i)*2+4,0x7) end end end
  end
	end
end

function ptrack(n) if peek(0x13FFC)~=n then music(n) end end
function mvol(val) for i=0,2 do poke4(0xFF9C*2+3+i*36,peek4(0xFF9C*2+3+i*36)*val) end end
function svol(val) poke4(0xFF9C*2+3+3*36,peek4(0xFF9C*2+3+3*36)*val) end

function debug()
 print("row:"..peek(0x13FFE).."\nfrm:"..peek(0x13FFD).."\ntrk:"..peek(0x13FFC),2,2,15,true,1,true)
	for i=0,3 do rect(2+i*6,36-(peek4(0xFF9C*2+3+i*36)*peek4(0x14000*2+i))//15,4,(peek4(0xFF9C*2+3+i*36)*peek4(0x14000*2+i))//15+1,15) end
	rectb(120-31,2,63,8,3)
	for i=0,3 do rect(120-31+i*16,4,1,4,3) end
	rect(120-30,3,peek(0x13FFE)%16*4+1,6,6)
	print("dt: "..dt.."\nft: "..ft.."\ndwt: "..dwt.."\nst: "..st,210,2,15,false,1,true)
	print(gstat,120-print(gstat,240,0)/2,130)
end

function save()
 for i=0,30 do
	 local pmt=math.floor(lvlbt[i+1]*100)<650 and math.floor(lvlbt[i+1]*100) or 650
	 pmem(i*2,pmt//256) pmem(i*2+1,pmt%256)
	end
	pmem(62,vol.m) pmem(63,vol.s)
end

function load()
 for i=0,30 do
	 lvlbt[i+1]=(pmem(i*2)*256+pmem(i*2+1))/100
	end
	if pmem(64)==0 then
 	vol={m=3,s=4}
		pmem(64,1)
	else
	 vol={m=pmem(62),s=pmem(63)}
	end
end

initPipes() initSaws() decompic() load() dt=32
recolor(16,16,16)
function TIC()
 np=time() et=np-lp lp=np 
 poke(0x3FFB,294)
	controls()
	
	cls()
	if gstat=="stscr" then
	 stscr()
	end
	if gstat=="menu" then
	 ptrack(0)
	 mvol(1-(math.abs(dwt)<60 and math.abs(dwt)/60 or 1))
	 menu()
	end
	if gstat=="lvlsel" then
	 ptrack(1)
		mvol(1-(math.abs(dwt)<40 and math.abs(dwt)/40 or 1))
		mvol(1-(math.abs(ft)<60 and math.abs(ft)/60 or 1))
	 lvlsel()
		if (peek(0x13FFC)==1 and ((peek(0x13FFD)==2 and peek(0x13FFE)>59) or peek(0x13FFD)==3)) or peek4((0x11164+192*11)*2+5)>>1==6 then if peek4((0x11164+192*11)*2+5)>>1==(clvl<=16 and 5 or 4) or peek4((0x11164+192*11)*2+5)>>1==6 then	for i=0,63 do if peek4((0x11164+192*11+3*i)*2+5)>>1>0 then poke4((0x11164+192*11+3*i)*2+5,(peek4((0x11164+192*11+3*i)*2+5)&0x1)|(((peek4((0x11164+192*11+3*i)*2+5)>>1)-1)<<1)) end end	end	else if peek4((0x11164+192*11)*2+5)>>1==(clvl<=16 and 4 or 3) then	for i=0,63 do if peek4((0x11164+192*11+3*i)*2+5)>>1>0 then poke4((0x11164+192*11+3*i)*2+5,(peek4((0x11164+192*11+3*i)*2+5)&0x1)|(((peek4((0x11164+192*11+3*i)*2+5)>>1)+1)<<1)) end end	end	end
	end
	if gstat=="ingame" then
	 ptrack(cm<16 and 2 or (cm>16 and 3 or 4))
		if playback then mvol(1-(math.abs(dwt)<40 and math.abs(dwt)/40 or 1)) end
	 if ctrl.pause and not playback and dt==0 and ft==0 and lnt==0 then gstat="pause" mc=1 end
 	eng()
 	draw()
	elseif gstat=="pause" then
	 mvol(0.5)
		mvol(1-(math.abs(dt)<40 and math.abs(dt)/40 or 1))
	 draw()
		pause()
	elseif gstat=="showpic" then
	 showpic()
	end
	mvol((vol.m/4)*0.75)	svol(vol.s/4)
 --FPS()
	--debug()
	st=st+1
	t=t+1
end

# <TILES>
# 001:477744447777444477744444444444454444475574447555774455554445b555
# 002:4444444447744444444444445445555455555b555555555555b5555555555555
# 003:7744444747444444444477444444774455544444555544445555444455554447
# 004:7333777733337777333777777777777477777344377734443377444477744447
# 005:7777777773377777777777774774444744444444444444444774444477444444
# 006:3377777373777777777733777777337747777777444777774444777744447773
# 007:0000000000000000000000000000000000000011000001110000011100001113
# 008:0000000000000000000000001001111011111111111111111331111133111111
# 009:0000000000000000000000000000000000000000110000001110000011100000
# 010:000000000000000b0000000b000000bb00000bbb000000b500000bbb0000bbbb
# 011:00000000b0000000b0000000bb000000bbb000005b000000bbb00000bbbb0000
# 012:000000bb00000bbb0000bbbb000bbbbb000bbbbb00bbbbbb00bbbbbb00bbbbbb
# 013:bb000000bbbb0000bbbbb000bbbbb000bbbbbb00bbbbbb00bbbbbb00bbbbbb00
# 014:000000000000000000000000000bb00000bbbb00000bb00000bbbb000bbbbbb0
# 015:000000000bbbbb00bbbbbbb0bbbbbbbbbbbbbbbbbbbbbbb555bbbbb0005b5b50
# 016:3377777777777377777773377733777777337777733777777777773777777377
# 017:444555554445555544445555744455557444555574445555444455b544455555
# 018:b555555b5555555555555b555bb55555555555555555555555b55555b555555b
# 019:555554475555544755bb5444555557445555574455557744b555444455554444
# 020:7774444777744444777744443777444437774444377744447777447477744447
# 021:7744444444444444444477444444777444444744444444444444444474444447
# 022:4444477344444773444447774444437744444377444433777444777774447777
# 023:0001111300011111000011110000111100001111000011110000113100011113
# 024:1333111111311111111111111111111111113311111113311111111113311111
# 025:1111000011111000111110001111100011111000111100003111000031110000
# 026:000000b500000bbb0000bbbb000bbbbb000000b500000bbb0000bbbb00bbbbbb
# 027:5b000000bbb00000bbbb0000bbbbb0005b000000bbb00000bbbb0000bbbbbb00
# 028:005bbbb5000bbb510005bbb100005bbb0000055b000000050000000100000004
# 029:5bbbb5001bb550001b5000001bbb0000bbbb5000555500001000000040000000
# 030:00b55b000bbbbbb0bbbbbbbb00b55b000bbbbbb0bbbbbbbb0001100000044000
# 031:000115000bbb1000bbbb10005bbbb00005bbbb000055bbb00001bb50000b5500
# 032:4444444444444444444444444444444444444444444444444444444444444444
# 033:4445555544445555744455557744455577444445774444474477444447777444
# 034:555555555555b5555b5555555555555555555b45745544447444477444447774
# 035:5555447455577477555444475b44444444444444444774444447777444447774
# 036:7774444477774444377744443377744433777774337777737733777773333777
# 037:7444444744444477444444444444444444444474374477773777733777773337
# 038:7444773744433733444777734477777777777777777337777773333777773337
# 039:0001111100001111000011110000011100000001000000000000000000000000
# 040:3111111311111133111111111111111111111101001100000000000000000000
# 041:3111000011100000111000001100000000000000000000000000000000000000
# 042:00000b550000bbbb000bbbbb0bbbbbbb00000bbb000000010000000400000004
# 043:55b00000bbbb0000bbbbb000bbbbbbb0bbb00000100000004000000040000000
# 044:00000bbb0000bbb50000b5510000000100000004000000040000000400000004
# 045:4000000040000000400000004000000040000000400000004000000040000000
# 046:000000000000000000bbbbb00bbbbbbb0bbbbbbbbbbbbbb55bbbb55505555550
# 047:00b110000bbb400005bb50000055400000044000000440000004400000044000
# 048:1111111111111111111111111111111111111111111111111111111111111111
# 049:555555555b5555555555bb55555555555555544455b574445555777455547774
# 050:5555555555bb555555555555555555b5574555557744555544775b5547775555
# 051:7444444444447774444447744444444447747777474437774443333744473337
# 052:4444444474447444444477444444474434444444337444447733474473334444
# 053:3111111111113331111113311111111113310000131100001110000011100000
# 054:1111111131113111111133111111131101111111000111110000131100001111
# 055:0000000000000000000000000000000000003333000013330001111300031113
# 056:0000000000000000000000000000000000000030130033331333311333331113
# 057:0000000000000000000000000000000010000000113000003311000031110000
# 058:aaaaaaa7a7777773a7777773a7777773a7777773a7777773a777777373333333
# 059:aaaaaaa7a3333373a33333a3a33333a3a33333a3a33333a3a7aaaaa373333333
# 060:44444aa744444a7344aa7a7344a73a7344733a73aaaaaa73a777777373333333
# 061:aa744444a7344444a73aa744a73a7344a7373344a77aaaa7a777777373333333
# 062:00000000000000000000000000000000aaaaaaaa7777777733333333aaaaaaaa
# 063:33111111111111111111111111111311aaaaaaaa7777777733333333aaaaaaaa
# 064:00000000000b0000000bb000000bb00000bbbb0000bbbb000bbbbbb0bbbbbbb0
# 065:75544447555444445b55774455557744555554445555b5555b55555555b55555
# 066:477755557777555b77745555444555554555555555545555555555b555555555
# 067:4447777344447777744433777744437744444477444474444774444444444744
# 068:7333477733334477333744447744444444447444477444444377444444444447
# 069:1110000011110000311100003311100011111100111131111331111111111311
# 070:0000133300001133000011110011111111113111133111111333111111111113
# 071:0003333100033331000033330000313300000133000011330000333300003333
# 072:1133333333333133333331133311333333113333311333333333331333333133
# 073:3333000033330000333300001333000013330000133300003333000033300000
# 074:a73a73a7a73a73a7a73a73a7a73a73a7a73a73a7a73a73a7a73a73a7a73a73a7
# 075:aaaaaaaa7777777733333333aaaaaaaa7777777733333333aaaaaaaa77777777
# 076:aaaaaaa7a77777737333377344aa7a7344a73a7344733a7344444a7344444733
# 077:aaaaaaa7a7777773a7333333a73aa744a73a7344a7373344a734444473344444
# 078:7777777733333333aaaaaaaa7777777700000000000000000000000000000000
# 079:7777777733333333aaaaaaaa7777777711111111111111111111111111111311
# 080:00b4bbbb0bb44000bbb4bb0000044bb000044bbb0004400000b440000bb44000
# 081:555555555b5555505555bb00555550005555000055b000005500000050000000
# 082:5555555505bb555500555555000555b500005555000005550000005500000005
# 083:7444444444447770444447004444400047740000474000004400000040000000
# 084:4444444404447444004477440004474400004444000004440000004400000004
# 085:7333777733337770333777007777700077770000377000003300000070000000
# 086:3377777303777777007733770007337700007777000007770000007700000003
# 087:0003333100003333000011330000013300000033000000000000000000000000
# 088:3333333331133333333333333333303330000000000000000000000000000000
# 089:3111000011110000111300003330000000000000000000000000000000000000
# 090:00000007000000a300000a730000a773000a777300a777730a77777373333333
# 091:a0000000aa000000a7a00000a77a0000a777a000a7777a00a77777a073333337
# 092:000000070000007300000a7300003a7300033a7300aaaa730777777373333333
# 093:a0000000a7000000a7300000a73a0000a7373000a77aaa00a777777073333333
# 094:0000a73a0000a73a0000a73a0000a73a0000a73a0000a73a0000a73a0000a73a
# 095:73a7000073a7000073a7000073a7000073a7000073a7000073a7000073a70000
# 096:0004400000044b00000440000004400000044000000440000004400000044000
# 097:70000000550000005b50000055550000555550005555b5005b55555055b55555
# 098:000000050000005b00000555000055550005555500545555055555b555555555
# 099:4000000044000000744000007744000044444000444474004774444044444744
# 100:0000000700000077000004440000444400047444007444440377444444444447
# 101:7000000077000000377000003377000033777000337777007733777073333777
# 102:0000000700000033000007730000777700077777007337770773333777773337
# 103:3111111111111111111111111111111113113333111113331111111311131113
# 104:3111111311111133111111111111111111111131131133331333311333331113
# 105:1111111111111111111331111111111111111111113111113311111131111111
# 106:aaaaaaa703777773003777730003777300003773000003730000003300000003
# 107:aaaaaaa7a7777730a7777300a7773000a7730000a7300000a300000070000000
# 108:aaaaaaa70777777300333773000a7a7300003a7300000a730000007300000003
# 109:aaaaaaa7a7777770a7333300a73aa000a73a0000a7300000a700000070000000
# 110:3311a73a1111a73a1111a73a1111a73a1111a73a1111a73a1111a73a1111a73a
# 111:73a7111173a7111173a7111173a7111173a7111173a7111173a7111173a71113
# 112:0000000000004400000044400000440400044000004440000004400000044400
# 113:555555555b5555515555bb11555553315555131155b111115511111151111113
# 114:5555555515bb555511555555111555b511115555111115551111115531111115
# 115:7444444444447771444447114444433147741311474111114411111141111113
# 116:4444444414447444114477441114474411114444111114441111114431111114
# 117:7333777733337773333777137777733377773333377333333333331373333133
# 118:3377777333777777337733773317337733117777311337773333337733333133
# 119:1113333111133331111133331111313311111133111111333111333331113333
# 120:1133333333333133333331133311333333113333311333333333331333333133
# 121:3333111333331111333311111333111113331111133311113333113133311113
# 122:33111117111111a311113a731111a773111a777311a777731a77777373333333
# 123:a3111111aa111111a7a13311a77a3331a777a311a7777a11a77777a173333337
# 124:331111171111117311113a7311113a7311133a7311aaaa731777777373333333
# 125:a3111111a7111111a7313311a73a3331a7373311a77aaa11a777777173333333
# 126:111111bb11111bbb1111bbbb111bbbbb111bbbbb11bbbbbb11bbbbbb11bbbbbb
# 127:bb111111bbbb1111bbbbb111bbbbb111bbbbbb11bbbbbb11bbbbbb11bbbbbb11
# 128:0044400004440000004400000044000004400000044400000440000004400000
# 129:73111111551111115b51331155553331555553115555b5115b55555155b55555
# 130:331111151111115b11113555111155551115555511545555155555b555555555
# 131:4311111144111111744133117744333144444311444474114774444144444744
# 132:3311111711111177111134441111444411147444117444441377444444444447
# 133:7133333377333133377331133377333333777333337777337733777373333777
# 134:1133333733333133333337733311777733177777317337773773333777773337
# 135:1113333111113333111111331111113311111133131111111111311111111111
# 136:3333333331133333333333333333313331111111111111111331111133111111
# 137:3133131131111111111311113331111133111111111111111111311111133111
# 138:aaaaaaa713777773113777731113777311113773111113731111113331111113
# 139:aaaaaaa7a7777731a7777311a7773331a7731311a7311111a311111171111113
# 140:aaaaaaa71777777311333773111a7a7311113a7311111a731111117331111113
# 141:aaaaaaa7a7777771a7333311a73aa331a73a1311a7311111a711111171111113
# 142:115bbbb5111bbb511115bbb111115bbb1111155b111111151111111111111114
# 143:5bbbb5111bb551111b5111111bbb1111bbbb5111555511111111111141111111
# 145:4444444444444774444477344444734444444444477444444433444444444444
# 146:4444447744774444444774744447744444444444447444444774444744444477
# 147:4444447744444444444474444444444447444444447444444444444444444474
# 148:4444744444444444444444444444444444444447444444444444444444444444
# 149:4474444444444744444444444444444474444444444444444444444444444444
# 150:55b5555555555555555555b555555555b55555555555555555555bb555555555
# 151:3111111131111113111111111131111111111111111113111111311111111111
# 152:7777777747444777744444747447747777447774747744777774474747774777
# 153:7777777747444777744444747447747777447774747744777774474747774777
# 154:1111111111111111111111111111111111111111111111111111111111111111
# 155:aaaaaaa7a1111113a1111113a1111113a1111113a1111113a111111373333333
# 156:aaaaaaa7a7733773a7333373a3333333a3333333a73333a3a7733a7373333333
# 157:7744444444444444443333444433334444333344443333744444474474444447
# 158:11111bbb1111bbb51111b5511111111111111114111111141111111411111114
# 159:4111111141111111411111114111111141111111411111114111111141111111
# 160:1143311111433111114331111143311111433111114331111143311111433111
# 161:4444444444444444444444444444111144410000441000004100000010000000
# 162:4444444444444444444444441111111100000000000000000000000000000000
# 163:4444444444444444444444441114444400004444000004440000004400000004
# 164:4444444444444444444444441111111111111111111111111111111111111111
# 165:4444444144444441444444414444444144444441444444414444444144444441
# 166:4444444444444444444444444444111144413111441331114143311111433111
# 167:4444444444444444444444441111111111433111114331111143311111433111
# 168:4444444444444444444444441114444411414444114314441143314411433114
# 169:aaaaaaa7a0000003a0000003a0000003a0000003a0000003a000000373333333
# 170:3113311331133113311331133113311331133113311331133113311331133113
# 171:3333333333333331331111313311113133111131331111313333333131111111
# 172:3333333333333331333333313333333133333331333333313333333131111111
# 173:3333333311111111111111113333333333333333111111111111111133333333
# 174:aaaaaaa7a7777773a7777773a777777373333333a7777773a7777773a7777773
# 175:aaaaaaa7a7777773a7777773a777777373333333a73a73a7a73a73a7a73a73a7
# 176:1111111111111111111111111111111100000000000000000000000000000000
# 177:4441000044410000444100004441000044410000444100004441000044410000
# 178:1111111111111111111111111114411144444444444444441114411111144111
# 179:0000444100004441000044410000444100004441000044410000444100004441
# 180:4444444444444444444444444444444444444444444444444444444411111111
# 181:4444444144444441444444414444444144444441444444414444444111111111
# 182:8888888a888888a788888a778888a777888a777788a777778a777777a7777777
# 183:aaaaaaaa77777777777777777777777777777777777777777777777777777777
# 184:888888883aaa8a8a33aaaaaa3a333333333333333a333333333333333a333333
# 185:888888888a8a8a8aaaaaaaaa3333333333333333333333333333333333333333
# 186:888888888a888888aa8a888833aa8a883333a88833333aa833333a88333333aa
# 187:7777777777777777777777777777777777777777777777777777777777777777
# 188:aaaaaaa711111113111111131117733311177333111111131111111373333333
# 189:a1111117a1111113a1111113a1177113a1177113a1133113a113311373333333
# 190:a7777773a7777773a777777373333333aaaaaaaa7777777733333333aaaaaaaa
# 191:a73a73a7a73a73a7a73a73a7a73a73a7aaaaaaaa7777777733333333aaaaaaaa
# 192:1143311111433111114111111114411144444444444444441114411111144111
# 193:0000000000000000000000000000000044444444444444444444444411114444
# 194:4444444144444441444444411111111100000000000000000000000000000000
# 195:0000000000000000000000000000000044444444444444444444444444441111
# 196:4444111144413111441331114143311111433111114331111143311111433111
# 197:1141444411431444114331441143311411433111114331111143311111433111
# 198:8111777783333111833133338133113388111111888888888888888888888888
# 199:7711111811133188333318881131888811188888888888888888888888888888
# 200:333333333a333333333333333a333333133333331a3333331377aaaa1778a8a8
# 201:333333333333333333333333333333333333333333333333aaaaaaaaa8a8a8a8
# 202:333333a8333333aa33333a8833333aa83333a88833aa8a88aa8a8888a8888888
# 203:7777777711111111333331333333333311111111888888888888888888888888
# 204:aaaaaaa7a1133113a1133113a1177113a1177113a1111113a111111371111113
# 205:aaaaaaa7a1111111a1111111a3377111a3377111a1111111a111111173333333
# 206:aaaaaaaa3333333377777777aaaaaaaa33333333000000000000000000000000
# 207:aaaaaaaa3333333377777777aaaaaaaa33333333111111111111111111111111
# 208:11111111111b1111111bb111111bb11111bbbb1111bbbb111bbbbbb1bbbbbbb1
# 213:8888888888888888888888888888888888888888888888888888888888888888
# 214:4444444444444444444444444444111144410000444100004441000044410000
# 215:0000000000000000001111001114411144444444444444441114411100144100
# 216:88888888a8a88888aaa8a88833aa88a83333aa8833333a8833333aaa333333a8
# 217:333333aa333333a833333aaa33333a883333aa8833aa88a8aa8a88888a888888
# 218:aaaa77aa77777773a77aa77a7a7a7a7a77777777777777737777777377777777
# 219:8883333388877777888877888888f788cccfef880cc0f78844444488ccccc788
# 220:333333337777773388888800888880008000000080ff8f888088cc8f8088cc88
# 221:3333888877778888877888880378888808738888083788880887388808877888
# 222:9999999999999999999999999999999999999999999999999999999999999999
# 223:2222222222222222222222222222222222222222222222222222222222222222
# 224:11b4bbbb1bb44111bbb4bb1111144bb111144bbb1114411111b441111bb44111
# 230:888888883aa8a8a833aaaaaa3a333333333333333a333333333333333a333333
# 231:88888888a8a8a8a8aaaaaaaa3333333333333333333333333333333333333333
# 232:0000000090000000990000009999000099999900999999909999999099999999
# 233:0000000900000999000099990000999900099999000999990099999909999999
# 234:0000000000000000000900000099900000999900009990000009000000090000
# 235:0000000000000000000000000000900000009000000999000009990000009000
# 236:0000000000000000000000000000000000000000000000000000000000099900
# 238:9999999999999999999999999999999999999999999222999922222992222229
# 239:9999999999999999999999999999999999999999999999999999299999992999
# 240:1114411111144b11111441111114411111144111111441111114411111144111
# 246:333333333a333333333333333a333333133333331a3333331377aaaa177a8a8a
# 247:333333333333333333333333333333333333333333333333aaaaaaaa8a8a8a8a
# 248:2999999922299999222299992222999922222999222229992222229922222229
# 249:9999999999999992999999229999222299222222922222229222222222222222
# 250:9999999999229999922229999222229999222299992229999992999999929999
# 251:9999999999992999999929999992229999922299992222299922222999992999
# 252:0099999009999990099999990099999000099900009990000009900000099000
# 253:0000900000009000000999000009990000999990009999900999999900099900
# 254:9222222292222222992222299992229999222999999229999992299999922999
# 255:9992229999922299999222999922222999222229922222229222222299922299
# </TILES>

# <SPRITES>
# 000:8888888866666666666666666066606660666066666666666666666686688668
# 001:8888888866666666666666660666066606660666666666666666666681188668
# 002:8888888886666666866666668660666686606666866666668666666688811668
# 003:8888888886666668866666688660666886606666866666668666666888811668
# 004:88888888888888f88ccccfef8cccccf8c0ccc0ccccc0cccc8cccccc88cc88cc8
# 005:88888888888888f88ccccfefc0ccc0fcccc00ccc8cc00cc88cccccc88cc88cc8
# 006:000000000ff8f880088ccf80088cc88000a6a0000006a0000000000080088008
# 007:0000000000000000000000000000000000066646000066460000660000006600
# 008:0006000000066000006466006460664666400000000000000000000000000000
# 009:0000000000000000000000000006000066660000646600000666000000040000
# 010:0000000000000000000000600000006600000066000006600000666400006640
# 011:0000000000000060006666646660666666404066000000000000000000000000
# 012:0000000000000000000000000000000066000000666000000466660000606000
# 013:0000000000000000000000000000000000000066000006640006606000666600
# 014:0000000060000000666666006606666666000064400000000000000000000000
# 015:0000000000000000600000006600000066000000066000000666000000660000
# 016:8888888866666666666666660666066606660666666666666666666686688668
# 017:8888888866666666666666660666066606660666666666666666666686688118
# 018:8888888886666666866666668660666686606666866666668666666688866118
# 019:8888888888888888888888888888888888888888888888888888800888880000
# 020:8888888888888888888888888888888800088888008888880888888888888888
# 021:8888888888888888888888888888888808888888008888880008888888888888
# 022:8888888888888888888888888888888808888888000888880088888888888888
# 023:0006640000060000006600000646000066660000006000000006600000064000
# 025:0006600000466000000066000000066600004660000066000006600000046000
# 026:0066000006646000006600000060000000640000006600000006600000066000
# 028:0006600000466000000066000000060000006600000046000006666000066600
# 029:0006600000066000006640000066000000644000006000000066600006666000
# 031:0046666000066600000066000000660000000600000066000006600000006000
# 032:6666666646060460044000400000000000000000000000000000000000000000
# 033:0000000600000066000006040000664000060400006600000600400064000000
# 034:0000000011111111111111111011101110111011111111111111111101100110
# 035:88000888000f00880ffff0080fffff080ffff008000f00888800088888888888
# 036:0110000010010010111101111001001000000000000000000000000000000000
# 037:773311003ffc61003c1111001616100016111000111000000000000000000000
# 039:0000660000006464000066600000666600006000000000000000000000000000
# 040:0000000000000000000000006600046066660466006666000006600000006000
# 041:0066000006060000646600006666600000000000000000000000000000000000
# 042:0006060000666464000006660000006600000000000000000000000000000000
# 043:0000000000000000000000000600006664660664666666000600000000000000
# 044:0466000000660000666000006600000066000000060000000000000000000000
# 045:0000660000006640000006660000006600000066000000060000000000000000
# 046:0000000000000000400000006000004666666606006664660000000600000000
# 047:0004660000666000666000006600000000000000000000000000000000000000
# 048:0000000000000000000000000000000000000000000000060000000000000006
# 049:0000000000000006000000460000066600066060666664006060000060000000
# 050:0000000000000000600000006660460066666660000460600000064600000006
# 051:0000000000000000000000000000000000000000000000000000000060600000
# 052:0000000000000000000000000000000000000000000000000000000000000666
# 053:0000000000000000000000000006066600666606066064004660000060000000
# 054:0000000006000000666000006660000040666006000666660040066000000004
# 055:0000000000000000000000000000000000000000600000006000000060000000
# 056:0000000000000000000000000000000000000000000000000000006600000006
# 057:0000000000000600000006600000666600066406066600006464000060000000
# 058:0000000000000000000600006664600066666000040606600000046600000006
# 059:0000000000000000000000000000000000000000000000000600000066000000
# 064:0000006000006660000664400000600000006600000664000006600000660000
# 067:6660000000400000066000000066000000660000000660000006600000006660
# 068:0000666400000660000006400000660000006600006400000666600000666000
# 071:6600000006600000066600000466600000660000000060000006600000066000
# 072:0000006400000600000006600006660000666600000664000006000000066000
# 075:4600000006600000066000000466000000646000000666600000660000066000
# 080:0646600000066400000600000000660000006600000006600000046000000666
# 082:0000000000000000000000000000000000000000000000000000000000000004
# 083:0006460000466000000660000046000000660000060660000666000066400000
# 084:0006600000066000000660400000600000066600000066600000064000000066
# 085:0000000000000000000000000000000000000000000000000000000004000000
# 086:0000000000000000000000000000000000000000000000000000000400000000
# 087:0006660000064660000066000046000000660000066000000460000066660000
# 088:0006400000660000066664000006660000006000000006600000064000000066
# 089:0000000000000000000000000000000000000000000000004000000000000000
# 091:0004600000066000000060000066660000666000064000004660000006000000
# 096:0000060600000000000000000000000000000000000000000000000000000000
# 097:0400000066600000066460000466660400600666000000060000000000000000
# 098:0000000600000066000646660666640064600000600000006000000000000000
# 099:6000000000000000600000000000000000000000000000000000000000000000
# 100:0000000600000006000000060000000000000000000000000000000000000000
# 101:0000000066604000666660006006660400000666000006660000006000000000
# 102:0000000600000606000666606066460066606000000000000000000000000000
# 103:6660000000000000000000000000000000000000000000000000000000000000
# 104:0000006600000060000000000000000000000000000000000000000000000000
# 105:6000000060600000066640000006606600066664000060000000000000000000
# 106:0000000600000666400466606606600064660000066000000060000000000000
# 107:6000000046000000000000000000000000000000000000000000000000000000
# 108:0000000000000000000000000000100000016100001666100166166116616666
# 109:0000000000000000000000000000000000000000000000000000000110000016
# 110:0000000000000000000000000000000000060000000000600100010016100000
# 112:0000000a0000000a000000aa00aaaa77000a7777000a777700a777770aa77773
# 113:00000000a0000000aa00a00077aaa0007777a0007777a00077777a0037777aaa
# 114:00000000000000000000a0aa0000aa77000a777700aa77770aa7777700a77773
# 115:000000000a000000aaa0000077aa00007777aa007777a00077777a0037777a00
# 116:0000000000000a0000000aaa0000aa7700aa7777000a777700a7777700a77773
# 117:0000000000000000aa0a000077aa00007777a0007777aaa077777a0037777a00
# 118:0000000600000004000000660066460000060000000640000060000006640000
# 119:0000000060000000460060000064600000006000000060000000060000000646
# 120:0000000000000000000060660000464000060000006000000664000000600000
# 121:0000000006000000646000000046000000006600000060000000460000000600
# 122:0000000000000600000006640000660000640000000600000060000000400000
# 123:0000000000000000660600004066000000004000000066600000060000004600
# 124:0166661616166166010166610016161000010100000000000000000000000000
# 125:610001011000161600000166000016610000016a000000160006001700000aa6
# 126:666100006166a00166166a00666666aa66777677777677677767777777733777
# 127:0000000000000000a6000000a0000000a0000000a00000007a0000007aaa0000
# 128:aaa7777300a77777000a7777000a7777000aaa77000a00aa0000000a00000000
# 129:37777aa077777a007777a0007777a00077aaaa00aa000000a0000000a0000000
# 130:00a7777300a77777000a777700aa77770000aa7700000aaa000000a000000000
# 131:37777a0077777aa07777aa007777a00077aa0000aa0a00000000000000000000
# 132:00a7777300a777770aaa7777000a77770000aa770000a0aa0000000000000000
# 133:37777a0077777a007777a0007777aa0077aa0000aaa0000000a0000000000000
# 134:6640000000600000000640000004000000064640000600460000000400000000
# 135:0000046000000600000060000000600000464600040000006600000060000000
# 136:0040000000600000000600000064400000006600000004660000006000000000
# 137:0000040000000060000066000000400000460000660600000000000000000000
# 138:0060000000640000066600000004040000006600000060660000000000000000
# 139:0000040000000600000060000000460000460000466000000060000000000000
# 140:1111111116666661161661611616616116666661166666611161161101111110
# 141:1111111116666661161661611616616116666661166666611161111101110000
# 142:1111111116666661161661611616616116666661166666611161161101111110
# 143:1111111116666661161661611616616116666661166666611111161100001110
# 144:00000000000000000000000000000000000aaaaa0000aaaa0000aaa70000aa77
# 145:000a0000000aa00000aaaa00aaaaaaaaaa7777aa77777777777a7777777aa777
# 146:000000000000000000000000000a0000aaaa0000aaaa00007aaa000077aa0000
# 147:0000000000000000000000a0000000aa000000aa00000aaa0000aaa70000aa77
# 148:00000000000000a000aaaaaaaaaaaaaaaa7777aa777777777777a7777a77aa77
# 149:00000000000000000000000000000000aa000000aaa000007aaaaa0077aaa000
# 150:00000000000000000000000000000000000000aa00000aaa000aaaa700aaaa77
# 151:00000000a0000000aaaaaa00aaaaaaaaaa7777aa7777777777a7777777aa77a7
# 152:0000000000000000a0000000aa000000aa000000aaa000007aaa000077aa0000
# 153:0808080888888888080808088888888808080808888888880808080888888888
# 154:0808080880808080080808088080808008080808808080800808080880808080
# 155:0808080800000000080808080000000008080808000000000808080800000000
# 156:0077770007700770070000707777777777777777777777777777777700000000
# 157:10110000101f1100101fff10101f110010110000100000001000000010000000
# 160:000aa777000aa77700aa77770aaa777aaaaa77aa00aa7777000aa777000aa777
# 161:a7aaaa7a7aa77aa7aa7777aaa773377aa773377aaa7777aa7aa77aa7a7aaaa7a
# 162:777aa000777aa0007777aa00aa77aaaaa777aaa07777aa00777aa000777aa000
# 163:00aaa7770aaaa77700aa777a00aa77aa00aa777700aa7777000aa77a000aa777
# 164:7aaaaa777aa77aaaaa7777aaa773377aa773377aaa7777aaaaa77aa777aaaaa7
# 165:777aa000a77aa0007777aa007777aa00aa77aa00a777aa00777aaaa0777aaa00
# 166:000aa777000aa77a00aa777700aa777700aa777a00aa77aa00aaa7770aaaa777
# 167:77aaaaa7aaa77aa7aa7777aaa773377aa773377aaa7777aa7aa77aaa7aaaaa77
# 168:777aaaa0777aaa00aa77aa00a777aa007777aa007777aa00a77aa000777aa000
# 169:f8f8f8f888888888f8f8f8f888888888f8f8f8f888888888f8f8f8f888888888
# 170:f8f8f8f88f8f8f8ff8f8f8f88f8f8f8ff8f8f8f88f8f8f8ff8f8f8f88f8f8f8f
# 171:f8f8f8f8fffffffff8f8f8f8fffffffff8f8f8f8fffffffff8f8f8f8ffffffff
# 172:0000000000aaaa000aaaaaa0a00aa00aa00aa00a0aaaaaa00aaaaaa000a00a00
# 173:0000000000777700077777707777777770077007077777700777777000700700
# 174:0a0a0a0000aaaa0aaaa77aa00a7777aaaa7777a00aa77aaaa0aaaa0000a0a0a0
# 176:0000aa770000aaa70000aaaa0000aaaa0000a000000000000000000000000000
# 177:777aa7777777a77777777777aa7777aaaaaaaaaa00aaaa00000aa0000000a000
# 178:77aa00007aaa0000aaaa0000aaaaa00000000000000000000000000000000000
# 179:000aaa7700aaaaa700000aaa000000aa00000000000000000000000000000000
# 180:77aa77a7777a777777777777aa7777aaaaaaaaaaaaaaaa000a00000000000000
# 181:77aa00007aaa0000aaa00000aa000000aa0000000a0000000000000000000000
# 182:0000aa770000aaa700000aaa000000aa000000aa0000000a0000000000000000
# 183:7a77aa7777777a7777777777aa7777aaaaaaaaaa00aaaaaa0000000a00000000
# 184:77aaaa007aaaa000aaa00000aa00000000000000000000000000000000000000
# 185:fffffffff8888888f8888888f8888888f8888888f8888888f888888888888888
# 186:ff00ffff1ffffff01fffff0001ff000001000000010000000010000000100000
# 187:0011100001f1f1001ff1ff1011f111101fffff1001f1f1000011100000000000
# 188:00077000000aa000000aa00000aaaa0000aaaa00000aa0000000000000000000
# 189:0000000000000000000000007aaaaaa77aaaaaa7000000000000000000000000
# 190:0001100000033000000330000033330000333300000330000000000000000000
# 191:0000000000000000000000001333333113333331000000000000000000000000
# 192:00000000000000000000000000000000000000000000000a000000000000000a
# 193:000000000000000a0000000a00000aaa000aaaaaaaaaa777aaa7777aa777777a
# 194:0000000000000000a0000000aaa00a00aaaaaaa0777aaaa077777aaaa777777a
# 195:00000000000000000000000000000000000000000000000000000000a0a00000
# 196:0000000000000000000000000000000000000000000000000000000000000aaa
# 197:000000000000000000000000000a0aaa00aaaaaa0aaaa777aaa77777a7777777
# 198:000000000a000000aaa00000aaa00000aaaaa00a777aaaaa77777aaa77a7777a
# 199:0000000000000000000000000000000000000000a0000000a0000000a0000000
# 200:000000000000000000000000000000000000000000000000000000aa0000000a
# 201:0000000000000a0000000aa00000aaaa000aaaaa0aaaa777aaa77777a777a777
# 202:0000000000000000000a0000aaaaa000aaaaa000777aaaa077777aaa7777777a
# 203:0000000000000000000000000000000000000000000000000a000000aa000000
# 205:0000000000000000000000000000000000000000000000000000000070000000
# 206:0000000000000000000000000000700000077a000000aaa000000aaa000000aa
# 207:00000000000000000000000000000000000000000000000000000000a0000000
# 208:000000aa0000aaa7000aaaa70000aa770000aa77000aa777000aa77700aaa77a
# 209:777777aa7777aa777aaa777a77a7777a7a77aaaa7a777a77a777a773a77aa733
# 210:aa77777777aa7a777777aa77a7777a77aa7a77a777aa77a7377a777a337aaa7a
# 211:aaa000007aa000007aa0000077aa000077aa0000777aa000777aa000aa7aaaa0
# 212:0000aaaa00000aa700000aa70000aa770000aa7700aaa77a0aaaa77700aaa777
# 213:777777aa77aaaa77777a777777a77a77aa777aaaaa777a77a77aa773a7aaa733
# 214:aaaa777777aa7777a777a7a7aa777aa7aa7777a777aaa7a7377a777a337a777a
# 215:aa0000007aa000007aaa000077aaa00077aa0000777aa000777aa000777aa000
# 216:000000aa00000aa700000aa7000aaa7700aaaa77000aa777000aa777000aa777
# 217:7777aaaa7777aa77777a77a7aaa777aa7a7777aa7a7aaa77a777a773a777a733
# 218:aa77a77777aaa7777777a77777a77a77aaa777aa77a777aa377aaa7a337aa77a
# 219:aa0000007aa000007aa0000077aa0000a7aaa000777aaaa0777aaa00777aa000
# 220:0000000700000000000000000000000000000000000000000000000000000000
# 221:7a000000aaa000000aaaa00000aaaa0000aaaa00000aa0000000000000000000
# 222:0000000a00000000000000000000000000000000000000000000000000000000
# 223:aa000000aaa000000aaa000000a7700000070000000000000000000000000000
# 224:0aaaa7aa000aa777000aa7770000aa770000aa7700000aa700000aa700000aaa
# 225:a7aaa733a777a7737a77aa777a77a7aa77a7777a77aa777777a7aa77777777aa
# 226:337aa77a377a777a77a777a7aaaa77a7a7777a77a777aaa777aa7777aa777777
# 227:a77aaa00777aa000777aa00077aa000077aa00007aaaa0007aaa0000aa000000
# 228:000aa777000aa777000aa7770000aa77000aaa770000aaa700000aa7000000aa
# 229:a777a733a777a7737a7aaa777a7777aa7aa777aa7a7a777a7777aa777777aaaa
# 230:337aaa7a377aa77a77a777aaaaa777aa77a77a777777a77777aaaa77aa777777
# 231:777aaa00777aaaa0a77aaa0077aa000077aa00007aa000007aa00000aaaa0000
# 232:000aa77700aaa7770aaaa777000aaa7a0000aa7700000aa700000aa7000000aa
# 233:a77aa733a7aaa773aa777a77aa777aaa77a77a77777a7777777aaa77777a77aa
# 234:337a777a377a777a77aaa7a7aa7777a7aa777aaa7a77a77777aa7777aaaa7777
# 235:777aa000777aa000777aa00077aaaa0077aaa0007aa000007aa00000aa000000
# 237:0000000000000000000000000000000000000000000000000000000010000000
# 238:0000000000000000000000000000100000011300000033300000033300000033
# 239:0000000000000000000000000000000000000000000000000000000030000000
# 240:00000a0a00000000000000000000000000000000000000000000000000000000
# 241:a777777aaaa777770aaaa7770aaaaaaa00a00aaa0000000a0000000000000000
# 242:a777777aa7777aaa777aaaaaaaaaa000aaa00000a0000000a000000000000000
# 243:a000000000000000a00000000000000000000000000000000000000000000000
# 244:0000000a0000000a0000000a0000000000000000000000000000000000000000
# 245:a7777a77aaa77777aaaaa777a00aaaaa00000aaa00000aaa000000a000000000
# 246:7777777a77777aaa777aaaa0aaaaaa00aaa0a000000000000000000000000000
# 247:aaa0000000000000000000000000000000000000000000000000000000000000
# 248:000000aa000000a0000000000000000000000000000000000000000000000000
# 249:a7777777aaa777770aaaa777000aaaaa000aaaaa0000a0000000000000000000
# 250:777a777a77777aaa777aaaa0aaaaa000aaaa00000aa0000000a0000000000000
# 251:a0000000aa000000000000000000000000000000000000000000000000000000
# 252:0000000100000000000000000000000000000000000000000000000000000000
# 253:1300000033300000033330000033330000333300000330000000000000000000
# 254:0000000300000000000000000000000000000000000000000000000000000000
# 255:3300000033300000033300000031100000010000000000000000000000000000
# </SPRITES>

# <MAP>
# 000:b2000000000000000000000000000000000000000000000000000000002600000000000000000000000000000000455151395151515151191960010102020202c4a3a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a3d40202020202010101010140195181815490000000000000000000000000000000000000000000000000000000000000000000002613023900000000000000000000020202029000000000000000000000020202020202610101010101010141010101410202020202020202020202021902024902020202020202346001000000000000000000000000000000000000000000000000000000000000
# 001:110000000000000000000000000000000000000000000000000000000013000000000000000000000000000000000000726381475159495139516001020202020202020203030303030303030303030303510202020202020202010140604044025138818154808090000000000000000000000000000000000000000000a332020212231332511222320259000000000000000000f0020219029100000000000000000000020202020202346001010101010141010140493979818179815363817903897981818181817981817929593450000000000000000000000000000000000000000000000000000000000000
# 002:12000000000000000000000000000000000000000000000000000000003100000000000000000000000000000000f0000071818179817947024929600202020202c3a32903030303030303030303790303a3a4a4a3d302020202505044344402020210211881818154900000000000000000000000000000000000000000a359023951123202490239590237900000000000000000f1020202025490000000000000000000634702020239496101010101014044405044293703037953829200638103890381537281815363818147394902000000000000000000000000000000000000000000000000000000000000
# 003:51000000000000000000000000000000000000000000000000000000003100000000000000000000000000000000f1007064810379798181510239190202020202a3d40203030303030303030303030303a4030303a30202020202020202020202021222232169692121216921216921321216000000000000000000a3a3d437030303038103030347020298910000000000000000f2023902020354900000000000000000710302020202396201010101014159442902797903798191000000006303897981818181819172818103790202000000000000000000000000000000000000000000000000000000000000
# 004:510000000000000000000000000000000000000000000000000000000032000000000000000000000000000000e2f2007181790303037981510202490202020202a3b30203790303a3a4a4a4a303030303f3030303b402020202020202020202020202021222232121222222222313323951111600000000000000003049190303030303030303030302518154900000002621696921020249020303540000000000007080647947024902610101010101014102590202790303815392000000007179898153920072635400638179810219000000000000000000000000000000000000000000000000000000000000
# 005:1900000000000000000000000000000000000000000000000000007080510000000000000000000000000000692131515159020203030381020202020202020202c4a30203030303025102020203030303f4030303b402020202020202020229020202020251122232590202491232020259122300000000000000001430020376960303030303810302397981548080641322232121020202378903796454900070647903030379020202346001010101404402023902810303795490000000706481895392000000726354727981790202d00000000000000000000000000000a4a3a4000000000000000000000000
# 006:52000000000000000000000000000000a0b00000000000000000706481510000000000000000000000000000132232c3b3d329510303030302020202020202020202d40203030303030303030303030303a4030303a30202d9020251020202020202020202020249020202020202020202024912000000000000000021310203789803a302380303810202038181818181a329111323020202038979030389020202020202020202020202023960010140295902020219817903037991000000648179039100000000007181910070810202d10000000000020202020202020202a3a3a3020202020202000000000000
# 007:01000000000000000000000000709000a1b10000000000000000718179300000000000000000000000000000455139a38696a3428103037902020202020202020202020203030303030303030303030303a3a4a4a3d4020202020202020202020202390202020202020202020202020202020251000000000000000013320203030303b4d3020303765102038192630303b45112321202b3c9038953637989a3a4a3024902020202020202490229505044493902020202190202020229020236817903039100004602020202198081810249d200000000003b4c03030a0303030a0303030a0303035c1b000000000000
# 008:010000000000000000000000e2715490a2b20000000000000000718181315400000000000000000000000000004702345697a30196030303510202020202020202020202030303030303a30303030303030202020202021902020202020202020202023781798181538282828282637981020249000000000000000032510203810303b4b3020381780202818154700303b41030021002c4a303899100638903a6b4d3020202020202290202020202390202020202390202025902020202020202a3a4a4a4a30202490202020281818139023236000000003b0a03030a0303030a0303030a0303030a1b000000000000
# 009:40000000000000000000002121692121692100000000000000706481813138900000000000000000000000000063022901010101849603812902020202c3a4d30202a302030303a30303020303a3030303020202c3d3020202020202020202020202027981817953920000000000726381020202000000000000000020300203037903b4d429030303020253638103a3a4a3123251120202b47989549072890379a3b3d302020202020202020202020202490202020202020202020202020202024902020202020202020202377979030202515100a0b0003b0a03030a030b030a0303030a030b030a3c000000000000
# 010:41000000000000000000002569212222231500000000000000718179813151910000000000000000000000000072023960010101848496865151020202b4c9b402020202030303020303020303b4030303020202c4d4020202020202390202020202020379818154900000000000007263020202000000000000000069143003030303a30202030303510254640303020249515949510202b40389035400890303b4a4a3d3020219020249020202020202022902490202378179038181815300000071890381819100007181810303030202395100a1b1001c0a03030a0303030a0303030a0303030a1b000000000000
# 011:4100000000000000000000007179818191000000000000000071818179311991000000000000000000000000000051d951600101848484844229510202c4a4d402020202030303020303020303b40303790202020202020202020202020202020202028103790381815490000000000071023902540400000000000069213103030303290202790303493781030303020202020239593902a30389817900897903a6b9b3a3020202020202020202021902020202020202817903038181819100000072890303815400007263810303030239511016a2b246020a03030a4a4a4a7afaeafa7a4a4a4a8a1b000000000000
# 012:1090000000000000000000706481818154900000000051106921211322325191000000000000000000000000000045514919605784848484014219590202020202020202030303020303020303a303030302c3a4a4d30202020202020202020202021923691302a381818181a3000000710202028105070000000000211337030303030202028181030303030381790202020202020202c3b4038903530089030303a3a4b4d302020202d92902d9020202020202020202810303818181530000007064890303038154006481790303030202331222231332020a03030a0303030afbebfb0a0303030a1b000000000000
# 013:11910000000000000000007181818179819100000000202421691332515130910000000000000000000000000000007263818178848484840101421902020202020202020303030203030203030203030302b4a3a3b402020202c3b4d36242430202025122020202a4a4a3a4399000007151020281060800c0d00000638898030303033049020376960303037976860251020202020202a3b403890391008903538263a8a3c90202020202020202020202020202020202790303798181549000706479890303037981548179030303030202344451290251026a03030a0303030a0303030a0303030a1b000000000000
# 014:115490000000000000007064817981818191000000702121132232515119145490000000007080000000000000000070647903768484848401010142020202c3a3a4a4a30303030203030203030203030302b4a3a3b402020202a4a3a4443442430202020202020202020259379100007102020281122116c1d10070648181030376811430023878988103797687870202020202293302b9a3798953926403038154706403030303030303767898899845c3d302195902a3a4a4a37981819100717903890379030379818179a3a4a4a30202515151515151020a03030a030b030a0303030a0303030a1b000000000000
# 015:118154900000002621132222222222232169212121692113325119435252217991000000007181549000000000007064810303788484846801010101020202a3030303a40303030203030203030203030302c4a4a4d402020202c4b4d4025134424302790303817981798181539200706402021081391222c2d27064817903038181281332020202020202495102390202020219336202a3b4539900007179030381648103037903030353640303897986c9b302020202020202020202020202593803030348020202020239020202020202334302515151020a032b0c2b2b2b0c0303030a0303030a1b000000000000
# 016:122222222222222222325151393951122222222222222232514352620101216921696921692121692121216913325149023951196001010101010101020202b4030303f3030303a30303a30303a3a4a4a4a302020202020202020202020202026141020381818181536381819100007181020211814759c921211332023902020212223249023343020202020202020202393352620102c4b4919900006403030303037953630303035370030303890379b4d45902020202020259020202020202020303790202025902020239020202020201422919513352523951511a2a2a2a2a3a5a0a0303030a1b000000000000
# 017:515151513951515139593951595129495135000000000000000000000000000000000000000000000000000000000000000000000000000000000000d30202b4030303f4030303030303030303030303030202020202020202020202190202336241028153920000006481815470806479025112213881537954020249360000000000000000000000000000000000004659023664810239a3549000700303537263790391720303799081030303890379b4020200000000000000000000000000000000000000000000000000000000000001014351516140445181530000000000005a0a0b0b0b0a3c000000000000
# 018:512929020251513951292951023939293990000000000000000000000000000000000000000000000000000000000000000000000000000000000000c90202a3030303a40303030303030379030303030302020202020202020202020202026140440281910000122369211332a38181a31902511251530003480219a4a3000000000000000000000000000000000000a3a4190238790219b4030354790379920072810354006303037903030303890303a3d30200000000000000000000000000000000000000000000000000000000000001014243513444513753000000000000005a0a0303030a1b000000000000
# 019:513951025151515149293929395151513792000000000000000000000000593600000000000000000000000000000000000000000000000000004659d40202c4a3a4a4a30303020202020202020202020202020202020202020202020202026141020281920000471222223259c4a4a4d402020249599100023343a3a4a3000000000000000000000000000000000000a3a4a34333020202b4038989898989890202020249390202030381030303890303b4b90200000000000000000000000000000000000000000000000000000000007001010144295151818191000000000000005a0a0303030a1b000000000000
# 020:0251515129515159195151510251023791000000000000000000000000005951000000000000000000000000000000000000000000000000000059590202020202020249030302c3a30202020202020202c3d3020202020202020233524333404402028100000063818181818181818181020202c3c99100330144c4a33500000000000000000000000000000000000045a3d44401330202a3030303030303030202020202020259960303030303890303b4d40200000000000000000000000000000000000000000000000000000046593901014051515151798192000000000000005a0a0303030a1b000000000000
# 021:5151514951023951195151493798815392000000000000000000000000000202000000000000000000000000000000000000000000000000004602510202020202020202030302a3020202025102020202a3d40202020202020233620101404402020281900000728282826379030379810239a3b3b8910062405937ca0000000000000000000000000000000000000000ca4749406202c3a3d503030303034659021902d9020202980381030303890303a34902d0000000000000000000000000000000000000000000000000f00049390250504439195151035300000000000000005b0a0303030a1b000000000000
# 022:39513933430251515137868898815392000000000000000000000000000029023600000000000000000000000000000000000000000000000002590202020202020202020303020203030303030303030302020202020229020262014040440202020281549000000000007263790303810202c4d853920044377981000000000000000000290259390000000000000000008179474443a3c9a3a4a3a3a4a4c93902020202020239987992630303890303b4d302d1040000000000000000000000000000000000000000000000f1700259295151515151515181549000000000000000000a0303030a1b000000000000
# 023:2959393444025137788898818181910000000000000000000000000000000259020400c0d0709000000000000000000000000000000000000059395902020202020202020303020203030303030303030302020202020202020201404443020202020281815400000064549071817903810202375300000029818153000000000000000000020202590000000000000000006303812941c4a3d402021902c4b30202020202025937037954708103897903b4a302f90e549000000000000000000000000000000000000000e200f2643059025102192951515179815400000000000000000a2b2b2b0a1b000000000000
# 024:5139515151029881817981817953920000000000000000000000000000000249590570e8f803910000000000e0000000000000000000000000514959020202020202020203035102030351020202020303020202020202020202014262424302290202024912222321a38181a38103038102518192000000020353920000000000000000003902020200000000000000000072637902410202593798030303030303038178889879030303796303890303a3a302211332020400000000000000000000000000000000002113222321311020512951025151510303530000000000000039493949515919393600000000
# 025:5102592951518179818181798191000000000000000000000000000000000202020671e9f979548090e20000e1000000000070809000000070020202020202020202020203030303030302a3a3d3510303020202020202020202010101014243020202020202391232c4a4a4d88103037902028190000000598191000000000000000000004962424900000000000000000000718159440249029879030303030303030303037903030303036403890303b4a3023239020205e00000000000000021a3320000000000003239591223142421390251514902517953920000000000000051515151510251511900000000
# 026:395102192951818181817981815493000000000000000000000000000000190210212121212121133212223212325902020229025490000071590259020259c3d302020203790303030302c4b3a3020303190202020202020202010101010142430249378181818181818181818103798102027954900000027991000000000000000000000260400200000000000000000000718102b4d302020303030303030303030303030303030303790303890303b4d3390202025906e100000000000070a3c9a30000000000000071473911132321511951515151518154900000000000000051025151515139515100000000
# 027:512951395102818181818151515191000000000000000000000000000000025912231332122222325939020239394902590202598154809064595139020202c4d40202022902020202020202c4a3020303020202020202020202010101010101424302818181797903030303030379817939107981548090020391000000000000000000002902593900000000000000000000717902a3a402020303030303037903030303030303037903030303890303a3b95202022939122313900000007064c8a3d85490000000007064811024311121515151515151518103540000000000706451495151512951513500000000
# 028:5151513959028179817981510249910000000000000000000000000000004951491232390259a3a4dcdaca03030379cadaa3a4a3798181798102513902020202020202020202023902020202020202030302020202020202020201010101010140440281818179030379037981818179815112323881815402799100000000000000708090a3b9b9a370809000000000000000710302b4d402020303038103030303030303030303030303030303890303b4d4015902495910243254900070648179989681815490007064817611133224135151515129395179e7f75400000000647951395151513352530000000000
# 029:5102295129518179817981a3395154930000000000000000000000000000020202cada0303030303cadaca03790303cadacacada790303dacaa3b45902020202020202020203030303030303030303030302020202490202020201010101014044025139020202020202020202020202490202020202493902023900000000000000718154a3b9b9a364819100000000000000390202020202029603030303030303030303030303030303030303030303b461010239102024320281548064038103030303817979818181037812d93912325139510251515103e8f87990000070810351025949516201540000000000
# 030:3343595159518181818179b4392978548093000000000000000000000000020202cada0303030303cadaca03030303cadacacada810379dacacba3d3a3d30202020202020203030303030303030303030302020202020202020201010101404402020249020202020202020259394902020202020202020249378154900000000000710381c8b3b3d881799100000000007064814759023902020202020202020202020202020202898989898981030303a334604910241332591079037981030303037903810303030303037959020219495139515139515138e9f90354900071794851395133620101795400000000
# 031:3444595151517981818179a35102794a4a4a4a4a8a5a0000000000000000025902cada8103030303caa3a4a4a4a4a4a4a3a4a4a3a4a4a4a4a3a3b4b402c4a30202020202020202020202020202020202020202020202020202020101010142430202020202020202590202020202025902020202020202022939a3819100000000007181798181790379819100000000007181a33929020202020259020202020202020202020202030303030303030303a3d334021223310210247903030303769603030303030303030379030259020202515102515139515112222121211332395949515162010101035300000000
# 032:4951025102298179818179a349510303030303030a5a0000000000000000495902cada030302020259020202590202c4b4b9b9b4d45902c4b3b9a3b30202020202020202020202020202020202020202020202020202020202020101010101424302020202020239020202020202020202020202390202020259c4799100a3a3a3007179815382826379819100a3a3a3007103d45902020202020202020202020202d902395902593881030303030303a5b3a34949491232491121030303030378980303030303030376960303d902290202014251515151515151021222133251515129516101010101530000000000
# 033:5159195139518179798181b459510303030303030a5a0000000000000000020202cada03030202023902025902020259c9a4a4c902020202c4a3b4b40202020202c3a3a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a3d30202020202010101010101410202390202020202020202290202020202020202020251490202815490a4b3a4006481039102027181035400a4b3a4706481020249020202020202020202020202020202020249c9a3a4a4a3a4a3a3b3a3d402490229020212210376967903030303030303790303789803030202020239010101424351395102495139515151515151336201010101000000000000
# 034:5159594951028181818181a35151030b0b0b03030a2c0000000000000000025159cada0303020202d902490251390202290259025902490202c4a3d40202020202020202020202020202020202020202029100000000000000000000000000000000000000000000000000000000000000000000000202020202020202020202920000000000000070640202020202020202020202020202020202020202020202020202020202020202020202020202020202020219020259022176879881030303030303030303030303030d4702020202000000000000000000000000000000000000000000000000000000000000
# 035:39595149512979818179815102490303030303030a5a0000000000000000024902cada030302020202020202020202020202020202020202020259390202290202020202020202020202020202020229025480900000000000000000000000000000000000000000000000000000000000000000000219020203030303020202000000000000708064790202020202020202020202020202395902020202020202020202020202020202020202020202020202020239590202392187879803030303038103baba03030303030e7902025902000000000000000000000000000000000000000000000000000000000000
# 036:3959595102298181817981025159fcfcfcfcfcfc0a5a0000000000000000020202cada03030303ca030303030303cacadacacadacacacadaca0202020202020202020202390202020202020202020202023879549000000000000000000000000000000000000000000000000000000000000000000202020203030303020229900000000070647903480202020202020202020202020202020202020202020229020202020202395902020202020202020202020202021030102187980303030303030303030303817686960f8139490202000000000000000000000000000000000000000000000000000000000000
# 037:5151490239a381818181795139510303030303030a5a0000000000000000a3d349cada03030303da0303030379030303dacacada030303daca02024902023902020202020202020239020202290202020202020202020200000000000000000000000000000000000000000000000000000000000002020239960303030202020202020202020202020202020202022902021902d9020202020202020202020259a3d30202020202020202020202022902020202025902122321218703037903037903030303030303778787212121303902000000000000000000000000000000000000000000000000000000000000
# 038:5102395119b481817981794929020303030303030a2c0000000000000000b4b4a3cada03030303da0303810303030303dacacada030303daca0202590202020202020229020202020202020259020202020202020202020000000000000000000000000000000000000000000000000000000000004502023797030303020202390202020202020202020202020202025902020202020202022902020202020202c4a302c3b4d3020202020249020249290202023902025912321298030379038103ba030303030303788487a32121310259000000000000000000000000000000000000000000000000000000708080
# 039:0249295102a38179818181590219030b0b0b03030a5a0000000000000000b9c9dccada03030303ca03030303030303cadacaa302030379daca02490202020202020202025902020219020202020202020219390202025300000000000000000000000000000000000000000000000000000000000000720263980303760202c3c9d302020229020202290202020202020202020202020202025929020202490202020202a4a3a402290202020202020202020202020202020202597903030303810303030303030303037887b4d312324902000000000000000000000000000000000000000000000000000070640379
# 040:0249595151a381798181815129510303030303030a5a0000000000000000b4b4a3a3a4a4a4a4a4a3a3a4a4a4a4a4a4a4a4a3d402030303daca0249d902020202020219020202020202a3a4a302020202a3a4a30202029100000000000000000000000000000000000000000000000000000000000000000071030303785902d402c4a3020202020202590202190202024902023902020202020202020202c3c9d3023902c4b4d402c9a30202020202020202020202294902023902030303030303030303030303030303b4b4b4a302020202000000000000000000000000000000000000000000000000007064193902
# 041:5149595159b48181817981514951024b4b4b4b4b4b5b0000000000000000a3d4390202c4a3d4020202020202d90249290202c3a3030303daca02024902020202020202020202020202b49803030303030378b4020202910000000000000000000000000000000000000000e5a3f5000000000000000000706403030303a3d4020202b4020202020202020202020202020202020202c3a3d30202b4020202a3a3a302020202020219a3d40202020202390202020202020202025902030303790303030303030379030303a3c4a3b3a3290202000000000000000000000000000000000000000000000070806481510259
# 042:3951293929a381817981814751513792000000000000000000000000000002490202025902c3b9d3020251020202d90202c3b9a3030303daca02020202020202020202020202020202b47903030303030303b4023902920000000000000000000000000000000000000000e5a3f5000000000000000070640303030303b402357179a3980303470202020202020239020202022959a3a4a30202a3020202c402d80303789803da4702020202020202020229020230591020300239290303030303030303038103030303020202a3b302020280900000000000a3a30000000000a3a3a30000000000a3a3790381020249
# 043:51510249295181798181817988539200000000000000000000000000000002290259025902a3c9a3020251020202025902a3a3b8030303daca02025102492902020202020202290202b40303030379030303b4492902000000000000000000a3a300000000000000000000007100000000000000000071030303030303a353706403da0303030303780202020202020202020202370303980303cacaaaaacaca030303030303ca037847020202020202020202023202122332295910030d030379030303030303030303020239020202494922325100000000a6b60000000000a6a3b60000000000a6b8810379495951
# 044:513951025951817981798181795490000000000000000000000000000000025102cada030303ca03030303030303cacadacacada030381daca02025902020202020202021902020202a30303030303030303a3020202900000000000000000a3a300000000000000000000007190000000000000007064030379030303da54640303da03030303030347020202020249020249020303030303030303030303da03030303030379030376960347020202490202023902491232594924030e7976869603790303030303034902020259020202595149900000000000000000000000000000000000007003810381815102
# 045:512951025151818179818181798191000000000000000000000000000000490202cada030303da030303030303030303dacacada030303daca0259020202023703030378889847020202030303030303030302024919020000000000000000539200000000000000000000007191000000000000a3a3a3030303030303da03790303ca79030303030303035902020202020202370303030379030303030303da037903030303030303789803caa3022902020202024902020202102123212121c92121a4a4c9030379030239020202334302020251910000000000000000000000000000000070806403818181030202
# 046:515151495151968181817979818191000000000000000000000000000000020202cada030303da030303030303030303dacacada030303daca0202c302023903030303030303030303030303a3a3a3a303034702020202000000000000000091000000000000000000000070649100000000007002b4b4030303030303ca03030303da0303030303030303789847020237030303030303030303030303030303030303030303030303030303cab4024902020202020219020202111703030303030303030303030303030202020233624243025102549000000000000000000000000000000064798179817981815102
# 047:512959293949968181817979817954900000000000000000000000000000020202cada030303da030303030303030303dacacada030303dacaa3b4c902020203030303030303030303030303a4d4c4a403037698799100000000000000000091000000000000000000000071819100000070806449c4a3030303030303da03030303da03030303030303030303030303030303030303030303030303030303030303030303030303030303a3a3b4d3020202395902020202490212030303810303030303030303030303022959496101014159025979548080900000a3a300000000000070a3a3817981818103814902
# 048:514951293951868696818179818181549000000000000000000000000000025939290202a3a3ca03810303030303cacadacacadacacacadacacba3b402020202380303030303790303030376a30202a3030303030391000000000000000070549000000000000000000070647954900002020202020202030303790303da03030303a303030303030303030303790303030303030303030303030303030303790303030303030303037903cadac8a3020202020202020202020202030303030303030303030303810303390202396101014129025179810381548080a3b600000000708064a8a3818103810381813959
# 049:595151195159515149023879818181819100000000000000000000000000025902020202a3a4a3a4a3a4a4a4a4a4a4a3a3a4a4a4a4a4a3a4a3a3b4a302020249597903030303030303030377a32959029603030379548090000000a3a4a379795490a3a4a300000000706479a3039170020202295902020303030303a3a4a3a4a4a3a3960303030303030303030303030303a3a4dc03030303aacadc03030303030303dc0303cacacaaacacadacaa35902020202025902290239020303030303030379030303030303030202393362010142020251818181798181818154808080806481810303038181798179810202
# 050:515102336243295139295151388181819100000000000000000000000000020202510202c4c9d40202020259023902020202020202513929020249c40202020202020202020202020202020219020249390202020202020202024929c4d40202020202c4d4020239020202c3b4d30202020202020202020202020202a4b3a4d4c4a4a40202020202020202020202020202490202c4a3a4a339a3a4a3a30202020202c3b40249a3a3a3a4a3a4a3a4a30202022959020202020202020202023902490202020219020239020249330101010101515102037981037903030379038181038179817981798103818181035102
# 051:40440202c4a3cca3a4a3a4a4c929025902d9020202020202023443334402020202190202020202390202020202290202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020202020202020202020200000000000000000202020202020202020202020202020202020200000000000000000000000000000202020202590202020202020202020202020202020202020200000000000000000000000000000002020202020202020202020202020202020202020202020202020202020202020202020202020202
# 052:4102020202b4cacacaca0303030379030303030303030303020234443902030303030303030303030303030303030303030303030347020251020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020229020202590202020200000000000000004502020202020202020202020202020202020200000000000000000000000000000202020202020202020202024902020202020202020251020200000000000000000000000000000045020202020202020202020202020202020202020202020202020202020202020202020202020202
# 053:4402025102a3bacaca03030303030303030303030303030347022902023703030303030303030303030303ca03790303ca030303daca0239d9020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000046020202020202020202020200000000000000000002490202020202020202020202290202020200000000000000000000000000000045020239020202020202020202020202020202020202023500000000000000000000000000000000000000000045020202590202020202020202020202020202020202590202025102020202020202
# 054:1902020219b4caca81030303030303030303030303030303033902020203030303030381030303a3a4a3a4a3a4a4a4a4a3a4a4a4a389b4d302020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002020202020202020202020202020000000000000045020202025902020202020202020202023790000000000000000000000000000000020202020202023902020202020202020202020202910000000070808080900000000000000000000000007090020202020202020202020202020202490202020202020202020202023703470202
# 055:0202020202b4ca0303030303a3a3a3030303810303030303034702193703030303030303030303a3b3a3cacacacacacacacacacacabaa3b9d3022902000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002020259490202020202020202350000000000000046c3a302a3d302020202020202020202817954809000000000000000000000000002490202023747020202020202020202025902377953920000007064480202020202020202025100000000706454020202020202023902020202020202020202020202020202020202030303030302
# 056:0202590202c9030303030303c6b4b3030303030303030303030389890303030303030303030303c9c4b4bacacacacacacacacacacacacba3b9020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000202020202020202020202390200000000000000020202a3a3a3a3a30202020202020202023572820202390202000000000000000000000000728263814802020202c3a3d30202020202828292000000460202020202020202020202020200000000717981020202020202020202020202020202020202020202020202020202037903030302
# 057:025102020202030303030303039aa3030303030303030303030389890303030303030303030303b4590289a3a4a4a4a4a3a4a4a4a4a4a3b9d439020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000451902022902c3a3d3020202020000000000000045290253a3b4a353828263020202375392000000450202375300000000000000000000000000000045510202c3a3a3a3a3a3d3020235000000460202020202025902020249020202020200000000726302020202020202020202020237030303030303034702020202020202030303030302
# 058:020202190202030303030303c5b4a3030303030379030303030389890303030303037903030303a319b4bacacacacacacacacacacabab4d40259020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000450202a3b4a302020200000000000000000000000000000000000000450202829200000000000000000000000000000000000000000000000000007263a3a3a4a4a4a3a3829200000000020202c3a3a3a3a3d3020202020202393500000000007239020202020202025902027903030303030303030302020202020202030303038151
# 059:020202020202030303030303a3b4b3030303030303030303030389890381030303030303030303a302a3a3a3a3a3a3a3a3a3a3a3b389b4d30202025100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000072828292450292000000000000000000000000000000000000000039350000000000000000000000000000000000000000000000000000000000729200a3a3a30000000000000000020251a3a4a4a4a4a30237917282920000000000000000450202020251020202023703d3020202020202c30302c3a3a3a3a337030303390202
# 060:020202020202030303038103a3b9a3030303030303030303030389890303030303030303030303b429b4cacacacacacacacacacacabaa3b9020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000728263a30282920000000000000000000000007263790202023703030303a3a3a3a3a3a3a3a30347a3a4a4a40303030303020202
# 061:020202d90202030303030303c6b4a3030303030303030303030389890303030303030303030303a3d9b4bacacacacacacacacacacacacba302290202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007282990000000000000000000000000000007263798903030303030303030303030303030303a3a303030381030303030202
# 062:020259020202038103030303039ab3030303030303030303030389890303030303030303030303a3020289a3a4a4a4a4a3a4a4a4a4a4a3b939590202900000000000000000000000000000000000000000000000000000000000000000000000000000708090000000000000000000000000000000000000000000000000000000000000000000000000990000000000000000000000000000000000000000000000000000000000000000000000708090000000000000000000000000000000990000708090000000000000000000000071038903030303030303037903030303030303030303030303030303030202
# 063:02025102020203030379cacac5b4a3ca03030303caca030303cacacaca03030303caca810303cab402b4bacacacacacacacacacacabab40202021902549000000000000000000000000000000000000000007080900000000000000000000000000070648191000000000000000000000000000000000000000000000000000000000000000000000000990000007080900000000000000000000000000000000000000000000000000000007080647991000000000000000000000000000000990070647991000000000000000000000071038903030303030303030303030303030303030303030303030303030202
# 064:524302020202030303cabacaa3a3a3cacacacacabacacacacacacabacacacacacacacacacacadab459a3a3a3a3a3a3a3a3a3a3a3b389a3b9d3514939865480809000000000007090708090000000000000706479910000000000000000000000000071815392000000000000000000000000708080900000000000000000708080900000000000000000990000706479910000007080900070808090000000000000007090000000000000706481795392000000000000007080900000000000997064817954900070808090000000007064038903037903030303030303030303790303030379030303030303030202
# 065:0142020202020303cacacacaa302a3caaacacacaaacacacaaacacacacaaacacacaaacacacaaacaa302b4cacacacacacacacacacacabacba3b9020202878696815480900000706454647954900000000070647981549000000000000000000000007064815480808090000000008090007080647979549000000000708080648181549000000000000000000070648179548090706479548064798154809000000070806454900000007080647903815480900000000070806479549070809000007181817979548064797954900070806403030303030303030303038103030303030303030303030303030381030202
# 066:01014259020202a3a4a4a4a3d402c4a3a4a4a4a3a3a3a4a4a4a3a3a3a3a4a4a4a3a3a3a4a4a4a3d402c9a3a4a4a4a4a4a4a4a4a4a4a4a3b9d42902020140504449390202020202023902a3a3a3a3020259020202a3a3a3a3020202020202a3a3a3a30202020202020259a3a4a4a302020202020202a3a4a4a4a30202020202a3a4a4a4a4a3a4a4a4a4a30202020202020202025902020202a3a4a4a30202020202020202a3a4a3020202a3a4a4a4a4a302020202a3a4a302020202a3a4a4a4a4a4a4a351020202020202020202020202a3a4a4a4a4a4a3020202a3a3a3a3a3a3a3a30202a3a4a4a4a302020202590202
# 067:506001424302020251020259020202a3590202a3b9c9020202c4c9a3d4025902a3b9a3020202a33902020202020229d90202020202020202020202025044294902024902020259020202a3a4a4a3020202020202a3a4a4a3020202390202a3a4a4a30202020202020202a3a3a3a30202022902020202a3a3a3020202020202a3a3a3a3a3a3a3a3a3a3a30202020202020202020202490202c4a3a3d40202022902020202a3a3a3020202a3a3a3a3a3a302020202a3a3a302023902c4a3a3a3a3a3a3d402020202020202020202020202a3a3a3a3a3a3a3020202c4a3a4a4a4a4a3d40202a3a3a3a3a302020202025102
# 068:a2b20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000455151395151515151191960010102020202c4a3a4a4a4a4a4a4a4a4a4a4a3a4a4a4a4a4a4a3d4020202020201010101014019020202020202020202020202020202020202020202020200000000000000000000000000000000261302390000000000000000000002020202900000000000000000000000020202020261010101010101014101014102020202020202020202020202190202490202020202395934600100003b030000000000000000000000000000000000000000000000000000
# 069:211600000000000000000000000000000000000000000000000000002621000000000000000000000000000000000000726381475159a3a3d351600102020202020202020303030303030303a303030303510202020202020202010140604044020202020202020202020202020202020210300202020202000000000000a3320202a3a4a4a4a31222320259000000000000000000f002021902910000000000000000000000020202020234600101010101014101404939798181817981538981790303798981818181798181790259345000003b030000000000000000000000000000000000000000000000000000
# 070:22230000000000000000000000000000000000000000000000000000133200000000000000000000000000000000f000007181817981a8c9a34929600202020202c3a3290303030303030303a303790303a3a4a4a3d302020202505044344402021020203010301030020202021030103012320202020202000000000000a359023951123202490239590237900000000000000000f102020202549000000000000000000000634702023949610101010101404450442937030303795382929963810379038953728181536381814749020200003b030000000000000000000000000000000000000000000000000000
# 071:49120000000000000000000000000000000000000000000000000000315900000000000000000000000000000000f10070648103797981a8a30239190202020202a3d4020303030303030303a40303030303030303a302d9020202020202020202111323311114243102020202111424311030020202020200000000a3a3d437030353638103549045020298910000000000000000f202390202035490000000000000000000710302020239620101010101415929027979037979819100009900630303798981818181917281817979390200003b030000000000000000000000000000000000000000000000000000
# 072:395100000000000000000000000000000000000000000000000000003239000000000000000000000000000000e2f2007181790303037981510202490202020202a3b30203790303a3a4a4a4a30303030379030303b40202020202020202020202111424311113233102020202111323311131020202020200000000304919030303546403030354800251815490000000262169692102024902030354000000000000708080647947490261010101010101410202027903038181539200009900717903818992007263540063817981021900003b030000000000000000000000000000000000000000000000000000
# 073:49190000000000000000000000000000000000000000000000007080513900000000000000000000000000006921315151a3a3b503030381020202020202020202c4a3020303030303030303030303030303030303b40202020202020202022902122222321232123210300202123212321232020202020200000000143002037696030303030381030202798154808064a32223212102020237030379645490007064797903030379020234600101010140440239028103037953920000009970648103539900000072635472798179020200003b030000000000000000000000000000000000000000000000000000
# 074:6242000000000000000000000000000000000000000000000070648151390000000000000000000000000000132232c3b3d3c4a30303030302020202020202020202d4020303030303030303030303030303030303a3020249020251020202020202020202020202022432020202020202020202020202020000000021310203789803a3a3a35363810202039263818181b429111323020202030379030303a39aa30202a3a4a302020202023960010140295902021981790303540000000000648179039100000000007181910070810202000000030000000000000000000000000000000000000000000000000000
# 075:6040000000000000000000000000000000000000000000000071817930290000000000000000000000000000a6a3a3a38696a3a381030379a3d30202020202020202020203030303030303030303030303a3a4a4a3d4020202020202020202020202390202020202020202020202020202020202020202020000000013320203030303b4a3b45400635102035470035363b45112321202b3c9030353637903a3a4a30202c4a3d4020202024902295050444939020202190238030391000070648179030354900000007046021980818102490000000300000000000000a4a3a400000000000000000000000000000000
# 076:395900000000000000000000007090000000000000000000007181811430000000000000000000000000000000a6c9345697a30196030303a3a302020202020202020202030303030303a30303030303030202020202021902020202020202020202023792798181538282828282637981020249020202020000000032510203810303b4b3b403546402a381810353a3a4a31030021002c4a303039100638903a6b4d302020202020229020202020239020202023902020259a3a4a4a4a4a4a4a3a4a4a4a3a4a4a4a4a302020281818139020000020202020202020202a3a3a302020202a3c9a3a3a3a3a30000000000
# 077:59290000000000000000000000715490000000000000000070648181213100000000000000000000000000000063a3290101404484960381a3a30202023902020202a3020303a3a3e4e4a30303a3a30303020202c3d3020202020202020202020202029264817953920000000000726381020202020202020000000020300203037903b4a3b403030302b453638154020249123251120202b47903549072890379a3b3d3020202020202020202020202024902020202020202c4a3a3a3a3a3a3a3a3b3a3a3a3a3a3a3d4020237797903020200003b4c0303030a03030a0303030a035c02a3a4a4a4a4a4a30000000000
# 078:4149000000000000000000a3a3a4a4a4a3a30000000000007181798113320004000000000000000000000000007202396040c3a384849686a3d4020202025902020202a30303c4a30303c4030302a40303020202c4d4020202020202390202020202026479818154900000000000007263020202020202020000000069143003030303a3a4a303030351a354640303020249515949510202b40303035400630303b4a4a3d302021902024902020202020202290202023781790389cacacacacacaa3faa3cacacacacaca898181030303020200003b0a0303030a03030a0303030a030a5b030300030003000000000000
# 079:443900000000000000000000b4b3a3b3b400000000000000718181793129e005000000000000000000000000000051d951c3b3a3848484844229510202020202020202a3e4e402020303f4e4e4b4a403030202020202020202020202020202020202028103790381815490000000000071023902020202020000000069213103030303290202790303493781030303020202020239593902a30303817900727903a6b9b3a302020202020202020202190202020202028179030389ca8181910000a6fbb80303815400ca9963810303030239b0003b0a0303030a030b0a0303030a0b0a03030300030003000000000000
# 080:391090000000000000000070648181815490000000005110692121133249e1060000000000000000000000000000455149a3a3b684848484014219d902020202020202020303f4f403030303030303037902020202020202020202020202020202021923691302a3a3a3a3a3a3000000710202020202020200000000211337030303030202028181030303030381790202020202020202c3b4030303530070030303a3a4b4d302020202d92902d902020202020202028103030389ca815300000070ca038263038154ca8981790303030202b1001c0a0303030a03030a0303030a030a03030300030003000000000000
# 081:1024910000000000000000718181817981910000000020242169133251512131360000f000000000000000000000007263818178848484840101421902020202020202020303030303030303030303030302c3a4a4d302020202c3b4d36242430202025122020202a4a4a3a439900000715102020202020200c0d000638898030303033049020376960303037976860251020202020202a3b403890391706403538263a8a3c9020202020202020202020202020202027903037989ca815490007064ca030072637981ca8979030303030202b246020a0303037a4a4a7afaeafa7a4a8a5a030300030003000000000000
# 082:1223548090000000000070648179818181910000007021211322325151191332022936f10070800000000000000000706479037684849888a3010142020202020202020203030303030303030303030303a3b4a3a3b402020202a4a3a444344243020202020202020202025937910000710202020212210200c1d170648181030376811430023878988103797687870202020202293302b9a3798953926403038154706403030303030303767898039845c3d30259a3a4a3030389ca81819100717989030000726379ca897903a3a4a4a3021332020a0303030a03030afbebfb0a030a5ba3a4a4a4a4a4a30000000000
# 083:2911818154900026211322222222222321692121216921133251194352523202393902f200718154900000000000706481030378848497c5d40101d90202020202020202030303030303a3f4f4c4a30303b4b4a3a3b402020202c4b4d402513442430279030381798179818153920070640202100239122216c2d26481790303818128133202020202a3a4a4a302390202020219336202a3b4539900007179030381648103037903030353640303037986c9b302020202c4a3a4a3ca79815400718179030000007103caa3a4a3d4020202020251026a0303030a03030a0303030a030a0303030303035c5a0000000000
# 084:59122222222222222232515139a3d3122232c3a3d31222325143526201013929515910246921216921212169133251a3a3b3a3196001a3d4b301010102020202020202020303b4b4e4e402030302a30303a3c4a4a4d4020202020202020202026141020381818153638181819100007181020211020259c921211332023902020212223249023343020202020202020202393352620102c4b4910000006403030303037953630303035370030303030379b4d4590202020202c4b4caaaaaaaaaaacabacaaaaaaaaaaacab4d43902020202025151020a0303030a030b0a0303030a030a0303030303030a5a0000000000
# 085:515151513951515139593951595129495135000000000000000000000000000000000000000000000000000000000000000000000000000000000000d302020202020202030302020303a3030302a3a4a3d40202020202020202020219020233624102815392000064818181540070647902511221020202795446a4a30000000000000000000000000000000000000000a3a43664810239a3549000700303537263790391720303799081030303030379b402020000000000000000000000000000000000000000000000000000000000005151020a0303030a03030a0303030a030a0303030303030a5a0000000000
# 086:512929020251513951292951023939293990000000000000000000000000000000000000000000000000000000000000000000000000000000000000c90202c3a3a4a4a30303a3a30303b4e4e4a303030302020202020202020202020202026140440281910000122369211332a3a3a3a3190251125102020348021949360000000000000000000000000000000000004659190238790219b4790354790379920072810354006303037903030303030303a3d30200000000000000000000000000000000000000000000000000000000000051335252a3a4a4e4e4e4e42a3a024b4b4b5be4e4e4e4030a5a0000000000
# 087:513951025151515149293929395151513792000000000000000000000000a336000000000000000000000000000000000000000000000000000046a3d40202a3030303030303b4b4f3f3a3b4b4a3f3f3f302020202020202020202020202026141020281920000471222223259c4a4a4d4020202495902020233430202020000000000000000000000000000000000000202024333020202b4030303030379540202020249390202030381030303030303b4b902000000000000000000000000000000000000000000000000000000000070516140445181530000000000003b0a030a0303030303030a5a0000000000
# 088:025151512951515919515151025102379100000000000000000000000000a351000000000000000000000000000000000000000000000000000059a3020202b403030303030339c3a3d302020202020202c3d3020202020202020233524333404402028100000063818181818181815472020202c3c9020233014402023900000000000000c5b3b3d5000000000000003902024401330202a3037903030303030202020202020259960303030303030303b4d402000000000000000000000000000000000000000000000000000000465939513444513753000000000000003b0a0b0a030b0b0b0b030a5a0000000000
# 089:515151495102395119515149379881539200000000000000000000000000a302000000000000000000000000000000000000000000000000004602a3020202b403030303030302a3a4a4a4a4a4a4a4a4a4a3d40202020202020233620101404402020281900000728282826379030379540239a3b302020262405949023500000000000000a3b9b9a30000000000000045024949406202c3a3d503030381034659021902d9020202980381030303030303a34902d0000000000000000000000000000000000000000000000000f00049390219515103530000000000000000000a030a0303030303030a5a0000000000
# 090:395139334302515151378688988153920000000000000000000000000000a302360000a0b000000000000000000000000000000000000000000259a3020202a3030303030303020203030303030303030302020202020229020262014040440202020281549000000000007263790303810202c40202020244377981920000000000000000a3b9b9a30000000000000000728179474443a3c9a3a4a3a3a4a4c93902020202020239987992630303030303b4d302d1040000000000000000000000000000000000000000000000f17002592951515181549000000000000000000a030a03036d2a2a2a2a2c0000000000
# 091:295939344402513778889881818191000000000000000000000000000000a359020400a5f4f4f4b500a5a4a4b500a5a4a4a3000000000000005939a3020202c4a3a4a4a30303020203030303030303030302020202020202020201404443020202020281815400000000000071817903810202020202020229818153000000000000000000008181000000000000000000006303812941c4a3d402021902c4b30202020202025937037954708103037903b4a302f90e5490000000000000000000000000000000000000000000f26430590251515179815400000000000000000a030a03031b00000000000000000000
# 092:513951515102988181798181795392000000000000000000000000000000a349590570a30b0b0ba8a4a30b0ba3a4a30b0ba3000000000000005149a30202020202024929030351020303a3a4a4a4a30303020202020202020202014262424302290202024912222321a35490a381030381025102020202020203539200000000a3000000000081810000000000a30000000072637902410202593798030303030303038178889879030303796303030303a3a30221133202040000000000000000000000000000000000a3a4a4a4a331102051515103035300000000000000000a2b0c2b031b00000000000000000000
# 093:510259295151817981818179819100000000000000000000000000000000a302020671dc030303030303030303030303030303a390000000700202a30202020202020202030303030303b4d603c6b40303020202020202020202010101014243020202020202391232c4a4a4d681030379020202020202025981910000000000a3000000000081810000000000a30000000000718159440249029879030303030303030303037903030303036403890303b4a3023239020205e000000000000000a3c9a3000000000000a3e4a3a4a3142421490251795392000000000000003949394951591951191a00000000000000
# 094:395102192951818181815363819200000000000000000000000000000000a302102121a3a3a4a4a4a4a3a4a4a3a4a3a4a4a3a4a354900000715902a3020259c3d3020202037903030303b4030303b403031902020202020202020101010101424302493781818181549000007081037981020202020202020279910000000000b3000000000081810000000000b30000000000717902020202020303030303030303030303030303030303790303890303b4d3390202025906e100000000000070a3a3a30000000000000070a8a311132321515151815490000000000000005151515151025151510000007d7d000000
# 095:5129513951028181818191a5a3b590000000000000000000000000000000a359122313321222223259390202393949025902025981548090645951a3020202c4d40202a3a3a4a4a30303a3790303a303030202020202020202020101010101014243028181817979039100706403798179391002020202020279549000000000a300000000a39a9aa300000000a3000000007064030202d902020303030303037903030303030303037903030303030303a3b9520202293912a3a4cc0000007064c8a3d85490000000007064811024311121515151810354000000000000005102515151513951350000462939360000
# 096:5151513959028179817954a3b4a39100000000000002024b4b4b5a000000a351491232390259a3a4dcdaca03030379cadaa3a4a3798181798102c3a302020202020202c4a30303030303030303030303030202020202020202020101010101014044028181817903035490718181817981511202020202024939299100000000a300708080a39a9aa380809000a30000000071293949020202020303038103030303030303030303030303030303030303b4d4015902495939c4a35490007064817998968181549000706481761113322413293951790379540000000070645139515151335254900000395919490000
# 097:5102295129518179817981a3a3d454930000000000025a030b035a000000a30202cada0303030303cadaca03790303cadacacada790303dacaa3b4a3020202020202020202037903030303030303030303020202024902020202010101010140440251390202020202020202020202024902020202024939d9493991000000000000718103c8b3b3d8818191000000000000713949d9020202029603030303030303030303030303030303030303030303b461010239102030590281548064038103795363817979818181037812d9391232515151030303799000000064795102594951620179910000450202350000
# 098:3343595159518181818179b4d42978548093000000025a0303035a000000a30202cada0303030303cadaca03030303cadacacada810379dacacba3a3a3d3020202020202020303030303030303030303030202020202020202020101010140440202024902020202020202025939490202020202020202020202a3549000000000007181815382826303819100000000007064a3020202390202020202020202a3a4a4a302020202030303030381030303a33460491024133259107903798103030303546453630303030303795902021949395151387903035490007081485139513362010181910000700202000000
# 099:3444595151517981818179a3510279e4e4e4e44a8a025a03022a2c000000a35902cada8103030303caa3a4a4a4a4a4a4a3a4a4a3a4a4a4a4a3a3b4b402c4a30202020202020303030303030303810303030202020202020202020101010142430202020202020202590202020202025902020202020202020239c4819170a3a3a3007103819100007181799100a3a3a3907181d4390202020202025902020202c4a3b3d402020202030303030303030303a3d334021223310210247903030353639603035300726303030379030259020202513951511222212121133239594951516201010153920000715902000000
# 100:49510251c3a38179818179a349510303030303030a025a00020000000000a35902cada030302020259020202590202c4b4b9b9b4d45902c4b3b9a3b30202020202c3a3a4a3a3a303030303030303030303a3a4a3d30202020202010101010142430202020202023902020202020202020202020239020202025902799171a4b3a4007181795480806479819100a4b3a4917103025902020202020202020202020202c902395902593881030303030303a5b3a34949491232491121030303795464980303910070908263960303d902290202515151515102122213325151512951610101010154809000710239900000
# 101:51591951a3b48179798181b459510303030303030a025a03a30000000000a30202cada03030202023902025902020259c9a4a4c902020202c4a3b4b40202020202a3030303030303037903030303030303030303a3020202020201010101010141020239020202020202020229020202020202020202025149020281546402020270648103a7a3a3b781035490020202546481020249020202020202020202020202020202020249c9a3a4a4a3a4a3a3b3a3d402490229020212210376967903030303035480640354649803030202020239435139510249513951515151515133620101010103795480640202910000
# 102:51595949a3b48181818181a35151030b0b0b03030a025b03a40000000000a35159cada0303020202d902490251390202290259025902490202c4a3a30202020202020202020202020202020202020202029100000000000000000000000000000000000000000000000000000000000000000000000202020202020202020202920000000000000070640202020202020202020202020202020202020202020202020202020202020202020202020202020202020219020259022176879881030303030303030303030303030d4702020202000000000000000000000000000000000000000000000000000000000000
# 103:39595149c4a379818179815102490303030303030a5a0303a40000000000a34902cada030302020202020202020202020202020202020202020259a30202290202020202020202020202020202020229025480900000000000000000000000000000000000000000000000000000000000000000000219020203030303020202000000000000708064790202020202020202020202020202395902020202020202020202020202020202020202020202020202020239590202392187879803030303038103baba03030303030e7902025902000000000000000000000000000000000000000000000000000000000000
# 104:3959595102298181817981025159e4e4e4e4e4e40a5a2b03a40000000000a30202cada03030303ca030303030303cacadacacadacacacadaca0202a30202020202020202390202020202020202020202023879549000000000000000000000000000000000000000000000000000000000000000000202020203030303020229900000000070647903480202020202020202020202020202020202020202020229020202020202395902020202020202020202020202021030102187980303536303030303030303817686960f4639d90202000000000000000000000000000000000000000000000000000000000000
# 105:5151490239a38181818179a3d3510303030303030a025a03a40000000000a3d349cada03030303da0303030379030303dacacada030303daca0202a302023902020202020202020239020202290202020202020202023600000000000000000000000000000000000000000000000000000000000002020239960303030202020202020202020202020202020202022902021902d9020202020202020202020259a3d30202020202020202020202022902020202025902122321218703035370647903030303030303778787212121303902000000000000000000000000000000000000000000000000000000000000
# 106:5102395119b48181798179b4a30203032b2b2b2b0c025a03a30000000000b4b4a3cada03030303da0303810303030303dacacada030303daca0202a30202020202020229020202020202020259020202020202020202020000000000000000000000000000000000000000000000000000000000004502023797030303020202390202020202020202020202020202025902020202020202022902020202020202c4a302c3b4d3020202020249020249290202023902025912321298030391718103ba030303630303788487a32121310259000000000000000000000000000000000000000000000000000000708080
# 107:0249295102a38179818181b4a319034b4b4b4b4b4b4b5b035a0000000000b9c9dccada03030303ca03030303030303cadacaa302030379daca0249a302020202020202025902020219020202020202020219390202023700000000000000000000000000000000000000000000000000000000000000728263980303760202c3c9d302020229020202290202020202020202020202020202025929020202490202020202a4a3a402290202020202020202020202020202020202597903539271810303030379906303037887b4d312324902000000000000000000000000000000000000000000000000000070648179
# 108:0249595151a38179818181a3d451032b2b2b2b2b0c2b2b035a0000000000b4b4a3a3a4a4a4a4a4a3a3a4a4a4a4a4a4a4a4a3d402030303daca0249c902020202020219020202020202c3a3020202020202a3d30202025300000000000000000000000000000000000000000000000000000000000000000071030303785902d402c4a3020202020202590202190202024902023902020202020202020202c3c9d3023902c4b4d402c9a30202020202020202020202294902023902030354806403030303030354640303b4b4b4a302020202000000000000000000000000000000000000000000000000007064193902
# 109:5149595159b48181817981514951024b1a2a2a2a2a2a2a2a2c0000000000a3d4390202c4a3d4020202020202d90249290202c3a3030303daca0202a302020202020202020202020202b49803030303030378b4020202910000000000000000000000000000000000000000e5a3f5000000000000000000706403030303a3d4020202b4020202020202020202020202020202020202c3a3d30202b4020202a3a3a302020202020219a3d40202020202390202020202020202025902030303790303030303030379030303a3c4a3b3a3290202000000000000000000000000000000000000000000000070806481510259
# 110:3951293929a3818179818147515137920000000000000000000000000000a3490202025902c3b9d3020251020202d90202c3b9a3030303daca0202a302020202020202020202020202b47903030303030303b4023902920000000000000000000000000000000000000000e5a3f5000000000000000070640303030303b402357179a3980303470202020202020239020202022959a3a4a30202a3020202c402d80303789803da4702020202020202020229020230591020300239290303030303030303038103030303020202a3b302020280900000000000e5a3000000000000c9000000000000a3f6790381020249
# 111:515102492951817981818179885392000000000000000000000000000000a3290259025902a3c9a3020251020202025902a3a3b8030303daca0202a302492902020202020202290202b40303030379030303b4492902000000000000000000a3a300000000000000000000007100000000000000000071030303030303a353706403da0303030303780202020202020202020202370303980303cacaaaaacaca030303030303ca037847020202020202020202023202122332295910030d030379030303030303030303020239020202494922325100000000e5a300000000000000000000000000a3f6810379475951
# 112:513951025951817981798181795490000000000000000000000000000000a35102cada030303ca03030303030303cacadacacada030381daca0202a302020202020202021902020202a30303030303030303a3020202900000000000000000a3a300000000000000000000007190000000000000007064030379030303da54640303da03030303030347020202020249020249020303030303030303030303da03030303030379030376960347020202490202023902491232594924030e7976869603790303536303034902020259020202595149900000000000000000000000000000000000007003810381815102
# 113:512951025151818179818181798191000000000000000000000000000000a30202cada030303da030303030303030303dacacada030303daca0259a30202020303030378889847020202030303030303030302024919020000000000000000539200000000000000000000007191000000000000a3a3a3030303030303da03790303ca79030303030303035902020202020202370303030379030303030303da037903030303030303789803caa3022902020202024902020202102123212121c92121a4a4c9806479030239020202334302020251910000000000000000000000000000000070806403818181030202
# 114:515151495151968181817979818191000000000000000000000000000000a30202cada030303da030303030303030303dacacada030303daca02c3a302023938030303030303030303030303a3a3a3a303034702020202000000000000000091000000000000000000000070649100000000007002b4b4030303030303ca03030303da0303030303030303789847020237030303030303030303030303030303030303030303030303030303cab4024902020202020219020202111703030303030303030303030303030202020233624243025102549000000000000000000000000000000064798179817981815102
# 115:512959293949968181817979817954900000000000000000000000000000a30202cada030303da030303030303030303dacacada030303dacaa3b4c902020259030303030303030303030303a4d4c4a403037698799100000000000000000091000000000000000000000071819100000070806449c4a3030303030303da03030303da03030303030303030303030303030303030303030303030303030303030303030303030303030303a3a3b4d3020202395902020202490212030303810303030303030303030303022959496101014159023779548080900000a3a300000000000070a3a3817981818103814902
# 116:514951293951868696818179818181549000000000000000000000000000a35939290202a3a3ca03810303030303cacadacacadacacacadacacba3b402020202023803030303790303030376a30202a3030303030391000000000000000070549000000000000000000070647954900002020202020202030303790303da03030303a303030303030303030303790303030303030303030303030303030303790303030303030303037903cadac8a3020202020202020202020202030303030303030303030303810303390202396101014129027979810381548080a3a300000000708064a3a3818103810381814759
# 117:595151195159515149023879818181819100000000000000000000000000a35902020202a3a4a3a4a3a4a4a4a4a4a4a3a3a4a4a4a4a4a3a4a3a3b4a302020249495979030303030303030377a32959029603030379548090000000a3a4a379795490a3a4a300000000706479a3039170020202295902020303030303a3a4a3a4a4a3a396030303030303030303030303030303030303030303aaca0303030303030303dc0303cacacaaacacadacaa35902020202025902290239020303030303030379030303030303030202393362010142020203818181798181818154808080806481810303038181798179817902
# 118:515102336243295139295151388181819100000000000000000000000000a30202510202c4c9d402020202590239020202020202025139290249c4a30202020202020202020202020202020219020249390202020202020202024929c4d40202020202c4d4020239020202c3b4d30202020202020202020202020202a4b3a4d4c4a4a40202020202020202020202020202490202c4a3a4a339a3a4a3a30202020202c3b40249a3a3a3a4a3a4a3a4a30202022959020202020202020202023902490202020219020239020249330101010101513781797981037903030379038181038179817981798103818181030302
# 119:40440202c4a3a3a3a4a3a4a4c929025902d90202020202020202344439020202021902020202023902020202022902020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005dbdcddd5d5d5d5d5d5d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# 120:4102020202b4cacacaca030303037903030303030303030347022902023703030303030303030303030303030303030303030303da470202510202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006b7b7bad8b9b9b9b9bab0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# 121:4402025102a3bacaca03030303030303030303030303030353390202026353030303035363030303030303ca03790303ca030303caba0239d9020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbbbbbbb8c9c9c9c9cac0000000000000000000000000000000000000000000000000000000000000000000000000000de0000000000000000000000
# 122:1902020219b4caca81030303030303035382030303030303914502193564916303035370640303a3a4a3a4a3a3a3b3a3a3a3b3a3a3cab4d3020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006cbcbc7c5d5d5d5d5d5d000000000000000000000000000000000000000000de0000de00de00000000000000000000aedf00000000ce000000cecede
# 123:0202020202b4ca0303030303a3a3a3035464810303030381546403030303546403035464030303a3b3a3cacacaa4a4a4a3a4a4a4a3caa3b9d30229020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005dbdcddd5d5d5d5d5d5d0000000000000000000000000000000000000000aedfbe00df00df00ce0000000000cede9eeded8e00de00cf00aebecfcfdf
# 124:0202590202c9030353630303c6b4b3030303030303030379030303030303536303030303030303c9c4b4cacacacacacacacacacacacacba3b90202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006b7b7bad6e7e7e7e7e8d0000000000000000000000000000000000000000ededededededed8ecf0000000000cfdfedededed00df9eededededededed
# 125:025102020202030354710303039aa3030303035363030303030389890353926403030303030303b45902caa3a4a4a4a4a3a4a4a4a4a4a3b9d4390202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbbbbbbb6f7f7f7f7f9d0000000000000000000000000000000000000000edededededededededed8eaebe9eedededededededededededededededed
# 126:020202190202030391640303c5b4a3030353829264030303030389890354640303037903030303a319dccacacacacacacacacacacacab4d4025902020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006cbcbc7c5d5d5d5d5d5d0000000000000000000000000000000000000000edededededededededededededededededededededededededededededed
# 127:020202020202030354030303a3b4b3035392000003030303030389890381030303030303536303a302a3a3a3a4a4a3a4a4a3a4a4b3cab4d302020251000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000edededededededededededededededededededededededededededededed
# 128:020202020202030303038103a3b9a3035464795403030303030303030303030303030353806403b429b4cacacaa3a3a3a3a3a3a3a3caa3b902020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000edededededededededededededededededededededededededededededed
# 129:020202d90202030303030303c6b4a3037903030303030303030303030303030303030303030303a3d9b4cacacacacacacacacacacacacba302290202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ededededfeedeeededededededededededededededededededededededed
# 130:020259020202038103030303039ab3030303030303030303030381030303030303030303030303a30202caa3a4a4a4a4a3a4a4a4a4a4a3b939590202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000edeefeedffbfefededfeedededededededededededededfeededeeededed
# 131:02025102020203030379cacac5b4a3ca03030303caca030303cacacaca03030303caca810303cab402dccacacacacacacacacacacacab40202021902000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000afefff9ffdfdfd8fafffededeefeedededeeedfeeeededffafedefededed
# 132:524302020202030303cabacaa3a3a3cacacacacabacacacacacacabacacacacacacacacacaa3b4b459a3a3a3a3a3a3a3a3a3a3a3b3caa3b9d3514939000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fdfdfdfdfdfdfdfdfdfd8fbfefffafedbfefedffefbf9ffdfdfdfd8fbf9f
# 133:0142020202020303cacacacaa302a3caaacacacaaacacacaaacacacacaaacacacaaacacacaa49aa302b4cacacacacacacacacacacacacba3b9020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfd
# 134:010142590202dba3a4a4a4a3d402c4a3a4a4a4a3a3a3a4a4a4a3a3a3a3a4a4a4a3a3a3a4a4a4a3d402c9a3a4a4a4a4a4a4a4a4a4a4a4a3b9d4290202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfd
# 135:506001424302a3d451020259020202a3590202a3b9c9020202c4c9a3d4025902a3b9a3020202a33902020202020229d9020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfd
# </MAP>

# <WAVES>
# 000:00000000ffffffff00000000ffffffff
# 001:0123456789abcdeffedcba9876543210
# 002:0123456789abcdef0123456789abcdef
# 004:00000000ffffffff8bdeefff01234567
# 005:00000000000000008abcddeeeeddcba8
# 006:00000000ffffffff0000000001234567
# 007:00000000777777770245667777665420
# 008:012345677654321001234567fedcba98
# 009:01233210765432100123456789abcdef
# 010:8bdeeffffffeedb87421100000011247
# 011:48bdeffffffeedb8742110000001247b
# 012:01234567765432108bdeefff01234567
# 013:48bdeffffffecdefb74210000001247b
# 014:00001124bdeefffffdccbbbb01234567
# </WAVES>

# <SFX>
# 000:030e410ef300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b02000000000
# 001:630e020bb30ef300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b00000000000
# 002:430e020cb20e6301f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b00000000000
# 003:c302630500091208330953086308730883089308a308b308b308c308c308c308d308d308d308e308e308e308e308e308f308f308f308f308f308f308b70000000000
# 004:c30a430e03041300330043006300730083009300a300a300b300b300c300c300c300c300d300d300d300e300e300e300e300f300f300f300f300f300b00000000021
# 005:1308030a430c730a9309b308c308d308d308e308e308e308f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b70000000000
# 006:e300930f630ed00df300e20dc30c930b430cf300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b60000000000
# 007:b302d300b300e300b300c300c300e300c300d300c300e300d300e300d300f300d300e300e300f300e300f300e300e300f300f300f300f300f300f300b00000000001
# 008:830f430e830d42f043e0c2e0f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b70000000000
# 009:030f810ec30de30cf300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b70000000000
# 010:03098309c309e309f300e20da30dc30cf300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b50000000000
# 011:1209030f430f730e930eb30dc30cd30cd30be30ae309f309f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b70000000000
# 012:9350837073809370a370b360b360c350c250c240d040d030d330d320e320e310e310e300e300f300f300f300f300f300f300f300f300f300f300f300300000000000
# 013:d300c300c300b30fa30fa30fd30ec30ec30ef30de30de30df300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b70000000000
# 014:c300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b00000000000
# 016:0310813dc310e310f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300bf0000000000
# 017:031043008300a300c300d300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f3003e7000000100
# 018:0310130043008300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f3003e0000000100
# 019:4310a33dd310e310f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300bd7000000000
# 020:43107300a300c300d300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f3003c2000000100
# 021:431c53007300a300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300bc2000000101
# 022:040e040f0400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400202000000000
# 023:450e050f150f250f250f350f450f650f950fc50ff50ff50ff50ff50ff50fa50f850f850f950f950f950fa50fb50fd50fe50ff50ff50ff50ff50ff50f472000000000
# 024:080c080e080f080008000800080008000800080008000800080008000800080008000800080008000800080008000800080008000800080008000800207000000000
# 025:070e170f470f670f870fb70fc70fe70f875f975fa75fc75f470f570f770f870fb70fd70ff70ff70f87cf97cfa7cfc7cfb70fb70fc70fd70fe70ff70f4f2000000000
# 026:090009020900090e09000900090009000900090009000900090009000900090009000900090009000900090009000900090009000900090009000900474000000004
# 027:13172300430063008300a300b300c300d300d300e300e300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300cc4000000101
# 028:010e010f0100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100305000000000
# 029:8a004a022a000a0d0a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a002a004a008a00fa00342000000004
# 030:0b0e0b0f1b0f2b0f2b0f3b0f4b0f5b0f6b0f7b0f8b0f9b0fab0fbb0fbb0fcb0fcb0fdb0fdb0feb0feb0feb0ffb0ffb0ffb0ffb0ffb0ffb0ffb0ffb0f472000000000
# 032:0310813d0310833dc310e310f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300bf0000000000
# 033:03108300030043008300a300c300d300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f3003f0000000100
# 034:031083000300130043008300e300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f3003f0000000100
# 035:0310813d0310833d0310833dc310e310f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b80000000000
# 036:0c0e0c0f0c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c000c00202000000000
# 037:040e040f0400040004000400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400202000000000
# 038:0d0e0d0f1d0f2d0f2d0f3d0f4d0f5d0f6d0f7d0f8d0f9d0fad0fbd0fbd0fcd0fcd0fdd0fdd0fed0fed0fed0ffd0ffd0ffd0ffd0ffd0ffd0ffd0ffd0f572000000000
# 039:0e0e0e0f0e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e00402000000000
# 040:0e0e0e0f0e000e000e000e800e800e800e800e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e00482000000000
# 041:0e0e0e0f0e000e000e000e400e400e400e400e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e00402000000000
# 042:0e0e0e0f0e000e000e000e300e300e300e300e800e800e800e800ec00ec00ec00ec00ec00e000e000e000e000e000e000e000e000e000e000e000e00485000000000
# 043:0e0e0e0f0e000e000e000e300e300e300e300e700e700e700e700ec00ec00ec00ec00ec00e000e000e000e000e000e000e000e000e000e000e000e00484000000000
# 044:0e0e0e0f0e000e000e000e100e100e100e100e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e00402000000000
# 045:0e0e0e0f0e000e000e000e200e200e200e200e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e000e00402000000000
# 046:0e0e0e0f0e000e000e000e500e500e500e500e800e800e800e800ec00ec00ec00ec00ec00e000e000e000e000e000e000e000e000e000e000e000e00482000000000
# 048:0e4e0e4f0e000e000e000e600e600e000e000e000e700e700e000e000e400e400e000e000e000e000e000e000e000e000e000e000e000e000e000e0047a000000000
# 049:0e6e0e6f0e000e000e000e700e700e000e000e000e900e900e000e000e600e600e000e000e000e000e000e000e000e000e000e000e000e000e000e0047a000000000
# 050:0e7e0e7f0e000e000e000e900e900e000e000eb00eb00e000e000e000ec00ec00e000e000e000e000e000e000e000e000e000e000e000e000e000e0047a000000000
# 051:0ebe0ebf0e000e000e000e900e900e000e000e700e700e000e000e000e600e600e000e000e000e000e000e000e000e000e000e000e000e000e000e0047a000000000
# 052:0e0e0e0f0e000e000e000ef00ef00ef00ef00ec00ec00ec00ec00e800e800e800e800e800e000e000e000e000e000e000e000e000e000e000e000e00585000000000
# 053:0e0e0e0f0e000e000e000ee00ee00ee00ee00eb00eb00eb00eb00e700e700e700e700e700e000e000e000e000e000e000e000e000e000e000e000e00584000000000
# 054:0e0e0e0f0e000e000e000ec00ec00ec00ec00e800e800e800e800e400e400e400e400e400e000e000e000e000e000e000e000e000e000e000e000e00581000000000
# 055:82204320832043e0c3e0e3e0f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300f300b70001000000
# </SFX>

# <PATTERNS>
# 000:4ff1350000004771370000004ff1590000004771370000014ff1354cc1054771370000004ff1590000007771350000004ff1350000004771370000004ff1590000004771370000014ff1450000004771470000004ff1350000004771370000004ff1590000004771370000014ff1354cc1054771370000004ff1590000007771350000004ff1350000004771370000004ff1590000004771370000014ff1450000004771470000014ff1350000004771370000004ff159000000477137000001
# 001:fff163000000fcc163000000faa165000000fcc16300f000fff163000000fcc163000000faa1650ac000fcc163000000fff163000000fcc163000000faa165000000fcc1630000005ff1650000006cc165000000fff163000000fcc163000000faa165000000fcc163000000fff163000000fcc163000000faa165000000fcc163000000fff163000000fcc163000000faa165000000fcc1630000005ff1650000006cc165000000000000000000000000000000000000000000000000000000
# 002:4bb107000081400019000001400007000001400019000001400007000001400019000001400007000081400019000000400007000081400019000081400007000081400019000081400007000081400019000081400007000081400019000000400007000081400019000081400007000081400019000081400007000081400019000081400007000081400019000000400007000081400019000081400007000081400019000081400007000081400019000081400007000081400019000000
# 003:bff163000000bcc163000000baa165000000bcc163000000bff163000000bcc163000000baa165000000bcc163000000bff163000000bcc163000000baa165000000bcc1630000006ff1630000007ff1630000008ff1630000618cc1630000008aa1650000008cc1630000008ff1630000618cc1630000008aa1650000008cc1630000008ff1630f00008cc1630000008aa1650000618cc1630000009cc163000000aff163000000000000000000000000000000000000000000000000000000
# 004:4bb105000000000000000000455107000000000000000000488129000000000000455109bbb1050000010000000000004bb105000000000000000000b55105000000000000000000488117000000000000000000b881270000000000000000004bb105000000000000000000b88105000000000000000000488119000000000000755107b551070000000000007551074bb105000000000000b55105488105000000000000000000455117000000000000000000488129000000000000000000
# 005:4bb1050000000000000000004551070000000000000000004881290000000000000000008bb1050000010000000000004bb105000000000000000000855105000000000000000000488129000000000000000000b881050000000000000000004bb1050000000000000000004551070000000000000000004881290000000000000000008bb1050000010000000000004bb105000000000000000000855105000000000000000000488129000000000000000000b88105000000000000000000
# 006:bff175000000000000000000100071000000000000000000600075000000000000000000100071000000000000000000b00075000000000000000000100071000000000000000000600075000000000000000000100071000000000000000000700075000000000000000000100081000000000000000000e00075000000000000000000100071000000000000000000700075000000000000000000100071000000000000000000e00075000000000000000000100071000000000000000000
# 007:bff175000000000000000000100000000000000000000000b771750000000000000000006ff175000000000000000000100071000000000071000000900075000000000000000000100071000000a00075000000000071000000100000000000bff175000000000000000000100000000000000000000000b771750000000000000000006ff175000000000000000000100000000000000000000000900075000000000000000000100000000000a00075000000000000000000100000000000
# 008:4bb107000000400019400007000001400007400019000001400007000001400019000001400007400007400019000011400007000000400019400007000001400007400019400818400007400007400019000000400007000000400019000000400007000000400019400007000001400007400019000001400007000001400019000001400007400007400019000011400007000000400019400007000001400007400019400818400007000000000000000000000000400019400019400019
# 009:0aa100000000000000000000b00079000071b00079000071b00079000071b00079000000900079000071900079000000b00079000000b00079000000900079000000900079000000baa179000000b441799aa179000071944179000071baa179000071b44179000071eaa17940007b00007150177b00007140007b000071e01779000071b00079000000901779000071baa179000000b441790000006aa179000000644179000000baa179000000b441799aa179000000944179000071baa179
# 010:0aa10000000000007160007b70007b80007b90007ba0007bbaa17b000000b4417b000000eaa17b000000e4417b000000baa17b000000b4417b6aa17b00000064417b000071baa17b000071100000e0177b000000baa17b000000b4417b6aa17b000071100000e0177b000071d0007b000000b0177b00007160007b00000040177b000071e00079000000d017790000716aa17b00000064417b0000004aa17b00000044417b0000006aa17b00000064417b7aa17b00000074417b0000006aa17b
# 011:baa17b000000000000000000100000000000000000000000b4417b0000000000000000001000710000000000710000006aa17b00000000000000000010000000000000000000000064417b0000000000000000001000000000000000000000004aa17b00000000000000000010000000000000000000000044417b00000000000000000010000000000000000000a000eaa179000000000000000000100000000000000000000000e44179000000000000000000100000000000000000000000
# 012:6ff946602c44666944d551d7077100d991d70bb100ddd1d70bb100d991d7077100d551d70000006ff944600846600844600846600844666944d771d7099100dbb1d70dd100dbb1d7099100d771d7bff942900842b00842d00842b00842d00842600846600844666944e551d7077100e991d70bb100edd1d70bb100e991d7077100e551d70331006ff944600846600844600846600844666944d771d7099100dbb1d70dd100dbb1d7099100d771d7bff942900842b00842d00842b00842d00842
# 013:000071000000000000000000000071000000000000000000000071000000000000000000000071000000000000000000000071000000000000000000000071000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b77107000000bbb107000011bdd117bff117
# 014:4bb115000000b77105b331054bb129000071b771050000014bb1150000004771050000004bb129000000b771054331054bb115000000b77105b331054bb129000071b771050000014bb1150000004771050000004bb129000000b771054331054bb115000000b77105b331054bb129000071b771050000014bb1150000004771050000004bb129000000b771054331054bb115000000b77105b331054bb129000071b771050000014bb1150000004771050000004bb129000000b77105433105
# 015:d111d70000000221d1000000d331d7000000044100000000d551d7000000066100000000d771d7000000088100000000d991d70000000aa100000000dbb1d70000000cc100000000ddd1d70000000cc100000000dbb1d70000000aa100000000d991d7000000088100000000d771d7000000066100000000d551d7000000044100000000d331d7000000022100000000d111d70000000000000000001000d10000000000000000000000d10000000000000000000000d1000000000000000000
# 016:4bb1170000004bb1054771054bb1170000004bb1050000004bb1170000004bb1050000004bb1170000004bb1050000004bb1170000004bb1054771054bb1170000004bb1050000004bb1170000004bb1050000004bb1170000004bb1050000004bb1170000004bb1054771054bb1170000004bb1050000004bb1170000004bb1050000004bb1170000004bb1050000004bb1170000004bb1054771054bb1170000004bb1050000004bb1170000004bb1050000004bb1170000004bb105000000
# 017:bdd183000000000000000000100081000081600083000000100081000081900083000000100081a00083000000000000b00083000000000000000000100081000081600083000000100081000081900083000000100081a00083000000000000b00083000000000000000000100081000081600083000000100081000081900083000000100081a00083000000000000b00083000000000000000000100081000081600083000000100081000081900083000000100081a00083000000000000
# 018:bbb165000000000000000000100081000081600065000000100081000081900065000000100081a00065000000000000b00065000000000000000000100081000081600065000000100081000081900065000000100081a00065000000000000b00065000000000000000000100081000081600065000000100081000081900065000000100081a00065000000000000b00065000000000000000000100081000081600065000000100081000081900065000000100081a00065000000000000
# 019:ebb183000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400085000000000000000000000000000000000000000000500085000000000000000000700085000000900085000000e00083000000100000000000000000700085500085400085e00083000000e00083000000400085000000500085000000e00083000000100000000000000081700085500085400085e00083000000700083000000900083000081a00083000000
# 020:0bb181000081b00083000000600085000000b00083000000100081000000700085000000100000000000700083000000100000000000000000000000000000000000400085000000400085000000400085000000600085000000400085000000b00085000000b00083000000600085000000b00083000000100000000000700085000000100000000000700085000081100000000000000000000000000000000000400085000000400085000000400085000000600085000000400085000000
# 021:bbb185000081b00083000000600085000000b00083000000100081000000700085000000100000000000700083000000100000000000000000000000000000000000400085000000400085000000400085000000600085000000400085000000b00085000000b00083000000700085000000700085000000100081000000400087000000100081000000b00085000081100081000000700085000000700085000000400085000000e00083000000400085000000e00083000000d00083000000
# 022:4000b7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# 023:bff199000000000000000000000000000000000000000000600099000000000000000000000000000000000000000000400099000000000000000000000000000000000000000000e00097000000000091000000000091000000000000000000b00097000000000000000000000000000000000000000000600097000000000000000000000000000000000000000000400097000000000000000000000000000000000000000000e00095000000900095000000b000950000110000110000a1
# 024:0cc100000000b000a7000000b000a70000a19000a7100000b000a71000009000a7100000b000a79000a7100000b000a70000a1e000a74000a95000a94000a9e000a7b000a79000a7b000a71000006000a7100000b000a79000a71000a1b000a71000006000a99000a9a000a9b000a91000a1e000a9100000b000a96000a9100000b000a9100000e000a9b000a96000a9100000e000a9d000a9b000a96bb1a94000a9e000a7d000a76aa1a91000004000a91000006991a97000a91000006000a9
# 025:0cc100000000b000a7000000b000a70000a19000a7a000a7b000a71000009000a7100000b000a79000a7100000b000a70000a1e000a74000a95000a94000a9e000a7b000a79000a7b000a71000006000a7100000b000a79000a71000a1b000a71000006000a99000a9a000a9b000a91000a1e000a9100000b000a96000a9100000b000a9100000e000a9b000a96000a91000006000ab5000ab4000abebb1a9b000a96000a9100000baa1a9100000d000a9100000e991a91000006000ab100000
# 026:eff179900079e00077e00079e00079900079e00077e00079e00079900079e00077e00079e00079900079e00077e0007940007bb0007940007940007b40007bb0007940007940007b50007bc0007950007950007b70007be0007970007b700079e00077000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# 027:0ff100000000000000000000a00099000000000000000000b00099000000000000000000000000000000000000000000d00099000000000000000000000091000000e0009900000000009100000000000000000040009b00000000000000000000000000000000000000000060009b000000000000000000b00099000000000000000000000000000000000000000000e00099000000000000000000000091000000d00099000000000000000000000000000000000091000000000000000000
# 028:0ff100000000000000000000a00099000000000000000000b00099000000000000000000000000000000000000000000d00099000000000000000000000091000000e0009900000000009100000000000000000040009b000000000000000000000000000000000000000000b0009b00000000000000000060009b00000000000000000000000000000000000000000090009b00000000000000000000009100000080009b00000000000000000000000000000040009b000011000011000011
# 029:bff1e90000000000000000000000000000000000000000006000e90000000000000000000000000000000000000000004000e90000000000000000005000e90000000000000000006000e90000000000000000004000e9000000000000000000b000e70000000000000000000000000000000000000000006000e7000000000000000000000000000000000000000000e000e70000000000000000004000e9000000000000000000d000e7000000000000000000e00077000000000000000000
# 030:6991a90044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000a90000000000000000008000a90000000000000000000000a1000000000000000000000000000000000000000000000000000000000000000000b881a9000000000000000000000000000000000000000000d771a9000000000000000000000000000000000000000000
# 031:6991a96771a96551a96331a96ff179000000e024e7000000d000e9000000000000000000e000e9000000000000000000d000e90000000000a10000006331a90000006551a9000000b991a9000000000000000000d000a9000000000000000000e000a9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d000a9000000000000000000000000000000000000000000a000a9000000000000000000000000000000000000000000
# 032:b991a90000000000000000006024a9000000e020a7000000d020a9000000000000000000b020a9000000d020a9000000e020a9000000d020a9000000e020a90000004020ab000000b020ab0000004020ab000000e020a9000000d020a9000000e020a9000000000000000000000000000000b020a9000000000000000000000000000000e020a9000000000000000000d881a90000000000000000000000000000000000000000006771a9000000000000000000000000000000000000000000
# 033:4bb105000000b77107000000499127000000b771074bb1050000004bb105b77107000000499127000000b771070000004bb105000000b77107000000499127000000b771074bb1050000004bb105b77107000000499127000000b771070000004bb105000000b77107000000499127000000b771074bb1050000004bb105b77107000000499127000000b771070000004bb105000000b77107000000499127000000b771074bb1050000004bb105b77107000000499127000000b77107000000
# 034:4bb105000000477105000000499127000000799105b991054771054bb1274991050000004bb1270000014771050000014bb105000000477105000000499127000000799105b991054771054bb1274991050000004bb1270000004771050000004bb105000000477105000000499127000000799105b991054771054bb1274991050000004bb1270000004771050000004bb105000000477105000000499127000000799105b991054771054bb1274991050000004bb1274991074771054bb105
# 035:0000000000000000000000000000004dd129460329000021000021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# 036:4bb1050000004771070000004dd1174dd1170000004771074dd1050000004771050000004dd1170000004771050000004bb1050000004771070000004dd1174dd1170000004771074dd1050000004771050000004dd1170000004771050000004bb1050000004771070000004dd1174dd1170000004771074dd1050000004771050000004dd1170000004771050000004bb1050000004771070000004dd1174dd1170000004771074dd1050000004771050000004dd117000000477105000000
# 037:4dd107b771074dd119b771074dd1074aa9064dd119b771074dd107b771074dd119b771074dd107baa9064dd918b771074dd107b771074dd119b771074dd1074779064dd119b771074dd107b771074dd119b771074dd107b779064dd918b771074dd107b771074dd119b771074dd1074779064dd119b771074dd107b771074dd119b771074dd107b779064dd918b771074dd107b771074dd119b771074dd1074779064dd119b771074dd107b771074dd119b771074dd906400806400828400828
# 038:bdd179000000b99177000000b44177000000bdd179000000b99177000000b441770000009dd1790000009991770000006dd1790000006991770000006441770000006dd179000000699177000000644177000000edd177000000e99175000000bdd177000000b99175000000b44175000000bdd177000000b99175000000b44175000000bdd175000000b99175000000b44175000000bdd175000000b99175000000b44175000000bc0375000000000000000000000000000000000000000000
# 039:b004a90bb100001400000000000000000000000000000000000000000000000000000000000000000000000000000000e000a9000000d000a9e000a9b000a96000a94000a96000a94000a96000a94000a96000a94000a9e000a7b000a7e000a79000a90000008000a99000a98000a90000006000a98000a96000a94000a9e000a74000a9e000a7b000a76000a7b000a7e000a7b000a7e000a74000a95000a9b000a76000a99000a9b000a96000a9b000a9d000a9e000a9b000a9e000a94000ab
# 040:bbb1ab6014abe000a9d000ab9000ab6000ab4000ade000abd000abe000abb000ab6000abe000a9b000a96000a9e000a7e000a90000000000000000a10000a10000a14000ab0000006000ab0000004000ab6000ab4000ab000000e000a9b000a99000ab4000abd000a99000a99000ab4000abd000a99000a99000ab4000abd000a99000a99000ab4000abd000a99000a98000ab4000abb000a94000a98000ab4000abb000a94000a98000ab4000abb000a94000a98000ab4000ab9000abb000ab
# 041:bff1c50000001000006000c5b000c50000006000c50000009000c50000006000c50000007000c50000006000c5000000b000c50000001000006000c5b000c50000006000c50000009000c50000006000c5000000e000c5000000000000000000b000c50000001000006000c5b000c50000006000c50000009000c50000006000c50000007000c50000006000c5000000b000c50000001000006000c5b000c50000006000c50000009000c50000006000c5000000e000c3000000000000000000
# 042:bdd163b771c5bdd1636771c5000061bdd1636771c5bdd1639771c5bdd163bdd1656771c5000061bdd1637771c5bdd165bdd163b771c5bdd1636771c5000061bdd1636771c5bdd1639771c5bdd1639dd1656771c5000061edd163e771c59dd163bdd163b771c5bdd1636771c5000061bdd1636771c5bdd1639771c5bdd163bdd1656771c5000061bdd1636771c5bdd165bdd163b771c5bdd1636771c5000061bdd1636771c5bdd1631000c1bdd1639dd1656771c5000061edd163e771c59dd163
# 043:bff1c5000081100000000000000081000000b000c5000000100081000000b000c5000081b000c7b000c50000c10000009000c50000811000000000000000810000009000c50000001000810000009000c50000819000c79000c50000c10000007000c50000811000000000000000810000007000c50000001000810000007000c50000817000c77000c50000c10000006000c50000811000000000000000810000006000c50000001000810000006000c50000816000c76000c50000c1000000
# 044:6dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e5cdd1c5cbb1e5caa185cbb1e56dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e5ddd1c36bb1e59aa1859bb1e56dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e5cdd1c5cbb1e5caa185cbb1e56dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e56dd1c56bb1e56aa1856bb1e56dd1c5dbb1e39aa1858bb1e5
# 045:bff163000000000000000061b00063100061b00063100000b00063100000b00063100000b00063100000b00063100000bff063000000000000000061b00063100061b00063100000b00063100000b00063100000b00063100000b00063100000bff063000000000000000061b00063100061b00063100000b00063100000b00063100000b00063100000b00063100000bff063000000000000000061b00063100061b00063100000b00063100000b00063100000b00063100000b00063100000
# 046:eff163000000000000000061e00063100061e00063100000e00063100000e00063100000e00063100000e00063100000eff063000000000000000061e00063100061e00063100000e00063100000e00063100000e00063100000e000631000004ff0650000000000000000614000651000614000651000004000651000004000651000004000651000004000651000004ff065000000000000000061400065100061400065100000400065100000400065100000400065100000400065100000
# 047:b00083000000100000b00083000081100000b00083000000100000b00083000081100000000081000000b00083000000b00083000000100000b00083000081100000b00083000000100000b00083000081100000000081000000b00083000000900083000000100000900083000081100000900083000000100000900083000081100000000081000000900083000000900083000000100000900083000081100000900083000000100000900083000081100000000081000000900083000000
# 048:700083000000100000700083000081100000700083000000100000700083000081100000000081000000700083000000700083000000100000700083000081100000700083000000100000700083000081100000000081000000700083000000d00083000000100000d00083000081100081d00083000000100000d00083000081100000000081000000d00083000000600085000000100000600085000081100000600085000000100000600085000081100000000081000000600085000000
# 049:6bb1abb000a9000000000000b441a9000000ebb1a90000000000a1000000e441a90000004bb1ab000000000000000000b000a9b000a70000a1000000b441a70000000000a10000001000a10000000000000000214dd117400017400017490317000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# 050:b991cb6000cbe000c9b000cb6000cbe000c9b000cb6000cbe000c9b000cb6000cbe000c9b000cb6000cbb000cbd000cbe000cbb000cb6000cbe000cbb000cb6000cbe000cbb000cb6000cbe000cbb000cb6000cbe000cbb000cbe000cb6000cd4000cdd000cb9000cb4000cdd000cb9000cb4000cdd000cb9000cb4000cdd000cb9000cb4000cdd000cb4000cd6000cd9000cd4000cdd000cb9000cd4000cdd000cb9000cd4000cdd000cb9000cd4000cdd000cb9000cd4000cd9000cdb000cd
# 051:7991cd4000cdb000cb7000cd4000cdb000cb7000cd4000cdb000cb7000cd4000cdb000cb7000cd4000cdb000cb4000cd7000cde000cbb000cb7000cde000cbb000cb7000cde000cbb000cb7000cde000cbb000cb7000cde000cbb000cdd000cda000cd6000cdd000cba000cd6000cdd000cba000cd6000cdd000cba000cd6000cdd000cba000cd6000cdd000cb6000cda000cd6000cdd000cba000cd6000cdd000cba000cd6000cdd000cba000cd6000cdd000cba771cd6551cdd331cb6111cb
# 052:6ff1656ee1656dd1656cc1656bb1656aa1656991656881656771656661656551656441656331656221656111651000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004dd119400007400007400019
# 053:6bb165100061600065600065100000600065100000600065600065100061600065100061c00065c00065c00065c000656bb065600065600065600065100860600065100000600065900868600065d00063d00063600065600065900065900065dbb866100000600065600065100000600065100000600065d00868100061600065100061c00065c00065c00065c00065ebb86810000060006560006510000060006510000060006550086a000000000000000000000000644165600065600065
# 054:6ff183600085600065600085600083600085600065600085600083600085600065600085600083600085600065600085400083400085400065400085400083400085400065400085400083400085400065400085400083400085400065400085bff181b00083b00063b00083d00081d00083d00063d00083e00081e00083e00063e000836dd183600085600065600085dee181d00083d00063d00083d00081d00083d00063d00083d00081d00083d00063d00083d00081d00083d00063d00083
# 055:6ff944602c42c991d70bb100cdd1d70bb100c991d70771006ff942100000000000600842100000000000600842100000600844600842d991d70bb1d1ddd1d70bb1d1d991d70771d16ff942100000000000600842100000000000600842600842600844600842e991d70bb1d1edd1d70bb100e991d70771006ff9421000000000006008421000000000006008421000006008446008426991d90bb1d16dd1d90bb1d16991d90771d16ff942100000000000600842100000000061600854600854
# 056:5ff96a00000060086a00000000000000000000000000000000000000000000000000000080086a00000000086000000090086a000000000860000000e0086800000000000000000000000000000000000000000060086a000000000000000000d00868000000000000000000000000000000000000000000000000000000000000000000b00868000000000000000000d00868000000000000000000000000000000000000000000900868000000000000000000800868000000000000000000
# 057:6ff968000000000000000000000000000000000000000000c00868000000000000000000d00868000000000000000000b00868000000000000000000900868000000000000000000b00868000000000000000000d0086800000000000000000060086800000000000000000000086000000000000000000050086a00000000000000000060086a00000000000000000080086a00000000000000000000000000000000000000000090086a000000000000000000b0086a000000000000000000
# 058:6dd978d7fd76601c78900888b00878900878800878900878600878d00876600878900898800878600878500878600878600878d00876600878900878b00878900878800878900878e00878600878d00878600878c00878600878d0087860087860087ad00876600878800878900878600878800878900878d00878800878900878d0087860087ad0087860087a80087a9008aa0008709008aa0008709008aa0008709008aa0008708008ba0008708008ba0008708008ba0008708008ba000870
# 059:6dd97ad7fd78601c7a80087a90087a60087a90087ab0087ae0087ad008cad0087ab008dab0087ad0087ab0087a90087a80087a40087a80087ab0087a4008ec0000004008ec000000b0087ad0087ab0087a90087a80087a9008da80087a40087ae00809000000000000000000e00819000000000000000000e00829000000000000000000e0083900000000000000000090084b00000090084b00000090084b00000090084b00000080085b00000080085b00000050086b00000050086b000000
# </PATTERNS>

# <TRACKS>
# 000:180000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ce8000
# 001:5c1a005c1b00602c00602c00000000000000000000000000000000000000000000000000000000000000000000000000050000
# 002:794810e84810fc4910fc48101d4a10f05b10f45c10f85d10f45c10f85d100000000000000000000000000000000000002e0000
# 003:2aa0102eae102eaf1032b02032b1203ea7205ab8205eb9205ab23071c33004c430000000420000000000000000000000ce0000
# 004:34bd0034b83057b93098da306edb306edc30000000000000000000000000000000000000000000000000000000000000ec0000
# </TRACKS>

# <SCREEN>
# 000:666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111116666611111111111111111111116666611111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 001:666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 002:666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 003:666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 004:666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 005:666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 006:666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 007:666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 008:666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 009:666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 010:666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 011:666666666666666666666666666666666666666666666666666666666666666111111111666666666661111111111111111111111111111111111111111111111111111111111111111111111111116666666666111111111666666666666666666666666666666666666666666666666666666666666666
# 012:666666666666666666666666666666666666666666111111111111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666666611116666111166666666666666666666111111
# 013:666666666666666666666666666666666666666666111111111111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666666611116666111166666666666666666666111111
# 014:666666661111111111111111666666666666666611111166661111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666661111111111111111666666666666666666111111
# 015:666666661111111111111111666666666666666611111166661111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666661111111111111111666666666666666666111111
# 016:666666661111111111111111666666666666666611111111111111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666661111111111111111666666666666666666111166
# 017:666666661111111111111111666666666666666611111111111111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666661111111111111111666666666666666666111166
# 018:666666661166111111661111666666666666666666111111111111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666661111661111116611666666666666666666111111
# 019:666666661166111111661111666666666666666666111111111111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611116666666666666666661111661111116611666666666666666666111111
# 020:666666661166111111661111666666666666666666111111111111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666661111661111116611666666666666666666111111
# 021:666666661166111111661111666666666666666666111111111111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666661111661111116611666666666666666666111111
# 022:666666661111111111111111666666666666666611111166661111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666661111111111111111666666666666666666111111
# 023:666666661111111111111111666666666666666611111166661111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666661111111111111111666666666666666666111111
# 024:666666661111111111111111666666666666666611111111111111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666661111111111111111666666666666666666111166
# 025:666666661111111111111111666666666666666611111111111111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666661111111111111111666666666666666666111166
# 026:666666666611116666111166666666666666666666111111111111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666666666666666666666666666666666666666111111
# 027:666666666611116666111166666666666666666666111111111111666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116611116666666666666666666666666666666666666666666666666666111111
# 028:666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666
# 029:666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666
# 030:666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666
# 031:666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666
# 032:666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666
# 033:666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666
# 034:666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666
# 035:666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666
# 036:666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666
# 037:666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666
# 038:666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666
# 039:666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666
# 040:666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666
# 041:666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666
# 042:666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111611111111111111611111111111111111111666666666666666666666666666666666666666666666666
# 043:666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116661111111111111111611111111111111116666666666666666666666666666666666666666666666666
# 044:661111666666666666666666661111111111116666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166166111111111111111111111111111111116666666666666666666666666661111111111116666666666
# 045:6611116666666666666666666611111111111166666666666111111111111111dddddddddddddddddddddddddddddddddd11dddddddddddddddddddddd1111111111111111111111111111111661666611111116161111111111111111111116666666666666666666666666661111111111116666666666
# 046:1111111166666666666666666611111111111111666666666611111111111111d0000000000000000dd00000000000000d11d00000000dd0000000000d1111111111111111111111111111111166661661111111666111111111111111111166111111116666666666666666111111666611116666666666
# 047:11111111666666666666666666111111111111116666666666111111111111ddd0eeeeeeee00eeee0dd0ee00eeeeeeee0dddd0eeeeee0dd0eeeeeeee0ddd111111111111111116666661111116166166111116166166a1111111111111111161111111116666666666666666111111666611116666666666
# 048:11111111666666666666666666111166661111116666666666611111111111d000eeeeeeee00eeee0dd0ee00eeeeeeee000000eeeeee0000eeeeeeee000d1111111111111111161661611111111166611111116666166a11a611111111111661111111116666666666666666111111111111116666666666
# 049:11111111666666666666666666111166661111116666666666611111111111d0eeeeee000000eeee0dd0ee00eeee0000ee00eeee00eeee00eeee0000ee0d11111111111111111616616111111116161111111661666666aaa111111111111611111111116666666666666666111111111111116666666666
# 050:11116611666666666666666666111111111111666666666666661111111111d0eeeeee000000eeee0dd0ee00eeee0dd0ee00eeee00eeee00eeee0dd0ee0d1111111111111111166666611111111111111111116a66777677a111111111116611116611116666666666666666661111111111116666666666
# 051:11116611666666666666666666111111111111666666666666661111111111d00000eeeeee00eeee0dd0ee00eeee0dd0ee00eeeeee000000eeee0dd0000d1111111111111111166666611111111111111111111677767767a111111111116111116611116666666666666666661111111111116666666666
# 052:11116611666666666666666666111111111111666666666666666111111111d00000eeeeee00eeee0000ee00eeee0000ee00eeeeee000dd0eeee0ddddddd11111111111111111161161111111111111111161117776777777a11111111166111116611116666666666666666661111111111116666666666
# 053:11116611666666666666666666111111111111666666666666666111111111d0eeeeeeee000000eeeeee0000eeeeeeee000000eeeeee0dd0eeee0ddd111111111111111111111111111111111111111111111aa6777337777aaa111111166111116611116666666666666666661111111111116666666666
# 054:111111116666666666666666661111111111111166666666666dddddddddddd0eeeeeeee0dddd0eeeeee0dd0eeeeeeee0dddd0eeeeee0dd0eeee0dddddd111111111dddddddddddddddddd111ddddddddddddddddddddddddddddddddd116611111111116666666666666666111111666611116666666666
# 055:111111116666666666666666661111111111111166666666666d000000000000000000000000000000000000eeee000000000000000000000000000000d111111111d0000000000000000d111d0000000000000dd0000000000000000d116611111111116666666666666666111111666611116666666666
# 056:111111116666666666666666661111666611111166666666666d000000000000000000000000000000000000eeee000000000000dd0000000000000000d111111111d0000000000000000d111d0000000000000dd0000000000000000d116611111111116666666666666666111111111111116666666666
# 057:111111116666666666666666661111666611111166666666666d0066666600066666600066666666666666600000066666666600dd0066666666666600d111111111d0066666666666600ddddd0066666666600dd0066666600066600d116661111111116666666666666666111111111111116666666666
# 058:666666666666666666666666661111111111116666666666666d0066666600066666600066666666666666600000066666666600000066666666666600d111111111d0066666666666600000000066666666600000066666600066600d111666661111666666666666666666661111111111116666666666
# 059:666666666666666666666666661111111111116666666666661d0066666600066666600066666666666666600000066666666600000066666666666600d111111111d0066666666666600000000066666666600000066666600066600d111116661111666666666666666666661111111111116666666666
# 060:666666666666666666666666666666666666666666666666611d0066666666666666600066666611111111100066666611111166600011166666611100d111111111d0066666611111166600066666611111166600066666600066600d111111666666666666666666666666666666666666666666666666
# 061:666666666666666666666666666666666666666666666666111d0066666666666666600066666611111111100066666611111166600011166666611100d111111111d0066666611111166600066666611111166600066666600066600d111111166666666666666666666666666666666666666666666666
# 062:666666666666666666666666666666666666666666666611111d0066666666666666600066666600000000000066666600000066600000066666600000d111111111d0066666600000066600066666600000066600066666600066600d111111116666666666666666666666666666666666666666666666
# 063:666666666666666666666666666666666666666666666111111d0066666666666666600066666666666600000066666600000066600000066666600000d111111111d0066666666666611100066666600000066600066666666666600d111111111666666666666666666666666666666666666666666666
# 064:666666666666666666666666666666666666666666661111111d0066666666666666600066666666666600dd0066666600000066600dd0066666600dddd111111111d0066666666666611100066666600dd0066600066666666666600d111111111166666666666666666666666666666666666666666666
# 065:666666666666666666666666666666666666666666611111111d0066666666666666600066666666666600dd0066666600000066600dd0066666600d111111111111d0066666666666600000066666600dd0066600066666666666600d111111111111666666666666666666666666666666666666666666
# 066:666666666666666666666666666666666666666666111111111d0066611166611166600066666611111100dd0066666666666666600dd0066666600d111111111111d0066666611111166600066666600dd0066600011166666611100d111111111111166666666666666666666666666666666666666666
# 067:666666666666666666666666666666666666666661111111111d0066611166611166600066666611111100000066666666666666600dd0066666600d111111111111d0066666611111166600066666600000066600011166666611100d111111111111116666666666666666666666666666666666666666
# 068:666666666666666666666666666666666666666611111111111d0066600066600066600066666600000000000066666666666666600dd0066666600d111111111111d0066666600000066600066666600000066600000066666600000d111111111111111666666666666666666666666666666666666666
# 069:666666666666666666666666666666666666666661111111111d0066600011100066600066666666666666600066666611111166600dd0066666600d111111111111d0066666666666611100011166666666611100000066666600000d111111111111116666666666666666666666666666666666666666
# 070:666666666666666666666666666666666666666666111111111d0066600011100066600066666666666666600066666611111166600dd0066666600d111111111111d0066666666666611100011166666666611100dd0066666600dddd111111111111166666666666666666666666666666666666666666
# 071:666666666666666666666666666666666666666666611111111d0066600000000066600066666666666666600066666600000066600dd0066666600d111111111111d0066666666666600000000066666666600000dd0066666600d111111111111116666666666666666666666666666666666666666666
# 072:666666666666666666666666666666666666666666666111111d0011100000000011100011111111111111100011111100000011100dd0011111100d111111111111d0011111111111100000000011111111100000dd0011111100d111111111111166666666666666666666666666666666666666666666
# 073:666666666666666666666666666666666666666666666611111d0011100ddddd0011100011111111111111100011111100dd0011100dd0011111100d111111111111d0011111111111100ddddd0011111111100ddddd0011111100d111111111111666666666666666666666666666666666666666666666
# 074:666666666666666666666666666666666666666666666661111d0000000d111d0000000000000000000000000000000000dd0000000dd0000000000d111111111111d0000000000000000d111d0000000000000d111d0000000000d111111111166666666666666666666666666666666666666666666666
# 075:666666666666666666666666666666666666666666666666111d0000000d111d0000000000000000000000000000000000dd0000000dd0000000000d111111111111d0000000000000000d111d0000000000000d111d0000000000d111111111666666666666666666666666666666666666666666666666
# 076:666666666666666666666666666666666666666666111116611ddddddddd111ddddddddddddddddddddddddddddddddddddddddddddddddddddddddd111111111111dddddddddddddddddd111ddddddddddddddd111dddddddddddd111111116666666666611116666111166666666666666666666111111
# 077:666666666666666666666666666666666666666666111111666111111111111111111111111111111110000000000000000111110000010000011111110000111111111111111110000111111111111111111111111111111111111111111166666666666611116666111166666666666666666666111111
# 078:666666661111111111111111666666666666666611111166666611111111111111111111111111111110aaaa0aaaa00aaa0011100aaa000aaa001111000aa0000000000001000000aa0000000001111111111111111111111111111111116666666666661111111111111111666666666666666666111111
# 079:6666666611111111111111116666666666666666111111666666611111111111111111111111111111100aa000aa00aa00a00000aa00a0aa0aa011100aaaa00aaa00aa0a000aaaa0aa00a00aaa00111111111111111111111111111111116666666666661111111111111111666666666666666666111111
# 080:6666666611111111111111116666666666666666111111111116611111111111111111111111111111110aa010aa00aa0000aaa00aaa00aaa0a01110a00aa0aa0aa0aaaaa0a00aa0aaaa00aa0aa0111111111111111111111111111111116666666666661111111111111111666666666666666666111166
# 081:6666666611111111111111116666666666666666111111111116611111111111111111111111111111110aa000aa00aa00a00000aa00a0aa00a01110a00aa0aaa000a0a0a0a00aa0aa00a0aaa000111111111111111111111111111111116666666666661111111111111111666666666666666666111166
# 082:6666666611661111116611116666666666666666661111111116611111111111111111111111111111110aa00aaaa00aaa0011100aaa000aaa0011100aaaa00aaa00a0a0a00aaaa0aa00a00aaa01111111111111111111111111111111116666666666661111661111116611666666666666666666111111
# 083:666666661166111111661111666666666666666666111111111661111111111111111111111111111111000000000000000111110000010000011111000000000000000000000000000000000001111111111111111111111111111111166666666666661111661111116611666666666666666666111111
# 084:666666661166111111661111666666666666666666111111111611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666661111661111116611666666666666666666111111
# 085:666666661166111111661111666666666666666666111111116611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666661111661111116611666666666666666666111111
# 086:666666661111111111111111666666666666666611111166666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666661111111111111111666666666666666666111111
# 087:666666661111111111111111666666666666666611111166666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666661111111111111111666666666666666666111111
# 088:666666661111111111111111666666666666666611111111161111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666661111111111111111666666666666666666111166
# 089:666666661111111111111111666666666666666611111111661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666661111111111111111666666666666666666111166
# 090:666666666611116666111166666666666666666666111111661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666111111
# 091:666666666611116666111166666666666666666666111111611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666111111
# 092:666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666
# 093:666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666
# 094:666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666
# 095:666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666
# 096:666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666
# 097:666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666
# 098:666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666
# 099:666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666
# 100:666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666
# 101:666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666
# 102:666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666
# 103:666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666
# 104:666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666
# 105:666666666666666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666
# 106:666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666
# 107:666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666
# 108:661111666666666666666666661111111111116666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666661111111111116666666666
# 109:661111666666666666666666661111111111116666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666661111111111116666666666
# 110:111111116666666666666666661111111111111166666666666666661111116611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666611111111111111116666666666666666111111666611116666666666
# 111:111111116666666666666666661111111111111166666666666666661111116611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666611111111111111116666666666666666111111666611116666666666
# 112:111111116666666666666666661111666611111166666666666666661111116611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666611111111111111116666666666666666111111111111116666666666
# 113:111111116666666666666666661111666611111166666666666666661111116611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666611111111111111116666666666666666111111111111116666666666
# 114:111166116666666666666666661111111111116666666666666666661166116611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666611661111116611116666666666666666661111111111116666666666
# 115:111166116666666666666666661111111111116666666666666666661166116611111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111116666666611661111116611116666666666666666661111111111116666666666
# 116:111166116666666666666666661111111111116666666666666666661166116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666611661111116611116666666666666666661111111111116666666666
# 117:111166116666666666666666661111111111116666666666666666661166116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666611661111116611116666666666666666661111111111116666666666
# 118:111111116666666666666666661111111111111166666666666666661111116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666611111111111111116666666666666666111111666611116666666666
# 119:111111116666666666666666661111111111111166666666666666661111116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666611111111111111116666666666666666111111666611116666666666
# 120:111111116666666666666666661111666611111166666666666666661111116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666611111111111111116666666666666666111111111111116666666666
# 121:111111116666666666666666661111666611111166666666666666661111116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666611111111111111116666666666666666111111111111116666666666
# 122:666666666666666666666666661111111111116666666666666666666611116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666111166661111666666666666666666661111111111116666666666
# 123:666666666666666666666666661111111111116666666666666666666611116111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111666666666111166661111666666666666666666661111111111116666666666
# 124:666666666666666666666666666666666666666666666666666666666666666111111111666666666111111111111111111111111111111111111111111111111111111111111111111111111111111166666666111111111666666666666666666666666666666666666666666666666666666666666666
# 125:666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 126:666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 127:666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 128:666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 129:666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111111111111111111111111111111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 130:666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 131:666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111111111111111111111111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 132:666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 133:666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 134:666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111111111111111111111111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# 135:666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111116611111111111111111111111111111611111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
# </SCREEN>

# <PALETTE>
# 000:140c1c442c34b2ce9556524e7555483c5028b046487571616786ffc6deb68d959950753cd2a5aedeeed6dad45edeeed6
# </PALETTE>

