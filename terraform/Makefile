CD = [[ -d env/${ENV} ]] && cd env/${ENV}
ENV = $1

tfp:
	@${CD} && terraform plan

tfv:
	@${CD} && terraform validate

tfa:
	@${CD} && terraform apply

tfg:
	@${CD} && terraform get
