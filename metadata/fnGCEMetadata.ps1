function get-GceMetadata($project, $zone, $vm, $type)
{
    # Set your project as the default project for the gcloud command-line tool
    gcloud config set project $project

    # Retrieve the instance name and machine type of your VM
    $instanceName = gcloud compute instances describe $vm --zone $zone --format='get(name)'
    $machineType = gcloud compute instances describe $vm --zone $zone --format='get(machineType)'

    # Output the results
    Write-Host "Instance name: $instanceName"
    Write-Host "Machine type: $machineType"
    
    # get GCE instance details for the VM
    $instance = Get-GceInstance $vm -zone $zone
    Write-Host $instance.$type
}

get-GceMetadata "temporal-data-382411" "us-west4-b" "vm1" "machineType"