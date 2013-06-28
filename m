From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/2] serial: imx: remove the uart_console() check
Date: Fri, 28 Jun 2013 10:17:49 +0800
Message-ID: <51CCF24D.1060007@freescale.com>
References: <1372239359-4054-1-git-send-email-b32955@freescale.com> <20130627141535.GD2695@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:40089
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753652Ab3F1COP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Jun 2013 22:14:15 -0400
In-Reply-To: <20130627141535.GD2695@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com

=E4=BA=8E 2013=E5=B9=B406=E6=9C=8827=E6=97=A5 22:15, Shawn Guo =E5=86=99=
=E9=81=93:
>>   	* Check whether an invalid uart number has been specified, and
>> >  @@ -1371,6 +1381,15 @@ imx_console_setup(struct console *co, char=
 *options)
>> >    	if (sport =3D=3D NULL)
>> >    		return -ENODEV;
>> > =20
>> >  +	retval =3D clk_prepare_enable(sport->clk_per);
>> >  +	if (retval)
>> >  +		goto error_console;
>> >  +	retval =3D clk_prepare_enable(sport->clk_ipg);
>> >  +	if (retval) {
>> >  +		clk_disable_unprepare(sport->clk_per);
>> >  +		goto error_console;
>> >  +	}
>> >  +
> Why do we need clk_enable() here at all?  The amba-pl011 driver only
> calls clk_prepare() in console .setup().
>
We need to set the imx_setUp_ufcr() in our imx_console_setup(),
so we need to enable the clocks, aren't we?
>> >    	if (options)
>> >    		uart_parse_options(options,&baud,&parity,&bits,&flow);
>> >    	else
>> >  @@ -1378,7 +1397,17 @@ imx_console_setup(struct console *co, char=
 *options)
>> > =20
>> >    	imx_setup_ufcr(sport, 0);
>> > =20
>> >  -	return uart_set_options(&sport->port, co, baud, parity, bits, f=
low);
>> >  +	retval =3D uart_set_options(&sport->port, co, baud, parity, bit=
s, flow);
>> >  +
>> >  +	clk_disable(sport->clk_per);
>> >  +	clk_disable(sport->clk_ipg);
>> >  +	if (retval) {
>> >  +		clk_unprepare(sport->clk_per);
>> >  +		clk_unprepare(sport->clk_ipg);
>> >  +	}
>> >  +
>> >  +error_console:
>> >  +	return retval;
>> >    }
>> > =20
>> >    static struct uart_driver imx_reg;
>> >  @@ -1583,10 +1612,8 @@ static int serial_imx_probe(struct platfor=
m_device *pdev)
>> >    		goto deinit;
>> >    	platform_set_drvdata(pdev, sport);
>> > =20
>> >  -	if (!uart_console(&sport->port)) {
>> >  -		clk_disable_unprepare(sport->clk_per);
>> >  -		clk_disable_unprepare(sport->clk_ipg);
>> >  -	}
>> >  +	clk_disable_unprepare(sport->clk_per);
>> >  +	clk_disable_unprepare(sport->clk_ipg);
> I also had a hard time to understand why we need to turn on the clock=
s
> in .probe() for a while and then turn them off.
In the probe's uart_add_one_port(), we will register the console and=20
call the setup() hook,
so it's ok to disable the clocks in the end of the probe.
> It just reminds me a thing.  Did you test CONFIG_CONSOLE_POLL support
> when your commit 28eb427 (serial: imx: enable the clocks only when th=
e
> uart is used) went in?  The commit turns off the clocks at the
sorry, i did not do this.
> end of .probe(), but who will enable the clocks for .poll_get_char()
> and .poll_put_char()?  The amba-pl011 driver does that in .poll_init(=
).
>
dido. in the uart_add_one_port().

thanks
Huang Shijie


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
