Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506301;
	b=Ax2k5vJ9CNbiwCUqKa4DDOBtTAatXZjgt7sjzMAPRoqORqbI3fVcAdKVlB51c+3x9zNW
	 qfPVI2Tc1cGC6CfetBvBuCYkEqan/Tr/Bm/zfihzIiFGTZaL+DPvl298y+K8UiqknVVto
	 bmgdPV6focq8ycDawrCswY2o4NZRxoE5QbCzc/c9brxcWA6okMEEopr99u7wLce/7OusF
	 9ru4+zTV9JK0jjI4FPj/imDkFbPnCxdKNEfuASPkynj5G9/mCJZ1AYGBQuRpAla4TqhP1
	 vBWRaV2CJFLOSzcpkncIgWWT/xdqjL1Y13ncgrDdJhMX0qO5YtDbBEBwvU1MI/lUM0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506301;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O+cdzjnLADFrfUAN+2cCdho8vWj9AoVzop5TTllD5RA=;
	b=R/4mArtjStD6VXGYIHZyLsZndPjxViKWfrPdkRvr478Dogd1bLeF0PcnDLd0scmh+9iT
	 Zi91uWl+ce284N2lvopzSsmedIQmEdZQVy8/X3tLOeatZVbPUJRYRZ6Eg6n6GYbLbqN56
	 Yhcnrq35gFBppXX+IJXcMFwKsapkoAKuIYP3HjNsdXcGiuoGUK6WPzz+d8c8DnqwrbC3n
	 7LUqhcygY9ta694vbF6N1g0IHDNA1f11M9heBQwLrMKtlNWwawVxbw5lwLWsu7iW7CQdQ
	 yYKN1yuqV2MU9avmNc8ZlHwfP0T6IN5qlxEJHhS7hMIwYv+VgGGP0pRab/KjhD5yyfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehAhta0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758C606A330
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehAhta0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CA91F000C4;
	Thu, 12 Nov 2026 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506301;
	bh=O+cdzjnLADFrfUAN+2cCdho8vWj9AoVzop5TTllD5RA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehAhta0yKOCqKbNTnzaphI5R6Jq2MdXByKoGm5xBphRPr/ywcPxklGknqT/1ZIf4Q
	 0JvECqeSU/tQE34p+IXyxqUvozstDlYbkVdiO5G+KT2KID8WmMwj1WEsY+6cFTsD3j
	 fddy4JDuuFHvemJNAYDFptbKjt5H5gaMnSyD/81yZjDIKpZKsUVtxrwtdZR15hIv2t
	 YDjzLxoXRPPItFY0TMIS8y28J49gLVRSLFeiN/t844aq+gL+Sw+Guau2pN3q4n2bQd
	 P/8h2s1fcWI3E1I3ljJ3YcW/a+i4+T8U1MVkT17XpRj5mlAE5nV/6IC/XtOZsSxevB
	 5NpbWC0pWjJJA==
Message-ID: <sashiko-outbox-211656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] tty: serdev: Add mutex lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261112-rust_serdev_probe_refactor-v6-1-3568ed56264c@posteo.de>
References: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
 <20261112-rust_serdev_probe_refactor-v6-1-3568ed56264c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:58:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] tty: serdev: late close in serdev_device_remove() and missed
  driver unbind
- [High] tty: serdev: returning -EALREADY in ttyport_open() breaks
  hci_mrvl probe
- [Low] tty: serdev: dev_WARN() used instead of dev_warn() in
  serdev_device_remove()
--

commit 5353012a0aab4d9161723d4449dfeeb88d3f481c
Author: Markus Probst <markus.probst@posteo.de>

tty: serdev: Add mutex lock

This commit adds mutex locking to serdev-ttyport to serialize open, close,
and receive operations, returns -EALREADY on duplicate opens, makes closing
an already-closed device a no-op, and closes the device with a warning in
serdev_device_remove() if left open.

> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc218..86d9cf8215edc 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -142,6 +142,13 @@ void serdev_device_remove(struct serdev_device *serd=
ev)
>  	struct serdev_controller *ctrl =3D serdev->ctrl;
> =20
>  	device_unregister(&serdev->dev);
> +
> +	/* Warn if driver did not close the serial device. */
> +	if (ctrl->ops->close && ctrl->ops->close(ctrl)) {

[Severity: High]
Does closing the controller after device_unregister(&serdev->dev) leave a
use-after-free window on serdev and its devres data?

When a child driver leaves the device open, SERPORT_ACTIVE remains set
while device_unregister() runs device_unbind_cleanup() (freeing devm
resources and clearing drvdata) and put_device() -> serdev_device_release()
-> kfree(serdev), before ctrl->ops->close(ctrl) clears SERPORT_ACTIVE and
ctrl->serdev is set to NULL:

CPU0                                  CPU1
serdev_device_remove()
  device_unregister(&serdev->dev)
    ...
    device_unbind_cleanup()
    kfree(serdev)
                                      ttyport_receive_buf()
                                        serdev_controller_receive_buf()
                                          serdev =3D ctrl->serdev;
                                          serdev->ops->receive_buf(serdev, =
...)
                                            <-- use-after-free
  ctrl->ops->close(ctrl)
  ctrl->serdev =3D NULL

In addition, serdev_device_remove() only runs when the struct serdev_device
itself is unregistered, not when a client driver is unbound via
serdev_drv_remove() (e.g. module unload or sysfs unbind).  If a driver
leaves the port open across unbind, this fallback close never runs,
leaving SERPORT_ACTIVE set with NULL drvdata and causing any later re-probe
to fail in serdev_device_open() with -EALREADY.

> +		dev_WARN(&ctrl->dev, "Child driver did not close the serial device");
> +		pm_runtime_put(&ctrl->dev);
> +	}

[Severity: Low]
As reported by Greg Kroah-Hartman on v4 [1], this should log a normal
kernel warning rather than a WARN_ON() splat.  dev_WARN() expands to
WARN(1, ...), which still triggers a backtrace and crashes systems with
panic_on_warn; dev_warn() (with a trailing newline) logs at KERN_WARNING
without a WARN trap.

[ ... ]

> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index b6638f9f40d2d..17c18d4b0cb8f 100644
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
Does returning -EALREADY here break probing of Marvell serdev Bluetooth
devices in drivers/bluetooth/hci_mrvl.c?

During probe, mrvl_serdev_probe() calls hci_uart_register_device() ->
hci_uart_register_device_priv(), which opens hu->serdev and then calls
p->open(hu):

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

mrvl_open() then calls serdev_device_open(hu->serdev) a second time:

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
mrvl_open() and mrvl_serdev_probe() will unconditionally fail.

[1] https://lore.kernel.org/r/2026101758-confidant-comprised-e1c0@gregkh

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-rust_serde=
v_probe_refactor-v6-0-3568ed56264c@posteo.de?part=3D1
