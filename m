Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6526AA93;
	Tue,  9 Dec 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765276073; cv=none; b=tzPKHIcu5Ik9Mc+VBN4GpipZym3Ow5CWIf4JchKhcBiuE+xLWTGD8X/MqbQXUg+9H+BtK+bZWITvEF9KKeZG9XCL+jV1g38AHcn4t6Gou+JlS1H+hogdgHuVM3a1qjPTapmMWxOLWrUpMNikaGQU0H+cdW7BjpPE5Cbb46/t8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765276073; c=relaxed/simple;
	bh=CG+BCOXiFKko9PT9cs+PfEVqV2G6F+qqYtmD5TdM1M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIObsDt+xaA12PYs+H6XwC2ibA4kR8PO+QpDSWv9Dt4gOleiCXglMVh8RbeRl7IqUZE6z6w8dHZVCI4oGkYr23v8GGl3iPQPQDhf8pzqqvwvUL3nWrQNL1WP0a8jVIsJG4pMuhI7xOjD0TupwbNZRVsJQeQoVMmro+A1l+qM8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iMGcJSmy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iMGcJSmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=bjDg1hk4hosIP7DQDKn7jJlbiZv/TZhg2Nrb7KdKhGE=;
	b=iMGcJSmypmpcaH54RYdYmN4gZHIrwXlHIOHYTuDQy01agGjGna6cQLC6JoqblA
	7SVxT03fkOPqoYHqYmD7AvmmfAb+4icHPV5DI+oux770oQQM1ZYOeEs5L0tlCaZJ
	71I04CpLqiM0N4b6HAT1elsV+DD736jKTZD2xYJ8Z0w2E=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wB3O611+Tdpvv3LAg--.31909S2;
	Tue, 09 Dec 2025 18:27:01 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v5] tty: tty_port: add workqueue to flip tty buffer
Date: Tue,  9 Dec 2025 18:26:58 +0800
Message-Id: <20251209102658.3163543-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6db427e4-4a82-4c63-b840-92654baf7e6b@kernel.org>
References: <6db427e4-4a82-4c63-b840-92654baf7e6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3O611+Tdpvv3LAg--.31909S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZFykArWxuw13Gw17uw4rZrb_yoW8GF1Uuo
	Z3Ww4rAwn5Kr1xJ3WFyrnrJFyfWa92vry5GFWjqrZ8A34vq3WYgrZ7Ga45Xa4fXF4rKF98
	Z3W3J3ZIyFsFya4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRQ2-0UUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwBbDzWk3+XZYIgAA3z

Dear Jiri,

On Mon, 8 Dec 2025 08:26:51 +0100 Jiri Slaby <jirislaby@kernel.org> wrote:

> > On the embedded platform, certain critical data, such as IMU data, is
> > transmitted through UART. The tty_flip_buffer_push interface in the TTY
> 
> In commit logs, we tend to add () after function names.

OK, I will revise it.

> > up the kworker thread on an idle CPU, it may be preeempted by real-time
> 
> Too many 'e's in preeempted :).

It’s my fault.

> > In flush_to_ldisc, when executing n_tty_receive_buf_common,
> > it wakes up
> 
> What is this "it" supposed to refer to? In English, this "it" here 
> actually refers to n_tty_receive_buf_common().

Here I mean n_tty_receive_buf_common(). I will add a dump stack info in v5
like the following:
flush_to_ldisc() needs to wake up the relevant data handle thread. When 
executing __wake_up_common_lock, it calls spin_lock_irqsave(), which does
not disable preemption but disables migration in RT-Linux. This prevents
the kworker thread from being migrated to other cores by CPU's balancing
logic, resulting in long delays. The call trace is as follows:
    __wake_up_common_lock
    __wake_up
    ep_poll_callback
    __wake_up_common
    __wake_up_common_lock
    __wake_up
    n_tty_receive_buf_common
    n_tty_receive_buf2
    tty_ldisc_receive_buf
    tty_port_default_receive_buf
    flush_to_ldisc

