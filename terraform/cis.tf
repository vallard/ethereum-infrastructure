variable "image" { default = "CoreOS" }
variable "count" { default = 4 }
variable "key_name" { default = "ethkey" }
variable "public_key_file" { default = "../Packer/packerKey.pub" }
/* the image that was built by packer */ 
variable "image_name" { default = "ethereum" }
variable "flavor_name" { default = "CO3-Medium" }
variable "network_id" { default = "551afb90-b9bc-416f-8526-6637da42aa06" }
variable "security_groups" { default = "default" }
variable "network_name" { default = "Toms-Private_Network" }


/* Using all environment variables to make this work.  
 You should have: 
  OS_REGION_NAME
  OS_TENANT_ID
  OS_PASSWORD
  OS_AUTH_URL
  OS_USERNAME
  OS_TENANT_NAME
*/
provider "openstack" {
  # Uses environment variables
}


resource "openstack_compute_keypair_v2" "keypair" {
  name = "${ var.key_name }"
  public_key = "${ file(var.public_key_file) }"
}

resource "openstack_compute_instance_v2" "ethnode" {
  name = "ethereum-${ format("%02d", count.index+1) }"
  key_pair = "${ var.key_name }"
  image_name = "${ var.image_name }"
  flavor_name = "${ var.flavor_name }"
  security_groups = [ "${ var.security_groups}" ]
  network =  {  name = "${ var.network_name }" }
  count = "${ var.count }"
  user_data = "${file("startmining.sh")}"
}
