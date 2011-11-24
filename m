From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH 0/8] serial: 8250: support hw-based RS485 direction control
 (finally!)
Date: Thu, 24 Nov 2011 17:05:27 +0100
Message-ID: <4ECE6B47.90202@evidence.eu.com>
References: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de> <20111123150312.GH4063@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64460 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1KXQFb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Nov 2011 11:05:31 -0500
In-Reply-To: <20111123150312.GH4063@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Juergen Beisert <jbe@pengutronix.de>, Matthias Fuchs <mfuchs@ma-fu.de>

Il 23/11/2011 16:03, Wolfram Sang ha scritto:
> On Wed, Nov 16, 2011 at 05:24:37PM +0100, Wolfram Sang wrote:
>> Some 8250-variants control the direction pin for RS485 in hardware. =
Linux has
>> RS485 support these days, so update the 8250-driver to adhere to tha=
t. There
>> have been attempts for mainlining this before. So, I started with th=
e version
>> from Matthias which got no further comments, a proof-of-concept for =
the 16V2750
>> from J=FCrgen, and reworked it to match the current state of RS485 i=
n Linux. Some
>> minor cleanup patches came along the way. Really looking forward to
>> comments/tags, because I think it is really time to get this functio=
nality into
>> mainline once and for all ;)
>=20
> Ping. Claudio? What do you think?=20

Hi Wolfram,

	sorry for the delay, but I'm very busy these days.

I noticed that some of your patches revert the changes made by the prev=
ious patches in the=20
same series. So I would have preferred having only one patch with the w=
hole changes wrt to=20
the mainline.=20

However, I've understood that some of those patches come from a previou=
s submission that you
preferred to not touch. And I can apply the whole series to check what =
are the actual changes,
so its' fine.

The RS485 part looks right.=20

I had a superficial look also at the rest of the code, and its seems OK=
 too.  But, honestly, I couldn't=20
find the time to read it carefully.

Best regards,

	Claudio
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
