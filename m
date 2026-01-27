Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5E23ABB9
	for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510079; cv=none; b=gmgd4dZoYFfyK7PNB43pT2W+f/mqfCljX3yHumLZf+Xmcv5JXRtIfcgTD+7OAOsQHdXKPLZw35oTGMaoDoJ3I6L7LrG8zbUiFeNHhc/Gl3rDx9Yg6+ss+E8YrVfzKEeHREA6JhHwsLq0Z1iq6lkSWa9YQJfIWem5okS4ikQL7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510079; c=relaxed/simple;
	bh=GP4T6INFryoOsKIivs6sBmgAyDCHqslrxnNKRWAQ3dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BmTXQsYJO9rDdljXwwe3CgP7wPEf1sCFr+fDCWEKQoeneGIRur4EyDxy8ee+lAQSzMkPfzJ/QDDds8IY/q2pyjQd+v6qdCyaJHWrdXzDt9opZNMcP2Owuw0RbqjqZnu1BvtDqSYBk2aKvtQXIZltGbr9SRCqLxi9NF/bPHNdclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IvekkXvQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IvekkXvQ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260127103433euoutp012fad69325554a9d2a635d4173ea8a250~OkAl6s2yx0744307443euoutp01K
	for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 10:34:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260127103433euoutp012fad69325554a9d2a635d4173ea8a250~OkAl6s2yx0744307443euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769510074;
	bh=lhW0nsGwa2s5GkPEMYcL8Iwk4azPe0wyMyTmViOcz7U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IvekkXvQpOY7l9Qdm4GBMfJoQfdmqPBM57kEYH65iT/JoXaqQsbCAao1tKBbdGZmb
	 fEz0BVpcrQtLOFsgQCKTWR/6R8H4KnRDtL6hLfX+qr57vtxfcb99wJe6Fu/2CuhJo5
	 f3v5s6rFN9+pC2WIPdjFUAutSyq73FFmGxk6qgDM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260127103433eucas1p1ce8d8c194d4fd16d2f1dbbc0e9df28de~OkAlxlTHt2383623836eucas1p1o;
	Tue, 27 Jan 2026 10:34:33 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260127103433eusmtip12423b18c57f590d72a16e7f5d387720e~OkAlbOuyX2183321833eusmtip1_;
	Tue, 27 Jan 2026 10:34:33 +0000 (GMT)
Message-ID: <d1942304-ee30-478d-90fb-279519f3ae81@samsung.com>
Date: Tue, 27 Jan 2026 11:34:32 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v8] tty: tty_port: add workqueue to flip TTY buffer
To: Xin Zhao <jackzxcui1989@163.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, tj@kernel.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251223034836.2625547-1-jackzxcui1989@163.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260127103433eucas1p1ce8d8c194d4fd16d2f1dbbc0e9df28de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260127103433eucas1p1ce8d8c194d4fd16d2f1dbbc0e9df28de
X-EPHeader: CA
X-CMS-RootMailID: 20260127103433eucas1p1ce8d8c194d4fd16d2f1dbbc0e9df28de
References: <20251223034836.2625547-1-jackzxcui1989@163.com>
	<CGME20260127103433eucas1p1ce8d8c194d4fd16d2f1dbbc0e9df28de@eucas1p1.samsung.com>

On 23.12.2025 04:48, Xin Zhao wrote:
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
> have %TTY_DRIVER_CUSTOM_WORKQUEUE flag.
>
> Introduce %TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
> default single tty_driver workqueue. Two reasons why need to introduce the
> %TTY_DRIVER_CUSTOM_WORKQUEUE flag:
> 1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
> fail when trying to create a workqueue with the same name. The pty is an
> example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
> enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
> 2. Different tty ports may be used for different tasks, which may require
> separate core binding control via workqueues. In this case, the workqueue
> created by default in the tty driver is unnecessary. Enabling this flag
> prevents the creation of this redundant workqueue.
>
> After applying this patch, we can set the related UART TTY flip buffer
> workqueue by sysfs. We set the cpumask to CPU cores associated with the
> IMU tasks, and set the nice to -20. Testing has shown significant
> improvement in the previously described issue, with almost no stuttering
> occurring anymore.
>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

