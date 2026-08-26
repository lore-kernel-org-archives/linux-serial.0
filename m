Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F93812EF
	for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730633; cv=none; b=SULwTgG692NagTHufS7pdUwciDJBUzRHR3/eAMeADDa1OCCjMsKQ68jV2hHVennzRNUmZ2MpZiwzr+2+WKSkATRXm/Q+Ex37iUslKQNTuJpbGNqWdprpKtoP0OgHiM0YLZq0ByAHI/qw6ZY9jQ9HxTsQdKeIMABITrzotaxtLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730633; c=relaxed/simple;
	bh=Amn2loMUaPb7P6vA0JVhepaU9xIr+nYY2JR3TwIz9+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JtX5sWFQ4BRlng/KDzFDGTugFlRAFmkq3kigLaVSUFTH85bYQNJcE9jDIWYuyyJW+P6P8EG5bwtnF6tbkRgyuLzCzu94kE3SHf1uW6PsaYJ7pdMOKU781ZKpCV/s5CVec3Lcs/dPDL3nzH3SxoalM3qjsSfBgH8TP7OoyGHXdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMLertkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMLertkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06451F000E9;
	Wed, 26 Aug 2026 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787730632;
	bh=DSpWhjsKKyN6UZO6SwAsuJwlUIwnQiALCTYZ/emqTbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gMLertkx0iSyfJ3Zjjwg2H743YrHTaRuTLLhsm6yVID2Qzkzt8zj9RqiqawQH2H6n
	 T9ADgaxXvw2b5kPOjgCbljC3Fl8e2cDw7wyjXNlLPkE/sgpUwV5+5cLWU3UbisWt5E
	 0BE5v+25hKzz3W0ddhzTdzyftmi4Lu3IlRcM26by89PXmkCiXei8LcjeVXhYY+W8hz
	 1A86PUKuDHvL3tlH8YziSOKRMB/2+xRuIAKr2foJ0aJN6WH9oGgZGL81recW9LDMDP
	 h0VurH/VpRWhntQKvBuLETS5S3rj3D+2x5Qe8CTnMNz6+48SocqToFec0A9m+8D8dO
	 bmauDKRvOOReA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruslan Valiyev" <linuxoid@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260826073237.1377668-1-linuxoid@gmail.com>
References: <20260826073237.1377668-1-linuxoid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:50:31 +0000
Message-Id: <20260826075031.D06451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `tty_unregister_device()` unconditionally deregisters a `cdev`, ca=
using UAF or NULL pointer dereference if `tty_cdev_add()` previously failed.
- [High] `uart_resume_port()` dereferences a NULL `tty_dev` in `device_may_=
wakeup()` if port registration failed and the driver kept the port active.
- [High] Concurrent read-modify-write of `port->flags` without proper locki=
ng causes `UPF_DEAD` to be lost, undermining port teardown safety.
--

commit a9b5deb58407eb5cb3253b4b3646215bfcb86ab0
Author: Ruslan Valiyev <linuxoid@gmail.com>

serial: core: fix NULL pointer dereference in serial_core_unregister_port()

This commit fixes a NULL pointer dereference in serial_core_unregister_port=
()
that occurs when unregistering a port with no port device installed. It adds
an early return if port_dev is NULL and explicitly clears port->port_dev
on the error path of serial_core_register_port().

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index a530ad372b434..5bf71d7bbd223 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3327,6 +3327,7 @@ int serial_core_register_port(struct uart_driver *d=
rv, struct uart_port *port)
> =20
>  err_unregister_port_dev:
>  	serial_base_port_device_remove(port->port_dev);
> +	port->port_dev =3D NULL;

[Severity: High]
This is a pre-existing issue, but does uart_resume_port() dereference a
NULL tty_dev in device_may_wakeup() if port registration failed and the
driver kept the port active?

If serial_core_register_port() fails, port_dev is set to NULL. If this port
is configured as a console, during system suspend uart_suspend_port() will
return early (leaving uport->suspended =3D 0).

On system resume, uart_resume_port() calls device_find_child(NULL, ...):

drivers/tty/serial/serial_core.c:uart_resume_port() {
	tty_dev =3D device_find_child(&uport->port_dev->dev, &match, serial_match_=
port);
	if (!uport->suspended && device_may_wakeup(tty_dev)) {
		...
	}
}

