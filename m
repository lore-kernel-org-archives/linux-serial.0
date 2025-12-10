Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1720013A;
	Wed, 10 Dec 2025 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355074; cv=none; b=Pam9Ik9bG8wX9j5ZSJZihXkb+NRUZIVZxE1+HkkAh9eYLA7VnZfSt1coNjQogKwS0v+QqnkF9fms4/Sj936uKoHwVw2urI8ZsxRANFuvktJXTyMmS+Pw6LOLou3nsyV52khY5HVOUwEbWQhFKz3XtzyWJQPH7QvP7OV+5h7xehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355074; c=relaxed/simple;
	bh=dmF+WNVLPB8XVRB0s9cKmfJ6h5TNlMFI0taXBxLz4iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lkp2fRtqOAuv5jwVUh75XKeA2SZ2p6BG495ppOgJh6lW9cVMc8j5fNbFJ5YqbPTtHGqS46mT56HG8xTCutcKf6iR9ruQGuZF4HpLUVvY2NqxHjanjORs8ZGBhlpvIEEU5KEXV2JhF5X11WxfyMuFwiOyEhNp0Tv7LfnlIvuUhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQWv4hNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQWv4hNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1D2C4CEF1;
	Wed, 10 Dec 2025 08:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765355073;
	bh=dmF+WNVLPB8XVRB0s9cKmfJ6h5TNlMFI0taXBxLz4iA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQWv4hNma0AccmmwVQREgfTepZ7/7AIVOcfDctYINdyFvAyLU0SvYw3BvpTqMuyJS
	 AC2fsSEciOEHezj2lzBpty+BGUrxR0iLaC+nVGGkT0L36CLYa22Sy4h/QeLhzBdR7m
	 CIlXXyp7N+XFIokaoDSSZW/fD1wb8wlJlExjXofKrorphYTLkVR1cGWjfbtni2qRvq
	 xlTVmrQoDIQf4bDM0HEig8UD1UE2RnKPZHO8CDcvAGLlCK9MKGN6uY8fFXMSj6ntj7
	 HH35Xx1WqEbFF1Q1DS+SqW52JQIN1ziBZ5HzAQ+mFLh/GDxpM8mvD0T96JC8TRc0px
	 Ft5gc5cZGGEww==
Message-ID: <6f23b96f-003f-482e-90b6-6db89083407d@kernel.org>
Date: Wed, 10 Dec 2025 09:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] tty: tty_port: add workqueue to flip tty buffer
To: Xin Zhao <jackzxcui1989@163.com>, gregkh@linuxfoundation.org,
 tj@kernel.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20251210031827.3771327-1-jackzxcui1989@163.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20251210031827.3771327-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10. 12. 25, 4:18, Xin Zhao wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> layer uses system_unbound_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, it may be preempted by real-time
> tasks or other high-prio tasks.
...
> After applying this patch, we can set the related UART tty flip buffer
> workqueue by sysfs. We set the cpumask to CPU cores associated with the
> IMU tasks, and set the nice to -20. Testing has shown significant
> improvement in the previously described issue, with almost no stuttering
> occurring anymore.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

The commit log looks fine to me now.

> ---

I think Greg would mind missing "Change in v6" here :).

> Change in v5:
> - Do not allocate workqueue twice when CONFIG_UNIX98_PTYS and
>    CONFIG_LEGACY_PTYS are all enabled.
...
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -44,6 +44,8 @@ static struct tty_driver *pts_driver;
>   static DEFINE_MUTEX(devpts_mutex);
>   #endif
>   
> +static struct workqueue_struct *pty_flip_wq;

Can't pty simply "link" to system_unbound_wq instead of allocating a 
custom one:

> @@ -407,6 +409,8 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
>   	o_tty->link = tty;
>   	tty_port_init(ports[0]);
>   	tty_port_init(ports[1]);
> +	tty_port_link_wq(ports[0], pty_flip_wq);
> +	tty_port_link_wq(ports[1], pty_flip_wq);
>   	tty_buffer_set_limit(ports[0], 8192);
>   	tty_buffer_set_limit(ports[1], 8192);
>   	o_tty->port = ports[0];
> @@ -536,14 +540,16 @@ static void __init legacy_pty_init(void)
...
> @@ -940,6 +948,9 @@ static inline void unix98_pty_init(void) { }
>   
>   static int __init pty_init(void)
>   {
> +	pty_flip_wq = alloc_workqueue("pty-flip-wq", WQ_UNBOUND | WQ_SYSFS, 0);
> +	if (!pty_flip_wq)
> +		panic("Couldn't allocate pty flip workqueue");

here ^^^?

> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
...
> @@ -3475,6 +3488,10 @@ int tty_register_driver(struct tty_driver *driver)
>   	scoped_guard(mutex, &tty_mutex)
>   		list_del(&driver->tty_drivers);
>   
> +err_destroy_wq:
> +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
> +		destroy_workqueue(driver->flip_wq);
> +

The fail path appears to be correct now.

> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -103,6 +103,26 @@ void tty_port_init(struct tty_port *port)
>   }
>   EXPORT_SYMBOL(tty_port_init);
>   
> +/**
> + * tty_port_link_wq - link tty_port and flip workqueue
> + * @port: tty_port of the device
> + * @flip_wq: workqueue to queue flip buffer work on
> + *
> + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is used, you must link every tty port to

Passive voice, please:
every tty port shall be linked to a workqueue manually by this function

> + * workqueue manually by this function, otherwise tty_flip_buffer_push() will
> + * see NULL flip_wq pointer when queue_work.

%NULL flip_wq pointer on queue_work().

> + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is NOT used, you can also use the function

this function can be used

> + * to link a certain port to a specific workqueue, instead of using the
> + * workqueue allocated in tty_register_driver().
> + *
> + * Note tty port api will not destroy the workqueue in the TTY port API.

You sometimes write "tty port", other times "TTY port" -- unify to 
whatever surrounding code does.

> + */
> +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
> +{
> +	port->buf.flip_wq = flip_wq;
> +}
> +EXPORT_SYMBOL_GPL(tty_port_link_wq);
> +
...

> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -69,6 +69,10 @@ struct serial_struct;
>    *	Do not create numbered ``/dev`` nodes. For example, create
>    *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
>    *	driver for a single tty device is being allocated.
> + *
> + * @TTY_DRIVER_CUSTOM_WORKQUEUE:
> + *	Do not create workqueue when tty_register_driver(). In the case, you must
> + *	set flip buffer workqueue by tty_port_link_wq() every port.

Do not create a workqueue in tty_register_driver(). When set, flip 
buffer workqueue shall be set by tty_port_link_wq() for every port.

> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
> @@ -138,6 +138,7 @@ struct tty_port {
>   					   kernel */
>   
>   void tty_port_init(struct tty_port *port);
> +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq);
>   void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
>   		unsigned index);
>   struct device *tty_port_register_device(struct tty_port *port,
> @@ -165,6 +166,17 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
>   	return NULL;
>   }
>   
> +/*
> + * Never overwrite the workqueue set by tty_port_link_wq().
> + * No effect when %TTY_DRIVER_CUSTOM_WORKQUEUE, as driver->flip_wq is NULL.

when %TTY_DRIVER_CUSTOM_WORKQUEUE is set

%NULL

thanks,
-- 
js
suse labs
