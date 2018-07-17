From: Ulrich Hecht <ulrich.hecht@gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Fix use-after-free on subsequent port startup
Date: Tue, 17 Jul 2018 12:35:34 +0200
Message-ID: <CAO3366w+3v3vqNq=PHeKMB4uumwgJeXXqnby8HB4jLmBQiVDRQ@mail.gmail.com>
References: <20180717085810.23502-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717085810.23502-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 17, 2018 at 10:58 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> sci_request_irq() checks port->irqstr[j] for a NULL pointer, to decide
> if a fallback interrupt name string should be allocated or not.
>
> While this string is freed during port shutdown, the pointer is not
> zeroed.  Hence on a subsequent startup of the port, it will still be
> pointing to the freed memory, leading to e.g.
>
>     WARNING: CPU: 0 PID: 404 at fs/proc/generic.c:388 __proc_create+0xbc/0x260
>     name len 0
>
> or to a crash (the latter is more likely with CONFIG_DEBUG_SLAB=y, due
> to the poisoning of freed memory).
>
> Instead of zeroeing the pointer at multiple places, preinitialize
> port->irqstr[j] to zero to fix this.
>
> Fixes: 8b0bbd956228ae87 ("serial: sh-sci: Add support for R7S9210")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5808edfe3f7be404..f8e53ac5c17dfb94 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1872,6 +1872,7 @@ static int sci_request_irq(struct sci_port *port)
>                 }
>
>                 desc = sci_irq_desc + i;
> +               port->irqstr[j] = NULL;
>                 if (SCIx_TEIDRI_IRQ_EXISTS(port)) {
>                         /*
>                          * ERI and BRI are muxed, just register ERI and
> --
> 2.17.1
>

Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

CU
Uli
