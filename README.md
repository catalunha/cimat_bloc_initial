# cimat_bloc

Uma versão com StateMng usando bloc para o projeto cimat.

## Getting Started

catalunha@pop-os:~$ flutter create --project-name=cimat_bloc --org to.bope.cimat_bloc --platforms android,web ./cimat_bloc


# error
```
I/flutter ( 9234): ╭-- Parse Request
I/flutter ( 9234): curl -X GET -H 'user-agent: Flutter Parse SDK 4.0.0' -H 'X-Parse-Application-Id: S7QMm0nExKkUFbsIUGLsE5UcHD2O0B7cHssWpeMj' -H 'X-Parse-Session-Token: r:416666944ef93aae0afadb96a82abced' -H 'X-Parse-Client-Key: blOxPMjEgsNkfBBvZwufjmizCdcDLkDnMfBD4DIt' https://parseapi.back4app.com/classes/UserProfile?where=%7B%7D&order=-updatedAt&skip=-4&limit=2
I/flutter ( 9234):
I/flutter ( 9234):  https://parseapi.back4app.com/classes/UserProfile?where={}&order=-updatedAt&skip=-4&limit=2
I/flutter ( 9234): ╰--
D/EGL_emulation( 9234): app_time_stats: avg=6273.10ms min=6273.10ms max=6273.10ms count=1
I/flutter ( 9234): ╭-- Parse Response
I/flutter ( 9234): Class: UserProfile
I/flutter ( 9234): Function: ParseApiRQ.query
I/flutter ( 9234): Status Code: 1
I/flutter ( 9234): Type: InternalServerError
I/flutter ( 9234): Error: {ok: 0, code: 2, codeName: BadValue, name: MongoError}
I/flutter ( 9234): ╰--
```
No cimat_getx
```
I/flutter (18918): ╭-- Parse Request
I/flutter (18918): curl -X GET -H 'user-agent: Flutter Parse SDK 3.1.15' -H 'X-Parse-Application-Id: S7QMm0nExKkUFbsIUGLsE5UcHD2O0B7cHssWpeMj' -H 'X-Parse-Session-Token: r:a4160bb810cef5e8a53ce1c8453fc608' -H 'X-Parse-Client-Key: blOxPMjEgsNkfBBvZwufjmizCdcDLkDnMfBD4DIt' https://parseapi.back4app.com/classes/UserProfile?where=%7B%7D&order=-updatedAt&skip=0&limit=2
I/flutter (18918):
I/flutter (18918):  https://parseapi.back4app.com/classes/UserProfile?where={}&order=-updatedAt&skip=0&limit=2
I/flutter (18918): ╰--
D/EGL_emulation(18918): app_time_stats: avg=1053.25ms min=4.53ms max=4040.59ms count=4
I/flutter (18918): ╭-- Parse Response
I/flutter (18918): Class: UserProfile
I/flutter (18918): Function: ParseApiRQ.query
I/flutter (18918): Status Code: 200
I/flutter (18918): Payload: 
```