From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 20/45] drivers: tty: serial: msm_serial: use devm_*
 functions
Date: Sun, 26 May 2019 22:57:15 -0700
Message-ID: <20190527055715.GW31438@minitux>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-21-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552602855-26086-21-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Thu 14 Mar 15:33 PDT 2019, Enrico Weigelt, metux IT consult wrote:

> Use the safer devm versions of memory mapping functions.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

As pointed out by others, this resource does not follow the life cycle
of the port->dev, so I don't think this improves the code.

Regards,
Bjorn

> ---
>  drivers/tty/serial/msm_serial.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 1090960..e8e0c87 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1324,8 +1324,8 @@ static void msm_release_port(struct uart_port *port)
>  		return;
>  	size = resource_size(uart_resource);
>  
> -	release_mem_region(port->mapbase, size);
> -	iounmap(port->membase);
> +	devm_release_mem_region(port->dev, port->mapbase, size);
> +	devm_iounmap(port->dev, port->membase);
>  	port->membase = NULL;
>  }
>  
> @@ -1342,10 +1342,13 @@ static int msm_request_port(struct uart_port *port)
>  
>  	size = resource_size(uart_resource);
>  
> -	if (!request_mem_region(port->mapbase, size, "msm_serial"))
> +	if (!devm_request_mem_region(port->dev,
> +				     port->mapbase,
> +				     size,
> +				     "msm_serial"))
>  		return -EBUSY;
>  
> -	port->membase = ioremap(port->mapbase, size);
> +	port->membase = ioremap(port->dev, port->mapbase, size);
>  	if (!port->membase) {
>  		ret = -EBUSY;
>  		goto fail_release_port;
> @@ -1354,7 +1357,7 @@ static int msm_request_port(struct uart_port *port)
>  	return 0;
>  
>  fail_release_port:
> -	release_mem_region(port->mapbase, size);
> +	devm_release_mem_region(port->dev, port->mapbase, size);
>  	return ret;
>  }
>  
> -- 
> 1.9.1
> 
