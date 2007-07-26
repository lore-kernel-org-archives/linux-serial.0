From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: serial flow control appears broken
Date: Thu, 26 Jul 2007 14:34:20 +0200
Message-ID: <20070726123420.GA14163@informatik.uni-freiburg.de>
References: <46A7FE6A.4030309@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43226 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756538AbXGZMeZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jul 2007 08:34:25 -0400
Content-Disposition: inline
In-Reply-To: <46A7FE6A.4030309@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Hello,

> This is evidenced in hardware flow control by a little LED labeled "R=
TS"=20
> that is on the external modem.  This LED lights up when pin 7 of the =
DB9=20
> serial connection is given +12Vdc current (signalling "RTS" is on - t=
hat=20
> the host can accept data).  The LED goes dark when the current is=20
> removed (signalling that the host cannot accept data).  This "RTS" LE=
D=20
> never flickers at all, as it should, when receiving these bursts of d=
ata=20
> - the LED stays lit as long as the serial cable is connected to the=20
> host... and yet I will see those "input overrun" messages.  Thus, it=20
> seems quite clear that the Linux serial tty driver is not deasserting=
=20
> RTS as it should in hardware flow control.  (And probably the analogo=
us=20
> problem exists in software flow control, too.)
I don't know the relevant timings for problem, but just to be sure that
your prerequisites are correct:  How did you check that the LED stays
lit all the time?  Just from looking might not be accurate.  You might
want to mesure the signal with an oscilloscope.

Just my 0.02=A2
Uwe

--=20
Uwe Kleine-K=F6nig

fib where fib =3D 0 : 1 : zipWith (+) fib (tail fib)
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
