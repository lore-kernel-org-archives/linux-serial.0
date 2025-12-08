Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FD79DA;
	Mon,  8 Dec 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178816; cv=none; b=CEbVUcht4JppUa3cVu0IDlN8Tk/qZ97p849kJ4JAZraq5TFU3gYgo3Whyx4NeYy0J0vKSWnGY2uI7V/yJoaG932140ZfgZW4sWSilX14Zx9Ut3mXenYDOwB5Ih3tw+tJl7feclzW1pnC12VwZqksbMbLl9e/OXm9QNF+Y1zGShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178816; c=relaxed/simple;
	bh=xSdaemtGsL3LPy2hS4aFYq6bITvqfnAOsURwxHXUiFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjPfQiP3lSnDpOGXAexFZojUl+Pn+NdTEpmOlvVWsQ/hhtch/hoSdZokPFFW4kvAeRX+RavekmD9l1LdmviWYhJsXletq4S4K/hsVZGFrvD/sZTOy4ANGCHClnC3x0gzW9mfiTUTtrr+FgEMteM2TRs8TwIvKo5cDL5gmzMgrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GceAGcnI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GceAGcnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72A8C4CEF1;
	Mon,  8 Dec 2025 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765178815;
	bh=xSdaemtGsL3LPy2hS4aFYq6bITvqfnAOsURwxHXUiFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GceAGcnIgW4XBx2cfUmHJ+ZVCGksPjz05/LzzXCK/fIgneqnXK3UQgt+8h0B++0U6
	 Rcj9tT1keuRiPoJ7d6GhGHTRbeML3ZSQ8hbTREdo3imo1IUff3+JLAKYyEPPnCLL25
	 OerSULNOjjIoPbdwBkUwB+OOubK+t1kQ+9QpU/XNr2BMkFMGO1mPuxXIDZ+2qM5ESo
	 Qw0oMr7gJYk8EFmD/59Tgd9U7GOoprGMjE8gCRGOJji9kAZjbdt7ltzR7AcZW0PcTo
	 CLyP19tlDAxK8s30MDU+pmdvWXrBlVOqieA2bB7X6RfEP+H/uD+x31oSL3vJ2dV2fG
	 oTZlkEaSKXsYw==
Message-ID: <6db427e4-4a82-4c63-b840-92654baf7e6b@kernel.org>
Date: Mon, 8 Dec 2025 08:26:51 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tty: tty_port: add workqueue to flip tty buffer
To: Xin Zhao <jackzxcui1989@163.com>, gregkh@linuxfoundation.org,
 tj@kernel.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20251205030829.1829987-1-jackzxcui1989@163.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20251205030829.1829987-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 05. 12. 25, 4:08, Xin Zhao wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push interface in the TTY

In commit logs, we tend to add () after function names.

> layer uses system_unbound_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, it may be preeempted by real-time

Too many 'e's in preeempted :).

> tasks or other high-prio tasks.
> In flush_to_ldisc, when executing n_tty_receive_buf_common,
> it wakes up

What is this "it" supposed to refer to? In English, this "it" here 
actually refers to n_tty_receive_buf_common().

> other tasks. __wake_up_common_lock calls spin_lock_irqsave, which does
> not disable preemption but disable migration in RT-Linux. This prevents

"disables"

> the kworker thread from being migrated to other cores by CPU's balancing
> logic, resulting in long delays.

Here should be another \n to separate paragraphs.

> In our system, the processing interval for each frame of IMU data
> transmitted via UART can experience significant jitter due to this issue.
> Instead of the expected 10 to 15 ms frame processing interval, we see
> spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> jitter exceeds the software's tolerable limit of 20 ms.

One more \n here too.

> Introduce flip_wq in tty_port which can be set by tty_port_link_wq or as
> default linked to workqueue allocated when tty_register_driver using flag
> WQ_SYSFS, so that cpumask and nice can be set dynamically.

This is a heavy sentence. Split it.

> Introduce TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
> default single tty_driver workqueue.
> We set the cpumask to the same cpu where the IMU data is handled and has
> less long-time high-prio jobs, and then set nice to -20, the frame

Period after 20, not comma.

