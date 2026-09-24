Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA3372B32
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260850; cv=none; b=gr7uiWOEIrnqr/ExMD4eghWJSRI7VdE6tCy++WDeEuIdkHi5L40X81X+b1fsaE0MMnzMEhPE6WgiFqQk1lmKq5tdgJ+mYT/vGDB9Y9AiNpURwShAAOj/2vXVHwBxlmxocjRZa1pWct5WG/oWed7r1tOZ638hGeXqSWR3GPEnkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260850; c=relaxed/simple;
	bh=ZeK+nJfuTneJJX1f1eUY/4RFGoJnnoD4L3ioBpd1hDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6se0/FkAPOHFuTezi0SgNY4eQ71E1p1ztijlWnpnE9Sc1twr48T/IqN9fIZwzb5954Y5/if0x1SgBLDphuyn2UvaK5rNCoRj3/nGeLfOROsLL6cd6hz+O8EWsFtpKsXr9EzcRlDXPHim63F18v6UxNaPjZ3LVbyCN+lQ1tE8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfjdCEmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfjdCEmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D061F000FF;
	Thu, 24 Sep 2026 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790260848;
	bh=W5CQv9ijbeMKCfuMlpSn3oijRXbPVpGQFg0GiGrm3C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hfjdCEmAXNahdMcAChpozj9HVGN0rEDe9sWU8QVFroI3wOcQD2c0s5f5FKC8RoK11
	 Y64cZ14/jWD66UlU0Q+UqkNh6s/Suw9Eel0v+s5rjcjt9LWZPuKybEbrwLDBHqVkta
	 iRdN3Rl8QcBhDlAfqKTH9QwZsoEJdcb38Fgj/M5A=
Date: Thu, 24 Sep 2026 16:40:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: lujialin4@huawei.com, gongruiqi1@huawei.com, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, kmehltretter@gmail.com,
	john.ogness@linutronix.de, andriy.shevchenko@linux.intel.com,
	tony@atomide.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH -next,v2] serial: core: fix NULL/dangling port_dev on
 failed re-register
Message-ID: <2026092416-outhouse-overexert-fd98@gregkh>
References: <20260924131147.1952634-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924131147.1952634-1-cuigaosheng1@huawei.com>

On Thu, Sep 24, 2026 at 09:11:47PM +0800, Gaosheng Cui wrote:
> From: Cui GaoSheng <cuigaosheng1@huawei.com>
> 
> serial8250_unregister_port() removes a port and then re-registers it
> against the legacy serial8250 device when that device is still
> present, ignoring the return value of uart_add_one_port(). When the
> re-register fails, the error path of serial_core_register_port()
> removes the port device but leaves port->port_dev dangling (or NULL
> if the port device allocation itself failed). serial8250 matches
> ports on ->dev, so such half-registered slots still reach
> serial_core_unregister_port() on the next unbind:

So this is abusing bind/unbind and not anything that normally happens in
a system, right?

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
> Fix the error path to clear port->port_dev, and bail out of
> serial_core_unregister_port() when port_dev is NULL. Read
> port->port_dev under port_mutex, like all of its writers.
> 
> Reject registering a port that is already registered: a duplicate
> attempt would otherwise mark the live port dead and orphan its
> serial core port device before failing in serial_core_add_one_port(),
> and the port could then no longer be unregistered.

How can registering a port that is already registered ever actually
happen?

> No state slot restore is needed on the error path:
> serial_core_add_one_port() has no failure exit after linking
> state->uart_port, so a failed registration never links the state
> slot in the first place.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework
> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
> ---
> Changes in v2:
> - Drop the state slot restore from the registration error path.
> - Move the port->port_dev read and the !port_dev bail in
>   serial_core_unregister_port() under port_mutex.
> - Reject registering a port that is already registered.
>  drivers/tty/serial/serial_core.c | 37 +++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 95774b0f1484..5651313a2468 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3318,10 +3318,20 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
>  int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  {
>  	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
> -	int ret;
> +	int i, ret;
>  
>  	guard(mutex)(&port_mutex);
>  
> +	/*
> +	 * Reject registration of a port that is already registered. Bail
> +	 * out before taking any steps (UPF_DEAD, serial core devices) so
> +	 * that a duplicate attempt cannot disturb the live registration.
> +	 */
> +	for (i = 0; i < drv->nr; i++) {
> +		if (drv->state[i].uart_port == port)
> +			return -EINVAL;
> +	}

Again, what normal code path attempts to register a port that is already
registered?

> +
>  	/*
>  	 * Prevent serial_port_runtime_resume() from trying to use the port
>  	 * until serial_core_add_one_port() has completed
> @@ -3358,6 +3368,14 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  
>  err_unregister_port_dev:
>  	serial_base_port_device_remove(port->port_dev);
> +	/*
> +	 * serial_base_port_device_remove() dropped the last reference to
> +	 * the port device, so leave no dangling ->port_dev behind. No
> +	 * state slot restore is needed: serial_core_add_one_port() has no
> +	 * failure exit after linking state->uart_port, so a failed
> +	 * registration never links the state slot.
> +	 */

Is this comment really needed?  LLMs love to do this, please don't.

> +	port->port_dev = NULL;
>  
>  err_unregister_ctrl_dev:
>  	serial_base_ctrl_device_remove(new_ctrl_dev);
> @@ -3372,12 +3390,25 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
>  {
>  	struct device *phys_dev = port->dev;
> -	struct serial_port_device *port_dev = port->port_dev;
> -	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
> +	struct serial_port_device *port_dev;
> +	struct serial_ctrl_device *ctrl_dev;
>  	int ctrl_id = port->ctrl_id;
>  
>  	guard(mutex)(&port_mutex);
>  
> +	/*
> +	 * A port may be unregistered even though it was never successfully
> +	 * registered (e.g. an allocation failure aborted serial_core_register_port()
> +	 * part-way).

Ok, that might happen, but if it does, unregister isn't called, the port
is just "dead".

> Drivers like serial8250 remove ports matching on ->dev, so
> +	 * those half-registered ports still reach us with port_dev == NULL. Read
> +	 * ->port_dev under port_mutex like all of its writers.

How are you removing a port that failed to be added?

I'm all for fixing real issues, but not fake ones.

thanks,

greg k-h
