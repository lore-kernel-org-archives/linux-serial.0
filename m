Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671583;
	b=Ljqlu3avk1fMHH6Qi4ZpDQIKR4NJBc7bN22pHnDpEt7xzgc7qa7sVuCt2p8Sj74MEJuu
	 ip400Mx5/9hTa6KX2TVDqG9xCrG6zPMouMtSeowfNvbSBeEkKgxhZWsFwpqWgAC3pnKw7
	 c1oHR4b511JR0d2L5UQfivZgKFzHIyb2h3zraWBA/+SW0gCRJq3c6iovX0piDijMUAs67
	 3Jtrpi87A9n0PyCcRUXYveC/Bf5Im+nxE2TcNb5oPr5fWJycM3POFZHKEuHoTeqKV1Xjw
	 AotSNdkD5KYPt/urjc337/FEXaV33KafB5HrNGoEwEvsE/yXknneS7l4/zB+4ErFWPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671583;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hiZtzyfzUM0dNxYUpzNWFJNB1JRr9NPSNj1wrgYc5xE=;
	b=MAD5N1Qg+0Ey55XJdDWDaf4JpTvjws3voyA17CvymT/X3fdchfes9Jz9TErpKsetGj6V
	 8nwcraEULV4BaxtzuHcddKm/m3fKTartQcn/4bqUsgZwGJ7yc9OuKkOhwse0VJUq7yGwA
	 /KveH827O+oyJhy/7TXRxJ0E7p5WY2Zirx0zadZwZzytnIxZZIsBg71p0iBYwFGXyG4u4
	 4EQUeYr2bYCrdo9BWMI0mzNSkh18Eb98E70/RM4yfl3HfnVGED0AQobxMphwZ39Tr79Nt
	 +Vgz1DN5/xbSpy8BvTQ1NnohGWiyPC9XRZNKEZNRDYTCsN96PFc1HqH1BqmxTabGGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGVsctug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF11606A321
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGVsctug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C1A1F000C1;
	Thu, 22 Oct 2026 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671582;
	bh=hiZtzyfzUM0dNxYUpzNWFJNB1JRr9NPSNj1wrgYc5xE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGVsctugko8AtCnHpWCvySXf/VsZ1wK1lSqGQkpT1nDdPILhkrxployJFaZvAu17i
	 ZgRbecloe+xE+OBOWyoQ36w7tpOLjN/9uLo+04I+lEXCZt6lWnXD87+RjfZr06Rc3O
	 U2C7eNRlggPzACjQtNkswlcSdVVQmhu6jPryTyQ/dHefoPImOi4bit0cbPxCZ7bzFu
	 Ur2U3lI5Hn6w0mCuao8ptnv+9AYlzKeJPU77SCjK4rpmC2ocOfHOPywhhE1qTTGgun
	 dbzJycWG52KwUzXO/jWZrAvfUaqv6gPBHzh72gP1+PW8HRcLmp9XC7cwM3DV7Be2N9
	 QxSb/RQeIK/Aw==
Message-ID: <sashiko-outbox-181426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] tty: serdev: Add mutex lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261022-rust_serdev_probe_refactor-v5-1-a27d862a415a@posteo.de>
References: <20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
 <20261022-rust_serdev_probe_refactor-v5-1-a27d862a415a@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:19:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: serdev: returning -EALREADY in ttyport_open() breaks hci_mrvl=
 probe
- [High] tty: serdev: late close in serdev_device_remove() and missed drive=
r unbind
--

commit 792f1e31002a2c366a7d3535ec38a8a39ce21b0c
Author: Markus Probst <markus.probst@posteo.de>

tty: serdev: Add mutex lock

This commit adds mutexes to serialize serport state changes and receive
buffer handling in serdev-ttyport. It also rejects repeated opens with
-EALREADY, ignores redundant closes, and warns if a device is left open on
removal.

> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc218..77e8e1d4d2a66 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -142,6 +142,11 @@ void serdev_device_remove(struct serdev_device *serd=
ev)
>  	struct serdev_controller *ctrl =3D serdev->ctrl;
> =20
>  	device_unregister(&serdev->dev);
> +
> +	/* Warn if driver did not close the serial device. */
> +	if (ctrl->ops->close && WARN_ON(ctrl->ops->close(ctrl)))
> +		pm_runtime_put(&ctrl->dev);
> +
>  	ctrl->serdev =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_remove);

[Severity: High]
Is it safe to call ctrl->ops->close(ctrl) after device_unregister(&serdev->=
dev)
has already completed?

In serdev_device_remove(), device_unregister(&serdev->dev) calls device_del=
(),
which unbinds the driver via serdev_drv_remove() and runs
device_unbind_cleanup() (releasing devres resources and clearing drvdata),
followed by put_device(&serdev->dev), which invokes serdev_device_release()
and frees serdev:

drivers/tty/serdev/core.c:serdev_device_release() {
	struct serdev_device *serdev =3D to_serdev_device(dev);
	kfree(serdev);
}

When a driver leaves the port open across remove, SERPORT_ACTIVE remains set
and ctrl->serdev points to the freed serdev_device throughout
device_unbind_cleanup() and put_device() until ctrl->ops->close(ctrl) clears
SERPORT_ACTIVE. Could a concurrent ttyport_receive_buf() or
ttyport_write_wakeup() during this window dereference the freed ctrl->serdev
or invoke serdev->ops callbacks with NULL or freed drvdata?

Also, serdev_device_remove() is only called when unregistering the
serdev_device itself, not when unbinding a driver via serdev_drv_remove():

drivers/tty/serdev/core.c:serdev_drv_remove() {
	const struct serdev_device_driver *sdrv =3D to_serdev_device_driver(dev->d=
river);
	if (sdrv->remove)
		sdrv->remove(to_serdev_device(dev));
}

If a driver leaves the device open on unbind (or after a failed probe),
wouldn't SERPORT_ACTIVE stay set while drvdata is cleared, leaving the port
open and causing any subsequent re-probe to fail in serdev_device_open() wi=
th
-EALREADY?

[ ... ]

> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index bab1b143b8a68..7d2d50d7e1a48 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c

[ ... ]

> @@ -99,14 +103,23 @@ static int ttyport_open(struct serdev_controller *ct=
rl)
>  	struct ktermios ktermios;
>  	int ret;
> =20
> +	mutex_lock(&serport->lock);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags)) {
> +		ret =3D -EALREADY;
> +		goto err_flags_unlock;
> +	}

[Severity: High]
Won't returning -EALREADY here cause a regression when probing Marvell
Bluetooth serdev devices in drivers/bluetooth/hci_mrvl.c?

During mrvl_serdev_probe(), hci_uart_register_device() calls
hci_uart_register_device_priv(), which opens hu->serdev before invoking the
protocol open callback p->open(hu):

drivers/bluetooth/hci_serdev.c:hci_uart_register_device_priv() {
	...
	err =3D serdev_device_open(hu->serdev);
	if (err)
		goto err_rwsem;

	err =3D p->open(hu);
	if (err)
		goto err_open;
	...
}

In drivers/bluetooth/hci_mrvl.c, mrvl_open() then calls
serdev_device_open(hu->serdev) a second time:

drivers/bluetooth/hci_mrvl.c:mrvl_open() {
	...
	if (hu->serdev) {
		ret =3D serdev_device_open(hu->serdev);
		if (ret)
			goto err;
	}
	...
}

With ttyport_open() returning -EALREADY when SERPORT_ACTIVE is already set,
won't mrvl_open() fail unconditionally and abort mrvl_serdev_probe()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-rust_serde=
v_probe_refactor-v5-0-a27d862a415a@posteo.de?part=3D1
