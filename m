Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33730F958
	for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735020; cv=none; b=bNnpJSghTRIvXEQNUzoPbjbQurU7jZ66l4SuM+qYUecDyAMMvBTIDsjOcyw7yKprtPhmNJoXRoJCeD5ABBFesVYr6UmltkGNA2TO0GdFDRfX8M9iomJ6GYuh9+yWY/RnsfNkd8nKu6S6qgdqXldWiW+CNhjP2mXffRqh/rrQjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735020; c=relaxed/simple;
	bh=T3Uqsysytc+uU1pK6cU2j89zjwHERWSosjBIYfZ5pPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E5O/uUy9/r1Fxi/rB+T6HAsVMnu1yDsqrXEEkjZJvTXkOC06ERMDJ8uRgptxpAmp7QpUdwHUUDwUbQhR3obeAuH4q93zgMB2/JkRUb1hI6cXamSyOskPr9PrKmCPrQ+SjiT8BHwf+leNWCyz7bVlo+6GH7rJzeMJapd70+7uFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knu+0SNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knu+0SNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9D51F000E9;
	Wed, 26 Aug 2026 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787735019;
	bh=E+qJz5huB7vCiK8dAbfKmB7xAV6IR8i14E3ePOpDv5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Knu+0SNT+DVuAg4dJZWICqMLm7ZpDwPQZV0/i9SyccfBTFaSyMTYC3xlv4tZmIuYt
	 xj+fJKQJlQvVcBp5HgcmV+txxbx3BSTBTomPAta61A2wjnge8Ne5VFZOlxxKvY+mk+
	 4+StZhbhMjscWADyoJKdCLlVMv6/Vh0gRnvW2sO/GGsfJYqt50sVKFXcb16y9vlRGM
	 KJf2ronGvDyNMFPfuIUlrd4+IYLmT7OOh8bcM8m+dLPiaqiPPjruWE4AxAfCoI/Xtp
	 OBjkJX8zdt9wr7AAHytRAiYzBNy1gKLIofl+PPw3nqMzgwSJtyI0Uu2VpM8NNWU20U
	 GjsuuMU4xbU8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruslan Valiyev" <linuxoid@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260826084654.1392851-1-linuxoid@gmail.com>
References: <20260826084654.1392851-1-linuxoid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 09:03:38 +0000
Message-Id: <20260826090339.2A9D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing cleanup on error paths in serial_core_add_one_port() l=
eaves dangling pointers resulting in a Use-After-Free.
- [Critical] tty_cdev_add() leaves a dangling pointer on error, leading to =
a UAF or NULL-ptr dereference in tty_unregister_device().
--

commit a575b72dd88626a6d4f9468762be3ccbc1fb5e60
Author: Ruslan Valiyev <linuxoid@gmail.com>

serial: core: fix NULL pointer dereference in serial_core_unregister_port()

This commit fixes a NULL pointer dereference in serial_core_unregister_port=
()
that happens when port->port_dev is NULL. It checks for a NULL port_dev ear=
ly
and clears port->port_dev on the registration error path. The patch does not
touch two other pre-existing problems in the tty layer hit by the reproduce=
r.

Link: https://syzkaller.appspot.com/bug?extid=3D9f57c1b2792029198fcf
Link: https://lore.kernel.org/all/20260826073237.1377668-1-linuxoid@gmail.c=
om/

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

[Severity: Critical]
This is a pre-existing issue, but does serial_core_add_one_port() leave a
dangling pointer on its error paths?

If memory allocation fails in serial_core_add_one_port() (e.g., when=20
allocating uport->name or uport->tty_groups), it returns -ENOMEM without
clearing state->uart_port, which was set to uport earlier:

drivers/tty/serial/serial_core.c:serial_core_add_one_port() {
    ...
    state->uart_port =3D uport;
    ...
    uport->name =3D kasprintf(...);
    if (!uport->name)
        return -ENOMEM;
    ...
}

Could this lead to a Use-After-Free if a subsequent read of
/proc/tty/driver/serial invokes uart_proc_show() -> uart_line_info(),
retrieving the freed uport via uart_port_check()?

[ ... ]

> @@ -3341,12 +3342,24 @@ int serial_core_register_port(struct uart_driver =
*drv, struct uart_port *port)
>  void serial_core_unregister_port(struct uart_driver *drv, struct uart_po=
rt *port)
>  {
[ ... ]
>  	port->flags |=3D UPF_DEAD;
> =20
>  	serial_core_remove_one_port(drv, port);

[Severity: Critical]
This is a pre-existing issue, but does tty_cdev_add() leave a dangling=20
pointer that causes a crash here during teardown?

In tty_cdev_add(), if cdev_add() fails, the cdev is freed but the array
entry is not cleared:

drivers/tty/tty_io.c:tty_cdev_add() {
    ...
    if (err)
        kobject_put(&driver->cdevs[index]->kobj);
    return err;
}

When serial_core_remove_one_port() is called here during teardown, it=20
unconditionally calls tty_unregister_device(). For drivers without dynamic=
=20
allocation, this calls cdev_del(driver->cdevs[index]), which directly=20
dereferences it:

fs/char_dev.c:cdev_del() {
    cdev_unmap(p->dev, p->count);
    ...
}

Could this cause a Use-After-Free or NULL pointer dereference when tearing=
=20
down a device that previously failed registration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826084654.1392=
851-1-linuxoid@gmail.com?part=3D1
