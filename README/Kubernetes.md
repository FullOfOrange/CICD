# Kubernetes

## 용어 설명

### Object

하나의 의도를 담은 레코드이다. Object를 생성하면 쿠버는 이 Object의 생성을 위해 동작한다.
오브젝트는 kubernetes에서 json 형태로 변경되어 실행된다.

요구되는 필드는 아래와 같으며 각각의 Object 에 따라 다른 값이 요구된다.

```
apiVersion //오브젝트를 생성하기 위해 사용되는 kubernetes 버전
kind // 어떤 종류의 오브젝트인지
metadata // 이름, UID, namespace 등의 오브젝트를 구분지어줄 데이터
spec // 오브젝트에 대해 의도한 상태가 무엇인지
```

### Pod

어플리케이션의 기본 실행 단위. 클러스터에서 실행되는 프로세스를 의미하기도 한다.
Pod 는 App containers, 저장소, 네트워크, 그리고 Container들의 실행에 필요한 옵션들을 캡슐화 한 배포의 단위이다.

아래에는 몇가지 쿠버 pod에 대한 활용 사례이다.
https://kubernetes.io/blog/2015/06/the-distributed-system-toolkit-patterns - 복합 Container를 위한 패턴
 https://kubernetes.io/blog/2016/06/container-design-patterns - Container 디자인 패턴

Pod에는 대체로 하나의 Container만 들어있는게 일반적이지만, 강한 결합성을 가진 Container들을 하나의 Pod안에서 실행될 수도 있다.

Pod 내의 Container들은 네트워크와 저장소를 공유한다. 마치 하나의 컴퓨터 내에서 실행되는 프로세스들 처럼 두가지를 공유한다

- 네트워킹 : 각각의 Pod 는 유일한 IP를 할당받고, 그 내부의 모든 Container 들은 네트워크의 namespace와 ip, ports를 공유한다. 파드안의 컨테이너는 다른 컨테이너와 localhost로 통신도 가능하다. 
- 저장소 : 파드는 공유 저장소 집합인 Volumn을 명시할 수 있다. Pod 내의 모든 Container 는 공유 볼륨에 접근이 가능하다. 또한 파드 내의 Container 가 재시작되어야 하는 경우에도 이 Volumn이 데이터를 연속되게 해줄 수 있다.

Pod는 Node 에서 동작하는데, 프로세스가 종료되거나, 리소스부족으로 인해 제거되거나 노드에 장애가 없는 한 노드에 남아있다.
단 Pod는 장애를 스스로 치료하지 않는다. 파드는 어떠한 장애가 발생하던 프로세스를 유지하지 못하게 되면 삭제되기에  Controller 라고 하는 고수준의 인스턴스 관리 작업을 하는 친구를 만든다.

**Template**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo 안녕하세요 쿠버네티스! && sleep 3600']
```

위와 같은 템플릿을 가지고 명세를 만들어서 파드를 디플로이한다. (아까 말했던 필수품들이 다 들어가있다.)

**종료**

Pod 는 종료 단계를 가지고 있다. 정확히 말하면 Kill 로 죽이는 것과 대조적으로 종료 프로세스를 가질 수 있다는 것이다. 

- 사용자가 Pod에게 삭제 명령을 내리면, 다음과 같은 종료 단계를 수행한다.
  1. Pod의 Container 내부에 preStop hook 이 정의되어 있다면 이것이 실행된다. (유예기간 내에)
  2. Pod의 모든 프로세스에 TERM 시그널이 전달된다. 모든 컨테이너가 동일한 시그널을 받기에 만약 먼저 꺼져야 하는 컨테이너가 내부에 있다면 1 의 단계에서 수행하도록 해야한다.
  3. 위의 단계와 동시에 서비스의 목록에서 제거되며 더이상 컨트롤러가 Pod를 생각하지 않는다. (트래픽이 가질 않는다.)
  4. 2의 유예기간이 만료되면 모든 프로세스에게 SIGKILL 로 종료를 시킨다.

**특권**

특권모드라는 것이 있는데, 이것은 리눅스엣