> processing interval remains between 10 and 15ms, no jitter occurs.

You can perhaps use some LLM to rephrase the text?

> ---
> Change in v5:
> - Do not allocate workqueue twice when CONFIG_UNIX98_PTYS and
>    CONFIG_LEGACY_PTYS are all enabled.
> 
> Change in v4:
> - Simplify the logic for creating and releasing the workqueue,
>    as suggested by Tejun Heo.
> - Allocate single workqueue of one tty_driver as default, link it to
>    port when tty_port register device or tty_driver.
> - Introduce tty_port_link_wq to link specific workqueue to port.
> - Add driver flag TTY_DRIVER_CUSTOM_WORKQUEUE meaning not to create the
>    default single tty_driver workqueue.
> - Link to v4: https://lore.kernel.org/all/202512041303.7192024b-lkp@intel.com/T/#t
> 
> Change in v3:
> - Add tty flip workqueue for all tty ports, as suggested by Greg KH.
>    Every tty port use an individual flip workqueue, while all pty ports
>    share the same workqueue created in pty_flip_wq_init.
> - Modify the commit log to describe the reason for latency spikes in
>    RT-Linux.
> - Link to v3: https://lore.kernel.org/all/20251027060929.394053-1-jackzxcui1989@163.com/
> 
> Change in v2:
> - Do not add new module parameters
>    as suggested by Greg KH
> - Set WQ_SYSFS to allow properties changes from userspace
>    as suggested by Tejun Heo
> - Link to v2: https://lore.kernel.org/all/20251024155534.2302590-1-jackzxcui1989@163.com
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

This S-O-B is too late -- it would be dropped. You have to add it before 
the first "---".

> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -44,6 +44,8 @@ static struct tty_driver *pts_driver;
>   static DEFINE_MUTEX(devpts_mutex);
>   #endif
>   
> +static struct workqueue_struct *pty_flip_wq;

It's not clear to me, why ptys need a separate wq. IOW: you should 
describe this in the commit log.

> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3452,6 +3452,20 @@ int tty_register_driver(struct tty_driver *driver)
>   			goto err_unreg_char;
>   	}
>   
> +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> +		driver->flip_wq = alloc_workqueue("%s-flip-wq",
> +						WQ_UNBOUND | WQ_SYSFS,
> +						0, driver->name);

Do you have to wrap the line here?

> +		if (!driver->flip_wq) {
> +			error = -ENOMEM;
> +			goto err_unreg_char;

Who is going to free cdevs in this fail path?

> +		}
> +		for (i = 0; i < driver->num; i++) {
> +			if (driver->ports[i] && !driver->ports[i]->buf.flip_wq)

You test it here and again in tty_port_link_driver_wq().

> +				tty_port_link_driver_wq(driver->ports[i], driver);

There are not many drivers having tty ports set at this point. Why are 
you doing this here, actually? Given you do this later again in 
register_device().

> +		}
> +	}
> +
>   	scoped_guard(mutex, &tty_mutex)
>   		list_add(&driver->tty_drivers, &tty_drivers);
>   
> @@ -3475,6 +3489,9 @@ int tty_register_driver(struct tty_driver *driver)
>   	scoped_guard(mutex, &tty_mutex)
>   		list_del(&driver->tty_drivers);
>   
> +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
> +		destroy_workqueue(driver->flip_wq);
> +
>   err_unreg_char:
>   	unregister_chrdev_region(dev, driver->num);
>   err:
...

> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -103,6 +103,22 @@ void tty_port_init(struct tty_port *port)
>   }
>   EXPORT_SYMBOL(tty_port_init);
>   
> +/**
> + * tty_port_link_wq - link tty_port and flip workqueue
> + * @port: tty_port of the device
> + * @flip_wq: workqueue to queue flip buffer work on
> + *
> + * Assign a specific workqueue to a certain port, instead of using the
> + * workqueue allocated in tty_register_driver when TTY_DRIVER_CUSTOM_WORKQUEUE

The same as for commit logs: functions end with (). Furthermore, 
constants start with % IIRC. A period is missing too. It should sound like:
"when TTY_DRIVER_CUSTOM_WORKQUEUE is used."

> + *
> + * Note tty port api will not destroy the workqueue in tty_port_destroy.

the TTY port API

> + */
> +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
> +{
> +	port->buf.flip_wq = flip_wq;
> +}
> +EXPORT_SYMBOL(tty_port_link_wq);

