From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals (v2.2c)
Date: Fri, 26 Sep 2014 14:59:18 +0200
Message-ID: <54256326.3080202@elproma.com.pl>
References: <1411150399-30902-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:59319 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753920AbaIZM7I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Sep 2014 08:59:08 -0400
In-Reply-To: <1411150399-30902-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>


W dniu 2014-09-25 17:29, Richard Genoud pisze:
> 2014-09-20 10:08 GMT+02:00 Janusz U=C5=BCycki <j.uzycki@elproma.com.p=
l>:
> Hi,
Hi Richard,

first, thanks for the very useful answers.

>> Could you look on my patch series [1...4]
>> serial: mxs-auart:
>> use mctrl_gpio helpers for handling modem signals (v2.2c)
>> at http://news.gmane.org/gmane.linux.serial ?
> If you resend them, put me in the CC list.
> That will be easier for me to have a look at them.

sure

>> I added some comments in patch's code.
>> In atmel_serial mctrl_gpio_free() is ommited,
>> is it useless?
> If you take a look at mctrl_gpio_init(), you'll see that all the
> allocations are done with devm_* functions.
> So that they are automatically deallocated when the module unloads.
> I still wrote mctrl_gpio_free() for some cases where we want to free
> memory without unloading the module.
>
> So you don't have to call mctrl_gpio_free() at the end of
> mxs_auart_probe() and mxs_auart_remove()
> (cf Documentation/serial/driver )

It is clear now, thanks.

>> Atmel_serial also does not parse modem
>> line status in mxs_auart_get_mctrl(),
>> 8250 driver does it. Which solution is ok?
> Well, in atmel_get_mctrl(), we have to retrieve the line status from
> the uart controller :
> that's done with :
> status =3D UART_GET_CSR(port);
> Then, for the lines controlled via GPIO, we are calling
> mctrl_gpio_get() that updates the mctrl flags with gpios states.
>
> It doesn't seems different from 8250.

But serial8250_get_mctrl() in 8250_core.c calls serial8250_modem_status=
()
which calls eg. uart_handle_cts_change() even if enable_ms() wasn't cal=
led.
This is the difference.
The serial8250_modem_status() is also called in the interrupt
and, what I don't understand, in serial8250_console_write().

>> Do you happen to know if tty layer
>> modifies mctrl between mxs_auart_get_mctrl(),
>> mxs_auart_set_mctrl() and mxs_auart_get_mctrl() again?
> I don't quite understand what you mean.
> The only way for the kernel to get line status (DCD, CTS,DSR,RI) is
> via get_mctrl.
> And the only way for the kernel to set line status
> (RTS,DTR,out1,out2,loop) is via set_mctrl.

Yes, but:
* mxs_auart_set_mctrl() in the mxs-auart stores the lastest mctrl
    in private ctrl field
* the stored value is used to supply initial returned value
    by mxs_auart_get_mctrl()
* uart_update_mctrl() in serial_core.c modifies only selected bits
    in port->mctrl field - OK, input bits stay untouched
* uart_port_startup() in serial_code.c sets RTS and DTR
    and zeroes others (also input bits)
* uart_set_termios() in serial_core.c modifies the bits too
* uart_suspend_port() in serial_core.c sets all mctrl bits to 0

It looks that mxs_auart_set_mctrl() doesn't have to store mctrl at all
because uart_tiocmget() in serial_core.c restores the output bits
from port->mctrl field. So the code is duplicated.
Do you agree?
P.S. It was even implemented in serial_core.c in 2.6.12.

best regards
Janusz
> best regards,
> Richard.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