This patch landed in linux-next as commit d000422a46aa ("tty: tty_port: 
add workqueue to flip TTY buffer"). In my tests I found that it causes 
some regressions, see the comments in the code below.

> ---
>
> Change in v8:
> - Rebase code, use system_dfl_wq instead of system_unbound_wq.
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
>   drivers/tty/pty.c          | 14 ++++++++++----
>   drivers/tty/tty_buffer.c   |  8 ++++----
>   drivers/tty/tty_io.c       | 21 ++++++++++++++++++++-
>   drivers/tty/tty_port.c     | 23 +++++++++++++++++++++++
>   include/linux/tty_buffer.h |  1 +
>   include/linux/tty_driver.h |  7 +++++++
>   include/linux/tty_port.h   | 13 +++++++++++++
>   7 files changed, 78 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 6120d827a..1f17575f8 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -403,6 +403,8 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
>   	o_tty->link = tty;
>   	tty_port_init(ports[0]);
>   	tty_port_init(ports[1]);
> +	tty_port_link_wq(ports[0], system_dfl_wq);
> +	tty_port_link_wq(ports[1], system_dfl_wq);
>   	tty_buffer_set_limit(ports[0], 8192);
>   	tty_buffer_set_limit(ports[1], 8192);
>   	o_tty->port = ports[0];
> @@ -532,14 +534,16 @@ static void __init legacy_pty_init(void)
>   	pty_driver = tty_alloc_driver(legacy_count,
>   			TTY_DRIVER_RESET_TERMIOS |
>   			TTY_DRIVER_REAL_RAW |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_CUSTOM_WORKQUEUE);
>   	if (IS_ERR(pty_driver))
>   		panic("Couldn't allocate pty driver");
>   
>   	pty_slave_driver = tty_alloc_driver(legacy_count,
>   			TTY_DRIVER_RESET_TERMIOS |
>   			TTY_DRIVER_REAL_RAW |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_CUSTOM_WORKQUEUE);
>   	if (IS_ERR(pty_slave_driver))
>   		panic("Couldn't allocate pty slave driver");
>   
> @@ -849,7 +853,8 @@ static void __init unix98_pty_init(void)
>   			TTY_DRIVER_REAL_RAW |
>   			TTY_DRIVER_DYNAMIC_DEV |
>   			TTY_DRIVER_DEVPTS_MEM |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_CUSTOM_WORKQUEUE);
>   	if (IS_ERR(ptm_driver))
>   		panic("Couldn't allocate Unix98 ptm driver");
>   	pts_driver = tty_alloc_driver(NR_UNIX98_PTY_MAX,
> @@ -857,7 +862,8 @@ static void __init unix98_pty_init(void)
>   			TTY_DRIVER_REAL_RAW |
>   			TTY_DRIVER_DYNAMIC_DEV |
>   			TTY_DRIVER_DEVPTS_MEM |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_CUSTOM_WORKQUEUE);
>   	if (IS_ERR(pts_driver))
>   		panic("Couldn't allocate Unix98 pts driver");
>   
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 1a5673acd..86e1e7178 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -76,7 +76,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
>   	mutex_unlock(&buf->lock);
>   
>   	if (restart)
> -		queue_work(system_dfl_wq, &buf->work);
> +		queue_work(buf->flip_wq, &buf->work);
>   }
>   EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
>   
> @@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
>   	struct tty_bufhead *buf = &port->buf;
>   
>   	tty_flip_buffer_commit(buf->tail);
> -	queue_work(system_dfl_wq, &buf->work);
> +	queue_work(buf->flip_wq, &buf->work);
>   }
>   EXPORT_SYMBOL(tty_flip_buffer_push);
>   
> @@ -560,7 +560,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
>   		tty_flip_buffer_commit(buf->tail);
>   	spin_unlock_irqrestore(&port->lock, flags);
>   
> -	queue_work(system_dfl_wq, &buf->work);
> +	queue_work(buf->flip_wq, &buf->work);
>   
>   	return size;
>   }
> @@ -613,7 +613,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
>   
>   bool tty_buffer_restart_work(struct tty_port *port)
>   {
> -	return queue_work(system_dfl_wq, &port->buf.work);
> +	return queue_work(port->buf.flip_wq, &port->buf.work);
>   }
>   
>   bool tty_buffer_cancel_work(struct tty_port *port)
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e2d92cf70..d64fb08ba 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3446,10 +3446,23 @@ int tty_register_driver(struct tty_driver *driver)
>   	if (error < 0)
>   		goto err;
>   
> +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> +		driver->flip_wq = alloc_workqueue("%s-flip-wq", WQ_UNBOUND | WQ_SYSFS,
> +						  0, driver->name);

