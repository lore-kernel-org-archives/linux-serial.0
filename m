From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: s3c24xx : TIOCM_CTS handling problem
Date: Tue, 16 Dec 2008 14:43:01 +0100
Message-ID: <4947B065.5080405@parrot.com>
References: <48D242DC.30102@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:46725 "EHLO co203.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432AbYLPOKt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Dec 2008 09:10:49 -0500
In-Reply-To: <48D242DC.30102@parrot.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org

Matthieu CASTET a =E9crit :
> Hi,
>=20
> there is a problem in samsung soc serial driver with the report of
> TIOCM_CTS in get_mctrl.
>=20
> The uart layer check the status of the TIOCM_CTS in the open or
> set_termios function and cache the result in the tty->hw_stopped flag=
=2E
>=20
> Then when sending data, in the function uart_start, it check
> tty->hw_stopped flag before calling the start_tx uart driver callback=
=2E
>=20
>=20
> For the samsung uart driver it means :
> - if the other side is not connected or in a reset state, then CTS
> signal is not activated
> - we open and configure the uart. get_mctrl don't report TIOCM_CTS fl=
ag.
> uart layer set tty->hw_stopped flag.
> - we connect or start the other side. CTS signal become activated.
> - we send some characters on the uart. This call uart_write which fil=
l
> uart tx queue and call uart_start. uart_start doesn't call driver
> start_tx because tty->hw_stopped flag is set.
> - because driver start_tx is never call, the data is never send on th=
e uart.
>=20
>>From what I see, working driver managing TIOCM_CTS flag (amba-pl011,
> 8250), call uart_handle_cts_change when the uart driver detect a CTS
> signal change (via a interrupt).
>=20
> Because the samsung controller doesn't generate an interrupt when CTS
> signal change, we can't call uart_handle_cts_change.
>=20
> And easy fix could be to always report TIOCM_CTS.
>=20
Ping ?

The bug is still present on git tree and I have got no replies.


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
