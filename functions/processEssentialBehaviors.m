function [kinData_xml] = processEssentialBehaviors(kinData_xml)
    
    [kinData_xml] = calculatePathLength(kinData_xml);
    [kinData_xml] = durationOfIndivRuns(kinData_xml);
    [kinData_xml] = extractFirstHeadCasts(kinData_xml);
    [kinData_xml] = extractOneCast(kinData_xml);
    [kinData_xml] = extractTwoCast(kinData_xml);
    [kinData_xml] = extractThreeCast(kinData_xml);
    [kinData_xml] = extractTurnPrevFirstHeadCast(kinData_xml);
    [kinData_xml] = extractTurnSucceedingFirstHeadCast(kinData_xml);
    [kinData_xml] = distanceConsecutiveTurns(kinData_xml);
    [kinData_xml] = distanceBetweenConsecutiveHeadCasts(kinData_xml);
    [kinData_xml] = timeBetweenConsecutiveHeadCasts(kinData_xml);
    [kinData_xml] = correlationPastVsPresentTurn(kinData_xml);
    [kinData_xml] = correlationFirstHeadCastVsPreviousTurn(kinData_xml);
    [kinData_xml] = correlationFirstHeadCastVsPresentTurn(kinData_xml);
    [kinData_xml] = extractNumberOfCastBeforeTurn(kinData_xml);
    [kinData_xml] = calculateProbabilityOfCastAcceptance(kinData_xml);
    [kinData_xml] = calculateFirstHeadCastProbability(kinData_xml);

end