> > not disable preemption but disable migration in RT-Linux. This prevents
> 
> "disables"

It’s my fault.

> > the kworker thread from being migrated to other cores by CPU's balancing
> > logic, resulting in long delays.
> 
> Here should be another \n to separate paragraphs.
> 
> > In our system, the processing interval for each frame of IMU data

OK.

> > jitter exceeds the software's tolerable limit of 20 ms.
> 
> One more \n here too.
> 
> > Introduce flip_wq in tty_port which can be set by tty_port_link_wq or as

OK.

> > Introduce flip_wq in tty_port which can be set by tty_port_link_wq or as
> > default linked to workqueue allocated when tty_register_driver using flag
> > WQ_SYSFS, so that cpumask and nice can be set dynamically.
> 
> This is a heavy sentence. Split it.

OK. I may change it as the following:
Introduce flip_wq in tty_port which can be set by tty_port_link_wq() or as
default linked to default workqueue allocated when tty_register_driver().
The default workqueue is allocated with flag WQ_SYSFS, so that cpumask and
nice can be set dynamically. The execution timing of tty_port_link_wq() is
not clearly restricted. The newly added function tty_port_link_driver_wq()
checks whether the flip_wq of the tty_port has already been assigned when
linking the default tty_driver's workqueue to the port. After the user has
set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
system will only use this custom workqueue, even if tty_driver does not
have %TTY_DRIVER_CUSTOM_WORKQUEUE flag.

> > Introduce TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
> > default single tty_driver workqueue.
> > We set the cpumask to the same cpu where the IMU data is handled and has
> > less long-time high-prio jobs, and then set nice to -20, the frame
> 
> Period after 20, not comma.
> 
> > processing interval remains between 10 and 15ms, no jitter occurs.
> 
> You can perhaps use some LLM to rephrase the text?
>
> > ---

OK. I may change it as the following:
Introduce TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
default single tty_driver workqueue. Two reasons why need to introduce the
TTY_DRIVER_CUSTOM_WORKQUEUE flag:
1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
fail when trying to create a workqueue with the same name. The pty is an
example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
2. Different tty ports may be used for different tasks, which may require
separate core binding control via workqueues. In this case, the workqueue
created by default in the tty driver is unnecessary. Enabling this flag
prevents the creation of this redundant workqueue.

After applying this patch, we can set the related UART tty flip buffer
workqueue by sysfs. We set the cpumask to CPU cores associated with the
IMU tasks, and set the nice to -20. Testing has shown significant
improvement in the previously described issue, with almost no stuttering
occurring anymore.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---

> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> This S-O-B is too late -- it would be dropped. You have to add it before 
> the first "---".

OK. I will revise it. Thanks.

> It's not clear to me, why ptys need a separate wq. IOW: you should 
> describe this in the commit log.
> 
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -3452,6 +3452,20 @@ int tty_register_driver(struct tty_driver *driver)
> >   			goto err_unreg_char;
> >   	}
> > 
> > +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> > +		driver->flip_wq = alloc_workqueue("%s-flip-wq",
> > +						WQ_UNBOUND | WQ_SYSFS,
> > +						0, driver->name);

OK. Like the following:
Introduce TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
default single tty_driver workqueue. Two reasons why need to introduce the
TTY_DRIVER_CUSTOM_WORKQUEUE flag:
1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
fail when trying to create a workqueue with the same name. The pty is an
example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
2. Different tty ports may be used for different tasks, which may require
separate core binding control via workqueues. In this case, the workqueue
created by default in the tty driver is unnecessary. Enabling this flag
prevents the creation of this redundant workqueue.

> > +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> > +		driver->flip_wq = alloc_workqueue("%s-flip-wq",
> > +						WQ_UNBOUND | WQ_SYSFS,
> > +						0, driver->name);
> 
> Do you have to wrap the line here?

OK, it hasn't exceeded 100 characters, so I won't break it into a new line.

