From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/9] tty: remove tty_struct dependency in tty flag macros
Date: Fri, 9 Sep 2016 20:02:40 -0500
Message-ID: <CAL_JsqJZQU4qjo-vjTR264ox5Y52y1vU6iGA+jWeiFU4BQCBQg@mail.gmail.com>
References: <20160909223711.26238-1-robh@kernel.org> <20160909223711.26238-3-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-3-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 9, 2016 at 5:37 PM, Rob Herring <robh@kernel.org> wrote:
> In preparation to support tty drivers having only a tty_port and
> possibly not a tty_struct, convert all the termios flag macros to take a
> termios ptr instead of the tty_struct ptr. After this change drivers can
> be converted to support a termios struct other than tty->termios.

[...]

> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 832cbd647145..e5d7e4db6bdc 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -560,7 +560,7 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
>                         dev_err(chan2dev(chan), "invalid src maxburst value\n");
>                         return -EINVAL;
>                 }
> -               atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
> +               atchan->cfg |= AT_XDMAC_CC_CSIZE(&csize->termios);
>                 dwidth = ffs(atchan->sconfig.src_addr_width) - 1;
>                 if (dwidth < 0) {
>                         dev_err(chan2dev(chan), "invalid src addr width value\n");
> @@ -583,7 +583,7 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
>                         dev_err(chan2dev(chan), "invalid src maxburst value\n");
>                         return -EINVAL;
>                 }
> -               atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
> +               atchan->cfg |= AT_XDMAC_CC_CSIZE(&csize->termios);
>                 dwidth = ffs(atchan->sconfig.dst_addr_width) - 1;
>                 if (dwidth < 0) {
>                         dev_err(chan2dev(chan), "invalid dst addr width value\n");

This file needs to be dropped. There were a few false matches and I
missed this one.

Rob
