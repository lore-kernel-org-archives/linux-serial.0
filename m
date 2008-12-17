From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: s3c24xx : TIOCM_CTS handling problem
Date: Wed, 17 Dec 2008 14:27:02 +0100
Message-ID: <4948FE26.90907@parrot.com>
References: <48D242DC.30102@parrot.com>	<4947B065.5080405@parrot.com> <20081216141533.7bcc5c9b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:60786 "EHLO co203.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbYLQN1I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Dec 2008 08:27:08 -0500
In-Reply-To: <20081216141533.7bcc5c9b@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org

Hi Alan,

Alan Cox a =E9crit :
>>> And easy fix could be to always report TIOCM_CTS.
>>>
>> Ping ?
>>
>> The bug is still present on git tree and I have got no replies.
>=20
> Send patches instead then ;)
>=20
> If the chip can sense the CTS line then you could check on a timer ev=
ent
May be it could be usefull to do something generic that call driver
get_mctrl instead of doing it in the driver (like it is done in
bfin_5xx, sa1100, ...)

> but it might be cleaner to add the functionality needed to allow a dr=
iver
> to say "always call my start_tx" method.
Or to say "recheck get_mctrl before my start_tx).
But have you got an idea how the driver could ask that to the serial co=
re ?
flags in struct uart_port seems full.


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
