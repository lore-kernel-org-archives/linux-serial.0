From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals (v2.2c)
Date: Fri, 26 Sep 2014 15:23:59 +0200
Message-ID: <542568EF.1040103@elproma.com.pl>
References: <1411150399-30902-1-git-send-email-j.uzycki@elproma.com.pl> <54256326.3080202@elproma.com.pl> <20140926131117.GR5182@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:50193 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754196AbaIZNXs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Sep 2014 09:23:48 -0400
In-Reply-To: <20140926131117.GR5182@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org


W dniu 2014-09-26 15:11, Russell King - ARM Linux pisze:
> On Fri, Sep 26, 2014 at 02:59:18PM +0200, Janusz U=C5=BCycki wrote:
>> But serial8250_get_mctrl() in 8250_core.c calls serial8250_modem_sta=
tus()
>> which calls eg. uart_handle_cts_change() even if enable_ms() wasn't =
called.
>> This is the difference.
>> The serial8250_modem_status() is also called in the interrupt
>> and, what I don't understand, in serial8250_console_write().
> Reading the MSR register clears the interrupts.  So, whenever MSR is =
read,
> you have to deal with any state changes which _would_ have been passe=
d
> to the interrupt function.
>
> Plus, it's not quite as you make out above.
>
> If enable_ms() is not called, then UART_IER_MSI will not be set in up=
->ier.
> Hence, uart_handle_cts_change() will not be called.

Oh, now I understand the condition "up->ier & UART_IER_MSI"
in serial8250_modem_status().
So in case of gpio modem lines interrupt is the only right place like i=
n=20
atmel_serial.c.

> The reason for the call in the console function is to account for the
> state changes during console write with CTS flow control - this again
> needs the MSR register to be read, and we have to account for MSR sta=
te
> changes after the console write has completed.
It means that gpio modem lines does not support flow control for consol=
e
on the moment, right Richard?

best regards
Janusz

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
