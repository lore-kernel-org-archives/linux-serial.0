From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Thu, 26 Jul 2007 09:28:06 -0700
Message-ID: <46A8CB96.1010501@howardsilvan.com>
References: <46A7FE6A.4030309@howardsilvan.com> <20070726123420.GA14163@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:33647 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760998AbXGZQ31 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jul 2007 12:29:27 -0400
In-Reply-To: <20070726123420.GA14163@informatik.uni-freiburg.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>
Cc: linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Uwe Kleine-K=F6nig wrote:

>Hello,
>
> =20
>
>>This is evidenced in hardware flow control by a little LED labeled "R=
TS"=20
>>that is on the external modem.  This LED lights up when pin 7 of the =
DB9=20
>>serial connection is given +12Vdc current (signalling "RTS" is on - t=
hat=20
>>the host can accept data).  The LED goes dark when the current is=20
>>removed (signalling that the host cannot accept data).  This "RTS" LE=
D=20
>>never flickers at all, as it should, when receiving these bursts of d=
ata=20
>>- the LED stays lit as long as the serial cable is connected to the=20
>>host... and yet I will see those "input overrun" messages.  Thus, it=20
>>seems quite clear that the Linux serial tty driver is not deasserting=
=20
>>RTS as it should in hardware flow control.  (And probably the analogo=
us=20
>>problem exists in software flow control, too.)
>>   =20
>>
>I don't know the relevant timings for problem, but just to be sure tha=
t
>your prerequisites are correct:  How did you check that the LED stays
>lit all the time?  Just from looking might not be accurate.  You might
>want to mesure the signal with an oscilloscope.
>

The manufacturer is using a scope to look for RTS and they're not seein=
g=20
it, either.  I just use my eyes to look at the LED, but I can see the=20
CTS, DTR, DCD, RD, and TD lights blink, flicker, or dim... (and TD, RD,=
=20
and CTS tend to go on and off rather quickly).

All of that said... even though I don't see RTS flicker or blink or dim=
=20
when using kernel 2.2.5 (RedHat 6.0) I don't have any problems using=20
115200 bps DTE-DCE communication rate.

Thanks,

Lee.
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
