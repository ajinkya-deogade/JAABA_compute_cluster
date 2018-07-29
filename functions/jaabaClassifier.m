function [result] = jaabaClassifier(inputfile_xml, inputfile_csv, outputfolder, lab, classifierFiles, flag_landscape)
    warning('off','all')
    %     try
    result = 0;
    flag_landscape = str2double(flag_landscape);
    lab = str2double(lab);
    
    display('Converting RAW Data to kinData Format......');
    [~, ~, kinData_xml] = XML_to_KinData_Cluster(inputfile_xml, outputfolder, lab);

    display('Postprocessing kinData Format......');
    [~] = postProcess_kinData_XML(kinData_xml, outputfolder, inputfile_xml, flag_landscape);

    display('Converting kinData to JAABA-friendly format........');
    [~, ~, kinData] = JLight(inputfile_csv, outputfolder, lab);

    display('Computing Spines......');
    kinData_spine = computeSpine_kinData(kinData);
    
    display('Creating JAABA Trx Files......');
    outputfolder_trx = fullfile(outputfolder, 'TRX');
    if exist(outputfolder_trx,'dir') ~= 7
        mkdir(outputfolder_trx);
    end
    outputfolder_exp = createtrxhighresnospinecomputation_cluster(inputfile_csv(1:end-4), kinData_spine, outputfolder_trx);
    display('Computing JAABA Per Frame Features......');
    allperframefeatureshighres_cluster(outputfolder_exp);

    display('Using JAABA Detect......');
    [classifierinfo, allScores] = JAABADetect(outputfolder_exp, 'jabfiles', {classifierFiles});

    result = 1;

end