From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: Inter-Character Delay
Date: Mon, 3 Mar 2008 09:29:23 +0100
Message-ID: <007301c87d09$65b8b2c0$2e01a8c0@acksys.local>
References: <200802271057.02716.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp02.msg.oleane.net ([62.161.4.2]:52059 "EHLO
	smtp02.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbYCCIek convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Mar 2008 03:34:40 -0500
In-Reply-To: <200802271057.02716.rgetz@blackfin.uclinux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Robin Getz' <rgetz@blackfin.uclinux.org>
Cc: linux-serial@vger.kernel.org

Maybe a new parameter for the driver module, or a new entry in /proc wo=
uld do it ?

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Robin Getz
> Sent: Wednesday, February 27, 2008 4:57 PM
> To: Chris Dor=C3=A9
> Cc: linux-serial@vger.kernel.org
> Subject: Re: Inter-Character Delay
>=20
>=20
> On Tue 26 Feb 2008 15:59, Chris Dor=C3=A9 pondered:
> > If I read this correctly, the summary is that you:
> >=20
> > 1. Want to add functionality to the serial driver that=20
> supports an extra
> > feature (the delay register).
> > 2. Would like to know what the best way is to expose this=20
> new functionality
> > to a user app.
>=20
> Yes - that about captures it.
>=20
> -Robin
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
