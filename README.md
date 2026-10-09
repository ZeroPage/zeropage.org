# ZeroPage Docker

zeropage.org 서버를 띄우는 저장소다. 새 운영 스택의 compose 파일, Dockerfile, 서비스 설정은 [ZeroPage/zeropage-platform](https://github.com/ZeroPage/zeropage-platform)의 `deploy/`에 있다. 이 저장소는 그 저장소를 `platform/` 서브모듈로 가리킨다(비공개 저장소라 접근 권한이 필요하다).

| 위치 | 내용 |
| --- | --- |
| `platform/` | zeropage-platform 서브모듈. 실행·갱신·재구축 안내는 [`platform/deploy/OPERATIONS.md`](https://github.com/ZeroPage/zeropage-platform/blob/main/deploy/OPERATIONS.md) |
| `legacy/` | 이관 전 서버(traefik, XpressEngine, MoniWiki, Mattermost 9.11, MediaWiki·Keycloak on MySQL 등)의 compose와 Dockerfile. 기록용이며 새 스택에서는 쓰지 않는다 |

## 새 스택 띄우기

```sh
git clone --recurse-submodules git@github.com:ZeroPage/zeropage.org.git
cd zeropage.org/platform/deploy
bin/init-env.sh --no-local-ca      # deploy/.env 와 deploy/secrets/ 를 만든다(git에 넣지 않는다). 주소·SMTP·Turnstile·GitHub 값을 채운다
docker compose -f compose.yml build
docker compose -f compose.yml up -d
```

- 서비스: Caddy(TLS) · PostgreSQL · Keycloak · 새 사이트(api, web) · Mattermost(패치 빌드) · mm-bridge · MediaWiki · MoniWiki(읽기 전용) · backup
- 설정값 목록: `platform/deploy/.env.example`
- 데이터 이관: `platform/deploy/MIGRATION-RUNBOOK.md`
- 백업 정책: `platform/docs/BACKUP-PLAN.md`

## 새 버전으로 갱신

```sh
git pull --recurse-submodules
git submodule update --remote platform   # zeropage-platform 최신 커밋으로 올릴 때(그 뒤 이 저장소에 커밋)
cd platform/deploy
docker compose -f compose.yml build <서비스>
docker compose -f compose.yml up -d --no-deps <서비스>
```
