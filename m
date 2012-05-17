From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v2] serial: samsung: Fixed wrong comparison for	baudclk_rate
Date: Thu, 17 May 2012 15:55:03 +0900
Message-ID: <0b1f01cd33f9$fc9503f0$f5bf0bd0$%kim@samsung.com>
References: <000501cd3297$75fba910$61f2fb30$%kim@samsung.com>
 <20120515124538.GN10453@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20120515124538.GN10453@n2100.arm.linux.org.uk>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Kyoungil Kim' <ki0351.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Jun-Ho Yoon' <junho78.yoon@samsung.com>, 'Alan Cox' <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> On Tue, May 15, 2012 at 09:37:16PM +0900, Kyoungil Kim wrote:
> > port->baudclk_rate should be compared to the rate of port->baudclk,
> > because port->baudclk_rate was assigned as the rate of port->baudclk
> previously.
> > So to check that the current baudclk rate is same as previous rate,
> > the target of comparison sholud be the rate of port->baudclk.
> >
> > Signed-off-by: Jun-Ho, Yoon <junho78.yoon@samsung.com>
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> > ---
> >  drivers/tty/serial/samsung.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > index d8b0aee..6a6a86a 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -1014,10 +1014,10 @@ static int
> s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
> >  	 * a disturbance in the clock-rate over the change.
> >  	 */
> >
> > -	if (IS_ERR(port->clk))
> > +	if (IS_ERR(port->baudclk) || port->baudclk == NULL)
> 
> Still no.  Why are you wanting to detect a NULL baud clock?
> 
> As I said, drivers have no business interpreting anything but IS_ERR(clk)
> as being an error.  They should not make any other assumptions.
> 
> Now that I look at this driver, it makes this mistake all over the place.
> This needs to be fixed.  Something like the below should do it.  Please
> check.
> 

Russell, thanks for your kindly pointing out.

Kyoungil, could you please re-submit for this as per Russell's suggestion
(with Russell's patch)?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index d8b0aee..6a952b1 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -529,7 +529,7 @@ static void s3c24xx_serial_pm(struct uart_port *port,
> unsigned int level,
> 
>  	switch (level) {
>  	case 3:
> -		if (!IS_ERR(ourport->baudclk) && ourport->baudclk != NULL)
> +		if (!IS_ERR(ourport->baudclk))
>  			clk_disable(ourport->baudclk);
> 
>  		clk_disable(ourport->clk);
> @@ -538,7 +538,7 @@ static void s3c24xx_serial_pm(struct uart_port *port,
> unsigned int level,
>  	case 0:
>  		clk_enable(ourport->clk);
> 
> -		if (!IS_ERR(ourport->baudclk) && ourport->baudclk != NULL)
> +		if (!IS_ERR(ourport->baudclk))
>  			clk_enable(ourport->baudclk);
> 
>  		break;
> @@ -713,9 +713,9 @@ static void s3c24xx_serial_set_termios(struct
> uart_port *port,
>  	if (ourport->baudclk != clk) {
>  		s3c24xx_serial_setsource(port, clk_sel);
> 
> -		if (ourport->baudclk != NULL && !IS_ERR(ourport->baudclk)) {
> +		if (!IS_ERR(ourport->baudclk)) {
>  			clk_disable(ourport->baudclk);
> -			ourport->baudclk  = NULL;
> +			ourport->baudclk = ERR_PTR(-EINVAL);
>  		}
> 
>  		clk_enable(clk);
> @@ -1160,6 +1160,9 @@ static ssize_t s3c24xx_serial_show_clksrc(struct
> device *dev,
>  	struct uart_port *port = s3c24xx_dev_to_port(dev);
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> 
> +	if (IS_ERR(ourport->baudclk))
> +		return -EINVAL;
> +
>  	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->baudclk->name);
>  }
> 
> @@ -1200,6 +1203,7 @@ static int s3c24xx_serial_probe(struct
> platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> +	ourport->baudclk = ERR_PTR(-EINVAL);
>  	ourport->info = ourport->drv_data->info;
>  	ourport->cfg = (pdev->dev.platform_data) ?
>  			(struct s3c2410_uartcfg *)pdev->dev.platform_data :
