From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v4 0/8] Various patches for SAMA5D2 backup mode
Date: Thu, 28 Sep 2017 12:02:22 +0200
Message-ID: <20170928100222.nnocjkyd5qkly6qx@piout.net>
References: <20170928094627.31017-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170928094627.31017-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alan Stern <stern@rowland.harvard.edu>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>lin
List-Id: linux-serial@vger.kernel.org

Hi,

On 28/09/2017 at 11:46:19 +0200, Romain Izard wrote:
> While the core of the backup mode for SAMA5D2 has been integrated in
> v4.13, it is far from complete. Individual controllers in the chip have
> drivers that do not support the reset of the registers during suspend,
> and they need to be adapted to handle it.
> 
> The first patch uses the clock wakeup code from the prototype backup
> mode instead of the version integrated in the mainline, as the mainline
> version is not stable. During a test loop with two-second backup
> suspend, the mainline version will hang in less than one day, whereas
> the prototype version has been running the same test for more than a
> week without hanging.
> 
> While all these patches are provided in a series, the clock, mtd,
> usb, pwm and mfd patch do not depend on each other.
> 
> Changes in v2:
> * drop the IIO patch duplicating existing code
> * determine the number of programmable clocks to save dynamically
> * declare a required local variable in the tty/serial patch
> 
> Changes in v3:
> * drop dev_printk changes for PMECC
> * rework the resume code for PMECC
> * improve comments on PMC clock handling
> 
> Changes in v4:
> * fix a bug in the PMECC resume code
> 
> Romain Izard (8):
>   clk: at91: pmc: Wait for clocks when resuming
>   clk: at91: pmc: Save SCSR during suspend
>   clk: at91: pmc: Support backup for programmable clocks
>   mtd: nand: atmel: Avoid ECC errors when leaving backup mode
>   ehci-atmel: Power down during suspend is normal
>   pwm: atmel-tcb: Support backup mode
>   atmel_flexcom: Support backup mode
>   tty/serial: atmel: Prevent a warning on suspend
> 

Really, you have to stop sending those independent patches as a series
if you want to have a chance to see them being merged.

>  drivers/clk/at91/clk-programmable.c      |  2 +
>  drivers/clk/at91/pmc.c                   | 63 ++++++++++++++++++++++++++-----
>  drivers/clk/at91/pmc.h                   |  2 +
>  drivers/mfd/atmel-flexcom.c              | 65 ++++++++++++++++++++++++--------
>  drivers/mtd/nand/atmel/nand-controller.c |  3 ++
>  drivers/mtd/nand/atmel/pmecc.c           | 17 +++++----
>  drivers/mtd/nand/atmel/pmecc.h           |  1 +
>  drivers/pwm/pwm-atmel-tcb.c              | 63 ++++++++++++++++++++++++++++++-
>  drivers/tty/serial/atmel_serial.c        | 13 +++++++
>  drivers/usb/host/ehci-atmel.c            |  3 +-
>  10 files changed, 196 insertions(+), 36 deletions(-)
> 
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
