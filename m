From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Change to serial_core.c .... causing my serial driver problem
 Help Request
Date: Thu, 17 Apr 2008 01:11:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804170103040.7335@axis700.grange>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com>
 <Pine.LNX.4.64.0804160046460.6851@axis700.grange>
 <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com>
 <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752617AbYDPXLW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Apr 2008 19:11:22 -0400
In-Reply-To: <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org

On Tue, 15 Apr 2008, vcgandhi1@aol.com wrote:

> I think the issue is when the serial port is embedded and not connect=
ed
> through the bus. So I am talking about the drivers in the
> kernel/drivers/serial directory. A few of them use suspend and resume=
 and I
> think they may not be compatible with your change.=C2=A0

Which specific driver do you see the problem with? I cannot check all=20
drivers. I took as an example mpc52xx_uart.c. And I see there

	port->dev	=3D &dev->dev;

in its ->probe, so, it shouldn't have a problem either.

> Do you know if you anybody tested any serial ports that are located i=
n that
> directory and use=C2=A0 the suspend and resume calls. Ports not conne=
cted through
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
