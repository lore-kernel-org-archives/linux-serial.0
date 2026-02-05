Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39453D522F
	for <linux-serial@vger.kernel.org>; Thu,  5 Feb 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304566; cv=none; b=bDKS5vOu58keZ3ptm0EHIsXE3NcZizvaNb8hOByJ4DS1KdCIIiZiLK7dEFmrX6f4pmgNxpU2fdUvajAGr85FfNoXgjgAKt8AnIK2Mzn16w/PBbax6o9IofJgEXJTy0i31+A98AGbq15tb4PUf2c83uAlVdq4iHl0msEVvW5n8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304566; c=relaxed/simple;
	bh=Vomx5CJjkrx2+6S8ITdtbkBABjudmtItIxKLS3XTmP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=juwGSX9LlbN8r5KjqbXaQ45MWHm8KLWHsuI6r84OqZhcKQlmysyfuZXkry08mUMCV7r7ccdPHRXZLRwGcc/Fy2GUnEvfyRcm5L6Hk/ti7hraIQlVhdbssmvwyPCe0DhANzflCYtjnkJ0U3/fWTVSbO6WB5KhKP2lYjfoRTd0hI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LaKBVJh0; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LaKBVJh0"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260205151557euoutp02572ecbdc80370b5a1a186e2fab890964~RYp2nl9pA0245202452euoutp02O
	for <linux-serial@vger.kernel.org>; Thu,  5 Feb 2026 15:15:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260205151557euoutp02572ecbdc80370b5a1a186e2fab890964~RYp2nl9pA0245202452euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770304557;
	bh=PHJyfaMrAcXJuGQmDV15ueoAglK9q5WE5FEjNFwHuzY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LaKBVJh0tDcW611OZljhTraQa2jpRIe+ZyQpTF3WD91diGnE3tjWAMsJvLtjFoQOK
	 AVvVlZaq+G3h/ncowYWS6TQgk/oUk6QG+en0HjE4j96HlUtq7ujVdwjFf4ANP4a2Ui
	 qBN9B4y8QMOaTpTsw+jeyMIkrxVLban9uKRiZ7+U=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260205151557eucas1p240d925e7d0ef2bab151d0e1af4eab504~RYp2T6e-F1234412344eucas1p2P;
	Thu,  5 Feb 2026 15:15:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260205151556eusmtip15cea7c494ce1ce58ced582117c5b1389~RYp1doG-F2881228812eusmtip1x;
	Thu,  5 Feb 2026 15:15:56 +0000 (GMT)
Message-ID: <8c737e26-ede3-48aa-85da-3977d638b616@samsung.com>
Date: Thu, 5 Feb 2026 16:15:55 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v9] tty: tty_port: add workqueue to flip TTY buffer
To: Xin Zhao <jackzxcui1989@163.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, tommaso.merciai.xr@bp.renesas.com,
	geert@linux-m68k.org
Cc: hch@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260205101948.594577-1-jackzxcui1989@163.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260205151557eucas1p240d925e7d0ef2bab151d0e1af4eab504
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260205102037eucas1p12efddc9710b361a90069623681b68589
X-EPHeader: CA
X-CMS-RootMailID: 20260205102037eucas1p12efddc9710b361a90069623681b68589
References: <CGME20260205102037eucas1p12efddc9710b361a90069623681b68589@eucas1p1.samsung.com>
	<20260205101948.594577-1-jackzxcui1989@163.com>

