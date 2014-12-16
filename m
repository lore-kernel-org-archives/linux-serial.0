From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add hardware flow control support of
 R-Car HSCIF
Date: Tue, 16 Dec 2014 14:42:11 +0900
Message-ID: <CANqRtoSEGxczvGQAcBBz1bE64xfRd9U7qmmn=9wGTbyb-9-Z_w@mail.gmail.com>
References: <1418652846-6821-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418652846-6821-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Kaneko-san,

On Mon, Dec 15, 2014 at 11:14 PM, Yoshihiro Kaneko
<ykaneko0929@gmail.com> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> TIOCM_CTS is enabled to use hardware flow control of HSCIF.
> And hardware flow control of HSCIF is handled by device tree.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
> tree.
>
>  drivers/tty/serial/sh-sci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index bcec10a..6744702 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1216,7 +1216,11 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
>          * CTS/RTS is handled in hardware when supported, while nothing
>          * else is wired up. Keep it simple and simply assert DSR/CAR.
>          */
> -       return TIOCM_DSR | TIOCM_CAR;
> +       unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
> +
> +       if (port->type == PORT_HSCIF)
> +               mctrl |= TIOCM_CTS;
> +       return mctrl;
>  }
>
>  #ifdef CONFIG_SERIAL_SH_SCI_DMA

Thanks for the patch. I suspect that a bit more work is needed to
enable CTS handling as expected in this driver...

> @@ -2611,6 +2615,8 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
>         p->type = info->type;
>         p->regtype = info->regtype;
>         p->scscr = SCSCR_RE | SCSCR_TE;
> +       if (of_property_read_bool(np, "ctsrts"))
> +               p->capabilities = SCIx_HAVE_RTSCTS;

Also, for this particular DT property, perhaps we need to document it somehow?

Thanks,

/ magnus