> > +		if (!driver->flip_wq) {
> > +			error = -ENOMEM;
> > +			goto err_unreg_char;
> 
> Who is going to free cdevs in this fail path?

I overlooked the fact that tty_unregister_device performs the cdev_del
release action. I will move the alloc_workqueue before tty_cdev_add() like
the following:

	if (error < 0)
		goto err;

	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
		driver->flip_wq = alloc_workqueue("%s-flip-wq", WQ_UNBOUND | WQ_SYSFS, 0, driver->name);
		if (!driver->flip_wq) {
			error = -ENOMEM;
			goto err;
		}
        ...
	}

	if (driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) {
		error = tty_cdev_add(driver, dev, 0, driver->num);
		if (error)
			goto err_destroy_wq;
	}
    ...

err_unreg_devs:
	for (i--; i >= 0; i--)
		tty_unregister_device(driver, i);

	scoped_guard(mutex, &tty_mutex)
		list_del(&driver->tty_drivers);

err_destroy_wq:
	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE))
		destroy_workqueue(driver->flip_wq);

> > +		}
> > +		for (i = 0; i < driver->num; i++) {
> > +			if (driver->ports[i] && !driver->ports[i]->buf.flip_wq)
> 
> You test it here and again in tty_port_link_driver_wq().

It's my fault. I will change it as follows:
		for (i = 0; i < driver->num; i++) {
			if (driver->ports[i])
				tty_port_link_driver_wq(driver->ports[i], driver);
		}

> > +				tty_port_link_driver_wq(driver->ports[i], driver);
> 
> There are not many drivers having tty ports set at this point. Why are 
> you doing this here, actually? Given you do this later again in 
> register_device().

I do not perform the tty_port_link_wq() in tty_register_device_attr(). I
execute tty_port_link_wq() in tty_register_driver().
In my previous version, I created the workqueue in tty_port_init, but
since tty_port_init is a void-return function, it cannot handle errors
related to workqueue allocation failure. So, I looked for other suitable
functions to handle workqueue allocation and found that both
tty_register_driver() and tty_register_device_attr() were potential
options. However, I realized that tty_port_register_device_attr_serdev()
may not call tty_register_device_attr, while every tty-related driver
would call tty_register_driver. Therefore, I decided to perform the
workqueue allocation in tty_register_driver.
I did not directly perform the tty_port_link_wq() action in
tty_port_link_device() because there are several usage scenarios that
follow this execution order:
    tty_alloc_driver()
    driver->name = xxx
    tty_port_link_device()
    tty_register_driver
In such cases, if I were to directly perform the tty_port_link_wq() action
in tty_port_link_device(), I would need to create the workqueue in
tty_alloc_driver, but at that point, the driver’s name is not yet known,
which prevents the creation of a workqueue with WQ_SYSFS. Therefore, for
this scenario, I can only perform the workqueue creation in
tty_register_driver before executing the link action.
Additionally, I have confirmed that every call to tty_port_link_device() in
the current kernel code is accompanied by a call to tty_register_driver().
The tty_port_link_device() interface is also used in tty_port.c, and I have
added the tty_port_link_driver_wq() call at every location where the
tty_port_link_device() interface is called.

> > --- a/drivers/tty/tty_port.c
> > +++ b/drivers/tty/tty_port.c
> > @@ -103,6 +103,22 @@ void tty_port_init(struct tty_port *port)
> >   }
> >   EXPORT_SYMBOL(tty_port_init);
> > 
> > +/**
> > + * tty_port_link_wq - link tty_port and flip workqueue
> > + * @port: tty_port of the device
> > + * @flip_wq: workqueue to queue flip buffer work on
> > + *
> > + * Assign a specific workqueue to a certain port, instead of using the
> > + * workqueue allocated in tty_register_driver when TTY_DRIVER_CUSTOM_WORKQUEUE
> 
> The same as for commit logs: functions end with (). Furthermore, 
> constants start with % IIRC. A period is missing too. It should sound like:
> "when TTY_DRIVER_CUSTOM_WORKQUEUE is used."
> 
> > + *
> > + * Note tty port api will not destroy the workqueue in tty_port_destroy.
> 
> the TTY port API
> 
> > + */
> > +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
> > +{
> > +	port->buf.flip_wq = flip_wq;
> > +}
> > +EXPORT_SYMBOL(tty_port_link_wq);
> 
> _GPL likely?

