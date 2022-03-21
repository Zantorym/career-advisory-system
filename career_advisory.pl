/*
  __  __       _          _____ _
 |  \/  |     (_)        / ____| |
 | \  / | __ _ _ _ __   | |    | | __ _ _   _ ___  ___
 | |\/| |/ _` | | '_ \  | |    | |/ _` | | | / __|/ _ \
 | |  | | (_| | | | | | | |____| | (_| | |_| \__ \  __/
 |_|  |_|\__,_|_|_| |_|  \_____|_|\__,_|\__,_|___/\___|
*/

% Run this clause (by typing "main.") while consulting the program to
% start the advisory system
main:-
    write('~~~~~Career Advisory System~~~~'), nl,
    write('You will be asked a series of questions regarding yourself...'), nl,
    write('Please answer accurately to the best of your abilities by selecting the most approriate option.'), nl,
    write('To select an option, type the number corresponding to it followed by "." '), nl,
    write('Good Luck!'), nl,
    retractall(user_info(_, _)), % Resets all the answers set by the user in a previous attempt, otherwise the program needs to be restarted everytime the user wants to re-attempt it.
    career(Potential_career). % Calling all the career clauses one by one and until a match is found.

% Makes it possible to update the database with facts provided by the
% user
:- dynamic(user_info/2). % user_info is used to store answers corresponding to each question asked to the user (stores question and corresponding answer)


/*
  _____     ______     _____ _
 |_   _|   / / __ \   / ____| |
   | |    / / |  | | | |    | | __ _ _   _ ___  ___  ___
   | |   / /| |  | | | |    | |/ _` | | | / __|/ _ \/ __|
  _| |_ / / | |__| | | |____| | (_| | |_| \__ \  __/\__ \
 |_____/_/   \____/   \_____|_|\__,_|\__,_|___/\___||___/
*/

% Take input from user, find element in list corresponding to input,
% store question and answer in user_info.
read_and_store(Ques, Desired_ans, Options) :-
  read(Input),
  find_in_list(Input, User_ans, Options),
  assert(user_info(Ques, User_ans)),
  User_ans = Desired_ans. % Fails if user's answer is not equal to the desired answer for the particular career the corresponding question is being asked

% Finds the list element corresponding the user's input, and stores it
% in User_ans.
find_in_list(Input, User_ans, [Head|Tail]) :-
  (Input = 1 -> User_ans = Head;
  (Mod_input is Input - 1,
  find_in_list(Mod_input, Tail, User_ans))).

% Pretty printing the options to a question by iterating through a list
% recursively
display_options([], _).
display_options([Head|Tail], I) :-
  J is I + 1,
  write(J), write('. '), option(Head), nl,
  display_options(Tail, J).


/*
   _____                            _____ _
  / ____|                          / ____| |
 | |     __ _ _ __ ___  ___ _ __  | |    | | __ _ _   _ ___  ___  ___
 | |    / _` | '__/ _ \/ _ \ '__| | |    | |/ _` | | | / __|/ _ \/ __|
 | |___| (_| | | |  __/  __/ |    | |____| | (_| | |_| \__ \  __/\__ \
  \_____\__,_|_|  \___|\___|_|     \_____|_|\__,_|\__,_|___/\___||___/

*/


% Each career clause calls on qualification clauses that determine
% whether the user satisfies the qualifications required to take
% that career path. If ALL the qualifications are satisfied, that career
% will be suggested to the user along with a justification for that
% choice.

% Academia related fields
career(researcher):-
    % Criteria
    gpa(v_high),
    patient(yes),
    theoretical_or_practical(theoretical),
    team_player(team),
    indoor_or_outdoor(indoor),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a researcher!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have a very high GPA, incidacting a high probability of doing well in an academic field.'), nl,
    write('2. You have the patience and determination required to be a quality researcher.'), nl,
    write('3. You prefer developing new theories/techniques/procedures and/or discovering new things over implementing existing things.'), nl,
    write('4. You are a team player. The ability to know your limitations and allow others to help you is crucial in the field of research.'), nl,
    write('5. You prefer working indoors over outdoors').

