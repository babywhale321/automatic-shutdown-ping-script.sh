#Log file
$path = "internet-monitor.log"

#creates log file if it does not exsist
if(![System.IO.File]::Exists($path)){ New-Item internet-monitor.log }

While ($True){

#---First-stage---
    ping 9.9.9.9
    #Check the exit status
    if ($LASTEXITCODE -eq 0) {
    #Wait 60 seconds before continuing loop if successful
    Start-Sleep -Seconds 60 
    continue }
    #Log first stage failure then wait 60 seconds before continuing next stage
    else { echo "First stage has failed on $(Get-Date)" | Out-File -Append "internet-monitor.log" 
           Start-Sleep -Seconds 60

#---Second-stage---
        ping 1.1.1.1
        #Check the exit status
        if ($LASTEXITCODE -eq 0) {
        #Wait 60 seconds before continuing loop if successful
        Start-Sleep -Seconds 60 
        continue }
        #Log second stage failure then wait 60 seconds before continuing next stage
        else { echo "Second stage has failed on $(Get-Date)" | Out-File -Append "internet-monitor.log"
               Start-Sleep -Seconds 60

#---Third-stage---
            ping 8.8.8.8
            #Check the exit status
            if ($LASTEXITCODE -eq 0) {
            #Wait 60 seconds before continuing loop if successful
            Start-Sleep -Seconds 60 
            continue }
            #Log third stage failure then use shutdown command
            else { echo "Third stage has failed on $(Get-Date) initiating shutdown command" | Out-File -Append "internet-monitor.log"
            shutdown /s
            }
        }
    }
    
    
    
    }