On 05.02.2026 11:19, Xin Zhao wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> layer uses system_dfl_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, it may be preempted by real-time
> tasks or other high-prio tasks.
>
> flush_to_ldisc() needs to wake up the relevant data handle thread. When
> executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
> does not disable preemption but disables migration in RT-Linux. This
> prevents the kworker thread from being migrated to other cores by CPU's
> balancing logic, resulting in long delays. The call trace is as follows:
>      __wake_up_common_lock
>      __wake_up
>      ep_poll_callback
>      __wake_up_common
>      __wake_up_common_lock
>      __wake_up
>      n_tty_receive_buf_common
>      n_tty_receive_buf2
>      tty_ldisc_receive_buf
>      tty_port_default_receive_buf
>      flush_to_ldisc
>
> In our system, the processing interval for each frame of IMU data
> transmitted via UART can experience significant jitter due to this issue.
> Instead of the expected 10 to 15 ms frame processing interval, we see
> spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> jitter exceeds the software's tolerable limit of 20 ms.
>
> Introduce flip_wq in tty_port which can be set by tty_port_link_wq() or as
> default linked to default workqueue allocated when tty_register_driver().
> The default workqueue is allocated with flag WQ_SYSFS, so that cpumask and
> nice can be set dynamically. The execution timing of tty_port_link_wq() is
> not clearly restricted. The newly added function tty_port_link_driver_wq()
> checks whether the flip_wq of the tty_port has already been assigned when
> linking the default tty_driver's workqueue to the port. After the user has
> set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
> system will only use this custom workqueue, even if tty_driver does not
> have %TTY_DRIVER_NO_WORKQUEUE flag. When tty_port register device, flip_wq
> link operation is done by tty_port_link_driver_wq(), but for in-memory
> devices the link operation cannot cover all the cases. Although
> tty_port_install() is dedicated for in-memory devices lik PTY to link port
> allocated on demand, the logic of tty_port_install() is so simple that
> people may not call it, vc_cons[0].d->port is one such case. We check the
> buf.flip_wq when flip TTY buffer, if buf.flip_wq of TTY port is NULL, use
> system_dfl_wq as a backup.
>
> Introduce %TTY_DRIVER_NO_WORKQUEUE flag meaning not to create the
> default single tty_driver workqueue. Two reasons why need to introduce the
> %TTY_DRIVER_NO_WORKQUEUE flag:
> 1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
> fail when trying to create a workqueue with the same name. The pty is an
> example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
> enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
> 2. Different TTY ports may be used for different tasks, which may require
> separate core binding control via workqueues. In this case, the workqueue
> created by default in the TTY driver is unnecessary. Enabling this flag
> prevents the creation of this redundant workqueue.
>
> After applying this patch, we can set the related UART TTY flip buffer
> workqueue by sysfs. We set the cpumask to CPU cores associated with the
> IMU tasks, and set the nice to -20. Testing has shown significant
> improvement in the previously described issue, with almost no stuttering
> occurring anymore.
>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

