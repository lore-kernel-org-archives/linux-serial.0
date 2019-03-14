From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date: Thu, 14 Mar 2019 15:52:04 -0700
Message-ID: <20190314225204.GB1795@kroah.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552602855-26086-11-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
> Use the safer devm versions of memory mapping functions.

What is "safer" about them?

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/tty/serial/zs.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
> index b03d3e4..0b1ec2f 100644
> --- a/drivers/tty/serial/zs.c
> +++ b/drivers/tty/serial/zs.c
> @@ -984,16 +984,17 @@ static const char *zs_type(struct uart_port *uport)
>  
>  static void zs_release_port(struct uart_port *uport)
>  {
> -	iounmap(uport->membase);
> +	devm_iounmap(uport->dev, uport->membase);
>  	uport->membase = 0;
> -	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
> +	devm_release_mem_region(uport->dev, uport->mapbase, ZS_CHAN_IO_SIZE);

Isn't the whole goal of the devm* functions such that you are not
required to call "release" on them?

If so, are you sure this patchset is correct?

And also, why make the change, you aren't changing any functionality for
these old drivers at all from what I can tell (for the devm calls).
What am I missing here?

thanks,

greg k-h
