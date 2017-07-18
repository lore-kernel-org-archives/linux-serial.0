From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/5] earlycon hang under some conditions
Date: Tue, 18 Jul 2017 10:51:51 -0700
Message-ID: <20170718175149.GA131686@google.com>
References: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, dianders@chromium.org, peter@hurleysoftware.com, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Jeffy,

On Tue, Jul 18, 2017 at 02:02:53PM +0800, Jeffy Chen wrote:
> I was testing earlycon with 8250 dw serial console. And it hangs in
> these cases:
> 1/ kernel hang when calling early write function after free_initmem:
> a) the earlycon not disabled after the init code(due to keep_bootcon or
>    not specify a real console to switch to)
> b) the early write func is marked as __init, for example 8250_early.

FWIW, I tested 8250_early with "keep_bootcon", and this fixes that:

Tested-by: Brian Norris <briannorris@chromium.org>

But then I get double console, if I have both a "real" and "early"
console.

If I were to *only* have the early console, then I might hit the
problems you mention:

> 2/ kernel hang when calling early write function after disable unused
> clks/pm domain:
> a) the earlycon not disabled after the init code
> b) the disable unused clks/pm domain kill the requiered clks/pm
>    domain, since they are not referenced by the earlycon.
> 
> 3/ kernel hang when calling early write function after the serial
>    console driver runtime suspended:
> a) the earlycon not disabled after the init code
> b) the serial console driver's runtime suspend kills the requiered
>    clks/pm domain, since they are not referenced by the earlycon.
> 
> This serial fix 1/ case only.

Problems 2 and 3 look like something that's not really in scope for
early consoles. There's a reason they are mainly supported for early
boot, and we try to switch off of them. There isn't really a good way to
handle all the clock and PM infrastructure without...switching off the
earlycon and using the real one :)

So, I guess this patchset has value for systems where the clock/PM
requirements are simple enough, and the earlycon can actually be useful
beyond early init.

Brian

> 
> 
> Jeffy Chen (5):
>   serial: arc: Remove __init marking from early write
>   serial: omap: Remove __init marking from early write
>   serial: xuartps: Remove __init marking from early write
>   serial: 8250_ingenic: Remove __init marking from early write
>   serial: 8250_early: Remove __init marking from early write
> 
>  drivers/tty/serial/8250/8250_early.c   |  8 ++++----
>  drivers/tty/serial/8250/8250_ingenic.c |  8 ++++----
>  drivers/tty/serial/arc_uart.c          |  4 ++--
>  drivers/tty/serial/omap-serial.c       | 13 ++++++-------
>  drivers/tty/serial/xilinx_uartps.c     |  2 +-
>  5 files changed, 17 insertions(+), 18 deletions(-)
> 
> -- 
> 2.1.4
> 
> 
