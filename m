From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: serial flow control appears broken
Date: Thu, 26 Jul 2007 17:51:44 +0200
Message-ID: <000b01c7cf9c$de574ea0$2e01a8c0@acksys.local>
References: <46A7FE6A.4030309@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp03.msg.oleane.net ([62.161.4.3]:51381 "EHLO
	smtp03.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758898AbXGZQNr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jul 2007 12:13:47 -0400
In-reply-to: <46A7FE6A.4030309@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Lee Howard' <faxguy@howardsilvan.com>, linux-serial@vger.kernel.org

Trivial check:

Did you set the CRTSCTS flag in the c_cflag parameter to tcsetattr() in your
linux application code ? Or in the corresponding ioctl(..., TCSETA,...) call
?


> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Lee Howard
> Sent: Thursday, July 26, 2007 3:53 AM
> To: linux-serial@vger.kernel.org; tytso@mit.edu; rmk@arm.linux.org.uk;
> linux-kernel@vger.kernel.org
> Subject: serial flow control appears broken
>
>
> Hello.
>
> I have fax modems that will, in their proper behavior with certain
> features, send up to 64 kilobytes of data to the host DTE all
> at once.
> (So, the fax modem handles an incoming fax and periodically will send
> between 256 bytes and 64 kilobytes of data in bursts.)
>
> When the DCE-DTE (modem-to-host) communication rate is established at
> 115200 bps data loss occurs systems using at least Linux
> kernels 2.6.5
> and 2.6.18 (and probably everything in-beween and then some
> more).  This
> is because the modem overflows the host's buffer.  This is
> evidenced in
> kernel logging:
>
> Jul 23 14:01:30 gollum kernel: ttyS1: 1 input overrun(s)
> Jul 23 17:09:45 gollum kernel: ttyS1: 1 input overrun(s)
>
> Normally I would blame the modem itself for not honoring the
> host's flow
> control signals.  However, I have worked with the modem manufacturer
> closely on this matter for over three months now.  In that
> process they
> have improved the responsiveness of the modem and have fixed other
> problems, but the end result is that it truly does appear that the
> serial tty driver is not using flow control.  Whether software flow
> control (XON/XOFF) or hardware flow control (RTS/CTS) is used
> the result
> is the same.
>
> This is evidenced in hardware flow control by a little LED
> labeled "RTS"
> that is on the external modem.  This LED lights up when pin 7
> of the DB9
> serial connection is given +12Vdc current (signalling "RTS"
> is on - that
> the host can accept data).  The LED goes dark when the current is
> removed (signalling that the host cannot accept data).  This
> "RTS" LED
> never flickers at all, as it should, when receiving these
> bursts of data
> - the LED stays lit as long as the serial cable is connected to the
> host... and yet I will see those "input overrun" messages.  Thus, it
> seems quite clear that the Linux serial tty driver is not deasserting
> RTS as it should in hardware flow control.  (And probably the
> analogous
> problem exists in software flow control, too.)
>
> Please tell me what I can do to help you resove and/or remedy this
> matter.  Also, please let me know if I have contacted the
> wrong people.
> (I have cross-posted to linux-kernel as a catch-all.  I am not
> subscribed to either linux-serial or linux-kernel mailing lists.  So
> please CC me in any list responses.)
>
> If it is of any value to know (perhaps they have common
> code?), the same
> error occurs on FreeBSD 6.2 as well.   The problem does not occur on
> Windows.  The problem does not occur on RedHat 6.0 (kernel 2.2.5).
>
> Thanks,
>
> Lee.
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

