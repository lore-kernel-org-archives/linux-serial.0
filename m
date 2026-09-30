Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65750B435
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790628; cv=none; b=FICklkb2WtiTGh4GRA9V9WHMb0tZJC2OLPy8tbW1uzy4Sqm+kM/sBp/CrY+O0APJeW3mcouc2mD04MVKGHpryeJqulIbe1YrUbaiUtJOSntzNs2mm0p02QOo2eJ2KdCyeS3I+gPuoXK0lHvF30Q6jHNyN9ODwDTsGqeGnpy7Ph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790628; c=relaxed/simple;
	bh=/s6Cg1qLzc2wVEBFcbWa/su2ZGxYmUMAV2URQcFl4a4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tpTTDIbWwxWIv6MwY0Mml2kXOOgylpIWy96+AtFK1PjgYNqsBwvmJRzUESmUA6c8OsVKjWAJgle6jO3UKrz/g6O+qVyZchzoJoeK0w0mLgTsWIU/HrOgcUk7NzZQNk4j1Y3N5+3xjRRxuYKJI0v20W19fSPoYBUEfm6suK0dTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWSyRuSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWSyRuSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C983C1F000FF;
	Wed, 30 Sep 2026 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790627;
	bh=3cPZSJon0n4gVf3amRk/Xa1EKr3bdYybc8ss9inrvjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWSyRuSHSWSLqelUf6kD0eONYSR/V6U7iUNvZum6ZQDoCEvRZTWQJzlJCQlqTMVjw
	 /mmvUZM1Ux8vPGnw+E6Bc+Przi6/SK8gp5TqNf5iUfRBZ6qWiUIYl67PjZjBEIvsxl
	 PBkdqku+rk/Q6oWqgUA98SflfAwEqghn/nb2M3eiY4sgRb7yfuS+w5zQGhXpzq33lf
	 gSKjCZx43L+hmJOgRHY7Vx1s+9cR26LPGs+NLC/MEFLISTjqPwzfWqzFVvpIOOP2GM
	 i2ldulwquGbwUxa6F6mny8l8JQJ41hzp0NpzwUks+hmncbm6zL3uM984B3TpUzbPfu
	 c7tyuXzc7XGDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] tty: serdev: Add mutex lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260930-rust_serdev_probe_refactor-v3-1-d1b6e77135e0@posteo.de>
References: <20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de>
 <20260930-rust_serdev_probe_refactor-v3-1-d1b6e77135e0@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:50:26 +0000
Message-Id: <20260930175026.C983C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: serdev: ABBA deadlock between serport->lock and TTY workqueue
- [Medium] pm: serdev: cancelled async pm_runtime_put leaks power state
--

commit f8d69b3702358f814be05474626c0ebf27b17939
Author: Markus Probst <markus.probst@posteo.de>

    tty: serdev: Add mutex lock
   =20
    Besides more predictable behaviour, this allows for several hardened
    behaviour changes:
   =20
    Return -EALREADY in serdev_device_open if the device is already open
    instead of causing undefined behaviour.

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

[Severity: Medium]
When a driver fails to close the device, this calls an asynchronous
pm_runtime_put(). If this removal occurs during controller teardown,
serdev_controller_remove() will immediately call
pm_runtime_disable(&ctrl->dev).

Disabling runtime PM explicitly cancels any pending asynchronous idle/suspe=
nd
work. Does this leave the device permanently powered on? Would a synchronous
pm_runtime_put_sync() prevent this leak?

>  	ctrl->serdev =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_remove);
[ ... ]
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index bab1b143b8a68..c11908f5e1ce3 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
[ ... ]
> @@ -29,6 +30,8 @@ static size_t ttyport_receive_buf(struct tty_port *port=
, const u8 *cp,
>  	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
>  	size_t ret;
> =20
> +	guard(mutex)(&serport->lock);
> +

[Severity: High]
This is a pre-existing issue, but does attempting to acquire the lock here
trigger a use-after-free if the device is actively receiving data when
unregistered?

When serdev_tty_port_unregister() drops the reference to ctrl, it frees both
ctrl and serport without synchronously cancelling the flush_to_ldisc TTY
workqueue. If that workqueue is executing concurrently, it will call
ttyport_receive_buf() and try to acquire serport->lock on the freed memory.

Also, does this lock attempt cause an ABBA deadlock?

ttyport_close() acquires serport->lock, then calls tty_release_struct().
tty_release_struct() synchronously waits for the flush_to_ldisc workqueue
to drain via cancel_work_sync(). If that workqueue is running concurrently,
it calls ttyport_receive_buf() and blocks here trying to acquire the same
serport->lock, deadlocking the system.

>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
> =20
[ ... ]
> @@ -130,23 +142,30 @@ static int ttyport_open(struct serdev_controller *c=
trl)
> =20
>  	set_bit(SERPORT_ACTIVE, &serport->flags);
> =20
> +	mutex_unlock(&serport->lock);
> +
>  	return 0;
> =20
>  err_close:
>  	tty->ops->close(tty, NULL);
> -err_unlock:
> +err_tty_unlock:
>  	tty_unlock(tty);
>  	tty_release_struct(tty, serport->tty_idx);
> +err_flags_unlock:
> +	mutex_unlock(&serport->lock);

[Severity: High]
Does this error path trigger the same deadlock described above? It calls
tty_release_struct() while holding serport->lock.

> =20
>  	return ret;
>  }
> =20
> -static void ttyport_close(struct serdev_controller *ctrl)
> +static bool ttyport_close(struct serdev_controller *ctrl)
>  {
>  	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
>  	struct tty_struct *tty =3D serport->tty;
> =20
> -	clear_bit(SERPORT_ACTIVE, &serport->flags);
> +	guard(mutex)(&serport->lock);
> +

[Severity: High]
This is a pre-existing issue, but does reading serport->tty into a local
variable before acquiring the lock bypass the lock's protection?

If ttyport_close() runs concurrently with ttyport_open(), it may read a sta=
le
or NULL tty pointer before acquiring the lock. After ttyport_open() finishes
and releases the lock, ttyport_close() acquires it, passes the
SERPORT_ACTIVE check, and then dereferences the stale tty pointer.

> +	if (!__test_and_clear_bit(SERPORT_ACTIVE, &serport->flags))
> +		return false;
> =20
>  	tty_lock(tty);
>  	if (tty->ops->close)
> @@ -154,6 +173,8 @@ static void ttyport_close(struct serdev_controller *c=
trl)
>  	tty_unlock(tty);
> =20
>  	tty_release_struct(tty, serport->tty_idx);
> +
> +	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rust_serde=
v_probe_refactor-v3-0-d1b6e77135e0@posteo.de?part=3D1
