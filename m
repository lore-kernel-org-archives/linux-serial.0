From: "Paul Chiha" <paul.chiha@greyinnovation.com>
Subject: RE: OMAP2+:UART driver help
Date: Tue, 18 Oct 2011 15:46:27 +1100
Message-ID: <51A4F524D105AA4C93787F33E2C90E62EE5A5A@greysvr02.GreyInnovation.local>
References: <51A4F524D105AA4C93787F33E2C90E62EE59C2@greysvr02.GreyInnovation.local> <CAAL8m4zbWxJk4X9N-=pX6fQLv+1zrE_949o3rwLNrd+sTtKraA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eth1683.vic.adsl.internode.on.net ([150.101.217.146]:16035 "EHLO
	greyinnovation.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751494Ab1JREpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Oct 2011 00:45:24 -0400
Content-class: urn:content-classes:message
In-Reply-To: <CAAL8m4zbWxJk4X9N-=pX6fQLv+1zrE_949o3rwLNrd+sTtKraA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-serial@vger.kernel.org

Govindraj,

Thanks for your response.

On Monday, 17 October 2011 4:43 PM, Govindraj [mailto:govindraj.ti@gmai=
l.com] wrote:
>=20
> Hi Paul,
>=20
> On Mon, Oct 17, 2011 at 10:18 AM, Paul Chiha <paul.chiha@greyinnovati=
on.com>
> wrote:
> > Hi,
> >
> > I'm a newbie and would like some help with serial drivers in the ke=
rnel.
> >
> > I've got an OMAP35x EVM (with UARTs 1/2-3 on board), and I would li=
ke
> > to write my own driver which uses UART 3. =A0I'm not sure of the be=
st
> > way to do this.
>=20
> Most use cases tend to use omap-serial itself with a client driver, f=
or any
> client peripheral over uart.
>=20
> > I don't know how to use the existing ttyO2 device and omap-serial
> > driver for my own purpose. =A0Basically I want to write a driver wh=
ich
> > sits between the application and the omap-serial driver, but only f=
or
> > UART 3. =A0Is there a simple mechanism to do this, or do I need to
> > replace omap_serial with my own?
>=20
> I don't know why you want to do that rather use the existing uart dri=
ver, for
> any console usage you can pass console parameter from bootargs and wo=
rks well,
> for any use case from user space application can open
> UART3(ttyO2) configure it using termios ops and use it.
>=20
> How is your use case very different from these?
>=20

Because I need to be able to convert the given datastream, and send out=
 packets at a precise periodic interval.  I could do it all in userspac=
e, but I need to be able to guarantee timing.  Hence, a driver is recom=
mended.

> If you have a device connected over UART and want to controlled then,=
 you may
> consider intermediate layer as ldisc layer.
> ex: TI Bluetooth driver "drivers/misc/ti-st/st_core.c"
>=20

Thanks, I'll have a look.

>=20
> > Also,
> > is there an existing driver that does something similar to what I w=
ant
> > that I can base my driver on?
>=20
> I dont see any such driver other omap-serial which supports omap-uart=
s, but
> AFAIK you cannot add stuffs in that driver for a particular use case.
>=20

Yes I know.  I'll see if I can use the existing omap-serial driver.
Thanks,
Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
