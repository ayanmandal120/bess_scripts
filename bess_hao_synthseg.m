function bess_hao_synthseg(subject)

system(['mkdir subjects/',subject]);
cd(['subjects/',subject]);
path2bgd = '/cbica/projects/bgdimagecentral/';
path2subject = [path2bgd, 'Data/hao_data/',subject];
folders = dir([path2subject, '/session_*']);
sessions = {folders.name};

for ii = 1:length(sessions)
    system(['mkdir ',sessions{ii}]);
    cd(sessions{ii});
    system(['cp ',path2subject,'/',sessions{ii},'/',subject,'*_T1w.nii.gz T1w.nii.gz']);
    
    
    % reorient, deface, and skull strip
    
    system('fslreorient2std T1w T1w');
    system('mri_deface T1w.nii.gz /cbica/projects/bgdimagecentral/templates/talairach_mixed_with_skull.gca /cbica/projects/bgdimagecentral/templates/face.gca T1w_defaced.nii.gz');
    system('bet T1w_defaced T1w_brain -A');
    

    % segmentation
    system([path2bgd, 'Projects/synthseg_job_code/jobSynthSeg.sh  ', pwd, '/T1w_defaced.nii.gz ', pwd, '/synthseg_output']); % is the full path needed if the files are in the current directory?
    
cd('..')
end

end
