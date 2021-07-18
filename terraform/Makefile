CD = [[ -d env/${ENV} ]] && cd env/${ENV}
ENV = $1

tfi:
	@${CD} && terraform init

tfp:
	@${CD} && terraform plan

tfv:
	@${CD} && terraform validate

tfa:
	@${CD} && terraform apply

tfg:
	@${CD} && terraform get