OK, I will change it as follows:
/**
 * tty_port_link_wq - link tty_port and flip workqueue
 * @port: tty_port of the device
 * @flip_wq: workqueue to queue flip buffer work on
 *
 * When %TTY_DRIVER_CUSTOM_WORKQUEUE is used, you must link every tty port to
 * workqueue manually by this function, otherwise tty_flip_buffer_push() will
 * see NULL flip_wq pointer when queue_work.
 * When %TTY_DRIVER_CUSTOM_WORKQUEUE is NOT used, you can also use the function
 * to link a certain port to a specific workqueue, instead of using the
 * workqueue allocated in tty_register_driver().
 *
 * Note tty port api will not destroy the workqueue in the TTY port API.
 */
void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
{
	port->buf.flip_wq = flip_wq;
}
EXPORT_SYMBOL_GPL(tty_port_link_wq);

> > + * @TTY_DRIVER_CUSTOM_WORKQUEUE:
> > + *	Do not create workqueue when tty_register_driver. Set flip buffer
> > + *	workqueue by tty_port_link_wq every port.
> 
> Sorry, parser error.

Are you saying to prefix the macro with @? I see that in the current code,
they are also prefixed with %, as shown in the comments in the tty_driver.h
file below:
 *	If the driver sets %TTY_DRIVER_HARDWARE_BREAK in tty_alloc_driver(),
 *	then the interface will also be called with actual times and the
 *	hardware is expected to do the delay work itself. 0 and -1 are still
 *	used for on/off.
I'll change as following using () to mean function:
 * @TTY_DRIVER_CUSTOM_WORKQUEUE:
 *	Do not create workqueue when tty_register_driver(). In the case, you must
 *	set flip buffer workqueue by tty_port_link_wq() every port.
 */

> > +/* No effect when TTY_DRIVER_CUSTOM_WORKQUEUE, as driver->flip_wq is NULL */
> > +static inline void tty_port_link_driver_wq(struct tty_port *port,
> > +					   struct tty_driver *driver)
> 
> I am not sure why you introduce two interfaces: 
> tty_port_link_driver_wq() and tty_port_link_wq(). Can't you add the if 
> to the latter and drop the former? To me at least, the latter is confusing.

It is indeed confusing, I will add the description of tty_port_link_driver_wq()
in the commit log and before tty_port_link_driver_wq().
In the commit log:
...
nice can be set dynamically. The execution timing of tty_port_link_wq() is
not clearly restricted. The newly added function tty_port_link_driver_wq()
checks whether the flip_wq of the tty_port has already been assigned when
linking the default tty_driver's workqueue to the port. After the user has
set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
system will only use this custom workqueue, even if tty_driver does not
have %TTY_DRIVER_CUSTOM_WORKQUEUE flag.
Before tty_port_link_driver_wq():
/*
 * Never overwrite the workqueue set by tty_port_link_wq().
 * No effect when TTY_DRIVER_CUSTOM_WORKQUEUE, as driver->flip_wq is NULL.
 */
static inline void tty_port_link_driver_wq(struct tty_port *port,
					   struct tty_driver *driver)

My thought is that even if the TTY_DRIVER_CUSTOM_WORKQUEUE flag is not set,
the user can still call tty_port_link_wq to link a specific tty port to a
custom workqueue, thus overriding the existing workqueue in the current
tty_port. Therefore, I cannot check for NULL in the tty_port_link_wq(), as
it must unconditionally set the workqueue.

--
Xin Zhao

