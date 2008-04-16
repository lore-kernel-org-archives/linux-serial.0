From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Tue, 15 Apr 2008 20:08:01 -0400
Message-ID: <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-m22.mx.aol.com ([64.12.137.3]:41507 "EHLO
	imo-m22.mail.aol.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753935AbYDPANd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Apr 2008 20:13:33 -0400
In-Reply-To: <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: vcgandhi1@aol.com, g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org



Guennadi,

I think the issue is when the serial port is embedded and not connected=
=20
through the bus. So I am talking about the drivers in the=20
kernel/drivers/serial directory. A few of them use suspend and resume=20
and I think they may not be compatible with your change.=C2=A0

Do you know if you anybody tested any serial ports that are located in=20
that directory and use=C2=A0 the suspend and resume calls. Ports not=20
connected through the pci  bus.

Vipul



-----Original Message-----
=46rom: vcgandhi1@aol.com
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org
Sent: Tue, 15 Apr 2008 4:30 pm
Subject: Re: Change to serial_core.c .... causing my serial driver=20
problem Help Request


Guennadi,

I think the issue is when the serial port is embedded and not connected=
=20
through the bus. So I am talking about the drivers in the=20
kernel/drivers/serial directory. A few of them use suspend and resume=20
and I think they may not be compatible with your change.=C2=A0I not sur=
e who=20
signed off on in=C2=A0but I am having problems with the change and woul=
d=20
like to like to get=C2=A0it resolved. =C2=A0

Do you know if you anybody tested any serial ports that are located in=20
that directory and use=C2=A0 the suspend and resume calls. Ports not=20
connected through a bus.

Vipul




-----Original Message-----
=46rom: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Tue, 15 Apr 2008 3:49 pm
Subject: RE: Change to serial_core.c .... causing my serial driver=20
problem Help Request



On Tue, 15 Apr 2008, vcgandhi1@aol.com wrote:

> Will do,

I added linux-serial to cc.

> But it seems like the code that was check in has issues.

Given the number and names of signed-off's under this patch, it is=20
pretty
unlikely.

> If you look in
> the directory no serial driver properly sets port->dev to be pointing=
=20
to
> the parent. It looks like they all point to themselves. Can you tell=20
me
> which driver you tested this change on. I can look to see how they=20
set
> port->dev.

8250_pci.c, and I do think it sets it properly in=20
pciserial_init_ports().

Thanks
Guennadi

> Vipul?
> ?
>
> -----Original Message-----
> From: Guennadi Liakhovetski [mailto:g.liakhovetski@gmx.de]
> Sent: Tuesday, April 15, 2008 2:50 PM
> To: Gandhi, Vipul
> Subject: Re: Change to serial_core.c .... causing my serial driver=20
problem
Help Request
>
> ?
>
> On Tue, 15 Apr 2008, Gandhi, Vipul wrote:
>
> ?
>
> > For my driver the following call is returning a NULL .?????????
>
> >
>
> >?
>
> >
>
> > tty_dev =3D device_find_child(port->dev, &match, serial_match_port)=
;
>
> >
>
> >?
>
> >
>
> > Any idea? why, previously this was not in serial_core.c but was=20
recently
>
> > added by you I believe. Any help would be appreciated.
>
> ?
>
> No, not without seeing the source-code of your driver. Also, please,
>
> direct such questions to the linux-serial or linux-kernel mailing=20
list,
>
> you may then additionally CC the person, who you think can help you=20
best.
>
> ?
>
> Thanks
>
> Guennadi
>
> ---
>
> Guennadi Liakhovetski
>

---
Guennadi Liakhovetski
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