Works fine on my test boards.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>
> Change in v9:
> - Fix 'cannot create duplicate filename' problem, when create flip_wq
>    workqueue, use '"%s-%s", ... driver->name, driver->driver_name' as
>    flip_wq workqueue name, as suggested by Marek Szyprowski.
>    driver_name maybe NULL, do not create driver flip_wq workqueue  when
>    driver_name is NULL. Drivers that do not define driver_name are
>    potentially in-memory devices like vty, which generally do not require
>    special workqueue settings.
> - Fix 'NULL pointer panic' problem, tty_flip_buffer_push() now check
>    whether buf.flip_wq is NULL, use system_dfl_wq instead if buf.flip_wq
>    is NULL. Therefore, no longer need to call tty_port_link_wq() to link
>    system_dfl_wq to pty ports.
> - Set buf.flip_wq to NULL in tty_port_destroy() and
>    tty_port_unregister_device().
>
> Change in v8:
> - Rebase code, use system_dfl_wq instead of system_unbound_wq.
> - Link to v8: https://lore.kernel.org/linux-serial/20260129103129.2928955-1-jackzxcui1989@163.com/T/#m8697be62ae18c8c7bcb677cbd96599c23b3dab4d
>
> Change in v7:
> - Pty simply link to system_unbound_wq instead of allocating a custom one,
>    as suggested by Jiri Slaby.
> - Modify some inappropriate expressions in the code comments,
>    as suggested by Jiri Slaby.
> - Link to v7: https://lore.kernel.org/all/20251210125028.4174917-1-jackzxcui1989@163.com/T/#u
>
> Change in v6:
> - Modify many inappropriate expressions in the commit log and code comments,
>    as suggested by Jiri Slaby.
> - Add reasons why need to introduce the %TTY_DRIVER_CUSTOM_WORKQUEUE in
>    commit log.
> - Modify the error handling related to the allocation failure of workqueue in
>    tty_register_driver(), as suggested by Jiri Slaby.
> - Add description of tty_port_link_driver_wq() in the commit log,
>    as suggested by Jiri Slaby.
> - Link to v6: https://lore.kernel.org/all/20251210031827.3771327-1-jackzxcui1989@163.com/
>
> Change in v5:
> - Do not allocate workqueue twice when CONFIG_UNIX98_PTYS and
>    CONFIG_LEGACY_PTYS are all enabled.
> - Link to v5: https://lore.kernel.org/all/20251205030829.1829987-1-jackzxcui1989@163.com/
>
> Change in v4:
> - Simplify the logic for creating and releasing the workqueue,
>    as suggested by Tejun Heo.
> - Allocate single workqueue of one tty_driver as default, link it to
>    port when tty_port register device or tty_driver.
> - Introduce tty_port_link_wq() to link specific workqueue to port.
> - Add driver flag %TTY_DRIVER_CUSTOM_WORKQUEUE meaning not to create the
>    default single tty_driver workqueue.
> - Link to v4: https://lore.kernel.org/all/202512041303.7192024b-lkp@intel.com/T/#t
>
> Change in v3:
> - Add tty flip workqueue for all tty ports, as suggested by Greg KH.
>    Every tty port use an individual flip workqueue, while all pty ports
>    share the same workqueue created in pty_flip_wq_init().
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
> ---
>   drivers/tty/pty.c          | 12 ++++++++----
>   drivers/tty/tty_buffer.c   | 15 +++++++++++----
>   drivers/tty/tty_io.c       | 25 ++++++++++++++++++++++++-
>   drivers/tty/tty_port.c     | 22 ++++++++++++++++++++++
>   include/linux/tty_buffer.h |  1 +
>   include/linux/tty_driver.h |  7 +++++++
>   include/linux/tty_port.h   | 13 +++++++++++++
>   7 files changed, 86 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 6120d827a..6c406c741 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -532,14 +532,16 @@ static void __init legacy_pty_init(void)
>   	pty_driver = tty_alloc_driver(legacy_count,
>   			TTY_DRIVER_RESET_TERMIOS |
>   			TTY_DRIVER_REAL_RAW |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>   	if (IS_ERR(pty_driver))
>   		panic("Couldn't allocate pty driver");
>   
>   	pty_slave_driver = tty_alloc_driver(legacy_count,
>   			TTY_DRIVER_RESET_TERMIOS |
>   			TTY_DRIVER_REAL_RAW |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>   	if (IS_ERR(pty_slave_driver))
>   		panic("Couldn't allocate pty slave driver");
>   
> @@ -849,7 +851,8 @@ static void __init unix98_pty_init(void)
>   			TTY_DRIVER_REAL_RAW |
>   			TTY_DRIVER_DYNAMIC_DEV |
>   			TTY_DRIVER_DEVPTS_MEM |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>   	if (IS_ERR(ptm_driver))
>   		panic("Couldn't allocate Unix98 ptm driver");
>   	pts_driver = tty_alloc_driver(NR_UNIX98_PTY_MAX,
> @@ -857,7 +860,8 @@ static void __init unix98_pty_init(void)
>   			TTY_DRIVER_REAL_RAW |
>   			TTY_DRIVER_DYNAMIC_DEV |
>   			TTY_DRIVER_DEVPTS_MEM |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>   	if (IS_ERR(pts_driver))
>   		panic("Couldn't allocate Unix98 pts driver");
>   
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 1a5673acd..1a2b29135 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -59,6 +59,13 @@ void tty_buffer_lock_exclusive(struct tty_port *port)
>   }
>   EXPORT_SYMBOL_GPL(tty_buffer_lock_exclusive);
>   
> +static bool tty_buffer_queue_work(struct tty_bufhead *buf)
> +{
> +	struct workqueue_struct *flip_wq = READ_ONCE(buf->flip_wq);
> +
> +	return queue_work(flip_wq ?: system_dfl_wq, &buf->work);
> +}
> +
>   /**
>    * tty_buffer_unlock_exclusive	-	release exclusive access
>    * @port: tty port owning the flip buffer
> @@ -76,7 +83,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
>   	mutex_unlock(&buf->lock);
>   
>   	if (restart)
> -		queue_work(system_dfl_wq, &buf->work);
> +		tty_buffer_queue_work(buf);
>   }
>   EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
>   
> @@ -530,7 +537,7 @@ void tty_flip_buffer_push(struct tty_port *port)
>   	struct tty_bufhead *buf = &port->buf;
>   
>   	tty_flip_buffer_commit(buf->tail);
> -	queue_work(system_dfl_wq, &buf->work);
> +	tty_buffer_queue_work(buf);
>   }
>   EXPORT_SYMBOL(tty_flip_buffer_push);
>   
> @@ -560,7 +567,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
>   		tty_flip_buffer_commit(buf->tail);
>   	spin_unlock_irqrestore(&port->lock, flags);
>   
> -	queue_work(system_dfl_wq, &buf->work);
> +	tty_buffer_queue_work(buf);
>   
>   	return size;
>   }
> @@ -613,7 +620,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
>   
>   bool tty_buffer_restart_work(struct tty_port *port)
>   {
> -	return queue_work(system_dfl_wq, &port->buf.work);
> +	return tty_buffer_queue_work(&port->buf);
>   }
>   
>   bool tty_buffer_cancel_work(struct tty_port *port)
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e2d92cf70..a8674a20a 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3446,10 +3446,27 @@ int tty_register_driver(struct tty_driver *driver)
>   	if (error < 0)
>   		goto err;
>   
> +	/*
> +	 * Drivers that do not define driver_name are potentially in-memory devices
> +	 * like vty, which generally do not require special workqueue settings.
> +	 */
> +	if (!(driver->flags & TTY_DRIVER_NO_WORKQUEUE) && driver->driver_name) {
> +		driver->flip_wq = alloc_workqueue("%s-%s", WQ_UNBOUND | WQ_SYSFS,
> +						  0, driver->name, driver->driver_name);
> +		if (!driver->flip_wq) {
> +			error = -ENOMEM;
> +			goto err_unreg_char;
> +		}
> +		for (i = 0; i < driver->num; i++) {
> +			if (driver->ports[i])
> +				tty_port_link_driver_wq(driver->ports[i], driver);
> +		}
> +	}
> +
>   	if (driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) {
>   		error = tty_cdev_add(driver, dev, 0, driver->num);
>   		if (error)
> -			goto err_unreg_char;
> +			goto err_destroy_wq;
>   	}
>   
>   	scoped_guard(mutex, &tty_mutex)
> @@ -3475,6 +3492,10 @@ int tty_register_driver(struct tty_driver *driver)
>   	scoped_guard(mutex, &tty_mutex)
>   		list_del(&driver->tty_drivers);
>   
> +err_destroy_wq:
> +	if (driver->flip_wq)
> +		destroy_workqueue(driver->flip_wq);
> +
>   err_unreg_char:
>   	unregister_chrdev_region(dev, driver->num);
>   err:
> @@ -3494,6 +3515,8 @@ void tty_unregister_driver(struct tty_driver *driver)
>   				driver->num);
>   	scoped_guard(mutex, &tty_mutex)
>   		list_del(&driver->tty_drivers);
> +	if (driver->flip_wq)
> +		destroy_workqueue(driver->flip_wq);
>   }
>   EXPORT_SYMBOL(tty_unregister_driver);
>   
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index fe67c5cb0..54359310e 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -99,6 +99,23 @@ void tty_port_init(struct tty_port *port)
>   }
>   EXPORT_SYMBOL(tty_port_init);
>   
> +/**
> + * tty_port_link_wq - link tty_port and flip workqueue
> + * @port: tty_port of the device
> + * @flip_wq: workqueue to queue flip buffer work on
> + *
> + * Whenever %TTY_DRIVER_NO_WORKQUEUE is used, every tty_port can be linked to
> + * a workqueue manually by this function.
> + * tty_port will use system_dfl_wq when buf.flip_wq is NULL.
> + *
> + * Note that tty_port API will NOT destroy the workqueue.
> + */
> +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
> +{
> +	port->buf.flip_wq = flip_wq;
> +}
> +EXPORT_SYMBOL_GPL(tty_port_link_wq);
> +
>   /**
>    * tty_port_link_device - link tty and tty_port
>    * @port: tty_port of the device
> @@ -157,6 +174,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
>   		const struct attribute_group **attr_grp)
>   {
>   	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>   	return tty_register_device_attr(driver, index, device, drvdata,
>   			attr_grp);
>   }
> @@ -183,6 +201,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>   	struct device *dev;
>   
>   	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>   
>   	dev = serdev_tty_port_register(port, host, parent, driver, index);
>   	if (PTR_ERR(dev) != -ENODEV) {
> @@ -210,6 +229,7 @@ void tty_port_unregister_device(struct tty_port *port,
>   {
>   	int ret;
>   
> +	WRITE_ONCE(port->buf.flip_wq, NULL);
>   	ret = serdev_tty_port_unregister(port);
>   	if (ret == 0)
>   		return;
> @@ -257,6 +277,7 @@ void tty_port_destroy(struct tty_port *port)
>   {
>   	tty_buffer_cancel_work(port);
>   	tty_buffer_free_all(port);
> +	WRITE_ONCE(port->buf.flip_wq, NULL);
>   }
>   EXPORT_SYMBOL(tty_port_destroy);
>   
> @@ -703,6 +724,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
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
> index 188ee9b76..f77af6472 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -69,6 +69,10 @@ struct serial_struct;
>    *	Do not create numbered ``/dev`` nodes. For example, create
>    *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
>    *	driver for a single tty device is being allocated.
> + *
> + * @TTY_DRIVER_NO_WORKQUEUE:
> + *	Do not create workqueue when tty_register_driver(). Whenever set, flip
> + *	buffer workqueue can be set by tty_port_link_wq() for every port.
>    */
>   enum tty_driver_flag {
>   	TTY_DRIVER_INSTALLED		= BIT(0),
> @@ -79,6 +83,7 @@ enum tty_driver_flag {
>   	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
>   	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
>   	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
> +	TTY_DRIVER_NO_WORKQUEUE	= BIT(8),
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
> index 660c254f1..d2a7882c0 100644
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
> @@ -165,6 +166,18 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
>   	return NULL;
>   }
>   
> +/*
> + * Never overwrite the workqueue set by tty_port_link_wq().
> + * No effect when %TTY_DRIVER_NO_WORKQUEUE is set, as driver->flip_wq is
> + * %NULL.
> + */
> +static inline void tty_port_link_driver_wq(struct tty_port *port,
> +					   struct tty_driver *driver)
> +{
> +	if (!port->buf.flip_wq)
> +		tty_port_link_wq(port, driver->flip_wq);
> +}
> +
>   /* If the cts flow control is enabled, return true. */
>   static inline bool tty_port_cts_enabled(const struct tty_port *port)
>   {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

