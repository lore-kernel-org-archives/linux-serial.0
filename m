Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7B78F2B;
	Sun, 21 Dec 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766306427; cv=none; b=C4juNeIcntctHDbMLLso1xxSg8AGCT20guVTXQPEyfGHvHAYPlGZLnFWcC4iMSDUWtwT+Bnuz2J0nZIMX+7Q9j5xL3ilJkfL0i3Ae6CieaQjiBLabNekBZc4iqX5+Z69EDUO3UBJxJFINn7I2+3n4Cjsz8B/n/FqV61uHl27kzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766306427; c=relaxed/simple;
	bh=Kszs5gtlRd/DxMlQuM6/YBh076miLN1hKA9oogh7hZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwqOMfKioMMzHQIVlu+1E59KlzOy/7W4TB+0uDE+kS+t+vfHhT9yx42n8RsbQU4paM7aItyqD31nOcf8Eon1NlyVxd6YMeppprYcbETYAjgpZgGIYQH1wxLqgR4czOG3bV5DrWmEjM+j1hrM2ersKfB8a1H/lHjOKOQUD80Sw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VH/f+2p0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VH/f+2p0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0774C4CEFB;
	Sun, 21 Dec 2025 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766306427;
	bh=Kszs5gtlRd/DxMlQuM6/YBh076miLN1hKA9oogh7hZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VH/f+2p0InQuwQhDOI9f7Cp1umwXTO/JI7bd8AzzeSgAf6advF6Zi3rFnXOkKNKGq
	 wNBqFN1orr85tELq+rRy9NB7YlS22Su88hyZMIkOFb2q99m0d7eu7i3Wma0+kqz86R
	 3gGLevuow8Rg907mHau+pn+BadpEmXl4g/CQATXE=
Date: Sun, 21 Dec 2025 09:40:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH 1/1] serial: core: Fix serial device initialization
Message-ID: <2025122151-petition-joylessly-bdc5@gregkh>
References: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>

On Fri, Dec 19, 2025 at 04:28:12PM +0100, Alexander Stein wrote:
> During restoring sysfs fwnode information the information of_node_reused
> was dropped. This was previously set by device_set_of_node_from_dev().
> Add it back manually
> 
> Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
> Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/tty/serial/serial_base_bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index 8e891984cdc0d..1e1ad28d83fcf 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -74,6 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
>  	dev->parent = parent_dev;
>  	dev->bus = &serial_base_bus_type;
>  	dev->release = release;
> +	dev->of_node_reused = true;
>  
>  	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>  
> -- 
> 2.43.0
> 
> 

Can I get some confirmation from people that this resolves the issue, or
should I just revert the original problem commit instead and wait for a
tested new version?

thanks,

greg k-h
