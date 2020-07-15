# EPICS PVA Gateway / Proxy `p2p`

`p2p` is for PVA what `gateway` is for CA:

| *Comparison*       | PVA         | CA             |
|--------------------|-------------|----------------|
| Executable         | `p2p`       | `gateway`      |
| Module / Extension | [pva2pva][] | [ca-gateway][] |

**Note**: There's also a PVA gateway from the Python package [p4p][] called [pvagw][]
which seems [quite a bit more in development](https://github.com/mdavidsaver/p4p/commits/master/src/p4p/gw.py).

## Synopsis

```
$ p2p -h
Usage: p2p [-vhiIC] <config file>
```

* `-v`: verbose
* `-h`: help (very scarce)
* `-i`: interactive no
* `-I`: interactive yes
* `-C`: check only
* `-q`: quiet (found in [src][]

## Example

This is the loopback example mentioned in the [pva2pva README][]:


```json
{
  "version":1,
  "readOnly":false,
  "clients":[
    {
      "name":"theclient",
      "provider":"pva",
      "addrlist":"127.0.0.1 127.255.255.255",
      "autoaddrlist":false,
      "serverport":5085,
      "bcastport":5086
    }
  ],
  "servers":[
    {
      "name":"theserver",
      "clients":["theclient"],
      "interface":"127.0.0.1",
      "addrlist":"127.255.255.255",
      "autoaddrlist":false,
      "serverport":5075,
      "bcastport":5076
    }
  ]
}
```

[pva2pva]: https://github.com/epics-base/pva2pva
[ca-gateway]: https://github.com/epics-extensions/ca-gateway
[pva2pva README]: https://github.com/epics-base/pva2pva#running-p2p
[pvagw]: https://mdavidsaver.github.io/p4p/gw.html
[src]: https://github.com/epics-base/pva2pva/blob/master/p2pApp/gwmain.cpp#L68
