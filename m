From: Ali Bahar <ali@internetdog.org>
Subject: Config. tips sought: Serial-console garbles boot messages.
Date: Wed, 4 May 2011 12:21:06 +0800
Message-ID: <20110504042106.GA25237@internetdog.org>
Reply-To: ali@internetdog.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from msr9.hinet.net ([168.95.4.109]:50074 "EHLO msr9.hinet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356Ab1EDGQ1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 May 2011 02:16:27 -0400
Received: from suxbox.internetDog.org (220-141-34-152.dynamic.hinet.net [220.141.34.152])
	by msr9.hinet.net (8.14.2/8.14.2) with ESMTP id p444IbCa023280
	for <linux-serial@vger.kernel.org>; Wed, 4 May 2011 12:18:37 +0800 (CST)
Received: from ab by suxbox.internetDog.org with local (Exim 4.72)
	(envelope-from <ab@internetdog.org>)
	id 1QHTaE-0006bN-Ow
	for linux-serial@vger.kernel.org; Wed, 04 May 2011 12:21:06 +0800
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

would someone please be kind enough to point me in the right direction
for this!=20

Symptom:

- serial console grables all the boot messages, until just at/before
the log-in prompt. Then, if I reboot, the 'shutdown' messages continue
to be seen correctly until boot-up begins again.
Sample output is provided further down.

I expect that something basic is missing here, but this has already
sucked up too much of my time! So I'll be very grateful for any
pointers as to where I should look.

Additional info is provided below.

Thanks much,
Ali


Context:=20

- serial console is set up between two boxes.=20
- The boxes' on-board COM ports work fine in every respect.
- a new PCI card provides additional COM ports for one box. Serial
  console does not work with this. This is the problem.
- After extensive testing, the culprit hardware has been confirmed to
be the new PCI card. The cables and the peer COM ports have been as
verified as is sane to do! Ditto the kermit/minicom/cu configuration.

- the "serial" driver (8250_pci.c) mentions this card as supported,
but I do not know the extent of its supports. Its initialization
function, pci_netmos_init(), _is_ in System.map -- so it's built in!


Additional info:

- the PCI card provides 2 COM ports. It is
  03:02.0 Serial controller: NetMos Technology PCI 9865 Multi-I/O Contr=
oller
  (For the benefit of googlers, it is an Uptech/Upmost UT300 RS-232
  PCI card. Chip: MOSCHIP MCS9865. 16C550 UART.)
  It is a high-speed port, but I run it at 115200, and have even tried
  9600 baud.

- the kernel is a very recent 2.6.39-rc5-wl, wireless-testing.git.
- the kernel command-line includes
  console=3DttyS1,115200  console=3Dtty0

- getty does not work on this. Nor does any input.
  (I'd take this observation with a tiny grain of salt, because IIRC
  there was one scenario in which it may have worked.)

- /proc/tty/driver/serial shows no rx, but its tx count requires more
  testing by me.

- Remote-Serial-Console-HOWTO, Serial-HOWTO and
  Documentation/serial-console.txt have not been fruitful, so far.



Sample output:

The garbled 'text' is the entire set of boot messages!

[ 1105.856980] ehci_hcd 0000:00:1a.7: PCI INT C disabled
[ 1105.917787] PM: Calling i8259A_shutdown+0x0/0x10
[ 1105.973273] Restarting system.
[ 1106.009954] machine restart
=EF=BF=BDu6=EF=BF=BD'&'-D=EF=BF=BD'6DL5$=EF=BF=BDt=EF=BF=BD$=EF=BF=BD=EF=
=BF=BD=EF=BF=BDN=C5=A5=EF=BF=BD4.=E4=9E=8E=EF=BF=BD=EF=BF=BDUN=EF=BF=BD=
4%T=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDU5=EF=BF=BD%'=EF=BF=BD4e$=C4=A7N=
=C5=A5=EF=BF=BD5.D=EF=BF=BD=EF=BF=BDN=C5=A5=EF=BF=BD=EF=BF=BD=EF=BF=BDE=
46=EF=BF=BDe$=C4=AE=EF=BF=BD%7=EF=BF=BD4e$
<U+0527>6=EF=BF=BDd,\-=EF=BF=BD=EF=BF=BD=EF=BF=BDeMtnVm&6d=EF=BF=BDm&%7=
e=EF=BF=BD=E6=BC=8Dt$=D6=9E=EF=BF=BD&$M'6=EF=BF=BD$<=EF=BF=BDM&DD
'6=C4=8E=EF=BF=BD&$=EF=BF=BD=EF=BF=BD&6=EF=BF=BDF=CD=A4=EF=BF=BD,T=EF=BF=
=BD'6=EF=BF=BD6v~=EF=BF=BD&7~=EF=BF=BD-&E=EF=BF=BDm&%=EF=BF=BD=EF=BF=BD=
&6dFM=EF=BF=BDn&=EF=BF=BD=EF=BF=BD'=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD4T-=EF=BF=BDT
                                                          =EF=BF=BD6.=EF=
=BF=BDfD=EF=BF=BD&=EF=BF=BD=EF=BF=BDe$^V>=EF=BF=BDV=EF=BF=BD>=EF=BF=BD=EF=
=BF=BD=EF=BF=BDO<$Pf$.=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD%7=EF=
=BF=BDF%w=EF=BF=BD$mm<=EF=BF=BD=EF=BF=BD=EF=BF=BD=CE=A5=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD~=EF=BF=BD'n=EF=BF=BDGEd=EF=BF=BD.=EF=BF=BD=EF=BF=BDd=
=EF=BF=BD7v=EF=BF=BD6f=EF=BF=BDVf=EF=BF=BD6f=EF=BF=BD6D=EF=BF=BDE=EF=BF=
=BDd=EF=BF=BDFNF=EF=BF=BD6V&$d'4=EF=BF=BDd=EF=BF=BD=C6=A5=EF=BF=BD54=EF=
=BF=BD6=EF=BF=BD^e=EF=BF=BD4=EF=BF=BD$=EF=BF=BD=EF=BF=BD%=EF=BF=BD=EF=BF=
=BD=EF=BF=BDt=EF=BF=BD=EF=BF=BDd=EF=BF=BD%=EF=BF=BD=EF=BF=BD=EF=BF=BDF/=
=EF=BF=BD=EF=BF=BDd=3Dd=EF=BF=BD=EF=BF=BD>=EF=BF=BDDd$=EF=BF=BD=EF=BF=BD=
lN'&v-=EF=BF=BD/=EF=BF=BD|-=EF=BF=BD=EF=BF=BD=EF=BF=BD/=EF=BF=BD^O=C4=B6=
6D]6=EF=BF=BD=EF=BF=BD$D=EF=BF=BD>M4=EF=BF=BD}<&m'=EF=BF=BDo/D$mm|g=EF=BF=
=BD>4=EF=BF=BD=EF=BF=BD=EF=BF=BDDmm<=C7=A4=EF=BF=BD$w47=EF=BF=BDo=EF=BF=
=BD$=EF=BF=BDV$Lm=EF=BF=BD=EF=BF=BD|=3DtDdD=EF=BF=BD=EF=BF=BDdD'=EF=BF=BD=
$$=EF=BF=BDtf=3DV=EF=BF=BDl=EF=BF=BD6=EF=BF=BDw=EF=BF=BDD=EF=BF=BD=EF=BF=
=BD=EF=BF=BDD=EF=BF=BD,=EF=BF=BD5=EF=BF=BD=EF=BF=BD=EF=BF=BDt=EF=BF=BDD=
=EF=BF=BDd>4.=EF=BF=BDnDt=EF=BF=BD=EF=BF=BDd$=EF=BF=BDt$D=EF=BF=BD$=EF=BF=
=BD
&l$=EF=BF=BDmT$.F=EF=BF=BDmTDt=EF=BF=BD=EF=BF=BDd=EF=BF=BDd4=EF=BF=BDt4=
=EF=BF=BDd.T=EF=BF=BD=EF=BF=BDD=EF=BF=BD=EF=BF=BD<=EF=BF=BDe%/$%/&=EF=BF=
=BD=EF=BF=BD/4=EF=BF=BDn.Tm=EF=BF=BD=EF=BF=BD=EF=BF=BDeD
DDT=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD%=EF=BF=BD<=EF=BF=BDD=EF=
=BF=BD=EF=BF=BD<=EF=BF=BDg'?T%-=EF=BF=BD&eDMm<=C5=A5=EF=BF=BDd$MDt=EF=BF=
=BD=EF=BF=BD$%T>=EF=BF=BD%=EF=BF=BD>=C4=94d=EF=BF=BDmL.6.$%&\mm<=EF=BF=BD=
=EF=BF=BD=EF=BF=BDDDmt4=EF=BF=BD=EF=BF=BD=EF=BF=BD=C5=BC<=EF=BF=BD$t\=EF=
=BF=BD.dod<=EF=BF=BDg'/t=3D=EF=BF=BDf=EF=BF=BD.4=EF=BF=BDD=EF=BF=BD=EF=BF=
=BDT%tv%=EF=BF=BD%vF=EF=BF=BDf%=EF=BF=BD<$=EF=BF=BD<%=EF=BF=BD=EF=BF=BD=
,=EF=BF=BD=EF=BF=BD=EF=BF=BD$tv=EF=BF=BD'=EF=BF=BD$=EF=BF=BD4%T=EF=BF=BD=
E$=EF=BF=BDE46=EF=BF=BDE$=EF=BF=BD=EF=BF=BD=EF=BF=BD%=EF=BF=BD
                                                                      =EF=
