From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: RE: Adding new driver - looking for suggestions
Date: Wed, 11 Jul 2007 10:20:03 -0400
Message-ID: <004901c7c3c6$92b2c9c0$7a4b82ce@connecttech.local>
References: <469417A6.24982.128022FD@Frantisek.Rysanek.post.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:4990 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758926AbXGKOUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Jul 2007 10:20:33 -0400
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id l6BEKXBx007748
	for <linux-serial@vger.kernel.org>; Wed, 11 Jul 2007 10:20:33 -0400 (EDT)
	(envelope-from cdore@connecttech.com)
Received: from cdore (cdore.connecttech.com [206.130.75.122]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id l6BEK9J24503 for <linux-serial@vger.kernel.org>; Wed, 11 Jul 2007 10:20:09 -0400 (EDT)
In-Reply-To: <469417A6.24982.128022FD@Frantisek.Rysanek.post.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

On July 10, 2007 5:35 PM, Frantisek Rysanek wrote:
>=20
> As far as patching the vanilla kernel is concerned:=20
> You seem to suggest an addition of rather proprietary data (members)=20
> to the neatly generic struct uart_port. I'd suggest adding something=20
> like=20
>=20
> void* priv; // device-specific driver private data=20

I agree, I'm not a fan of the current implementation.  I'd like to mass=
age
what we have into something more acceptable.

> to the generic struct uart_port of the vanilla kernel, which you=20
> could then use to hook your own private data struct, regardless of=20
> whether the rest of your driver lives in 8250_pci.c or in a stand-
> alone module. This is the way it's done in a number of other generic=20
> device structs (or maybe the more modern way is to use a nested=20
> struct with "parent struct decoding").

Thanks for the ideas.


Chris Dor=E9

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
