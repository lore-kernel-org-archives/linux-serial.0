From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [RFC] PATCH: rfcomm tty refcount fixes
Date: Fri, 12 Jul 2013 17:20:20 +0200
Message-ID: <51E01EB4.3090406@ahsoftware.de>
References: <20130706084343.GA10500@debian.seek.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:51652 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3GLPU5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Jul 2013 11:20:57 -0400
In-Reply-To: <20130706084343.GA10500@debian.seek.priv>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, peter@hurleysoftware.com

Am 06.07.2013 10:43, schrieb Gianluca Anzolin:
> Hi,
> 
> I'm getting panics and OOPS with the vanilla kernel 3.10 using rfcomm with a
> bluetooth module connected to a microcontroller: this occurs when I poweroff
> the microcontroller without closing first the rfcomm device.
> 
> Searching the web I found that I'm not alone with this issue:
> 
> http://marc.info/?l=linux-bluetooth&m=136868678418771&w=2
> 
> In the thread the issue seems to be a refcounting problem.
> 
> Indeed looking at the source there are places where dev->port.tty is accessed
> directly without taking references of the tty_struct.
> 
> So I inspected every dev->port.tty access and changed the code to use
> tty_port_tty_get which gets the references properly.
> 
> In other places I used directly the tty_port_* helpers already in place.
> 
> I the process I changed also the tty_port_hangup helper because it seems to me
> that it could leak references in some cases (I sent another email for that).
> 
> I attach the patch against net/bluetooth/rfcomm/tty.c and
> drivers/tty/tty_port.c
> 
> With this patch I cannot reproduce the oopses I was getting before: I was able
> to trigger the panics very easily and now I cannot trigger them anymore.

The patches with BUG_ON or WARN_ON don't work with 3.10 anymore and do
make things worse, at least here. They are fine for 3.7-3.9, but not
with 3.10.

> 
> I cannot tell however if the problem is really fixed so I'm here request for
> comments from people who know this code better than me.

I've just had the chance to test a 3.10(.0) kernel with your two patches
applied, they doesn't seem to help. The machine I've used to test just
stood still after the first or second disconnect. Unfortunatley I can't
provide any debug output, the machine I've just used doesn't have a
serial and without debugging such stuff is a pain.

> To them I'd like also to have a look at rfcomm_tty_close: in some situations
> tty_port_put could be called two times: is that right?

That doesn't sound sane.

Regards,

Alexander Holler
