Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61F49DBB1
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167946; cv=none; b=Cs9PWGjGHtbLekHh1XHLBkbSxKzT/wRsxng7/UexHaUzFyDne2+5/80Dl4qjytHmUz5pgiI/cVKvQLja1sa36CK1ZVvaKopSxr0boC7/C+lzQfopjHB2PaTI0EBZLI7ENJdk1alRNBfBbOVytNgpopoZuYdjLPM4O70X8YVO1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167946; c=relaxed/simple;
	bh=IQsXcjP7TKsKjebp28ls8C8aLE+JHrJLWZIW2ZMed64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9fYNh4X3X8Sx1eYTLOqLBExpBpi5oIPs7a382p4baimnZUXxFNAWSHVnHcH3oL/tYliov9XziWrfGWX/3CvP7NjauaZWIaWWEFca57/MkEdzuvXdF5VVqvx5llABNjsZY9Qre/0ox1ws0xJyQAWDVNNQ9UlJv02xoyd6GKzh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IanhZtgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IanhZtgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23411F000FF;
	Wed, 23 Sep 2026 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790167945;
	bh=XiYmQuqeK52PSDvi3lPox/TrhcJC2P4xI90EYj6Wx6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IanhZtgK58iGu0NPXpOwdqmjB4Cd7CLBiXBxaR01paJdqz0J9GFF8J/fVyN3DJpEv
	 miZgTVvrs2Z2LP8Rtx2YbNW/gF2i/tl01oFpNJ6JLd5reLmjz4eyVwnZ6LT3lRMnea
	 0nQDKbZzLSUCucCO5KZM05g2Qi8kcTMvqXV9Mymo=
Date: Wed, 23 Sep 2026 14:52:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: lujialin4@huawei.com, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
	kmehltretter@gmail.com, john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com, tony@atomide.com,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH -next] serial: core: fix NULL/dangling port_dev on failed
 re-register
Message-ID: <2026092332-divisible-hypocrite-d223@gregkh>
References: <20260914135154.3260303-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914135154.3260303-1-cuigaosheng1@huawei.com>

On Mon, Sep 14, 2026 at 09:51:54PM +0800, Gaosheng Cui wrote:
> From: Cui GaoSheng <cuigaosheng1@huawei.com>
> 
> serial8250_unregister_port() removes a port and then re-registers it
> against the legacy serial8250 device when that device is still
> present, ignoring the return value of uart_add_one_port(). When the
> re-register fails, the error path of serial_core_register_port()
> removes the port device but leaves port->port_dev dangling. A port
> that was never successfully registered (e.g. serial_core_port_device_add()
> failed) also reaches the unregister path with port->port_dev unset.
> serial8250 matches ports on ->dev, so such half-registered slots
> still reach serial_core_unregister_port() on the next unbind:
> 
>   Oops: general protection fault ... SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x40-0x47]
>   RIP: serial_core_unregister_port+0xe5/0xa00
>     serial8250_unregister_port+0x103
>     serial8250_remove+0x61
>     device_release_driver_internal+0x38c
>     unbind_store+0xd1
>     kernfs_fop_write_iter+0x329
>     vfs_write+0x5d0
>     ksys_write+0xf7
>     do_syscall_64+0xdd
>     entry_SYSCALL_64_after_hwframe+0x77
> 
> Fix the error path to clear port->port_dev and restore the state slot
> (guarded by line range) to the "not registered" state, and bail out of
> serial_core_unregister_port() when port_dev is NULL (either dangling
> from a failed re-register or never set).
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
> ---

Did you forget the Assited-by: tag?


>  drivers/tty/serial/serial_core.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 95774b0f1484..62d93c5964e2 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3358,6 +3358,17 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  
>  err_unregister_port_dev:
>  	serial_base_port_device_remove(port->port_dev);
> +	/*
> +	 * serial_base_port_device_remove() dropped the last reference to the
> +	 * port device, so leave no dangling ->port_dev behind. Restore the
> +	 * state slot to the same "not registered" state that
> +	 * serial_core_remove_one_port() produces on the normal path; the
> +	 * line range guard also covers the -EINVAL exit of
> +	 * serial_core_add_one_port() where line >= drv->nr.
> +	 */
> +	port->port_dev = NULL;
> +	if (port->line < drv->nr && drv->state[port->line].uart_port == port)
> +		drv->state[port->line].uart_port = NULL;


How was this tested?


>  
>  err_unregister_ctrl_dev:
>  	serial_base_ctrl_device_remove(new_ctrl_dev);
> @@ -3373,11 +3384,23 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
>  {
>  	struct device *phys_dev = port->dev;
>  	struct serial_port_device *port_dev = port->port_dev;
> -	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
> +	struct serial_ctrl_device *ctrl_dev;
>  	int ctrl_id = port->ctrl_id;
>  
> +	/*
> +	 * A port may be unregistered even though it was never successfully
> +	 * registered (e.g. an allocation failure aborted serial_core_register_port()
> +	 * part-way). Drivers like serial8250 remove ports matching on ->dev, so
> +	 * those half-registered ports still reach us with port_dev == NULL. Do not
> +	 * dereference it.
> +	 */
> +	if (!port_dev)
> +		return;

What keeps port_dev from not changing right after you read it?

thanks,

greg k-h
