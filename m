From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 1/3] ACPI: amba bus probing support
Date: Sun, 3 Jan 2016 13:36:46 +0000
Message-ID: <20160103133645.GC5779@n2100.arm.linux.org.uk>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
 <1450880383-29560-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450880383-29560-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 23, 2015 at 05:19:40PM +0300, Aleksey Makarov wrote:
> +	dev = amba_device_alloc(NULL, 0, 0);
> +	if (!dev) {
> +		dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
...
> +	/*
> +	 * If the ACPI node has a parent and that parent has a physical device
> +	 * attached to it, that physical device should be the parent of the
> +	 * platform device we are about to create.
> +	 */
> +	dev->dev.parent = NULL;

No need to initialise this; amba_device_alloc() uses kzalloc(), and so
dev->dev.parent will already be NULL.

...
> +	dev_set_name(&dev->dev, "%s", dev_name(&adev->dev));

Is there a reason not to use:

	dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);

above?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
