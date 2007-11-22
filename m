From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Oops in 8250 serial driver after unregistering port
Date: Thu, 22 Nov 2007 17:48:52 +0100
Message-ID: <200711221748.55524.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1733509.ObHS3O53EO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:43850 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751607AbXKVQtD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Nov 2007 11:49:03 -0500
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 3ACBD4D41
	for <linux-serial@vger.kernel.org>; Thu, 22 Nov 2007 17:48:56 +0100 (CET)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz [192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 1C4B444C2
	for <linux-serial@vger.kernel.org>; Thu, 22 Nov 2007 17:48:56 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--nextPart1733509.ObHS3O53EO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I experienced the following oops when trying to read data from ttyS0 after=
=20
deregistering the port by removing the associated driver.

Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: c0177ef4 LR: c012d278 CTR: c012d250
REGS: c3897cf0 TRAP: 0300   Not tainted  (2.6.23-gd2581171-dirty)
MSR: 00009032 <EE,ME,IR,DR>  CR: 48004222  XER: 20000000
DAR: 0000001c, DSISR: 20000000
TASK =3D c385a830[908] 'cat' THREAD: c3896000
GPR00: 00000020 c3897da0 c385a830 00000000 00000000 00000003 000000bf 00000=
000
GPR08: 00000202 c3c989d3 00000003 c3c98a08 48004224 10067024 03ff2000 00000=
001
GPR16: ffffffff 007fff00 00000000 00000000 00000000 1006262c 7fd5b808 10062=
644
GPR24: 00000000 00000000 00000000 c0344018 00000000 000000bf c02af6f8 00000=
003
NIP [c0177ef4] tbox_bus_write_reg+0x0/0x1c
LR [c012d278] serial_out+0x74/0x160
Call Trace:
[c3897da0] [00009032] 0x9032 (unreliable)
[c3897dc0] [c012f340] serial8250_pm+0xe0/0x12c
[c3897de0] [c012b7d4] uart_change_pm+0x58/0x5c
[c3897df0] [c012ba68] uart_close+0x17c/0x238
[c3897e10] [c0122324] release_dev+0x600/0x6c0
[c3897ec0] [c0122404] tty_release+0x20/0x3c
[c3897ee0] [c0065ea0] __fput+0x198/0x1b8
[c3897f00] [c0063eac] filp_close+0x54/0xac
[c3897f20] [c0063fa8] sys_close+0xa4/0x128
[c3897f40] [c000409c] ret_from_syscall+0x0/0x38
Instruction dump:
4bfba699 38ba00ac 7c641b78 3c60c024 38630044 4bea1085 80010024 7f83e378
bb410008 7c0803a6 38210020 4e800020 <8003001c> 54842834 7c840214 7cc429ae

The following patch gets rid of the oops.

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index ef158c1..1574b80 100644
=2D-- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2886,6 +2886,8 @@ void serial8250_unregister_port(int line)
                uart->port.flags &=3D ~UPF_BOOT_AUTOCONF;
                uart->port.type =3D PORT_UNKNOWN;
                uart->port.dev =3D &serial8250_isa_devs->dev;
+               uart->port.iobase =3D 0;
+               uart->capabilities =3D 0;
                uart_add_one_port(&serial8250_reg, &uart->port);
        } else {
                uart->port.dev =3D NULL;

The issue is that the UART_CAP_SLEEP flag is set uart->capabilities when th=
e=20
port is registered, and is not reset afterwards. When the 8250 driver calls=
=20
serial8250_pm, it will try to access the port. As the device disappeared th=
is=20
is obviously a bad idea.

Setting uart->capabilities to 0 in serial8250_unregister_port fixes the=20
problem. Setting uart->port.iobase to 0 is not required, but prevent=20
subsequent calls to serial8250_find_match_or_unused from skipping the=20
unregistered port. This make the device <-> tty node association more=20
predictable.

Is there any plan to get rid of the "let userspace open nonpresent ports"=20
behaviour ? This would probably make the 8250 driver cleaner.

Please let me know if I should submit a single patch with both modification=
s,=20
two patches or just the fix for the oops.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1733509.ObHS3O53EO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHRbL38y9gWxC9vpcRAi0LAJ48umIbIY26WeaBDN2vfl2AyksQrQCfXfuL
2n4S+dEo5H30zUU58IivpiM=
=k9Qk
-----END PGP SIGNATURE-----

--nextPart1733509.ObHS3O53EO--
