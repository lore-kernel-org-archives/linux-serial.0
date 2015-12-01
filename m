From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Tue, 01 Dec 2015 03:21:47 +0100
Message-ID: <14968240.IklpWf8GZo@vostro.rjw.lan>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org> <1443609530-21524-4-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-4-git-send-email-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Wednesday, September 30, 2015 11:38:50 AM Graeme Gregory wrote:
> In ACPI this device is only defined in SBSA mode so
> if we are probing from ACPI use this mode.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index fd27e98..55209aa 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2368,18 +2368,28 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  	if (!uap)
>  		return -ENOMEM;
>  
> -	uap->clk = devm_clk_get(&dev->dev, NULL);
> -	if (IS_ERR(uap->clk))
> -		return PTR_ERR(uap->clk);
> -
> -	uap->vendor = vendor;
> -	uap->lcrh_rx = vendor->lcrh_rx;
> -	uap->lcrh_tx = vendor->lcrh_tx;
> -	uap->fifosize = vendor->get_fifosize(dev);
> +	/* ACPI only defines SBSA variant */
> +	if (!ACPI_COMPANION(&dev->dev)) {

It would read more straightforward if you did

	if (ACPI_COMPANION(&dev->dev)) {
		<handle the ACPI case>
	} else {
		<handle the non-ACPI case>
	}

> +		uap->clk = devm_clk_get(&dev->dev, NULL);
> +		if (IS_ERR(uap->clk))
> +			return PTR_ERR(uap->clk);
> +
> +		uap->vendor = vendor;
> +		uap->lcrh_rx = vendor->lcrh_rx;
> +		uap->lcrh_tx = vendor->lcrh_tx;
> +		uap->fifosize = vendor->get_fifosize(dev);
> +		uap->port.ops = &amba_pl011_pops;
> +		snprintf(uap->type, sizeof(uap->type), "PL011 rev%u",
> +				amba_rev(dev));
> +	 } else {
> +		uap->vendor	= &vendor_sbsa;
> +		uap->fifosize	= 32;
> +		uap->port.ops	= &sbsa_uart_pops;
> +		uap->fixed_baud = 115200;
> +
> +		snprintf(uap->type, sizeof(uap->type), "SBSA");

This looks sort of heavy-handed.

Is this the only possible configuration of the device in the ACPI case?

> +	}
>  	uap->port.irq = dev->irq[0];
> -	uap->port.ops = &amba_pl011_pops;
> -
> -	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
>  
>  	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
>  	if (ret)

Thanks,
Rafael

