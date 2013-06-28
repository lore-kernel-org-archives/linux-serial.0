From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 1/2] serial: imx: remove the uart_console() check
Date: Fri, 28 Jun 2013 13:53:45 +0800
Message-ID: <51CD24E9.6060503@freescale.com>
References: <1372239359-4054-1-git-send-email-b32955@freescale.com> <20130627141535.GD2695@S2101-09.ap.freescale.net> <51CCF24D.1060007@freescale.com> <20130628025517.GA11043@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:31144
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961Ab3F1FuM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Jun 2013 01:50:12 -0400
In-Reply-To: <20130628025517.GA11043@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com

=E4=BA=8E 2013=E5=B9=B406=E6=9C=8828=E6=97=A5 10:55, Shawn Guo =E5=86=99=
=E9=81=93:
> On Fri, Jun 28, 2013 at 10:17:49AM +0800, Huang Shijie wrote:
>> We need to set the imx_setUp_ufcr() in our imx_console_setup(),
>> so we need to enable the clocks, aren't we?
> Ah, yes, I missed that.  But register access only needs ipg clock and
> per clock still does not need to be enabled here, right?
yes. we can only enable the ipg clock.
>> In the probe's uart_add_one_port(), we will register the console and
>> call the setup() hook,
>> so it's ok to disable the clocks in the end of the probe.
> Look, here is what you do in .probe().
>
> 	clk_prepare_enable(sport->clk_per);
> 	clk_prepare_enable(sport->clk_ipg);
> 	...
> 	uart_add_one_port(&imx_reg,&sport->port);
> 	...
> 	clk_disable_unprepare(sport->clk_per);
> 	clk_disable_unprepare(sport->clk_ipg);
>
> Since imx_console_setup() will be called in uart_add_one_port() and
> clocks are already being taken care of in imx_console_setup(), why do
> you need all these clock operations here at all?

I will remove all the clock operations in the probe.

thanks for pointing this.


Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
