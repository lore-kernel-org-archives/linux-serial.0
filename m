From: Ben Papps <ben.papps@oxsemi.com>
Subject: Hardware Flow Control on 16C950/954 (kernel 2.6.11)
Date: Thu, 04 Aug 2005 15:36:42 +0100
Message-ID: <42F227FA.2060607@oxsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from jupiter.oxsemi.com ([62.255.240.98]:42180 "EHLO
	jupiter.oxsemi.com") by vger.kernel.org with ESMTP id S261738AbVHDOgr
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Aug 2005 10:36:47 -0400
Received: from mercury.oxsemi.com (mercury.oxsemi.com [62.255.240.97])
	by jupiter.oxsemi.com (8.12.11/8.12.10) with ESMTP id j74EakXr023192
	for <linux-serial@vger.kernel.org>; Thu, 4 Aug 2005 15:36:46 +0100
Received: from mungo.oxsemi.com (mungo.oxsemi.com [172.16.0.11])
	by mercury.oxsemi.com (8.12.11/8.12.11) with ESMTP id j74EajsD031490
	for <linux-serial@vger.kernel.org>; Thu, 4 Aug 2005 15:36:45 +0100
Received: from [172.16.10.104] (bob.oxsemi.com [172.16.10.104])
	by mungo.oxsemi.com (Postfix) with ESMTP id 016087E8C4
	for <linux-serial@vger.kernel.org>; Thu,  4 Aug 2005 15:36:45 +0100 (BST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux serial newsgroup <linux-serial@vger.kernel.org>

Hi all,

I have found an issue concerning hardware flow control on the 16C950/95=
4=20
(specifically I am working on the OX16PCI954/952 devices) in Linux 2.6=20
(Specifically the 2.6.11 kernel source (Fedora Core 3)). I have been=20
looking at how I can get this small fix made in the kernel, and thought=
=20
that I'd post the issue here first to see what other people think about=
 it.

The short version...: In file 8250.c, in uart_config[], lines 223-229.

[PORT_16C950] =3D {
=2Ename =3D =9316C950/954=94,
=2Efifo_size =3D 128,
=2Etx_loadsz =3D 128,
=2Efcr =3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
=2Eflags =3D UART_CAP_FIFO,
}

They should be*:*

[PORT_16C950] =3D {
=2Ename =3D =9316C950/954=94,
=2Efifo_size =3D 128,
=2Etx_loadsz =3D 128,
=2Efcr =3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
=2Eflags =3D UART_CAP_FIFO *| UART_CAP_EFR | UART_CAP_SLEEP*,
}

These flags allow the enhanced register to be used, allowing flow=20
control amongst other things.

The long version... also in 8250.c, considering the OX16PCI954 device.
The autoconfig routine calls the autoconfig_16550a routine, in which we=
=20
find that the C95x chip has an EFR register. The autoconfig_16550a=20
routine then calls the autoconfig_has_efr routine where up->capabilitie=
s=20
is correctly set with UART_CAP_EFR and UART_CAP_SLEEP. On recognising=20
the Oxford Semiconductor 16C950 devise autoconfig_has_efr returns to=20
autoconfig_16550a which in turn returns to autoconfig..

 From line 879 to 888 in autoconfig the driver the checks the=20
up->capabilities against the devices information in uart_config[]. This=
=20
of course doesn't match, as shown above in the short version, and=20
up->capabilities is reset with the values that are in uart_config[].

Without the EFR settings the set_termios routine is unable to assert th=
e=20
hardware flow control feature of the C950 uart.

The 16C954/950 entry in uart_config[] needs to have the UART_CAP_EFR an=
d=20
UART_CAP_SLEEP flags added to fix this bug.

I would appreciate any feedback on this.

Thanks,

Ben Papps


=20
_____________________________
=20
Ben Papps

Software Design Engineer
Oxford Semiconductor Ltd
25 Milton Park, Oxfordshire, OX14 4SH
=20
Tel: 01235 824887


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