career(professor):-
    % Criteria
    gpa(v_high),
    like_teaching(yes),
    extrovert(yes),
    leader(yes),
    ya_or_children(ya),
    indoor_or_outdoor(indoor),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a university professor!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have a very high GPA, incidacting a high probability of doing well in an academic field.'), nl,
    write('2. You like spreading your knowledge to others and helping them learn, which aligns perfectly with the role of a professor.'), nl,
    write('3. You are comfortable talking in front of large groups of people for extended periods of time, which is essential for this profession.'), nl,
    write('4. You will be able to control a class full of students and will be effective in addressing their doubts and concerns.'), nl,
    write('5. You like teaching young adults, which are the primary demographic of college students.'), nl,
    write('6. You prefer working indoors over outdoors').

career(teacher):-
    % Criteria
    (gpa(v_high); gpa(decent)),
    like_teaching(yes),
    extrovert(yes),
    leader(yes),
    ya_or_children(children),
    indoor_or_outdoor(indoor),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a school teacher!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have a respectable GPA, incidacting a good probability of doing well in an academia-related field.'), nl,
    write('2. You like spreading your knowledge to others and helping them learn, which aligns perfectly with the role of a teacher.'), nl,
    write('3. You are comfortable talking in front of large groups of people for extended periods of time, which is essential for this profession.'), nl,
    write('4. You will be able to control a class full of students and will be effective in addressing their doubts and concerns.'), nl,
    write('5. You like teaching children and teenages, which are the primary demographic of school students.'), nl,
    write('6. You prefer working indoors over outdoors').

