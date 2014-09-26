From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for
	handling modem signals (v2.2c)
Date: Fri, 26 Sep 2014 14:11:17 +0100
Message-ID: <20140926131117.GR5182@n2100.arm.linux.org.uk>
References: <1411150399-30902-1-git-send-email-j.uzycki@elproma.com.pl> <54256326.3080202@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:43971 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752149AbaIZNLa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Sep 2014 09:11:30 -0400
Content-Disposition: inline
In-Reply-To: <54256326.3080202@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Sep 26, 2014 at 02:59:18PM +0200, Janusz U=C5=BCycki wrote:
> But serial8250_get_mctrl() in 8250_core.c calls serial8250_modem_stat=
us()
> which calls eg. uart_handle_cts_change() even if enable_ms() wasn't c=
alled.
> This is the difference.
> The serial8250_modem_status() is also called in the interrupt
> and, what I don't understand, in serial8250_console_write().

Reading the MSR register clears the interrupts.  So, whenever MSR is re=
ad,
you have to deal with any state changes which _would_ have been passed
to the interrupt function.

Plus, it's not quite as you make out above.

If enable_ms() is not called, then UART_IER_MSI will not be set in up->=
ier.
Hence, uart_handle_cts_change() will not be called.

The reason for the call in the console function is to account for the
state changes during console write with CTS flow control - this again
needs the MSR register to be read, and we have to account for MSR state
changes after the console write has completed.

--=20
=46TTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
