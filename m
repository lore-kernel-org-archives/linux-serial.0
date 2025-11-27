Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2B283121;
	Thu, 27 Nov 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270472; cv=none; b=ORg/4uDW1iQudXLTL5vckiV8c4g2RrA0VqvKcV9MnSZCvK9CFkHCKqEZis1Kev3OQaLiNwPBMloX0GA7eMoVaRbuVhEBFch4sRwsfwhXW+TIF63DSzOI6c4JDn4QbA9k1YrOfE+kbi/hJ6rr+Kxdq/x0O/LRDAJsqOugLTQGv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270472; c=relaxed/simple;
	bh=JKj3WRs8VmpjdQTFRDoG6VMyBxtWlzLWDeG34s6vSvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrV4sIXeLOUaGkmcZZkfA9+3StHuXJT14EwdcSCpFiba9eSAX0f76CrWvaNBBLfmdq1hB9EMAlzD9lTTvSy7xXheUr5t9ziSW99idYralbx8bGgjopCjYYVuY84od7k1xfKQhCEzdjDPc6fXf3t6hOciKy/XNmX2ntW5gCs2az4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/YHeLPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/YHeLPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0482C4CEF8;
	Thu, 27 Nov 2025 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764270471;
	bh=JKj3WRs8VmpjdQTFRDoG6VMyBxtWlzLWDeG34s6vSvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/YHeLPtOT4UmcxSFBAY/k42w46ApXovcuWE5r1aZQpsY4uPrMryCaw6cbHfq5UDj
	 ku5clLPyfq4STJghlRItnk01JZcurKm/wKjNtcAKyUihH0yeqs+NMyH7dqaFWGYHPB
	 Ktl1UzHZZ53bLWr7eQKV3Jr++vkkhiF8FdzE7kd0=
Date: Thu, 27 Nov 2025 20:07:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
Message-ID: <2025112739-hassle-duplicate-c31d@gregkh>
References: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>

On Thu, Nov 27, 2025 at 05:36:50PM +0100, Andy Shevchenko wrote:
> The change that restores sysfs fwnode information does it only for OF cases.
> Update the fix to cover all possible types of fwnodes.
> 
> Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/serial_base_bus.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 22749ab0428a..8e891984cdc0 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -13,7 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/idr.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/serial_core.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -60,6 +60,7 @@ void serial_base_driver_unregister(struct device_driver *driver)
>  	driver_unregister(driver);
>  }
>  
> +/* On failure the caller must put device @dev with put_device() */
>  static int serial_base_device_init(struct uart_port *port,
>  				   struct device *dev,
>  				   struct device *parent_dev,
> @@ -73,7 +74,8 @@ static int serial_base_device_init(struct uart_port *port,
>  	dev->parent = parent_dev;
>  	dev->bus = &serial_base_bus_type;
>  	dev->release = release;
> -	device_set_of_node_from_dev(dev, parent_dev);
> +
> +	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>  
>  	if (!serial_base_initialized) {
>  		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
> @@ -94,7 +96,7 @@ static void serial_base_ctrl_release(struct device *dev)
>  {
>  	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
>  
> -	of_node_put(dev->of_node);
> +	fwnode_handle_put(dev_fwnode(dev));
>  	kfree(ctrl_dev);
>  }
>  
> @@ -142,7 +144,7 @@ static void serial_base_port_release(struct device *dev)
>  {
>  	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
>  
> -	of_node_put(dev->of_node);
> +	fwnode_handle_put(dev_fwnode(dev));
>  	kfree(port_dev);
>  }
>  
> -- 
> 2.50.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
