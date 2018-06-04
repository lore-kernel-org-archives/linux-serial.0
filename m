From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/8] serial: 8250: Add 485 emulation to 8250_dw.
Date: Mon, 04 Jun 2018 13:12:07 +0300
Message-ID: <65c26f5db1275e958cfe6390e9336568b0158dea.camel@linux.intel.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Matwey V.Kornilov" <matwey@sai.msu.ru>
Cc: Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2018-06-01 at 14:40 +0200, Giulio Benetti wrote:
> Need to handle rs485 with 8250_dw port.
> 
> Use existing em485 emulation layer for 8250 taking care to fix some
> bug
> and taking care especially of RTS_AFTER_SEND case.
> 

I don't see in Cc list author of rs485 code, who might be interested in
this.

So, added him here.

> Giulio Benetti (8):
>   serial: 8250_dw: add em485 support
>   serial: 8250_dw: allow enable rs485 at boot time
>   serial: 8250: Copy em485 from port to real port.
>   serial: 8250: Handle case port doesn't have TEMT interrupt using
>     em485.
>   serial: 8250_dw: treat rpm suspend with -EBUSY if RS485 ON and
>     RTS_AFTER_SEND
>   serial: 8250: Copy mctrl when register port.
>   serial: 8250: Make em485_rts_after_send() set mctrl according to rts
>     state.
>   serial: core: Mask mctrl with TIOCM_RTS too if rs485 on and
>     RTS_AFTER_SEND set.
> 
>  drivers/tty/serial/8250/8250.h      |  2 +-
>  drivers/tty/serial/8250/8250_core.c |  2 ++
>  drivers/tty/serial/8250/8250_dw.c   | 41
> ++++++++++++++++++++++++++++-
>  drivers/tty/serial/8250/8250_omap.c |  2 +-
>  drivers/tty/serial/8250/8250_port.c | 33 ++++++++++++++++-------
>  drivers/tty/serial/serial_core.c    | 12 ++++++++-
>  include/linux/serial_8250.h         |  1 +
>  7 files changed, 79 insertions(+), 14 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