It looks that driver->name is not unique on some systems, see:

$ git grep ttyMSM drivers/tty/
drivers/tty/serial/msm_serial.c:        .name = "ttyMSM",
drivers/tty/serial/msm_serial.c:        .dev_name = "ttyMSM",
drivers/tty/serial/qcom_geni_serial.c:  .name = "ttyMSM",
drivers/tty/serial/qcom_geni_serial.c:  .dev_name = "ttyMSM",

This fails on Qualcomm RB5 boards, breaking the boot process (booting 
hangs, because drivers try to use the unregistered wq):

sysfs: cannot create duplicate filename 
'/devices/virtual/workqueue/ttyMSM-flip-wq'
CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.19.0-rc7-next-20260126+ #16440 PREEMPT
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0xc0/0xd0
  dump_stack+0x18/0x24
  sysfs_warn_dup+0x64/0x80
  sysfs_create_dir_ns+0xe8/0x108
  kobject_add_internal+0x98/0x270
  kobject_add+0x94/0x10c
  device_add+0xec/0x720
  device_register+0x20/0x30
  workqueue_sysfs_register+0x8c/0x170
  __alloc_workqueue+0x554/0x668
  alloc_workqueue_noprof+0x5c/0xfc
  tty_register_driver+0x120/0x2d0
  uart_register_driver+0x120/0x1b0
  qcom_geni_serial_init+0x20/0xc8
  do_one_initcall+0x64/0x308
  kernel_init_freeable+0x284/0x508
  kernel_init+0x24/0x1dc
  ret_from_fork+0x10/0x20
kobject: kobject_add_internal failed for ttyMSM-flip-wq with -EEXIST, 
don't try to register things with the same name in the same directory.

Changing the above alloc_workqueue() to use 'driver->driver_name' fixes 
the boot issue. If keeping the driver->name is desired, then maybe the 
'"%s-%s-flip-wq", ..., driver->name, driver->driver_name' format is a 
better one.

The other issue with this patch I've observed on ARM Juno R1 board. With 
one of the above fixes for the workqueue name, the boot process is still 
broken because of the NULL pointer dereference:

input: gpio-keys as /de ** replaying previous printk message ** input: 
gpio-keys as /devices/platform/gpio-keys/input/input3 Unable to handle 
kernel NULL pointer dereference at virtual address 00000000000001c0 Mem 
abort info: ... [00000000000001c0] user address but active_mm is swapper 
Internal error: Oops: 0000000096000004 [#1] SMP Modules linked in: CPU: 
1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-rc7-next-20260126+ 
#16443 PREEMPT Hardware name: ARM Juno development board (r1) (DT) 
pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--) pc : 
__queue_work+0x30/0x7c4 lr : queue_work_on+0xac/0xdc ... Call trace: 
__queue_work+0x30/0x7c4 (P) queue_work_on+0xac/0xdc 
tty_flip_buffer_push+0x2c/0x38 k_fn.part.0+0x7c/0xc8 k_fn+0x20/0x2c 
kbd_event+0x2d8/0x504 input_handle_events_default+0x50/0x74 
input_pass_values+0x148/0x2b4 input_handle_event+0xcc/0x5e0 
input_event+0x64/0xa4 gpio_keys_open+0x9c/0xc4 
input_open_device+0x8c/0x128 kbd_connect+0x84/0xa0 
input_attach_handler+0x9c/0xf4 input_register_device+0x308/0x48c 
gpio_keys_probe+0x40c/0xafc platform_probe+0x5c/0xac 
really_probe+0xbc/0x298 __driver_probe_device+0x78/0x12c 
driver_probe_device+0xdc/0x164 __driver_attach+0xe4/0x224 
bus_for_each_dev+0x74/0xd0 driver_attach+0x24/0x30 
bus_add_driver+0xe4/0x208 driver_register+0x60/0x128 
__platform_driver_register+0x24/0x30 gpio_keys_init+0x1c/0x28 
do_one_initcall+0x64/0x308 kernel_init_freeable+0x284/0x508 
kernel_init+0x24/0x1dc ret_from_fork+0x10/0x20 Code: a9025bf5 a90573fb 
aa0203fb 35001843 (b941c260) ---[ end trace 0000000000000000 ]--- note: 
swapper/0[1] exited with irqs disabled note: swapper/0[1] exited with 
preempt_count 3 Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b SMP: stopping secondary CPUs Kernel Offset: disabled 
CPU features: 0x1040000,41858004,00020000,0400421b Memory Limit: none 
---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b ]---

