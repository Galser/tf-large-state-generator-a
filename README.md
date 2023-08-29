# tf-large-state-generator-a

Repo that generates a large state in Terraform. Option A. Code creates "random_pets"+"random_string" resources 
and 3 counters that can be changed to adjust size and potential CPU load of plan/apply.


Initial purpose was to test the modes of execution in TFE

## How to use ?

1. Clone the repo
2. There are 3 main variables in code that can be adjusted to suit your tests :
	
	- string_length - length of the string to be generated
	- pet_words - count of words used in pet name
    - pets_count - amount of pet resoruce and strings to generate, be aware that
	  end result be doubled. E.g. if you set it to 1000 will have  1000 `random_pets` and 1000 `random_string`
3. Run plan/apply



## Examples

Sub-folder examples contains some reports of using the code with screenshots and logs. 

[TFE v20212-2 10K resources test with agents and without.](https://github.com/Galser/tf-large-state-generator-a/blob/main/examples/TFE_v202112-2_on_gcp_5k_and_10k_resources/readme.md)
