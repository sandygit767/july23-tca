vpc_cidr = "10.20.0.0/16"
ingress_rules = {
    "1" = {
      port  = 22
      cidrs = ["49.207.196.15/32"]
    },
    "2" = {
      port  = 443
      cidrs = ["0.0.0.0/0"]
    },
    "3" = {
      port  = 3389
      cidrs = ["0.0.0.0/0"]
    },
    "4" = {
      port  = 80
      cidrs = ["0.0.0.0/0"]
  }
  }
