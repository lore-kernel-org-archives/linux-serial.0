From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/5] earlycon hang under some conditions
Date: Mon, 24 Jul 2017 16:50:49 -0700
Message-ID: <CAD=FV=W5+jEE21DC6=cr=5koYeDAShVbqtad-Dy2oaRVzwQSVA@mail.gmail.com>
References: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <briannorris@chromium.org>, Peter Hurley <peter@hurleysoftware.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Mon, Jul 17, 2017 at 11:02 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> I was testing earlycon with 8250 dw serial console. And it hangs in
> these cases:
> 1/ kernel hang when calling early write function after free_initmem:
> a) the earlycon not disabled after the init code(due to keep_bootcon or
>    not specify a real console to switch to)
> b) the early write func is marked as __init, for example 8250_early.
>
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
>
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

I looked through all 5 patches and they seem sane to me.  I didn't go
through and test them since Brian already tested the patches for the
one UART driver I'd have access to anyway.

As per my previous email, I don't see any need to solve all the
world'd problems with this patch series, plus the keep_bootcon seems
to be an experts / debugging type option and it seems sane if you need
to take care in using it.

So officially for the series (FWIW since I'm just an interested 3rd party):

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
