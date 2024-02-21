resource "helm_release" "argocd" {
  count = var.is_cluster_forge ? 1 : 0
  depends_on = [
    ovh_cloud_project_kube_nodepool.pool
  ]
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "6.2.1"

  set {
    name  = "redis-ha.enabled"
    value = true
  }
  set {
    name  = "controller.replicas"
    value = 1
  }
  set {
    name  = "server.autoscaling.enabled"
    value = true
  }
  set {
    name  = "server.autoscaling.minReplicas"
    value = 2
  }
  set {
    name  = "repoServer.autoscaling.enabled"
    value = true
  }
  set {
    name  = "repoServer.autoscaling.minReplicas"
    value = 2
  }
  set {
    name  = "applicationSet.replicas"
    value = 2
  }
}

