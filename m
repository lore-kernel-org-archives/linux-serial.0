From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: questions regarding function autoconfig(); drivers/serial/8250.c
Date: Mon, 26 Nov 2007 13:46:47 +0100
Message-ID: <20071126124646.GA11351@informatik.uni-freiburg.de>
References: <4747575E.80501@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:41123 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862AbXKZMqt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Nov 2007 07:46:49 -0500
Content-Disposition: inline
In-Reply-To: <4747575E.80501@tiscali.nl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-serial@vger.kernel.org

Roel Kluin wrote:
> In drivers/serial/8250.c:995 it reads:
>=20
> if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
> 	return;
>=20
> As you can see the test !up->port.mapbase is duplicated, which makes =
no sense.
> maybe a different test was intended here?
Looking twice exposes that the second mapbase is actually a membase.  S=
o
it looks right to me.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D30+hours+and+4+days+in+seconds
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
