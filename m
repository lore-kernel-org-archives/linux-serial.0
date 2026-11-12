Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479304;
	b=orVu/IPhULbSZA86oFhwOm9mJRyUfdJSH0hqet67gl+raNEUd6L0K9DKfOcG67OoVpMZ
	 a8s07sv9iXmoMmVQgXlowH17HADGJxD6A6KcJkqUay9suS+wgjm+mBNrI2yMpTcJtiPoP
	 ZJr5wiolt8eM7R1pPp+FZTvfJXYD+i0S79DkyV/AA+G+05UaPx4IaIyRNrMO88GdvKcp6
	 O/hbrDfuMLS3C4iw5+/6viERo2eVi4Y7LjN4oFq42Q8OoFdw9MHt+D8O6AdIrmCkC/6RK
	 yHe1kfliyYdy8sFcBV4gJHmRSdvFOe7BOVFDBq727ZBWRE9k0EAxFDtACREiGkn/ljA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479304;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nkspNh9FUr3eUwjmKMxnrfiEBuzCv1McnwHZASI2zdM=;
	b=0QvyJ8bNQDcOVk4xLwMDi8OnI+lcUavfSgvB5mgBK9K1wsTFNy5s+JYNoby2GqrCyYHT
	 YFSh1TQEr4meKgElb1Dx8Z/JkKoiPLBGEGv6pXqPUNF2rwt4LWFSs6PiSMiUoDlqMw8b9
	 YEbwtRwveEnj/zNlCZB3XFKx5WCbp20vY6f/k1fCI4ZhTpR4777J6GW8wS76SG5jybWZp
	 6hbVF3K6BPGo4kI+vC42+tpnNdtWD6dygljITSpoyIURWsWXK3XjQ+8frgA92AUml1gmc
	 7evu1LOrV3NnRw/t9cPYWFAtuI8E4H2sfvTxHj7yBdBbbh0dhKjxrVRdE2C5la1YNWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSzT1sBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA2606A321
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSzT1sBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B961F00A06;
	Thu, 12 Nov 2026 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479304;
	bh=nkspNh9FUr3eUwjmKMxnrfiEBuzCv1McnwHZASI2zdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSzT1sBofUssbc3MzVoAev0inT3RkDcEaXmWsCYI/zcKFpLg8PhKJieZW5uqnmHuZ
	 uRpZPgicjdjxPrbjruQ57lfKC+WfWub0Us5X59hZ9hRDEmEiVjFag347MMnyvIhneE
	 Rp6srnCkogaPRyEfeN9u7n7hdivCVlfNRC5st3U4nqA5irTS4eVxnd37RcvT4JsLAj
	 xZadBIClczZ+bO0qL27yLtKTiMt8jneJ24Mk3tX93vdkW3lNEEvEJmiQHs5E2z9dC7
	 gTstxjMCVWNDwR5HlwZbZBr158Da7EoYpWaeusxhpTc/U3NFjHkcIq0TvcaSLjFoIn
	 hooqT3NnmjJsg==
Message-ID: <sashiko-outbox-210941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial core: fix use-after-free after driver module
 unload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112100541.348390-1-johan@kernel.org>
References: <20261112100541.348390-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:28:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] serial: core: use-after-free and early module_put() in
  uart_cleanup()
- [Low] serial: core: inaccurate Fixes trailer in commit message
--

commit 6a2bc2d8089d9c95546b231a0390b02e8dc6cd97
Author: Johan Hovold <johan@kernel.org>

> serial core: fix use-after-free after driver module unload
>
> Deregistering a uart driver frees the driver uart state including the
> tty ports themselves.
>
> Take a reference to the uart driver module at install() so that the
> uart state and resources like the tty driver name do not go away while a
> tty is still open.
>
> This specifically avoids use-after-free when accessing the tty port and
> crashes when accessing the tty driver name (e.g. in the tty printk
> macros) when a tty is closed after its driver module has been unloaded.
>
> It also makes sure that the uart state is still valid when waking up any
> waiters after releasing the final uart port reference in
> uart_port_deref().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

[Severity: Low]
1da177e4c3f4 ("Linux-2.6.12-rc2") cannot be resolved in the git history,
and uart_register_driver() originally set normal->owner =3D drv->owner until
it was removed by 2f16669d322e ("TTY: remove re-assignments to tty_driver
members").  Should the Fixes tag reference that commit instead?

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index b06d2649be343..2160e72780b45 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1935,10 +1935,25 @@ static int uart_install(struct tty_driver *driver=
, struct tty_struct *tty)
>  {
>  	struct uart_driver *drv =3D driver->driver_state;
>  	struct uart_state *state =3D drv->state + tty->index;
> +	int ret;
> +
> +	if (!try_module_get(drv->owner))
> +		return -ENODEV;
> =20
>  	tty->driver_data =3D state;
> =20
> -	return tty_standard_install(driver, tty);
> +	ret =3D tty_standard_install(driver, tty);
> +	if (ret)
> +		module_put(drv->owner);
> +
> +	return ret;
> +}
> +
> +static void uart_cleanup(struct tty_struct *tty)
> +{
> +	struct uart_driver *drv =3D tty->driver->driver_state;
> +
> +	module_put(drv->owner);
>  }

[Severity: High]
Can uart_cleanup() dereference freed memory via tty->driver->driver_state
when a device is unbound while a TTY is open?

Drivers such as sccnxp and tegra-tcu embed struct uart_driver inside
devm-allocated device state and call uart_unregister_driver() from their
.remove() callback.  Holding a reference to drv->owner does not prevent a
sysfs unbind, which unregisters the driver and frees the struct containing
struct uart_driver while the TTY remains open:

CPU0                                  CPU1
sccnxp_remove()
  uart_unregister_driver(&s->uart)
devres_release_all()
  kfree(s)
                                      release_one_tty()
                                        uart_cleanup()
                                          drv =3D tty->driver->driver_state;
                                          module_put(drv->owner);  <-- use-=
after-free

In addition, release_one_tty() runs tty->ops->cleanup(tty) before
tty_driver_kref_put(driver):

drivers/tty/tty_io.c:release_one_tty() {
	struct tty_driver *driver =3D tty->driver;
	struct module *owner =3D driver->owner;

	if (tty->ops->cleanup)
		tty->ops->cleanup(tty);

	tty_driver_kref_put(driver);
	module_put(owner);
}

Dropping drv->owner in uart_cleanup() allows a concurrent rmmod to finish
uart_unregister_driver() and unmap the module before release_one_tty()
calls tty_driver_kref_put(driver) -> destruct_tty_driver(), leaving
/proc/tty/driver/<driver_name> registered while drv and drv->state are
already freed.  Leaving normal->owner unset also leaves cdev->owner unset,
so an open() racing with module unload is not blocked in chrdev_open() and
can call tty_driver_kref_put() in tty_open_by_driver() after the module has
been unloaded.

Setting normal->owner =3D drv->owner (or passing drv->owner to
__tty_alloc_driver()) in uart_register_driver() lets the TTY core manage
the module reference via struct tty_driver without dereferencing
tty->driver->driver_state in cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112100541.3483=
90-1-johan@kernel.org?part=3D1
