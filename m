From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/8] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
Date: Mon, 04 Jun 2018 13:17:41 +0300
Message-ID: <3a66327727d9bf2ce5adf8ef0f1fcc1fffeaa4ec.camel@linux.intel.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
         <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2018-06-01 at 14:40 +0200, Giulio Benetti wrote:
> Some 8250 ports only have TEMT interrupt, so current implementation
> can't work for ports without it. The only chance to make it work is to
> loop-read on LSR register.
> 
> With NO TEMT interrupt check if both TEMT and THRE are set looping on
> LSR register.

> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

> -		int ret = serial8250_em485_init(up);
> +		int ret = serial8250_em485_init(up, false);

Is true for all possible DW configured types? Or it's your particular
case?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
