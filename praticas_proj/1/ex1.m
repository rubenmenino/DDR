%% 1a)
percentage = 0.6;
numberOfQuestions = 4;
right_answer = percentage + (1 - percentage) * (1/numberOfQuestions)

%% 1b)
percentageB = 0.7;
numberOfQuestionsB = 5;
right_answerB = percentageB + (1 - percentageB) * (1/numberOfQuestionsB);
probConditionalB = (1 * percentageB) / right_answerB

%% 1c)
percentage = linspace(0, 100, 51)
numberOfQuestionsC_3 = 3;
numberOfQuestionsC_4 = 4;
numberOfQuestionsC_5 = 5;
right_answer_3 = 100 .* (percentage .* 0.01 + (1 - percentage .* 0.01) * (1/numberOfQuestionsC_3));
right_answer_4 = 100 .* (percentage .* 0.01 + (1 - percentage .* 0.01) * (1/numberOfQuestionsC_4));
right_answer_5 = 100 .* (percentage .* 0.01 + (1 - percentage .* 0.01) * (1/numberOfQuestionsC_5));
plot(percentage,right_answer_3,'b-',percentage, right_answer_4,'b--',percentage, right_answer_5,'b:')


grid on
ylim([0 100])
title('Probability of right answer (%)')
xlabel('p (%)')
legend('n=3', 'n=4', 'n=5', 'location', 'northwest')

%% 1d

percentage = linspace(0, 100, 51)
numberOfQuestionsC_3 = 3;
numberOfQuestionsC_4 = 4;
numberOfQuestionsC_5 = 5;
right_answer_3 = 100 .* ((1 * percentage .* 0.01) ./ ( (percentage .* 0.01 + (1 - percentage .* 0.01) * (1/numberOfQuestionsC_3))));
right_answer_4 = 100 .* ((1 * percentage .* 0.01) ./ ( (percentage .* 0.01 + (1 - percentage .* 0.01) * (1/numberOfQuestionsC_4))));
right_answer_5 = 100 .* ((1 * percentage .* 0.01) ./ ( (percentage .* 0.01 + (1 - percentage .* 0.01) * (1/numberOfQuestionsC_5))));
plot(percentage,right_answer_3,'b-',percentage, right_answer_4,'b--',percentage, right_answer_5,'b:')

grid on
ylim([0 100])
title('Probability of right answer (%)')
xlabel('p (%)')
legend('n=3', 'n=4', 'n=5', 'location', 'northwest')


