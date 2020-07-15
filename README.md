# EPICS PVA Gateway / Proxy `p2p` (deprecated!)

*`p2p` was supposed to be for PVA what `gateway` is for CA.*

As indicated in the table below, **p2p is deprecated**. Please use p4p's **pvagw** instead.

| *Comparison*       | CA Gateway     | p4p pvagw       | **pva2pva p2p** |
|--------------------|----------------|-----------------|-----------------|
| Target Protocol    | CA             | PVA             | PVA             |
| Executable         | `gateway`      | `pvagw`         | `p2p`           |
| Module / Extension | [ca-gateway][] | [pva2pva][]     | [p4p][]         |
| Dev Activity       | [🔗][dev cagw] | [🔗][dev pvagw] | [🔗][dev p2p]   |
| Status             | production     | production      | **deprecated**  |

The target protocol indicates:
* the [PV Access protocol][] in the case of *PVA* and
* the [Channel Access protocol][] in the case of *CA*.

Pre-built multi-arch images can be found on the Docker Hub:
<https://hub.docker.com/r/pklaus/p2p>

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

**Deprecation Notice**

When you start the application with an actual config file, you'll get the following notice:

```
Notice: This p2p gateway prototype has been superceded by the p4p.gw gateway
        which has exciting new features including granular access control,
        and status PVs including bandwidth usage reports.
        p2p is considered deprecated by its author, and will receive
        minimal maintainance effort going forward.
        Users are encouraged to migrate to p4p.gw.
        https://mdavidsaver.github.io/p4p/gw.html
```

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
[src]: https://github.com/epics-base/pva2pva/blob/master/p2pApp/gwmain.cpp#L68
[p4p]: https://github.com/mdavidsaver/p4p
[pvagw]: https://mdavidsaver.github.io/p4p/gw.html
[PV Access protocol]: https://github.com/epics-base/pvAccessCPP/wiki/protocol
[Channel Access protocol]: https://docs.epics-controls.org/en/latest/specs/ca_protocol.html
[dev cagw]: https://github.com/epics-extensions/ca-gateway/commits/master
[dev pvagw]: https://github.com/mdavidsaver/p4p/commits/master/src/p4p/gw.py
[dev p2p]: https://github.com/epics-base/pva2pva/commits/master/p2pApp