% Computer science related fields
career(data_sci_anal):-
    % Criteria
    (gpa(v_high); gpa(decent)),
    indoor_or_outdoor(indoor),
    math(yes),
    data(yes),
    creative(yes),
    computers(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a data scientist/analyst!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have a respectable GPA, indicating a good probability of having the ability to learn on to go, which is essential in a field such as this which is contantly evolving'), nl,
    write('2. You prefer working indoors on computers.'), nl,
    write('3. You are adept at mathematics and have the ability to make unique and useful inferences from data provided to you'), nl,
    write('4. You have the ability to think outside-the-box to develop unique and efficient solutions to problems.').

career(soft_eng):-
    % Criteria
    (gpa(v_high); gpa(decent)),
    indoor_or_outdoor(indoor),
    computers(yes),
    creative(yes),
    coding(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a software engineer!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have a respectable GPA, indicating a good probability of having the ability to learn on to go, which is essential in a field such as this which is contantly evolving'), nl,
    write('2. You prefer working indoors on computers and like coding computer programs.'), nl,
    write('3. You have the ability to think outside-the-box to develop unique and efficient solutions to problems.').

career(ui_ux_des):-
    % Criteria
    (gpa(v_high); gpa(decent)),
    indoor_or_outdoor(indoor),
    computers(yes),
    creative(yes),
    artistic(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a UI/UX designer!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have a respectable GPA, indicating a good probability of having the ability to learn on to go, which is essential in a field such as this which is contantly evolving'), nl,
    write('2. You prefer working indoors on computers.'), nl,
    write('3. You have the ability to think outside-the-box to develop unique and efficient solutions to problems.'), nl,
    write('4. You have an artistic sense.').

% Aero/astro fields
career(aero_eng):-
    % Criteria
    gpa(v_high),
    computers(yes),
    indoor_or_outdoor(indoor),
    math(yes),
    p_science(yes),
    aeronautics(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become an aeronautical engineer!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have an exceptionally high GPA, indicating you can grasp high-level concepts efficiently and have a high mental capacity.'), nl,
    write('2. You prefer working indoors on computers.'), nl,
    write('3. You are adept in maths.'), nl,
    write('4 You have a keen interest in physics and aeronautics').

career(astro_eng):-
    % Criteria
    gpa(v_high),
    computers(yes),
    indoor_or_outdoor(indoor),
    math(yes),
    p_science(yes),
    astronautics(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become an astronautical engineer!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You have an exceptionally high GPA, indicating you can grasp high-level concepts efficiently and have a high mental capacity.'), nl,
    write('2. You prefer working indoors on computers.'), nl,
    write('3. You are adept in maths.'), nl,
    write('4 You have a keen interest in physics and astronautics').

% Arts related fields
career(animator):-
    % Criteria
    artistic(yes),
    creative(yes),
    animation(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become an animator!'), nl,
    nl, write('You are artistic, creative, and have an interest in animation.').

career(musician):-
    % Criteria
    artistic(yes),
    creative(yes),
    (g_singing(yes), c_singing(yes); g_instrument(yes), c_instrument(yes)),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a musician!'), nl,
    nl, write('You are artistic, creative, and are musically talented.').

% Culinary fields
career(chef):-
    % Criteria
    leader(yes),
    team_player(team),
    cooking(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a chef!'), nl,
    nl, write('You have leadership qualities, you are willing to work in a team and you have culinary talent.').

career(cook):-
    % Criteria
    team_player(team),
    cooking(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a line cook!'), nl,
    nl, write('You are willing to work in a team and have culinary talent.').

% Military fields
career(air_force):-
    % Criteria
    team_player(team),
    disciplined(yes),
    physically_fit(yes),
    indoor_or_outdoor(outdoor),
    p_science(yes),
    aeronautics(yes),
    armed_forces(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become an air force pilot!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You are willing to work in a team.'), nl,
    write('2. You are disciplined and physcially fit.'), nl,
    write('3. You prefer working outdoors.'), nl,
    write('4. You have a keen interest in physics and aeronautics'), nl,
    write('5. You are willing to join the armed forces.').

career(navy):-
    % Criteria
    team_player(team),
    disciplined(yes),
    physically_fit(yes),
    indoor_or_outdoor(outdoor),
    p_science(yes),
    oceanography(yes),
    armed_forces(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a navy sailor!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You are willing to work in a team.'), nl,
    write('2. You are disciplined and physcially fit.'), nl,
    write('3. You prefer working outdoors.'), nl,
    write('4. You have a keen interest in physics and oceanography'), nl,
    write('5. You are willing to join the armed forces.').

career(army):-
    % Criteria
    team_player(team),
    disciplined(yes),
    physically_fit(yes),
    indoor_or_outdoor(outdoor),
    p_science(yes),
    armed_forces(yes),

    % If all the criteria are satisfied, our work is done and this career is reccommended with justification provided
    nl, write('You have great potential to become a army soilder!'), nl,
    nl, write('The reasons are as follows:'), nl,
    write('1. You are willing to work in a team.'), nl,
    write('2. You are disciplined and physcially fit.'), nl,
    write('3. You prefer working outdoors.'), nl,
    write('4. You are willing to join the armed forces.').

% Not a good fit for any of the careers considered by this program
career(sabbatical):-
    % If the user is not able to satisfy all the criteria of any one career, they are advised to take a sabbatical with justification provided
    nl, write('You have a diverse personality. A career could not be determined for you. We suggest taking a sabbatical to introspect and contemplate on what you want to do with your life.'), nl.

/*
   _____      _ _            _          _____ _
  / ____|    (_) |          (_)        / ____| |
 | |     _ __ _| |_ ___ _ __ _  __ _  | |    | | __ _ _   _ ___  ___  ___
 | |    | '__| | __/ _ \ '__| |/ _` | | |    | |/ _` | | | / __|/ _ \/ __|
 | |____| |  | | ||  __/ |  | | (_| | | |____| | (_| | |_| \__ \  __/\__ \
  \_____|_|  |_|\__\___|_|  |_|\__,_|  \_____|_|\__,_|\__,_|___/\___||___/
*/

gpa(Option) :-
  % If this question has already been answered, use the existing answer
    user_info(gpa, Option);(
  % If no answer exists for this question, go ahead with the question
  \+user_info(gpa, _),
  write('What is your GPA?'), nl,
  display_options([v_high, decent, low], 0),
  read_and_store(gpa, Option, [v_high, decent, low])).

patient(Option) :-
  % If this question has already been answered, use the existing answer
    user_info(patient, Option);(
  % If no answer exists for this question, go ahead with the question
  \+user_info(patient, _),
  write('Are you patient enough to work on the same project for years, even if it may not succeed in the end?'), nl,
  display_options([yes, no], 0),
  read_and_store(patient, Option, [yes, no])).

theoretical_or_practical(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(theoretical_or_practical, Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(theoretical_or_practical, _),
  write('Which of these are you more interested in?'), nl,
  display_options([theoretical, practical], 0),
  read_and_store(theoretical_or_practical, Option, [theoretical, practical])).

team_player(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(team_player , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(team_player , _),
  write('Which one of the two statements best describes you?'), nl,
  display_options([team, solo], 0),
  read_and_store(team_player, Option, [team, solo])).

like_teaching(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(like_teaching , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(like_teaching , _),
  write('Do you like spreading your knowledge to others and helping them learn?'), nl,
  display_options([yes, no], 0),
  read_and_store(like_teaching, Option, [yes, no])).

extrovert(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(extrovert , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(extrovert , _),
  write('Are you comfortable talking in front of large groups of people for extended periods of time?'), nl,
  display_options([yes, no], 0),
  read_and_store(extrovert, Option, [yes, no])).

leader(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(leader , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(leader , _),
  write('Do you have leadership qualities, i.e., the ability to control a group of people while remaining respectful of them and listening to/addressing their concerns aptly?'), nl,
  display_options([yes, no], 0),
  read_and_store(leader, Option, [yes, no])).

ya_or_children(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(ya_or_children , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(ya_or_children , _),
  write('Which would you prefer teaching more?'), nl,
  display_options([ya, children], 0),
  read_and_store(ya_or_children, Option, [ya, children])).

indoor_or_outdoor(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(indoor_or_outdoor , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(indoor_or_outdoor , _),
  write('Would you rather prefer a job where you have to work indoors or outdoors?'), nl,
  display_options([indoor, outdoor], 0),
  read_and_store(indoor_or_outdoor, Option, [indoor, outdoor])).

math(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(math , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(math , _),
  write('Are you adept at mathematics?'), nl,
  display_options([yes, no], 0),
  read_and_store(math, Option, [yes, no])).

data(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(data , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(data , _),
  write('Do you have the ability to make unique and useful inferences based on data provided to you?'), nl,
  display_options([yes, no], 0),
  read_and_store(data, Option,[yes, no])).

computers(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(computers , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(computers , _),
  write('Do you like working on computers?'), nl,
  display_options([yes, no], 0),
  read_and_store(computers, Option, [yes, no])).

creative(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(creative , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(creative , _),
  write('Can you think creatively/outside-the-box to generate unique and efficient solutions to problems?'), nl,
  display_options([yes, no], 0),
  read_and_store(creative, Option, [yes, no])).

coding(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(coding , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(coding , _),
  write('Do you like coding computer programs?'), nl,
  display_options([yes, no], 0),
  read_and_store(coding, Option, [yes, no])).

artistic(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(artistic , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(artistic , _),
  write('Do you have an artistic sense?'), nl,
  display_options([yes, no], 0),
  read_and_store(artistic, Option, [yes, no])).

p_science(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(p_science , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(p_science , _),
  write('Do you have a keen interest in physics?'), nl,
  display_options([yes, no], 0),
  read_and_store(p_science, Option, [yes, no])).

aeronautics(Option) :-
    % If this question has already been answered
    user_info(aeronautics , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(aeronautics , _),
  write('Are you interested in aeronautics?'), nl,
  display_options([yes, no], 0),
  read_and_store(aeronautics, Option, [yes, no])).

astronautics(Option) :-
    % If this question has already been answered
    user_info(astronautics , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(astronautics , _),
  write('Are you interested in astronautics?'), nl,
  display_options([yes, no], 0),
  read_and_store(astronautics, Option,[yes, no])).

animation(Option) :-
    % If this question has already been answered
    user_info(animation , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(animation , _),
  write('Are you interested in animation?'), nl,
  display_options([yes, no], 0),
  read_and_store(animation, Option, [yes, no])).

g_singing(Option) :-
    % If this question has already been answered
    user_info(g_singing , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(g_singing , _),
  write('Are you good at singing?'), nl,
  display_options([yes, no], 0),
  read_and_store(g_singing, Option, [yes, no])).

c_singing(Option) :-
    % If this question has already been answered
    user_info(c_singing , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(c_singing , _),
  write('Would you like to pursue a career in singing?'), nl,
  display_options([yes, no], 0),
  read_and_store(c_singing, Option, [yes, no])).

g_instrument(Option) :-
    % If this question has already been answered
    user_info(g_instrument , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(g_instrument , _),
  write('Are you good at any musical instrument?'), nl,
  display_options([yes, no], 0),
  read_and_store(g_instrument, Option, [yes, no])).

c_instrument(Option) :-
    % If this question has already been answered
    user_info(c_instrument , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(c_instrument , _),
  write('Would you like to pursue a career as a musician who plays that instrument?'), nl,
  display_options([yes, no], 0),
  read_and_store(c_instrument, Option, [yes, no])).

cooking(Option) :-
    % If this question has already been answered
    user_info(cooking , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(cooking , _),
  write('Do you have a lot of culinary experience/are you good at cooking?'), nl,
  display_options([yes, no], 0),
  read_and_store(cooking, Option, [yes, no])).

disciplined(Option) :-
    % If this question has already been answered
    user_info(disciplined , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(disciplined , _),
  write('Do you considered yourself to be disciplined?'), nl,
  display_options([yes, no], 0),
  read_and_store(disciplined, Option, [yes, no])).

physically_fit(Option) :-
    % If this question has already been answered
    user_info(physically_fit , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(physically_fit , _),
  write('Are you physically fit?'), nl,
  display_options([yes, no], 0),
  read_and_store(physically_fit, Option, [yes, no])).

armed_forces(Option) :-
    % If this question has already been answered
    user_info(armed_forces , Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(armed_forces , _),
  write('Are you willing to join the armed forces?'), nl,
  display_options([yes, no], 0),
  read_and_store(armed_forces, Option, [yes, no])).

oceanography(Option) :-
    % If this question has already been answered, use the existing answer
    user_info(oceanography, Option); (
  % If no answer exists for this question, go ahead with the question
  \+user_info(oceanography, _),
  write(''), nl,
  display_options([yes, no], 0),
  read_and_store(oceanography, Option, [yes, no])).


% Clauses to convert options for questions into readable version that
% can be displayed to the user
option(v_high):- write('9+').
option(decent):- write('6+').
option(low):- write('<6').

option(yes):- write('Yes').
option(no):- write('No').

option(theoretical):- write('Theoretical work that involves developing new techniques/procedures/theories and/or discovering new things.').
option(practical):- write('Practical work that implements existing techniques/procedures/theories.').

option(team):- write('I enjoy working in teams and collaborating with other to reach a collective goal.').
option(solo):- write('I am a lone wolf and prefer doing things solo.').

option(ya):- write('Young adults (18 - 26 years old)').
option(children):- write('Children/Teenages (5-17 years old)').

option(indoor):- write('Indoors').
option(outdoor):- write('Outdoors').






















