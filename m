Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369547D468
	for <linux-serial@vger.kernel.org>; Thu, 10 Sep 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046431; cv=none; b=LcctJ0KLOIwXCB1o9SaboZLwUv7FrX6WxkSgrFmvc9lek7/I7KJFqro3ZxnerJccpKTJ1+uqmt1eHuOjhlTNpX6kZ46Gx4cnca9SUH18g3v6zGuZGk3UMC781xnUunKIhlJNNEUba2GBvc1gpHXOBtrAp7EZxEUvgFAnDLThFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046431; c=relaxed/simple;
	bh=14TpOpKSb8BInat7g3nDtx858oh3HTTIMsXKoLtXED4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGNoJEj81woGkJ3h6TW/oQTodRPxBFpzQPDgERIFOvK5LfbeYJn0/R7/FRT90UUuCjIR/vRS9524Ta4ttzTwpFYhBUEfJ4A+baZyr0MAjeJb8zhA+Tb9dIElt7NeQuFph9pskvazJOUzUnypSFiXR0gnGLpbqX/Tym8nENhu3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6jIzXN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6jIzXN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80801F00898;
	Thu, 10 Sep 2026 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046430;
	bh=L/KWYa/+0EGH4uBUap0jh0nfdQG7xG/7aukVqI3rNLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W6jIzXN6ZzQ77PvI67SuTQ9TnzzKP8ULDufmwrBeQ4yMxMdzWiee1CTpuaJxkxbAl
	 FxjxWFQPxCklBuHF045s4nqXCadIIU9sgo9bCu3JlHnxkoKv9cBL+4TPgM17Q1bwIr
	 b8SelWx4z0RhTAWqI7IA1+yK811TpSiiVeIYPxOJQVkg+Xl3rwg+RRqOFXjlWGk67c
	 WG9GJzGijxucbGFL0qpdp6h2o0C4YZSUZH9Uh6Yd3eHmrXNXjgWjAy1I9PjDATt0Ux
	 yC1z1RrF+hKgaj/p0df4gRYn5QAxl2/WPxJmxO4cc42Rxu57AIasQE/I6QdpAxGqRq
	 ZAVktlzsFxCRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] serial: abort TIOCMIWAIT on hangup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260910130816.642699-5-johan@kernel.org>
References: <20260910130816.642699-1-johan@kernel.org>
 <20260910130816.642699-5-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:20:29 +0000
Message-Id: <20260910132029.D80801F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `TIOCMIWAIT` implementation in `drivers/tty/mxser.c` suffers f=
rom the exact same missing hangup check as `serial_core.c`, causing indefin=
ite sleep on hangup.
- [High] The `TIOCMIWAIT` loop in `drivers/tty/amiserial.c` is fundamentall=
y broken, instantly returns `-EIO` without waiting, and lacks a hangup chec=
k.
--

commit a8c074101564c35207f8f5e3fb06b52d01a55d88
Author: Johan Hovold <johan@kernel.org>
Subject: serial: abort TIOCMIWAIT on hangup

The commit adds a missing hangup check to the TIOCMIWAIT wait loop in
serial_core.c to avoid indefinite sleep.

Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index f7b30f77b2312..33c8f3b6ac816 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1244,6 +1244,11 @@ static int uart_wait_modem_status(struct tty_struc=
t *tty, struct uart_state *sta
>  			break;
>  		}
> =20
> +		if (tty_io_error(tty)) {
> +			ret =3D -EIO;
> +			break;
> +		}
> +

[Severity: High]
This isn't a bug introduced by this patch, but the TIOCMIWAIT implementation
in drivers/tty/mxser.c suffers from the exact same missing hangup check,
causing indefinite sleep on hangup.

In drivers/tty/mxser.c:mxser_cflags_changed(), the condition for
wait_event_interruptible() is evaluated without checking for a hangup:

	ret =3D	((arg & TIOCM_RNG) && (cnow.rng !=3D cprev->rng)) ||
		((arg & TIOCM_DSR) && (cnow.dsr !=3D cprev->dsr)) ||
		((arg & TIOCM_CD)  && (cnow.dcd !=3D cprev->dcd)) ||
		((arg & TIOCM_CTS) && (cnow.cts !=3D cprev->cts));

Does mxser.c also need a tty_io_error() check here to prevent the process
from going back to sleep indefinitely instead of aborting when woken on
hangup?

[Severity: High]
This is a pre-existing issue, but the TIOCMIWAIT loop in
drivers/tty/amiserial.c is fundamentally broken, instantly returning
-EIO without waiting, and lacks a hangup check.

In drivers/tty/amiserial.c:rs_ioctl(), cprev is captured right before
the wait loop. Immediately inside the loop, cnow is captured again and
checked:

				cnow =3D info->icount; /* atomic copy */
				local_irq_restore(flags);
				if (cnow.rng =3D=3D cprev.rng && cnow.dsr =3D=3D cprev.dsr &&=20
				    cnow.dcd =3D=3D cprev.dcd && cnow.cts =3D=3D cprev.cts) {
					ret =3D -EIO; /* no change =3D> error */
					break;
				}

Because the copies happen almost back-to-back, the counters will almost
always be identical on the first iteration before schedule() is ever
called, causing an instant failure instead of waiting.=20

Should this faulty check be removed, and a proper hangup check like the
one you're adding in this patch be included instead?

>  		schedule();
> =20
>  		/* see if a signal did it */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910130816.6426=
99-1-johan@kernel.org?part=3D4
