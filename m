From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
Date: Fri, 28 Nov 2014 18:21:38 +0000
Message-ID: <20141128182138.42eb91f0@lxorguk.ukuu.org.uk>
References: <Sharkl64-v3>
	<1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
	<1416917818-10506-6-git-send-email-chunyan.zhang@spreadtrum.com>
	<20141126123313.520ac83f@lxorguk.ukuu.org.uk>
	<54784ADE.6010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:50621 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaK1SWW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Nov 2014 13:22:22 -0500
In-Reply-To: <54784ADE.6010602@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>, zhizhou.zhang@spreadtrum.com, lanqing.liu@spreadtrum.com, zhang.lyra@gmail.com, wei.qiao@spreadtrum.com, linux-serial@vger.kernel.org

> do we just leave the .major & .minor as NULL in struct uart_driver for 
> dynamic allocation?

Yes

> >> +config SERIAL_SPRD_NR
> >> +        int "Maximum number of sprd serial ports"
> >> +        depends on SERIAL_SPRD
> >> +        default "4"
> > If you are doing dynamic allocation this should pretty much go away
> I think you mean getting the number of uarts from dt and dynamically 
> allocate their port structure?

Yes

> > Also set the resulting baud back into the termios (see the 8250 termios
> > for an example)
> you mean something like this part ?
> 
> /* Don't rewrite B0 */
> if (tty_termios_baud_rate(termios))
> tty_termios_encode_baud_rate(termios, baud, baud);

Exactly.

Alan