_GPL likely?

> +
>   /**
>    * tty_port_link_device - link tty and tty_port
>    * @port: tty_port of the device
> @@ -161,6 +177,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
>   		const struct attribute_group **attr_grp)
>   {
>   	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>   	return tty_register_device_attr(driver, index, device, drvdata,
>   			attr_grp);
>   }
> @@ -187,6 +204,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>   	struct device *dev;
>   
>   	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>   
>   	dev = serdev_tty_port_register(port, host, parent, driver, index);
>   	if (PTR_ERR(dev) != -ENODEV) {
> @@ -718,6 +736,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
>   		struct tty_struct *tty)
>   {
>   	tty->port = port;
> +	tty_port_link_driver_wq(port, driver);
>   	return tty_standard_install(driver, tty);
>   }
>   EXPORT_SYMBOL_GPL(tty_port_install);
> diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
> index 31125e3be..48adcb0e8 100644
> --- a/include/linux/tty_buffer.h
> +++ b/include/linux/tty_buffer.h
> @@ -34,6 +34,7 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
>   
>   struct tty_bufhead {
>   	struct tty_buffer *head;	/* Queue head */
> +	struct workqueue_struct *flip_wq;
>   	struct work_struct work;
>   	struct mutex	   lock;
>   	atomic_t	   priority;
> diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> index 188ee9b76..cd93345bd 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -69,6 +69,10 @@ struct serial_struct;
>    *	Do not create numbered ``/dev`` nodes. For example, create
>    *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
>    *	driver for a single tty device is being allocated.
> + *
> + * @TTY_DRIVER_CUSTOM_WORKQUEUE:
> + *	Do not create workqueue when tty_register_driver. Set flip buffer
> + *	workqueue by tty_port_link_wq every port.

Sorry, parser error.

>    */
>   enum tty_driver_flag {
>   	TTY_DRIVER_INSTALLED		= BIT(0),
> @@ -79,6 +83,7 @@ enum tty_driver_flag {
>   	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
>   	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
>   	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
> +	TTY_DRIVER_CUSTOM_WORKQUEUE	= BIT(8),
>   };
>   
>   enum tty_driver_type {
> @@ -506,6 +511,7 @@ struct tty_operations {
>    * @flags: tty driver flags (%TTY_DRIVER_)
>    * @proc_entry: proc fs entry, used internally
>    * @other: driver of the linked tty; only used for the PTY driver
> + * @flip_wq: workqueue to queue flip buffer work on
>    * @ttys: array of active &struct tty_struct, set by tty_standard_install()
>    * @ports: array of &struct tty_port; can be set during initialization by
>    *	   tty_port_link_device() and similar
> @@ -539,6 +545,7 @@ struct tty_driver {
>   	unsigned long	flags;
>   	struct proc_dir_entry *proc_entry;
>   	struct tty_driver *other;
> +	struct workqueue_struct *flip_wq;
>   
>   	/*
>   	 * Pointer to the tty data structures
> diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> index 332ddb936..86e01bd51 100644
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
> @@ -165,6 +166,14 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
>   	return NULL;
>   }
>   
> +/* No effect when TTY_DRIVER_CUSTOM_WORKQUEUE, as driver->flip_wq is NULL */
> +static inline void tty_port_link_driver_wq(struct tty_port *port,
> +					   struct tty_driver *driver)

I am not sure why you introduce two interfaces: 
tty_port_link_driver_wq() and tty_port_link_wq(). Can't you add the if 
to the latter and drop the former? To me at least, the latter is confusing.

> +{
> +	if (!port->buf.flip_wq)
> +		port->buf.flip_wq = driver->flip_wq;
> +}
> +
>   /* If the cts flow control is enabled, return true. */
>   static inline bool tty_port_cts_enabled(const struct tty_port *port)
>   {

thanks,
-- 
js
suse labs
