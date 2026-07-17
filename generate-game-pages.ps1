Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$SiteUrl = "https://drivemads.online/"
$SiteBrand = "DriveMads"
$ContactEmail = "hello@drivemads.online"
$GameOutputRoot = Join-Path $Root "games"

$CuratedNotes = @{
  "drive-mad" = @{
    Standfirst = "Drive Mad is still the sharpest driving page in the catalog if you want a browser game that cares more about balance, landing angle, and restraint than top speed. This page keeps the current source, controls summary, and the usual fail points in one place so you can restart with better timing instead of guessing."
    OverviewParagraphs = @(
      "Drive Mad earns its replay value by exposing mistakes immediately. One heavy throttle burst can tilt the car too far, one nose-down landing can end the run, and the short obstacle format makes every retry feel productive instead of drawn out.",
      "It plays closer to a balance challenge than a race. Most progress comes from remembering one awkward bridge, gap, or ramp and then fixing the exact speed or angle that ruined the previous attempt."
    )
    ValueBullets = @(
      "Shows both the live embed URL and the clean source page URL so you can verify where the game is coming from.",
      "Calls out the most common failure pattern on early stages: over-accelerating into ramps and landing front-heavy.",
      "Connects Drive Mad to the closest follow-up driving pages when you want the same retry loop with a slightly different pace."
    )
    Tips = @(
      "Use short throttle taps before ramps instead of holding the accelerator all the way through the jump.",
      "Watch the car's nose on landing; if it drops too early, the real fix is usually the speed you carried into the obstacle.",
      "Treat each failed stage as a timing drill and correct one section at a time."
    )
    Mistakes = @(
      "Full-speed entries make the suspension bounce and flip the car even when the obstacle itself is simple.",
      "Trying to rescue every bad landing often creates a second crash immediately after the first wobble.",
      "Mobile players usually fail by overcorrecting because touch controls feel more binary than quick keyboard taps."
    )
    ControlsIntro = "The usual desktop controls are the arrow keys or A and D, but the real skill is in feathering the input rather than holding it down. The game punishes long, panicked presses much more than brief, controlled corrections."
    MobileNote = "Drive Mad is playable on mobile, but the touch version feels harsher because you lose the precision of short keyboard taps. Landscape mode gives the cleanest view of ramps and landing zones."
    SourceNote = "Drive Mad on this page is embedded from drivinggames.io. Loading the iframe or opening the source link can trigger that provider's own cookies, local storage, and request logging in the same way it would on the original host."
    ComparisonNote = "If Drive Mad feels too punishing, Snow Road gives you a longer downhill rhythm and fewer instant flips. If you like the balance pressure and want another stage-based driving page, Slope Rider is the closest follow-up."
  }
  "escape-road-city-2" = @{
    Standfirst = "Escape Road City 2 works best as a chase-and-dodge driving page rather than a pure precision platformer. The draw is weaving through traffic, holding momentum, and surviving long enough for the route to become readable."
    OverviewParagraphs = @(
      "Compared with Drive Mad, this page is less about one perfect landing and more about surviving sustained pressure through a busier city route. The game rewards clean lane changes and quick reading of what is blocking the road ahead.",
      "It is a better fit when you want forward motion and chase energy instead of short obstacle puzzles. The tension comes from traffic and recovery windows, not from a single awkward physics jump."
    )
    ValueBullets = @(
      "Frames the page as a chase game, which helps set expectations before you open the embed.",
      "Highlights why speed control matters even when the route pushes you to stay aggressive.",
      "Gives you a cleaner comparison with the more stop-start driving pages in the catalog."
    )
    Tips = @(
      "Make smaller steering corrections than your first instinct suggests so you do not slide into the next lane too early.",
      "Use open road to stabilize the car instead of accelerating blindly into denser traffic.",
      "If a run starts collapsing, reset your line first and rebuild speed after the road opens again."
    )
    Mistakes = @(
      "Holding top speed through every corner removes the room you need for last-second traffic reads.",
      "Cutting too tightly around vehicles often clips the rear of your car into the next obstacle.",
      "Tunnel vision on one opening can hide a second blocker just behind it."
    )
    ControlsIntro = "Expect a standard browser driving setup with directional keys or touch steering, but focus less on raw acceleration and more on keeping the car centered for the next traffic break."
    MobileNote = "The mobile version is playable, but city traffic is harder to read when your thumbs cover the lower edges of the screen. Landscape orientation helps preserve more reaction time."
    SourceNote = "This page uses the current game.azgame.io source for the playable version. If you prefer, use the source links first to inspect the host before opening the iframe."
    ComparisonNote = "Escape Road City 2 is the better pick when you want continuous chase pressure. Drive Mad is stronger when you want shorter puzzle-like stages and more obvious physics punishment."
  }
  "slope-rider" = @{
    Standfirst = "Slope Rider leans into downhill flow. The page matters because this game feels easy for a few seconds, then starts punishing heavy steering and bad line choice once speed builds."
    OverviewParagraphs = @(
      "This is a cleaner momentum page than a stop-start stage page. The main question is whether you can keep a readable line as the slope pushes more speed under you.",
      "Runs improve when you stop reacting to the obstacle under your board or sled and start reading the next bend a little earlier than feels natural."
    )
    ValueBullets = @(
      "Explains why the page is more about line choice than about memorizing one hard jump.",
      "Calls out the difference between stable downhill rhythm and panic steering.",
      "Helps you decide whether you want this longer flow or the sharper resets of Drive Mad."
    )
    Tips = @(
      "Guide the run with light adjustments and let the downhill speed carry you instead of fighting the slope constantly.",
      "Read the next bend early so you enter it already centered.",
      "When the pace spikes, survive one clean section first and chase riskier lines later."
    )
    Mistakes = @(
      "Oversteering at high speed turns one small drift into a full route collapse.",
      "Correcting late usually pushes you into the outside of the next bend.",
      "Trying to max speed before you understand the route removes any recovery buffer."
    )
    ControlsIntro = "The usual browser inputs are simple, but the real skill is how gently you steer when the downhill pace increases. Smaller inputs hold the line better than dramatic corrections."
    MobileNote = "Slope Rider is playable on touch, but long downhill sections can feel slippery on a small screen. Use landscape mode and expect slightly coarser steering than on desktop."
    SourceNote = "The current playable build is loaded from game.azgame.io, which means the third-party host can set its own technical identifiers or cookies once the iframe loads."
    ComparisonNote = "If you want a downhill page with more depth and visual space, Slope Rider 3D is the obvious comparison. If you want harsher obstacle timing and less continuous motion, Drive Mad still wins."
  }
  "slope-rider-3d" = @{
    Standfirst = "Slope Rider 3D takes the downhill idea and adds more depth, which means route choice and camera reading matter more than they do in the flatter version."
    OverviewParagraphs = @(
      "The 3D presentation changes how fast the page feels. Obstacles can look farther away than they really are, so the first challenge is judging distance and lane commitment before the pace gets uncomfortable.",
      "It is the better follow-up if you already like Slope Rider but want a little more space and a little more visual judgment in each run."
    )
    ValueBullets = @(
      "Flags the extra distance-reading problem that comes with the 3D camera.",
      "Keeps the source links visible so you can verify the hosted version before opening it.",
      "Separates this page from the flatter Slope Rider loop instead of treating them as the same game with a new coat of paint."
    )
    Tips = @(
      "Commit to a line earlier than you would in the 2D-feeling downhill pages because the camera makes late changes costlier.",
      "Use your first run to judge spacing, not to chase a perfect score.",
      "Once the course opens up, keep the cleanest route instead of cutting aggressively for speed."
    )
    Mistakes = @(
      "Late steering inputs feel worse here because the 3D depth hides how little room remains.",
      "Cutting corners too tightly often leaves no recovery angle for the next obstacle.",
      "Playing it exactly like Slope Rider usually leads to overconfidence on early runs."
    )
    ControlsIntro = "Standard steering controls still apply, but the 3D camera makes route commitment more important. Small but earlier inputs beat sharp last-second swerves."
    MobileNote = "The 3D camera reads better on wider screens. On mobile, keep the phone horizontal and expect obstacle depth to feel less forgiving than on desktop."
    SourceNote = "The embedded version currently comes from gamea.azgame.io. That host can manage its own cookies, device identifiers, and logging once the playable frame is requested."
    ComparisonNote = "Slope Rider 3D is the better pick when you want downhill movement with more depth judgment. The base Slope Rider page stays cleaner if you prefer simpler visuals and faster route reading."
  }
  "snow-road" = @{
    Standfirst = "Snow Road is the calmer-looking driving page that still punishes sloppy rhythm. Ice, speed, and narrow recovery windows matter more here than abrupt physics flips."
    OverviewParagraphs = @(
      "The snowy presentation makes the run feel smoother than Drive Mad, but the real challenge is still control under pressure. Once speed builds, every overcorrection carries farther than you expect.",
      "It is a good follow-up if you want something more continuous than stage-based obstacle driving but still want to feel your mistakes immediately."
    )
    ValueBullets = @(
      "Explains why the game is really about slippery momentum, not just winter visuals.",
      "Gives quick guidance for handling speed on a route that looks calmer than it plays.",
      "Helps you decide whether to stay with this smoother downhill loop or switch back to stage-based pages."
    )
    Tips = @(
      "Settle into a repeatable rhythm before you try to push for a faster run.",
      "Steer a little earlier than usual because icy movement keeps carrying after you input.",
      "When the route starts to drift away from you, prioritize stability over score or speed."
    )
    Mistakes = @(
      "Late corrections slide too far and usually create a second mistake on the next obstacle.",
      "Trying to force speed before you understand the route removes the only recovery margin you have.",
      "Players often underestimate how much visual calm can hide mechanical difficulty on snow-themed pages."
    )
    ControlsIntro = "Expect straightforward steering controls, but approach the run as an exercise in smooth input rather than aggressive weaving."
    MobileNote = "Mobile play is viable, though icy corrections feel wider on touch. Give yourself more space than you would on desktop and use landscape mode."
    SourceNote = "Snow Road on this page loads from game.azgame.io. If you open the iframe, the third-party host can apply its own cookies, local storage, or log data."
    ComparisonNote = "Snow Road is smoother and more continuous than Drive Mad. If you want a harsher obstacle page, go back to Drive Mad. If you want another downhill route with more direct slope pressure, Slope Rider is closer."
  }
  "2048" = @{
    Standfirst = "2048 looks simple until the board clogs and every move starts spending future space. This page is most useful when you want to refresh the core board discipline before wasting a promising run."
    OverviewParagraphs = @(
      "The real appeal of 2048 is that every bad move lingers. You do not lose because one button was hard to press; you lose because a single careless merge can break the structure you were building toward.",
      "That makes the page valuable even with the iframe hidden: the game rewards a plan, and the fastest way to improve is to avoid the same board management mistake on the next attempt."
    )
    ValueBullets = @(
      "Focuses on board structure, not just the fact that the game is famous and easy to load.",
      "Highlights the corner strategy and spacing discipline that new runs usually ignore.",
      "Gives a clear comparison with faster puzzle pages like Tetris and slower draw-based pages like Sugar Sugar."
    )
    Tips = @(
      "Pick one edge or corner for your highest tile and stop breaking that anchor unless the board is already collapsing.",
      "Use the opposite direction sparingly because one careless reverse swipe can scatter your whole structure.",
      "When the board gets crowded, play for space first and for flashy merges second."
    )
    Mistakes = @(
      "Breaking the home corner too early forces the board into a scramble that is hard to recover.",
      "Using all four directions freely makes it much harder to keep high-value tiles organized.",
      "Chasing one satisfying merge while the board is nearly full often throws away the run."
    )
    ControlsIntro = "Desktop versions usually use the arrow keys, while mobile versions rely on swipes. The hard part is not the control scheme itself but the discipline to avoid one unnecessary direction change."
    MobileNote = "2048 works well on phones, but swipe inputs can travel farther than expected if you play too quickly. Slower, deliberate swipes are usually safer than speed-playing the board."
    SourceNote = "The current playable version is embedded from azgames.io. That provider can set its own cookies or collect device-level data when the iframe is opened."
    ComparisonNote = "If you want another puzzle page with long-term board planning, stay with 2048. If you want a faster reflex puzzle, move to Tetris. If you want slower experimentation, Sugar Sugar is the calmer option."
  }
  "tetris" = @{
    Standfirst = "Tetris is the cleanest reflex puzzle page in the catalog when you want speed instead of long board planning. The important question is not whether you know Tetris already, but whether the current run is still controlled or already one bad stack away from a collapse."
    OverviewParagraphs = @(
      "Unlike 2048, Tetris punishes hesitation and messy stacking in real time. The board is always on the verge of becoming either stable and efficient or one misplaced piece away from panic.",
      "That makes a guidance page useful because the same few mistakes keep appearing: stacks rise too high in the center, line clears are delayed, and players outrun their own preview reading."
    )
    ValueBullets = @(
      "Frames the page around stack management and tempo instead of generic 'classic puzzle' filler.",
      "Separates Tetris from slower planning pages in the same catalog.",
      "Keeps the source host visible so you can check the version before you commit to a longer run."
    )
    Tips = @(
      "Keep the surface flatter than you think you need, especially through the middle columns.",
      "Burn a line early when the stack starts leaning too high rather than waiting for the perfect piece.",
      "Play only as fast as you can still read the next piece without panicking."
    )
    Mistakes = @(
      "Letting the center spike too high removes the recovery space you need for awkward pieces.",
      "Holding out too long for one perfect line clear often turns a manageable stack into a crisis.",
      "Speeding up before your preview reading is ready creates preventable misdrops."
    )
    ControlsIntro = "Browser Tetris versions usually rely on the arrow keys or comparable keyboard inputs. The controls are familiar; the real challenge is how cleanly you place pieces while the pace increases."
    MobileNote = "Touch versions are playable, but quick rotations and sideways corrections feel less crisp than on keyboard. Desktop is the better choice if you want longer, cleaner runs."
    SourceNote = "This page uses the current azgames.io embed. Once the frame loads, that host can apply its own cookies, storage, and measurement behavior."
    ComparisonNote = "Tetris is the better pick when you want a fast puzzle with visible time pressure. 2048 is slower and more positional, while Trap the Cat is almost entirely turn-based."
  }
  "trap-the-cat" = @{
    Standfirst = "Trap the Cat is a turn-based grid puzzle, so the page matters less for controls and more for helping you think about space, escape lanes, and why one bad block placement can ruin the whole trap."
    OverviewParagraphs = @(
      "The game looks harmless at first because the cat only moves one step at a time, but each move reshapes the board. The puzzle is really about shrinking the escape map without overcommitting to one side too early.",
      "That is why this page stays useful without the iframe: you improve less through raw speed and more through pattern recognition and a better sense of how the cat reads open lanes."
    )
    ValueBullets = @(
      "Reframes the game as a route-closing puzzle instead of a random click challenge.",
      "Calls out the most common strategic error: blocking near the cat while leaving a long edge escape lane open.",
      "Gives a cleaner puzzle comparison than the site's faster reflex-heavy pages."
    )
    Tips = @(
      "Build pressure from the outside in so the cat loses options without getting a clean straight-line escape.",
      "Watch for the longest open lane to the edge because that is usually the real threat, not the nearest gap.",
      "If the board starts to widen again, stop chasing the cat directly and rebuild the ring."
    )
    Mistakes = @(
      "Blocking the spaces right next to the cat can feel strong while still leaving one huge exit lane open.",
      "Random edge blocks rarely help unless they cut off the longest viable escape route.",
      "Reacting only to the current move instead of the next two makes the board too loose."
    )
    ControlsIntro = "The inputs are simple taps or clicks on grid cells. The difficulty comes from choosing the right cells in the right order rather than from any mechanical control barrier."
    MobileNote = "Trap the Cat works well on mobile because the puzzle is turn-based, though accidental taps are easier on smaller screens. Slow down and verify the exact cell before you place a block."
    SourceNote = "The playable version here is delivered from azgames.io. As with the other embeds, that third-party source can apply its own cookies or other identifiers once you open the frame."
    ComparisonNote = "If you want a puzzle page built on patient route control, Trap the Cat is stronger than the faster catalog options. If you want more constant motion, move to Tetris or one of the driving pages instead."
  }
  "sugar-sugar" = @{
    Standfirst = "Sugar Sugar is the slower, more tactile puzzle page in the catalog. Its value is not in twitch speed but in understanding gravity, line placement, and how a tiny drawing change can reroute the whole solution."
    OverviewParagraphs = @(
      "The puzzle loop is satisfying because the board usually looks simple right before it proves otherwise. Your lines either guide the sugar cleanly or create a messy spill that wastes the entire attempt.",
      "This is one of the better pages to keep open alongside the game because the source links, solve mindset, and mobile precision note are all more useful than generic puzzle filler."
    )
    ValueBullets = @(
      "Treats the game as a gravity-routing puzzle rather than another interchangeable 'play online' page.",
      "Highlights why over-drawing is often worse than under-drawing.",
      "Offers a calmer puzzle comparison for players who do not want the time pressure of Tetris."
    )
    Tips = @(
      "Start with the shortest workable line and let gravity do more of the job for you.",
      "Watch where the first stream misses before you redraw the whole solution.",
      "If colors or filters appear, solve the route in parts instead of forcing one giant line."
    )
    Mistakes = @(
      "Drawing too much too early can send the sugar into the wrong area before you understand the board.",
      "Ignoring the edges of the screen wastes some of the easiest guiding surfaces available.",
      "Players often redraw everything when only one angle or endpoint needed to change."
    )
    ControlsIntro = "Sugar Sugar is usually mouse-first on desktop and finger-draw based on mobile. The best input style is still the same: slower, more deliberate lines beat fast sketching."
    MobileNote = "The game is playable on touch, but finger width makes precision lines harder near small openings. Zooming your attention and drawing shorter lines usually helps."
    SourceNote = "The current Sugar Sugar embed is loaded from azgames.io. Opening it hands control of the playable frame to that third-party host and its own tracking behavior."
    ComparisonNote = "Sugar Sugar is the better fit when you want to experiment and revise slowly. 2048 is more about board discipline, and Tetris is much more about tempo and fast correction."
  }
  "stickman-hook" = @{
    Standfirst = "Stickman Hook is the action page for players who want momentum and timing rather than combat noise. What matters most is understanding when to release a swing, not just spotting the next hook."
    OverviewParagraphs = @(
      "The game feels simple because the input is so light, but momentum is doing most of the work under the surface. A slightly early release can preserve your flow, while a slightly late one can flatten the whole run.",
      "That makes it a good page to keep open with a few notes beside the iframe, especially if you are trying to turn messy first clears into smoother repeat runs."
    )
    ValueBullets = @(
      "Explains why release timing matters more than constant tapping.",
      "Helps separate smooth momentum runs from panic clicks that destroy speed.",
      "Provides a clearer action-page alternative for visitors who do not want an open-world sandbox or combat-heavy page."
    )
    Tips = @(
      "Let the swing build before you release instead of clicking every hook the moment it appears.",
      "Stay low and smooth when possible; giant arcs are flashy but harder to recover.",
      "If one section keeps failing, focus on the release point rather than the hook itself."
    )
    Mistakes = @(
      "Grabbing every available hook kills rhythm because not every hook is meant to be used.",
      "Holding too long at the bottom of a swing often throws away your forward speed.",
      "Players chasing huge arcs early usually lose control on the landing or the next catch."
    )
    ControlsIntro = "The control scheme is usually a single click, tap, or hold-based interaction. That simplicity is deceptive: the page rewards timing discipline more than raw reaction speed."
    MobileNote = "Stickman Hook works well on phones because the input is light, but thumb timing can still feel different from mouse timing. Expect a few warm-up runs before the release rhythm feels natural."
    SourceNote = "This page uses the current azgames.io embed for Stickman Hook. Once the game frame opens, that host can use its own storage, measurement, and cookie behavior."
    ComparisonNote = "Stickman Hook is the better action page when you want clean movement and timing. If you want heavier chaos or open-world sandbox energy, Dude Theft Auto is the more explosive option."
  }
  "stickman-war" = @{
    Standfirst = "Stickman War is a busier action page than Stickman Hook because the pressure comes from fights and positioning rather than one clean movement rhythm. The useful part of the page is understanding how quickly the arena can snowball against sloppy play."
    OverviewParagraphs = @(
      "This page works best when you treat the game as a compact battle loop instead of assuming it is only about clicking faster. Position, target choice, and knowing when to disengage matter more than rushing every threat head-on.",
      "It belongs in the maintained catalog because it gives action players a different flavor than pure traversal pages: more pressure, more chaos, and more reasons to value short resets."
    )
    ValueBullets = @(
      "Sets expectations around arena pressure instead of movement-only play.",
      "Highlights why survival and spacing matter as much as aggression.",
      "Gives the catalog an action page that feels different from sandbox or swing-based alternatives."
    )
    Tips = @(
      "Create space before you commit to the next attack instead of fighting from a crowded position.",
      "Read the first wave or pressure cycle before you rush deeper into danger.",
      "Use each retry to learn where the arena starts to become unsafe."
    )
    Mistakes = @(
      "Running straight into the center usually creates pressure from too many angles at once.",
      "Overcommitting after one good opening can leave no route out of the next threat.",
      "Ignoring positioning while chasing damage makes the page feel more random than it really is."
    )
    ControlsIntro = "Expect a standard browser action setup with movement plus one or two attack or reaction inputs. The hard part is managing space under pressure, not memorizing a complicated control sheet."
    MobileNote = "Mobile play is possible, but crowded action pages are always harder when on-screen controls cover part of the arena. Desktop gives the cleaner view."
    SourceNote = "The current Stickman War version on this page is embedded from gamea.azgame.io. That third-party host handles the playable frame and any related technical identifiers."
    ComparisonNote = "Stickman War is the better pick when you want compact arena pressure. Stickman Hook is cleaner and more movement-focused, while Dude Theft Auto leans much harder into sandbox chaos."
  }
  "dude-theft-auto" = @{
    Standfirst = "Dude Theft Auto is the sandbox page in the catalog. The point of opening this guide first is not to learn every control, but to know that the fun comes from improvisation, vehicles, and ragdoll chaos rather than tightly scripted level structure."
    OverviewParagraphs = @(
      "This game feels looser than most of the action pages here. You are usually making your own trouble, whether that means grabbing a vehicle early, provoking the map too fast, or turning a small moment into a full chase.",
      "That is why the page needs more than an iframe: a quick note on the tone, the first-run approach, and the mobile tradeoffs helps visitors decide whether they want sandbox mess or a cleaner action loop."
    )
    ValueBullets = @(
      "Makes it clear that this page is a sandbox action pick, not a linear challenge page.",
      "Warns new players that the game gets better once they secure mobility instead of picking a fight on foot immediately.",
      "Compares the page with tighter action alternatives so visitors can choose the right kind of chaos."
    )
    Tips = @(
      "Grab a vehicle early so you can control pace and escape routes instead of reacting on foot to every threat.",
      "Use the first minutes to test movement and map space before you escalate the chaos.",
      "If a run gets messy, reset your position first instead of trying to win every fight where it started."
    )
    Mistakes = @(
      "Picking the first fight on foot usually leaves you exposed before you understand the map or the controls.",
      "Chasing mayhem too quickly can turn the sandbox into noise before the game has become fun.",
      "Mobile players often lose camera control and situational awareness long before they lose health."
    )
    ControlsIntro = "Expect a more crowded action control layout than the simpler catalog pages. Movement, interaction, and vehicle handling all matter, so give yourself one relaxed test run before you start forcing action."
    MobileNote = "Dude Theft Auto is playable on mobile, but the screen gets busy quickly once movement, aiming, and driving overlap. Desktop is the better choice if you want cleaner camera control."
    SourceNote = "The current page uses a game.azgame.io source for the playable sandbox. Opening that frame gives the third-party host control over the embedded game environment and its own cookie or logging behavior."
    ComparisonNote = "Choose Dude Theft Auto when you want sandbox freedom and ragdoll-style chaos. If you want cleaner action timing with less interface clutter, Stickman Hook or Stickman War are more focused."
  }
  "astro-tycoon" = @{
    Standfirst = "Astro Tycoon is the strategy page in the maintained catalog, which means the value here is less about twitch tips and more about how to stabilize the early resource loop before the run sprawls out."
    OverviewParagraphs = @(
      "The game works when your first few decisions give you a sustainable economy instead of a flashy but fragile start. In browser strategy pages like this, one inefficient opening can echo through the entire session.",
      "That makes the page useful even before you play. A short note on pacing, resource priorities, and what kind of session to expect is more valuable than generic strategy buzzwords."
    )
    ValueBullets = @(
      "Frames the page around resource stability and planning instead of empty tycoon language.",
      "Helps visitors decide whether they want a longer build-up session or a faster arcade-style page.",
      "Adds a strategy option to the main catalog without pretending every page has the same pace."
    )
    Tips = @(
      "Stabilize your basic income loop before you spend heavily on expansion or flashy upgrades.",
      "Watch for bottlenecks that slow every future action, then fix those first.",
      "Use the first session to understand the economy rather than to chase the biggest build immediately."
    )
    Mistakes = @(
      "Expanding too early can leave the core economy too thin to recover from one bad decision.",
      "Ignoring idle production or dead travel time quietly drains the whole run.",
      "Buying upgrades without a simple plan often creates complexity without momentum."
    )
    ControlsIntro = "Strategy browser pages like Astro Tycoon are usually mouse-first with optional touch support. The important skill is sequencing decisions efficiently rather than learning complicated inputs."
    MobileNote = "The page is playable on mobile, but longer menus and smaller management targets are more comfortable on desktop if you plan to stay for a full session."
    SourceNote = "Astro Tycoon is currently embedded from gamea.azgame.io. If you open the iframe, that third-party host can apply its own cookies, storage, or analytics behavior."
    ComparisonNote = "Astro Tycoon is the right pick when you want a longer planning session. If you want a faster reset loop, switch back to 2048, Tetris, or one of the driving pages."
  }
  "wacky-nursery" = @{
    Standfirst = "Wacky Nursery is one of the stranger arcade pages in the catalog, so the useful part of this page is setting expectations: short loops, surprise timing, and a lot of value in paying attention to what changes after each retry."
    OverviewParagraphs = @(
      "This is not an endless high-score page built on pure speed. The fun usually comes from noticing odd interactions, reading the next beat of chaos earlier, and getting a little cleaner with each short repeat run.",
      "That makes it a good catalog closer because it offers a very different texture from the driving, puzzle, or swing-action pages while still staying compact enough for browser play."
    )
    ValueBullets = @(
      "Explains why the page is more about repeatable short loops than one long uninterrupted run.",
      "Encourages visitors to watch for interaction changes and timing cues instead of forcing speed immediately.",
      "Adds an arcade pick that feels distinct from the more conventional scoring or downhill pages."
    )
    Tips = @(
      "Use the first run to understand the room, timing, and surprise points before you try to optimize anything.",
      "When something odd happens, remember the trigger instead of assuming it was random.",
      "Short retries are the point here, so restart quickly and test one cleaner route at a time."
    )
    Mistakes = @(
      "Treating the page like a pure score chase can hide the interaction patterns that actually matter.",
      "Rushing past the first clue or timing cue usually causes the same repeat mistake again.",
      "Players often overreact to the chaos instead of slowing down and identifying the trigger."
    )
    ControlsIntro = "Expect a lightweight arcade control setup. The hard part is not the button count but noticing how the page changes around your actions and retry timing."
    MobileNote = "Wacky Nursery is readable on mobile, though the weird interaction cues are easier to catch on a larger screen. Desktop gives you a little more time to parse visual clutter."
    SourceNote = "The current playable build is loaded from game.azgame.io. As with the rest of the catalog, the third-party host controls the iframe environment once you open it."
    ComparisonNote = "Wacky Nursery is the pick for short chaotic loops and curiosity. If you want cleaner rhythm, Stickman Hook is more controlled. If you want pure downhill flow, stay with the driving pages."
  }
}

