From: Guido Classen <clagix@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Fri, 25 Jan 2013 10:13:10 +0100
Message-ID: <CAJa4H3eWaZH0p8+48Kq4RPEyDiAZfsiX801CBqJ7_CrTw688yw@mail.gmail.com>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49804 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab3AYJNL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 04:13:11 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so103901pbb.10
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 01:13:10 -0800 (PST)
In-Reply-To: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Grant Edwards <grant.b.edwards@gmail.com>

On 2014-01-23, Grant Edwards wrote:

> In applications like links using half-duplex modems, you may have to
> assert RTS for many hundreds of millisconds to allow the modulator to
> key up and stabilze and the demodulator to lock onto the signal before
> you can send data.  Some modems will let you know when they're ready
> by asserting CTS, and for others you just have to have a fixed delay.
> In those cases, you also typically hold RTS for some time after the
> end of the data for a time ranging up to several byte times.

> In our non-Linux based products, we implement pre/pose data RTS "hold"
> times as you describe in our device driver.  Our Linux-based products
> can't handle those applications.
I am glad to hear that there is at lease someone else out there who is using
such old technology. We still use a kind of V.23 modems which work as
you described in some projects in road traffic applications.
Why haven't you tried to implement that applications on Linux?  On slow
baud-rates even an user-mode implementation should be possible in most
cases?
