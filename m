From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] 8250_dw: Support all baudrates on baytrail
Date: Thu, 17 Apr 2014 14:24:55 -0700
Message-ID: <CAAYSxhq6-H7X080G_iQ-hSVc6HkZvKiwLA=Sq0pgQ0P_EUozsQ@mail.gmail.com>
References: <1397136684-11515-1-git-send-email-loic.poulain@intel.com>
	<20140417111953.GB17611@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:42899 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaDQVY4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2014 17:24:56 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so1063771obc.34
        for <linux-serial@vger.kernel.org>; Thu, 17 Apr 2014 14:24:56 -0700 (PDT)
In-Reply-To: <20140417111953.GB17611@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Loic Poulain <loic.poulain@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Thu, Apr 17, 2014 at 4:19 AM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> Well, we are already handling this same refclk in the clk that is
> provided to this driver in case of BYT, so we should probable handle
> this in that as well. Then we could have a more generic set_termios
> where we do something like this..
>
> static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>                                struct ktermios *old)
> {
>         unsigned int baud = tty_termios_baud_rate(termios);
>         struct dw8250_data *d = p->private_data;
>         unsigned int rate;
>         int ret;
>
>         rate = clk_round_rate(d->clk, baud*16);
>         ret = clk_set_rate(d->clk, rate);
>         if (!ret)
>                 p->uartclk = rate;
>         serial8250_do_set_termios(p, termios, old);
> }

On Broadcom's mobile SoCs, the external clock that feeds into the DW
UART can switch between high and low frequency parents.

The above may result in a lower frequency parent being selected in
cases where a higher frequency parent could yield better actual baud
rate.

Consider if 115,200 baud was requested and parents provided 2 MHz and
104 MHz.  This would select 2 MHz (for 125,000 baud) instead of 104
MHz (for 116,071 baud).

To get the best baud rate accuracy, the capabilities of the internal
divider need to be considered together with those of the external
clock.

-Tim