function Escape-Html {
  param([string]$Value)

  return [System.Net.WebUtility]::HtmlEncode([string]$Value)
}

function Write-Utf8File {
  param(
    [string]$Path,
    [string]$Content
  )

  $encoding = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

function Get-SourceHost {
  param([string]$Url)

  try {
    return ([System.Uri]$Url).Host -replace "^www\.", ""
  } catch {
    return "external source"
  }
}

function Get-Games {
  $raw = Get-Content (Join-Path $Root "games-data.js") -Raw
  $json = $raw -replace "^\s*window\.GAME_DATA\s*=\s*", "" -replace ";\s*$", ""
  return $json | ConvertFrom-Json
}

function Get-GamePath {
  param([string]$Slug)

  return "games/$Slug/"
}

function Get-RelativeGameHref {
  param([string]$Slug)

  return "../../games/$Slug/index.html"
}

function Get-CategoryDefaults {
  param(
    $Game,
    [string]$SourceHost
  )

  $title = [string]$Game.title
  $tagLower = ([string]$Game.tag).ToLowerInvariant()

  switch ([string]$Game.category) {
    "Driving" {
      return @{
        Standfirst = "$title is available here with direct browser play, source links, and a short guide to the control rhythm before you open the embed."
        OverviewParagraphs = @(
          "$title sits in the browser driving lane where timing and balance matter more than long race strategy. The $tagLower hook gives the page a clear identity even if the host version changes small presentation details over time.",
          "The page is most useful when you want to check the source, refresh the controls, and decide quickly whether this run is worth another retry."
        )
        ValueBullets = @(
          "Keeps the active embed URL visible instead of hiding the source inside the iframe.",
          "Summarizes the pace and the first skills new runs usually demand.",
          "Links back to stronger related pages in the maintained catalog once you finish this run."
        )
        Tips = @(
          "Use shorter throttle or steering inputs than your first instinct suggests.",
          "Read the next obstacle before you fully commit to the current one.",
          "If the run collapses, reset speed and balance before you chase a faster line."
        )
        Mistakes = @(
          "Overcommitting to speed too early removes any recovery buffer.",
          "Late corrections usually create a second mistake immediately after the first one.",
          "Mobile touch inputs feel harsher than quick keyboard taps on most driving pages."
        )
        ControlsIntro = "Most desktop versions use directional keys or a simple two-button setup, but the harder skill is controlling how long each input lasts."
        MobileNote = "Driving pages here are playable on mobile, but touch steering is usually less precise than desktop input. Landscape mode is the safer choice."
        SourceNote = "The playable version on this page loads from $SourceHost. Once the iframe opens, the third-party source can apply its own cookies, local storage, or technical identifiers."
        ComparisonNote = "If you still want another driving page after this one, use the related cards below to jump back into the stronger maintained routes."
      }
    }
    "Puzzle" {
      return @{
        Standfirst = "$title stays useful as a browser puzzle page when the surrounding notes help you avoid the same structural mistake on the next attempt."
        OverviewParagraphs = @(
          "$title works best when you treat it as a pattern or board-management problem instead of a race to move first. The $tagLower theme gives the puzzle its identity, but the real progress comes from cleaner decisions.",
          "That makes the page valuable even with the iframe hidden because the next successful run usually starts with a better plan, not with faster clicking."
        )
        ValueBullets = @(
          "Keeps the current source links visible before you open the embed.",
          "Turns the page toward solve habits, not generic puzzle filler.",
          "Makes it easier to choose between slower planning pages and faster reflex puzzles in the same catalog."
        )
        Tips = @(
          "Read the full board or setup before you make the first move.",
          "Protect future options instead of forcing one flashy short-term play.",
          "Retry quickly once the structure breaks so the next solve attempt stays fresh."
        )
        Mistakes = @(
          "Opening too quickly often hides the actual constraint that matters.",
          "One unnecessary move can remove the clean solution path from the rest of the board.",
          "Players often keep bad attempts alive too long instead of resetting and testing a cleaner idea."
        )
        ControlsIntro = "Puzzle controls are usually simple on both desktop and mobile. The real question is how deliberately you use them, not how many buttons the page has."
        MobileNote = "These puzzle pages usually work well on touch, though smaller screens make precise taps, drags, or swipes a little less forgiving."
        SourceNote = "The playable version is loaded from $SourceHost. Opening the frame means that host can apply its own cookies, local storage, and request logging."
        ComparisonNote = "If you finish this puzzle page and still want another, the related cards below keep you near the same general pace without bouncing you into unrelated genres."
      }
    }
    "Action" {
      return @{
        Standfirst = "$title is kept here as a browser action page with direct play, source disclosure, and enough notes to help you survive the rough first runs."
        OverviewParagraphs = @(
          "This kind of page works when the pressure is readable enough to improve through repetition. The $tagLower angle gives the action a clear flavor, but the fun still comes from better movement and cleaner reactions.",
          "The notes matter because action pages can look random when you do not yet know where the pressure actually starts building."
        )
        ValueBullets = @(
          "Shows the live source URLs before you commit to the iframe.",
          "Focuses the page on movement, timing, and survival choices instead of empty action keywords.",
          "Keeps the strongest action follow-ups close by when you want another short run after this one."
        )
        Tips = @(
          "Use the first moments of a run to read pressure instead of diving straight into it.",
          "Keep a clean escape route in mind before you take the next risk.",
          "Treat each restart as a chance to understand where the danger pattern begins."
        )
        Mistakes = @(
          "Overcommitting after one good opening usually removes the safest way out.",
          "Standing still for too long makes most action pages feel harder than they are.",
          "Mobile layouts often hide part of the play space once the screen gets busy."
        )
        ControlsIntro = "Action browser pages usually combine movement with one or two reaction inputs. The harder part is managing space under pressure, not memorizing the buttons."
        MobileNote = "Touch support exists on many action pages, but the smaller screen makes clutter and camera pressure harder to manage than on desktop."
        SourceNote = "This playable version comes from $SourceHost, and the third-party host can manage the embedded frame's own cookies, storage, or measurement once it loads."
        ComparisonNote = "If you want another action page after this one, the related cards below lean toward the cleaner maintained pages instead of random genre jumps."
      }
    }
    "Strategy" {
      return @{
        Standfirst = "$title is here as a longer browser strategy session, so the useful part of the page is setting expectations before you spend time inside the build loop."
        OverviewParagraphs = @(
          "Strategy pages live or die on whether the early decisions make sense. The $tagLower angle gives the run its theme, but progress still comes from efficient planning instead of from fast reactions.",
          "A short guide matters because the first fifteen minutes of a strategy page often decide whether the session feels readable or wasteful."
        )
        ValueBullets = @(
          "Clarifies that the page is a planning-heavy session rather than a quick arcade detour.",
          "Keeps the source and browser expectations visible before you start a longer run.",
          "Helps you choose between a build-up game and the faster retry loops elsewhere in the catalog."
        )
        Tips = @(
          "Stabilize the basic resource loop before chasing the largest upgrade or expansion.",
          "Fix the bottleneck that slows every other action instead of spreading resources too thin.",
          "Use the first session to understand pacing before you optimize it."
        )
        Mistakes = @(
          "Expanding too early can leave the whole economy fragile.",
          "Ignoring downtime or inefficient sequencing quietly drains the session.",
          "Players often add complexity before the core loop is stable."
        )
        ControlsIntro = "Strategy pages are usually mouse-first with optional touch support. The key skill is sequencing, not speed."
        MobileNote = "Longer menu-heavy pages are usually more comfortable on desktop, though touch support can still work for shorter sessions."
        SourceNote = "The playable version on this page loads from $SourceHost, which can apply its own cookies, local storage, or analytics after the iframe opens."
        ComparisonNote = "If you want a shorter loop after this session, the related catalog pages are much faster to restart than a strategy build-up run."
      }
    }
    default {
      return @{
        Standfirst = "$title is available here with direct browser play, source links, and a short note on how the session usually feels before you open the embed."
        OverviewParagraphs = @(
          "$title works best when the page stays focused on what the game actually asks from you instead of padding the screen with generic filler.",
          "The notes here are meant to help you decide quickly whether this is the right follow-up game for the next browser session."
        )
        ValueBullets = @(
          "Keeps the current source visible.",
          "Adds a short explanation of the pace and first-run experience.",
          "Links back to the stronger maintained pages once you are done."
        )
        Tips = @(
          "Use the first run to learn the pace before you chase a better score or cleaner result.",
          "Fix one repeat mistake at a time on the next attempt.",
          "Reset quickly when the current run stops teaching you anything useful."
        )
        Mistakes = @(
          "Trying to force speed before you understand the loop removes recovery room.",
          "Late reactions usually feel worse than slightly slower but earlier decisions.",
          "Touch controls often feel less forgiving than desktop inputs on the first few runs."
        )
        ControlsIntro = "The exact controls can vary by host, so the page focuses on what the game asks from you rather than pretending every version uses the same prompts."
        MobileNote = "Mobile support depends on the host version, but smaller screens usually make timing or precision a little harsher."
        SourceNote = "The embed on this page is served by $SourceHost, which can apply its own cookies or storage once the frame loads."
        ComparisonNote = "Use the related cards below if you want another maintained page with a similar pace after this one."
      }
    }
  }
}

function Get-GameNotes {
  param(
    $Game,
    [string]$SourceHost
  )

  $notes = Get-CategoryDefaults -Game $Game -SourceHost $SourceHost
  $slug = [string]$Game.slug

  if ($CuratedNotes.ContainsKey($slug)) {
    foreach ($key in $CuratedNotes[$slug].Keys) {
      $notes[$key] = $CuratedNotes[$slug][$key]
    }

    $notes["Indexable"] = $true
  } else {
    $notes["Indexable"] = $false
  }

  return $notes
}

function Render-ListItems {
  param([string[]]$Items)

  return ($Items | ForEach-Object { "                <li>$(Escape-Html $_)</li>" }) -join "`n"
}

function Get-IndexableGames {
  param($Games)

  return @(
    $Games | Where-Object {
      $CuratedNotes.ContainsKey([string]$_.slug)
    }
  )
}

function Get-RelatedGames {
  param(
    $CurrentGame,
    $IndexableGames
  )

  $sameCategory = @(
    $IndexableGames | Where-Object {
      [string]$_.slug -ne [string]$CurrentGame.slug -and
      [string]$_.category -eq [string]$CurrentGame.category
    }
  )

  $fallback = @(
    $IndexableGames | Where-Object {
      [string]$_.slug -ne [string]$CurrentGame.slug -and
      [string]$_.category -ne [string]$CurrentGame.category
    }
  )

  return @($sameCategory + $fallback | Select-Object -First 6)
}

function Render-RelatedCards {
  param($RelatedGames)

  return ($RelatedGames | ForEach-Object {
@"
          <a class="game-card" href="$(Get-RelativeGameHref -Slug ([string]$_.slug))">
            <img
              src="../../$(Escape-Html ([string]$_.thumbnail))"
              alt="$(Escape-Html ([string]$_.title)) thumbnail"
              loading="lazy"
              decoding="async"
            />
            <div class="card-body">
              <div class="card-copy">
                <h3>$(Escape-Html ([string]$_.title))</h3>
                <p>$(Escape-Html ([string]$_.category))</p>
              </div>
              <span class="card-tag">$(Escape-Html ([string]$_.tag))</span>
            </div>
          </a>
"@
  }) -join "`n"
}

function New-GameJsonLd {
  param(
    $Game,
    [string]$Canonical,
    [string]$Description
  )

  $graph = @(
    @{
      "@type" = "WebPage"
      "name" = "Play $([string]$Game.title) Online"
      "url" = $Canonical
      "inLanguage" = "en"
      "description" = $Description
      "isPartOf" = @{
        "@type" = "WebSite"
        "name" = $SiteBrand
        "url" = $SiteUrl
      }
    },
    @{
      "@type" = "VideoGame"
      "name" = [string]$Game.title
      "url" = $Canonical
      "description" = $Description
      "gamePlatform" = "Web Browser"
      "applicationCategory" = "Game"
      "playMode" = "SinglePlayer"
      "genre" = @([string]$Game.category, [string]$Game.tag)
      "image" = "$SiteUrl$([string]$Game.thumbnail)"
    },
    @{
      "@type" = "BreadcrumbList"
      "itemListElement" = @(
        @{
          "@type" = "ListItem"
          "position" = 1
          "name" = "Home"
          "item" = $SiteUrl
        },
        @{
          "@type" = "ListItem"
          "position" = 2
          "name" = [string]$Game.title
          "item" = $Canonical
        }
      )
    }
  )

  return (@{
    "@context" = "https://schema.org"
    "@graph" = $graph
  } | ConvertTo-Json -Compress -Depth 6)
}

function Build-GamePage {
  param(
    $Game,
    $Games,
    $IndexableGames
  )

  $title = [string]$Game.title
  $summary = [string]$Game.summary
  $sourceHost = Get-SourceHost -Url ([string]$Game.embedUrl)
  $notes = Get-GameNotes -Game $Game -SourceHost $sourceHost
  $isIndexable = [bool]$notes.Indexable
  $canonical = "$SiteUrl$(Get-GamePath -Slug ([string]$Game.slug))"
  $pageTitle = "Play $title Online | $SiteBrand"
  $description = "$summary Read the source links, quick tips, and browser notes on $SiteBrand."
  $sourcePageHref = if ([string]$Game.embedUrl -match "\.embed(?:[/?#]|$)") {
    ([string]$Game.embedUrl) -replace "\.embed(?=([/?#]|$))", ""
  } else {
    [string]$Game.embedUrl
  }
  $relatedGames = Get-RelatedGames -CurrentGame $Game -IndexableGames $IndexableGames
  $relatedCards = Render-RelatedCards -RelatedGames $relatedGames
  $relatedLead = if ($relatedGames.Count -gt 0) { [string]$relatedGames[0].title } else { "Drive Mad" }
  $valueItems = Render-ListItems -Items $notes.ValueBullets
  $tipItems = Render-ListItems -Items $notes.Tips
  $mistakeItems = Render-ListItems -Items $notes.Mistakes
  $jsonLd = New-GameJsonLd -Game $Game -Canonical $canonical -Description $description
  $chipOne = ($title + " online").ToLowerInvariant()
  $chipTwo = ([string]$Game.tag).ToLowerInvariant()
  $chipThree = (([string]$Game.category) + " browser game").ToLowerInvariant()
  $chipFour = $sourceHost.ToLowerInvariant()
  $robotsMeta = if ($isIndexable) { "" } else { '    <meta name="robots" content="noindex,follow" />' }
  $archiveNotice = if ($isIndexable) { "" } else {
@"
              <p>This page stays reachable for direct visitors, but it is not part of the maintained main catalog or sitemap right now.</p>
"@
  }

  return @"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>$(Escape-Html $pageTitle)</title>
    <meta
      name="description"
      content="$(Escape-Html $description)"
    />
$robotsMeta
    <meta name="theme-color" content="#f5f5f7" />
    <link rel="icon" type="image/svg+xml" href="../../favicon.svg" />
    <link rel="icon" type="image/png" href="../../assets/games/drive-mad.png" />
    <link rel="shortcut icon" href="../../favicon.svg" />
    <link rel="canonical" href="$canonical" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Sora:wght@500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <meta property="og:title" content="$(Escape-Html $pageTitle)" />
    <meta
      property="og:description"
      content="$(Escape-Html $description)"
    />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="$canonical" />
    <meta
      property="og:image"
      content="$SiteUrl$([string]$Game.thumbnail)"
    />
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="$(Escape-Html $pageTitle)" />
    <meta
      name="twitter:description"
      content="$(Escape-Html $description)"
    />
    <link rel="stylesheet" href="../../styles.css" />
    <script type="application/ld+json">$jsonLd</script>
  </head>
  <body>
    <a class="skip-link" href="#main-content">Skip to content</a>

    <header class="site-header">
      <div class="container topbar">
        <a class="brand" href="../../index.html" aria-label="$SiteBrand home">
          <span class="brand-mark">DM</span>
          <span class="brand-copy">
            <span class="brand-title">$SiteBrand</span>
            <span class="brand-subtitle">$(Escape-Html "$([string]$Game.category) game page")</span>
          </span>
        </a>

        <nav class="nav" aria-label="Primary">
          <a href="../../index.html">Home</a>
          <a href="../../index.html#play-online">Featured Game</a>
          <a href="../../index.html#all-games">Catalog</a>
          <a href="../../about.html">About</a>
          <a href="../../contact.html">Contact</a>
        </nav>
      </div>
    </header>

    <main id="main-content">
      <section class="page-hero">
        <div class="container">
          <a class="inline-link back-link" href="../../index.html#all-games">Back to main catalog</a>
          <span class="eyebrow">$(Escape-Html "$([string]$Game.category) game")</span>
          <h1>$(Escape-Html "Play $title Online")</h1>
          <p>$(Escape-Html $notes.Standfirst)</p>
          <div class="chip-row" aria-label="$(Escape-Html "$title page tags")">
            <span class="chip">$(Escape-Html $chipOne)</span>
            <span class="chip">$(Escape-Html $chipTwo)</span>
            <span class="chip">$(Escape-Html $chipThree)</span>
            <span class="chip">$(Escape-Html $chipFour)</span>
          </div>
        </div>
      </section>

      <section class="section" id="play-game">
        <div class="container embed-layout">
          <div class="play-stack">
            <div class="embed-shell">
              <div class="frame-wrap">
                <iframe
                  src="$(Escape-Html ([string]$Game.embedUrl))"
                  title="$(Escape-Html "Play $title Online")"
                  allow="autoplay; fullscreen; gamepad; clipboard-write; web-share"
                  loading="eager"
                  referrerpolicy="strict-origin-when-cross-origin"
                  allowfullscreen
                ></iframe>
              </div>
            </div>

            <div class="embed-access">
              <div class="embed-access-head">
                <h3>Embed and source links</h3>
$archiveNotice
                <p>This page keeps the live embed URL and the direct source page visible so you can inspect the host before or after you play.</p>
              </div>

              <div class="embed-link-list">
                <div class="embed-link-item">
                  <span class="embed-link-label">Embedded source URL</span>
                  <div class="embed-link-row">
                    <div class="embed-link-box" data-copy-value="$(Escape-Html ([string]$Game.embedUrl))">$(Escape-Html ([string]$Game.embedUrl))</div>
                    <button class="embed-link-button" type="button" data-copy-target="$(Escape-Html ([string]$Game.embedUrl))">Copy</button>
                    <a class="embed-link-button" href="$(Escape-Html ([string]$Game.embedUrl))" target="_blank" rel="noopener noreferrer">Open</a>
                  </div>
                </div>

                <div class="embed-link-item">
                  <span class="embed-link-label">Source page URL</span>
                  <div class="embed-link-row">
                    <div class="embed-link-box" data-copy-value="$(Escape-Html $sourcePageHref)">$(Escape-Html $sourcePageHref)</div>
                    <button class="embed-link-button" type="button" data-copy-target="$(Escape-Html $sourcePageHref)">Copy</button>
                    <a class="embed-link-button" href="$(Escape-Html $sourcePageHref)" target="_blank" rel="noopener noreferrer">Open</a>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <aside class="hero-panel" aria-label="$(Escape-Html "$title quick facts")">
            <h2>$(Escape-Html "$title quick facts")</h2>
            <p>$(Escape-Html $summary)</p>
            <div class="meta-list">
              <div class="meta-item"><span>Category</span><strong>$(Escape-Html ([string]$Game.category))</strong></div>
              <div class="meta-item"><span>Tag</span><strong>$(Escape-Html ([string]$Game.tag))</strong></div>
              <div class="meta-item"><span>Source</span><strong>$(Escape-Html $sourceHost)</strong></div>
              <div class="meta-item"><span>Catalog Status</span><strong>$(Escape-Html $(if ($isIndexable) { "Main catalog" } else { "Direct-access archive" }))</strong></div>
            </div>
            <div class="list-card">
              <h3>First things to do</h3>
              <ul>
$tipItems
              </ul>
            </div>
            <div class="hero-actions">
              <a class="button" href="$(Escape-Html ([string]$Game.embedUrl))" target="_blank" rel="noopener noreferrer"
                >Open source game</a
              >
              <a class="button-secondary" href="../../index.html#all-games">Browse more games</a>
            </div>
          </aside>
        </div>
      </section>

      <section class="section">
        <div class="container">
          <div class="section-head">
            <span class="section-label">Before You Play</span>
            <h2>$(Escape-Html "What to know before you open $title")</h2>
            <p class="section-copy">
              $(Escape-Html "This page stays focused on how $title plays, where the embed comes from, and what usually matters in the first few minutes.")
            </p>
          </div>

          <div class="panel-grid">
            <article class="panel">
              <h2>$(Escape-Html "Why this $title page is useful")</h2>
              <ul class="bullet-list">
$valueItems
              </ul>
            </article>

            <article class="panel">
              <h2>$(Escape-Html "How $title actually feels")</h2>
              <p>$(Escape-Html $notes.OverviewParagraphs[0])</p>
              <p>$(Escape-Html $notes.OverviewParagraphs[1])</p>
            </article>
          </div>

          <div class="panel-grid section-split">
            <article class="panel">
              <h2>$(Escape-Html "$title controls and start plan")</h2>
              <p>$(Escape-Html $notes.ControlsIntro)</p>
              <ul class="bullet-list">
$tipItems
              </ul>
            </article>

            <article class="panel">
              <h2>$(Escape-Html "Common mistakes in $title")</h2>
              <p>$(Escape-Html "Most frustrating runs in $title come from a short list of repeat errors rather than from hidden mechanics.")</p>
              <ul class="bullet-list">
$mistakeItems
              </ul>
            </article>
          </div>

          <div class="panel-grid section-split">
            <article class="panel">
              <h2>Mobile and browser notes</h2>
              <p>$(Escape-Html $notes.MobileNote)</p>
              <p>$(Escape-Html $notes.SourceNote)</p>
            </article>

            <article class="panel">
              <h2>$(Escape-Html "What to try after $title")</h2>
              <p>$(Escape-Html $notes.ComparisonNote)</p>
              <p>$(Escape-Html "If this page is not the right fit, $relatedLead is one of the closest maintained follow-ups still left in the main catalog.")</p>
            </article>
          </div>
        </div>
      </section>

      <section class="section">
        <div class="container">
          <div class="section-head">
            <span class="section-label">Related Games</span>
            <h2>$(Escape-Html "Try another maintained page after $title")</h2>
            <p class="section-copy">
              $(Escape-Html "These related links point to the pages still kept in the main catalog, with the closest same-category options shown first.")
            </p>
          </div>

          <div class="card-grid" aria-label="$(Escape-Html "Related games for $title")">
$relatedCards
          </div>
        </div>
      </section>

      <section class="section">
        <div class="container faq">
          <div class="section-head">
            <span class="section-label">FAQ</span>
            <h2>$(Escape-Html "$title FAQ")</h2>
          </div>

          <article class="faq-item">
            <h3>$(Escape-Html "Can you play $title in a browser without downloading anything?")</h3>
            <p>$(Escape-Html "Yes. This page embeds $title directly in the browser, so you can start without a separate download step.")</p>
          </article>

          <article class="faq-item">
            <h3>$(Escape-Html "What kind of game is ${title}?")</h3>
            <p>$(Escape-Html $notes.OverviewParagraphs[0])</p>
          </article>

          <article class="faq-item">
            <h3>$(Escape-Html "What usually trips new players up in ${title}?")</h3>
            <p>$(Escape-Html "$($notes.Mistakes[0]) $($notes.Mistakes[1])")</p>
          </article>

          <article class="faq-item">
            <h3>$(Escape-Html "What should you open after ${title}?")</h3>
            <p>$(Escape-Html "$relatedLead is one of the closest maintained follow-up pages right now. $($notes.ComparisonNote)")</p>
          </article>
        </div>
      </section>
    </main>

    <footer class="container site-footer">
      <div class="footer-grid">
        <div class="footer-copy">
          <strong>$SiteBrand</strong>
          <p>$(Escape-Html "$title page with source disclosure, original notes, and a curated follow-up path through the maintained catalog.")</p>
        </div>

        <nav class="footer-links" aria-label="Footer">
          <a href="../../index.html">Home</a>
          <a href="../../about.html">About</a>
          <a href="../../privacy-policy.html">Privacy Policy</a>
          <button class="footer-link-button" type="button" data-open-consent>
            Privacy Settings
          </button>
        </nav>
      </div>
    </footer>

    <script src="../../site.js"></script>
  </body>
</html>
"@
}

function Build-Sitemap {
  param($Games)

  $indexableGames = Get-IndexableGames -Games $Games
  $lastmod = Get-Date -Format "yyyy-MM-dd"
  $entries = @(
    @{ loc = $SiteUrl; changefreq = "weekly"; priority = "1.0" },
    @{ loc = "${SiteUrl}about.html"; changefreq = "monthly"; priority = "0.7" },
    @{ loc = "${SiteUrl}contact.html"; changefreq = "monthly"; priority = "0.7" },
    @{ loc = "${SiteUrl}privacy-policy.html"; changefreq = "monthly"; priority = "0.6" }
  )

  foreach ($game in $indexableGames) {
    $entries += @{
      loc = "$SiteUrl$(Get-GamePath -Slug ([string]$game.slug))"
      changefreq = "weekly"
      priority = "0.8"
    }
  }

  $lines = @(
    "<?xml version=""1.0"" encoding=""UTF-8""?>",
    "<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">"
  )

  foreach ($entry in $entries) {
    $lines += "  <url>"
    $lines += "    <loc>$($entry.loc)</loc>"
    $lines += "    <lastmod>$lastmod</lastmod>"
    $lines += "    <changefreq>$($entry.changefreq)</changefreq>"
    $lines += "    <priority>$($entry.priority)</priority>"
    $lines += "  </url>"
  }

  $lines += "</urlset>"
  return ($lines -join "`n")
}

$games = Get-Games
$indexableGames = Get-IndexableGames -Games $games
New-Item -ItemType Directory -Force -Path $GameOutputRoot | Out-Null

foreach ($game in $games) {
  $directory = Join-Path $GameOutputRoot ([string]$game.slug)
  New-Item -ItemType Directory -Force -Path $directory | Out-Null

  $content = Build-GamePage -Game $game -Games $games -IndexableGames $indexableGames
  Write-Utf8File -Path (Join-Path $directory "index.html") -Content $content
}

$sitemap = Build-Sitemap -Games $games
Write-Utf8File -Path (Join-Path $Root "sitemap.xml") -Content $sitemap

Write-Output "Generated $($games.Count) game pages in $GameOutputRoot and refreshed sitemap.xml."
