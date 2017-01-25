From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] serial: sh-sci: Reformat sci_parse_dt() for git diff
Date: Wed, 25 Jan 2017 17:45:53 +0100
Message-ID: <20170125164552.GB12042@verge.net.au>
References: <1485356149-2731-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485356149-2731-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 25, 2017 at 03:55:49PM +0100, Geert Uytterhoeven wrote:
> As the function header of sci_parse_dt() is split in an unusual way,
> "git diff" gets confused when changes to the body of the function are
> made, and attributes them to the wrong function.
> 
> Reformat the function header to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/tty/serial/sh-sci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 9bc9756a2d15d574..a589544f320661f5 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2816,8 +2816,8 @@ static int sci_remove(struct platform_device *dev)
>  };
>  MODULE_DEVICE_TABLE(of, of_sci_match);
>  
> -static struct plat_sci_port *
> -sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
> +static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
> +					  unsigned int *dev_id)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	const struct of_device_id *match;
> -- 
> 1.9.1
> 