=BF=BD4,=E4=94=A7N=C5=A5=EF=BF=BD=EF=BF=BD4.=E4=84=AE=EF=BF=BD%7=EF=BF=BD=
E$<U+E3AE>=EF=BF=BD=EF=BF=BD=EF=BF=BD4,=E4=A6=8C=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD46=EF=BF=BDE$=C4=AE=EF=BF=BD%7=EF=BF=BD5dd=EF=BF=BD=
=EF=BF=BD=EF=BF=BD%'=EF=BF=BD4e$=EF=BF=BDE46=EF=BF=BD5d$=EF=BF=BD=EF=BF=
=BD=EF=BF=BD6=EF=BF=BD=EF=BF=BDt=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=CE=
=A7L=C5=A5=EF=BF=BDT%.DEM%D=EF=BF=BDdt4V=E6=A6=B4=EF=BF=BD=EF=BF=BD=EF=BF=
=BD'=EF=BF=BDF=EF=BF=BD6L=EF=BF=BD4'=EF=BF=BD4=EF=BF=BDD=D6=AC=EF=BF=BD=
=EF=BF=BDml'$=DD=86=EF=BF=BDfL=EF=BF=BDL=EF=BF=BD=EF=BF=BD'=EF=BF=BD-=EF=
=BF=BDF-&=EF=BF=BD-=C4=B4M5=EF=BF=BDfn'&=EF=BF=BDD=EF=BF=BDD=EF=BF=BD=EF=
=BF=BDl
                                                       Nm=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD[
12.184356] sshd (1529): /proc/1529/oom_adj is deprecated, please use
/proc/1529/oom_score_adj instead.
[   13.930906] r8169 0000:02:00.0: eth0: link up
[   13.982514] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