It safely returns NULL for tty_dev. Since uport->suspended is 0, the
short-circuit && does not prevent device_may_wakeup(tty_dev) from being
called.

device_may_wakeup(NULL) unconditionally dereferences NULL->power.can_wakeup:

include/linux/pm_wakeup.h:device_may_wakeup() {
	return dev->power.can_wakeup && !!dev->power.wakeup;
}

> =20
>  err_unregister_ctrl_dev:
>  	serial_base_ctrl_device_remove(new_ctrl_dev);

[ ... ]

> @@ -3341,12 +3342,24 @@ int serial_core_register_port(struct uart_driver =
*drv, struct uart_port *port)
>  void serial_core_unregister_port(struct uart_driver *drv, struct uart_po=
rt *port)
>  {
>  	struct device *phys_dev =3D port->dev;
> -	struct serial_port_device *port_dev =3D port->port_dev;
> -	struct serial_ctrl_device *ctrl_dev =3D serial_core_get_ctrl_dev(port_d=
ev);
> +	struct serial_port_device *port_dev;
> +	struct serial_ctrl_device *ctrl_dev;
>  	int ctrl_id =3D port->ctrl_id;
> =20
>  	guard(mutex)(&port_mutex);
> =20
> +	/*
> +	 * A NULL port device means there is no registered port device to
> +	 * remove: serial_core_remove_one_port() clears port_dev on
> +	 * teardown, and it is never set if registration failed before
> +	 * serial_core_port_device_add().
> +	 */
> +	port_dev =3D port->port_dev;
> +	if (!port_dev)
> +		return;
> +
> +	ctrl_dev =3D serial_core_get_ctrl_dev(port_dev);
> +
>  	port->flags |=3D UPF_DEAD;

[Severity: High]
This is a pre-existing issue, but can a concurrent read-modify-write of
port->flags without proper locking cause UPF_DEAD to be lost, undermining
port teardown safety?

serial_core_unregister_port() sets the UPF_DEAD bit in port->flags while
holding the global port_mutex, but without holding the TTY &port->mutex.

Concurrently, uart_set_info() modifies port->flags using a read-modify-write
operation while holding the TTY &port->mutex:

drivers/tty/serial/serial_core.c:uart_set_info() {
	uport->flags =3D (uport->flags & ~UPF_CHANGE_MASK) |
				 (new_flags & UPF_CHANGE_MASK);
}

If the threads interleave, uart_set_info() can overwrite and clear the
UPF_DEAD bit set by the teardown path. If UPF_DEAD is lost,
uart_port_activate() will incorrectly allow an unbound/removed port to be
opened and activated.

> =20
>  	serial_core_remove_one_port(drv, port);

[Severity: High]
This is a pre-existing issue, but does tty_unregister_device() unconditiona=
lly
deregister a cdev, causing UAF or NULL pointer dereference if tty_cdev_add()
previously failed?

If cdev_alloc() or cdev_add() fails in tty_cdev_add(), it leaves
driver->cdevs[index] pointing to NULL or freed memory:

drivers/tty/tty_io.c:tty_cdev_add() {
	err =3D cdev_add(driver->cdevs[index], dev, count);
	if (err)
		kobject_put(&driver->cdevs[index]->kobj);
	return err;
}

Because serial_core_add_one_port() ignores this error, treating TTY
registration failure as non-fatal and returning success, the port gets
registered:

drivers/tty/serial/serial_core.c:serial_core_add_one_port() {
	if (!IS_ERR(tty_dev)) {
		device_set_wakeup_capable(tty_dev, 1);
	} else {
		uport->flags |=3D UPF_DEAD;
		dev_err(uport->dev, "Cannot register tty device on line %u\n",
		       uport->line);
	}
	return 0;
}

On teardown, serial_core_remove_one_port() calls
tty_port_unregister_device() which invokes tty_unregister_device().
tty_unregister_device() calls cdev_del(driver->cdevs[index]) unconditionally
since serial_core does not use the TTY_DRIVER_DYNAMIC_ALLOC flag:

drivers/tty/tty_io.c:tty_unregister_device() {
	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
		cdev_del(driver->cdevs[index]);
		driver->cdevs[index] =3D NULL;
	}
}

cdev_del() does not check for NULL and dereferences the pointer, causing a
direct kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826073237.1377=
668-1-linuxoid@gmail.com?part=3D1
