# Ore-Ore-WAF

A Web Application Framework Dedicated To Me.
===============



## INSTALLATION

Recommended environment : Plenv, cpanm, Carton


```
 $ git clone https://github.com/adokoy001/Ore-Ore-WAF.git
 $ cd Ore-Ore-WAF
 $ carton install
    or, if you do not use Carton
 $ cpanm --installdeps .

```

## RUN as develop

```
 $ ./command develop
   or
 $ carton exec ./command develop
```

## RUN as production

Recommended HTTP Server : Starman

```
 $ ./command production
   or
 $ carton exec ./command production
```



## STOP production

```
 $ ./command stop
```