Reverting $subject on top of current linux-next fixes this issue.

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
> @@ -3475,6 +3488,10 @@ int tty_register_driver(struct tty_driver *driver)
>   	scoped_guard(mutex, &tty_mutex)
>   		list_del(&driver->tty_drivers);
>   
> +err_destroy_wq:
> +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
> +		destroy_workqueue(driver->flip_wq);
> +
>   err_unreg_char:
>   	unregister_chrdev_region(dev, driver->num);
>   err:
> @@ -3494,6 +3511,8 @@ void tty_unregister_driver(struct tty_driver *driver)
>   				driver->num);
>   	scoped_guard(mutex, &tty_mutex)
>   		list_del(&driver->tty_drivers);
> +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
> +		destroy_workqueue(driver->flip_wq);
>   }
>   EXPORT_SYMBOL(tty_unregister_driver);
>   
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index fe67c5cb0..611f87814 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -99,6 +99,26 @@ void tty_port_init(struct tty_port *port)
>   }
>   EXPORT_SYMBOL(tty_port_init);
>   
> +/**
> + * tty_port_link_wq - link tty_port and flip workqueue
> + * @port: tty_port of the device
> + * @flip_wq: workqueue to queue flip buffer work on
> + *
> + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is used, every tty_port shall be linked to
> + * a workqueue manually by this function, otherwise tty_flip_buffer_push() will
> + * see %NULL flip_wq pointer on queue_work.
> + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is NOT used, the function can be used to
> + * link a certain port to a specific workqueue, instead of using the workqueue
> + * allocated in tty_register_driver().
> + *
> + * Note that TTY port API will NOT destroy the workqueue.
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
> @@ -157,6 +177,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
>   		const struct attribute_group **attr_grp)
>   {
>   	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>   	return tty_register_device_attr(driver, index, device, drvdata,
>   			attr_grp);
>   }
> @@ -183,6 +204,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>   	struct device *dev;
>   
>   	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>   
>   	dev = serdev_tty_port_register(port, host, parent, driver, index);
>   	if (PTR_ERR(dev) != -ENODEV) {
> @@ -703,6 +725,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
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
> index 188ee9b76..9c65854f7 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -69,6 +69,10 @@ struct serial_struct;
>    *	Do not create numbered ``/dev`` nodes. For example, create
>    *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
>    *	driver for a single tty device is being allocated.
> + *
> + * @TTY_DRIVER_CUSTOM_WORKQUEUE:
> + *	Do not create workqueue when tty_register_driver(). When set, flip
> + *	buffer workqueue shall be set by tty_port_link_wq() for every port.
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
> index 660c254f1..c1b87f3c5 100644
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
> + * No effect when %TTY_DRIVER_CUSTOM_WORKQUEUE is set, as driver->flip_wq is
> + * %NULL.
> + */
> +static inline void tty_port_link_driver_wq(struct tty_port *port,
> +					   struct tty_driver *driver)
> +{
> +	if (!port->buf.flip_wq)
> +		port->buf.flip_wq = driver->flip_wq;
> +}
> +
>   /* If the cts flow control is enabled, return true. */
>   static inline bool tty_port_cts_enabled(const struct tty_port *port)
>   {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

