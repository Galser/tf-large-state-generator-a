# Test of some executions for 10K resources

## Test suite, versions and sizing

Code used from repo : https://github.com/Galser/tf-large-state-generator-a

Software : TFE v202112-2 running on Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1064-gcp x86_64)
Agents : Binary exectuion mode , tfc-agent 1.0.2

Downloaded from URL : https://releases.hashicorp.com/tfc-agent/1.0.2/tfc-agent_1.0.2_linux_amd64.zip  

Google Cloud computing used, all instancs are of equal size for simplicty and to see the influence of 
backyround tasks and UI overhead : n1-standard-4 

Machine type n1-standard-4 - https://cloud.google.com/compute/docs/general-purpose-machines#n1-standard
CPU platform Intel Skylake
RAM : 15GB
CPU : 4 

TFE server running in **europe-west4**
 - 2 tf-agents in one pool - running in the same zone
 - 2 tf-agents in "Asia" pool running in DC in Osaka - **asia-northeast2**

Tests perfomed over course of 3 days Feb 16-Feb 18 2022, 


## Results for 10K resources `plan` and `apply`

- State size : 11Mb
- On average network usage goes to 67Mbit on agent in recevieng for freshly started agent; around 51 - sending 
- Aproximately 80% of 4 CPUs is used
- On 16GB RAM - there is still ~13Gb free memory
- Workspaces have Terrafomr 1.0.11 configured


Case A) Running code in TFE remote execution mode (e.g. execution in TFE server) :
==================================================================================

PLAN : 2 minutes, and 32 seconds

APPLY : 10 minutes, and 27 seconds


Case B) 2 TF agents in the same region/dc, Western Europe :
==================================================================================

PLAN  ---> 55 microseconds :
......................................................................
				          microseconds to download and unpack binaries
 				<1 second to download config
 				<1 second to init
 			   41 seconds - for plan itself
               10 seconds to upload JSON plan
                ~1 second to make and upload providers schamas   
 				~2 seconds - to persist FS to remote storage

APPLY ---> "3 minutes, and 41 seconds"

( From which apply itself took 3 minutes, and 38 seconds )


Case C) 2 TF agents, Asia-geo pool, against TFE in Western Europe
==================================================================================

PLAN ---> 9 minutes, and 42 seconds :
......................................................................
				          microseconds to download and unpack binaries
 				1 second to download config
 				5 seconds to init
 5 minutes, and 9 seconds - for plan itself
               16 seconds to upload JSON plan
                4 seconds to make and upload providers schamas   
 4 minutes, and 7 seconds - to persist FS to remote storage ( uploading blob winto Archivist )

 APPLY ---> "13 minutes, and 46 seconds"

( From which apply itself took 13 minutes, and 39 seconds )


# Short summary

 --------------------------------------------------------------------------+
 |        |     Local TFE    |      Agents closeby*  |   Agents far away   |
 +--------|------------------|-----------------------|---------------------|
 | plan   |    2m 32 seconds |        55 seconds     |    9 m 42 seconds   |
 | apply  |   10m 27 sceonds |     3m 41 seconds     |   13 m 46 seconds   |
 --------------------------------------------------------------------------+

  > * So - properly configured agents, that are located closeby - can actually be faster then TFE itself, probably due to the fact that they don't need to run UI  and don't need to parse JSON for display and workspace/Archivist overhead is absent

