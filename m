From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for
	handling modem signals
Date: Sat, 27 Sep 2014 11:07:38 +0100
Message-ID: <20140927100737.GC5182@n2100.arm.linux.org.uk>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl> <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:44757 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752719AbaI0KHr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 06:07:47 -0400
Content-Disposition: inline
In-Reply-To: <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org

On Sat, Sep 27, 2014 at 11:46:35AM +0200, Janusz Uzycki wrote:
> @@ -635,7 +645,12 @@ static void mxs_auart_settermios(struct uart_port *u,
>  		ctrl |= AUART_LINECTRL_STP2;
>  
>  	/* figure out the hardware flow control settings */
> -	if (cflag & CRTSCTS) {
> +	/* FIXME: Likely DMA could be enabled not only for HW flow control */
> +	if (cflag & CRTSCTS &&
> +			(IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
> +					 UART_GPIO_RTS)) ||
> +			 IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,
> +					 UART_GPIO_CTS)))) {

There has to be a better way to do this.

> +static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
> +{
> +	s->gpios = mctrl_gpio_init(dev, 0);
> +	if (IS_ERR_OR_NULL(s->gpios))
> +		return -1;
> +	return 0;

I personally hate the practise of returning -1 - it ends up getting returned
to userspace as an error code, and it means EPERM.  If you want to indicate
success/failure, use the bool return type, and return true/false.

> @@ -1074,6 +1100,11 @@ static int mxs_auart_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, s);
>  
> +	ret = mxs_auart_init_gpios(s, &pdev->dev);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "%s",
> +			"Failed to initialize GPIOs. The serial port may not work as expected");

Does the "%s" do anything for this message?  More importantly though, it's
lacking a newline.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
