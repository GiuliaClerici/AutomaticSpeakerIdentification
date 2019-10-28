function[GMMdb] = learningErg(filenameErgodicoM, filenameErgodicoF, framesize, overlap, target_Fs, pef, mfcc_utili, filenameDB, M)

    coeffErgodicoM = acquisizioneFile(filenameErgodicoM, framesize, overlap, target_Fs, pef, mfcc_utili);
    GMMdb = learning(coeffErgodicoM, filenameDB, filenameErgodicoM, M);
    
    coeffErgodicoF = acquisizioneFile(filenameErgodicoF, framesize, overlap, target_Fs, pef, mfcc_utili);
    GMMdb = learning(coeffErgodicoF, filenameDB, filenameErgodicoF, M);
    
end