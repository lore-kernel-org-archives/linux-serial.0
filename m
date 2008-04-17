From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Wed, 16 Apr 2008 22:16:24 -0400
Message-ID: <8CA6E482AE34A65-15A8-47A5@webmail-nb06.sysops.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com> <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804170103040.7335@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-m24.mx.aol.com ([64.12.137.5]:58548 "EHLO
	imo-m24.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYDQCQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Apr 2008 22:16:40 -0400
In-Reply-To: <Pine.LNX.4.64.0804170103040.7335@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org

Hi,

I do the same

port->dev   =3D &dev->dev;

But I am not sure &dev->dev points to the parent. I think it points to=20
the device it's self, but I may be wrong.  I have tried port->dev =3D=20
&dev->dev as well as port->dev =3D dev->dev.parent. One of these found=20
something when the port was TTYS0 but did not work when the port was=20
TTYS2.

Did you test with a non zero port->line. I working on ttyS2.


Just trying to narrow down what could be wrong. It just that   =20

tty_dev =3D device_find_child(port->dev, &match, serial_match_port);

is returning NULL for me.

Thank You for your help.
Vipul

PS. One quick suggestion you may want to check the return value and=20
verify it is non-NULL before using it. Makes it easier to debug the=20
code. ...


-----Original Message-----
=46rom: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Wed, 16 Apr 2008 4:11 pm
Subject: Re: Change to serial_core.c .... causing my serial driver=20
problem Help Request



On Tue, 15 Apr 2008, vcgandhi1@aol.com wrote:

> I think the issue is when the serial port is embedded and not=20
connected
> through the bus. So I am talking about the drivers in the
> kernel/drivers/serial directory. A few of them use suspend and resume=
=20
and I
> think they may not be compatible with your change.=C2=A0

Which specific driver do you see the problem with? I cannot check all
drivers. I took as an example mpc52xx_uart.c. And I see there

    port->dev   =3D &dev->dev;

in its ->probe, so, it shouldn't have a problem either.

> Do you know if you anybody tested any serial ports that are located=20
in that
> directory and use=C2=A0 the suspend and resume calls. Ports not conne=
cted=20
through
> the pci  bus.

No, I don't know.

Thanks
Guennadi
---
Guennadi Liakhovetski

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
