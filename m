From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Thu, 3 Dec 2015 14:06:27 -0600
Message-ID: <CAOZdJXXWyYsn5g4S=L_gkPSRaANwB3=UMazdQHq5Jv4b7oQZpg@mail.gmail.com>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
	<1443609530-21524-4-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-4-git-send-email-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 30, 2015 at 5:38 AM, Graeme Gregory
<graeme.gregory@linaro.org> wrote:

> @@ -2368,18 +2368,28 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>         if (!uap)
>                 return -ENOMEM;
>
> -       uap->clk = devm_clk_get(&dev->dev, NULL);
> -       if (IS_ERR(uap->clk))
> -               return PTR_ERR(uap->clk);
> -
> -       uap->vendor = vendor;
> -       uap->lcrh_rx = vendor->lcrh_rx;
> -       uap->lcrh_tx = vendor->lcrh_tx;
> -       uap->fifosize = vendor->get_fifosize(dev);
> +       /* ACPI only defines SBSA variant */
> +       if (!ACPI_COMPANION(&dev->dev)) {
> +               uap->clk = devm_clk_get(&dev->dev, NULL);
> +               if (IS_ERR(uap->clk))
> +                       return PTR_ERR(uap->clk);
> +
> +               uap->vendor = vendor;
> +               uap->lcrh_rx = vendor->lcrh_rx;
> +               uap->lcrh_tx = vendor->lcrh_tx;
> +               uap->fifosize = vendor->get_fifosize(dev);
> +               uap->port.ops = &amba_pl011_pops;
> +               snprintf(uap->type, sizeof(uap->type), "PL011 rev%u",
> +                               amba_rev(dev));
> +        } else {
> +               uap->vendor     = &vendor_sbsa;
> +               uap->fifosize   = 32;
> +               uap->port.ops   = &sbsa_uart_pops;
> +               uap->fixed_baud = 115200;
> +
> +               snprintf(uap->type, sizeof(uap->type), "SBSA");
> +       }
>         uap->port.irq = dev->irq[0];
> -       uap->port.ops = &amba_pl011_pops;
> -
> -       snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));

I'm confused.  We already have ACPI support in amba-pl011 driver, and
pl011_probe() is never called on an SBSA system.  That's what
sbsa_uart_probe() is for.  You even added this patch:

        drivers: PL011: add ACPI probing for SBSA UART

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
