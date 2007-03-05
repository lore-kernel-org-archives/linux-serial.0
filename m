From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: should RTS init in serial core be tied to CRTSCTS
Date: Mon, 5 Mar 2007 18:39:29 +0100
Message-ID: <000e01c75f4d$3ab83620$2e01a8c0@acksys.local>
References: <8bd0f97a0703050909n18386114kd2c0b2a108591641@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp24.msg.oleane.net ([62.161.4.24]:60638 "EHLO
	smtp24.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbXCESFQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2007 13:05:16 -0500
Received: from RD2 ([194.206.161.7])
	by smtp24.msg.oleane.net (MTA) with SMTP id l25HdYil018434
	for <linux-serial@vger.kernel.org>; Mon, 5 Mar 2007 18:39:34 +0100
In-Reply-To: <8bd0f97a0703050909n18386114kd2c0b2a108591641@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

> true ... so ignoring the original motivation for change i posted, is
> it really correct for the serial core to be forcing TIOCM_RTS at uart
> startup even though the uart doesnt have CTSRTS flow control enabled ?
>  in other words, my change is agnostic of the console, and is done for
> all uarts ... it should prob have a similar change in uart_shutdown()
> though ...
> -mike

All UNIX drivers historically set RTS and DTR upon opening, and Windows
drivers do the same... and this behaviour must be kept for compatibility I
think...

The only way I can imagine to keep RTS low on opens on selected ports, would
be to set up a parameter in /proc or /sys ? maybe its management could be
added to setserial ?

I have a similar problem with many RS485 cards, when the port is opened the
card takes the RS485 bus until RTS is turned back down by the opening
process.


