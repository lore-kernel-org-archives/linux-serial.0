From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: restart callback not supposed to sleep?
Date: Mon, 20 Aug 2012 10:57:34 +0200
Message-ID: <20529.64510.403690.325993@ipc1.ka-ro>
References: <20120820082423.GJ2232@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:51373 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab2HTI5v (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 04:57:51 -0400
In-Reply-To: <20120820082423.GJ2232@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Hi,

Uwe Kleine-K=C3=B6nig writes:
> Hello,
>=20
> while triggering a reboot via sysrq on an ARM machine I saw a "BUG:
> sleeping function called from invalid context" message (details below=
).
> The reason is that the sysrq handler is calling the restart hook in i=
rq
> context. So what should be done about that? The obvious possiblities
> are:
>=20
>  a) ignore the problem as it won't result in problems (and maybe some=
how
>     silence the warnign); or
>  b) make the restart hook atomic; or
>  c) assert sysrq not calling the hook in atomic mode
>=20
> What do you think?
>=20
This has been discussed earlier (with your participation) with 'a)'
being the conclusion.
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/033=
877.html


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
