Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1840BCB2
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764438; cv=none; b=N8vYKX0NfhtsTO1CVu7NWDd0ibWXfpNxO0fM6T4fW1HImx4KYbi9vI40JERrJp3zoz6SdAwjodaAE150R1BU5eraP6DEZsPTJTaCnkY5tYt+YC0KPRNvJzOzfhPk+beUbyPs3HAApsZSIfPskXmyhCvPektVbPEpNfn4y5xuTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764438; c=relaxed/simple;
	bh=5HSmoOGRLuh46E6Ob8mnjuIk6CzI0OPKigzzoRbiAOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JfDXkcnfSzCM4aL6RAkWxQrQf7vswu4U3PYRAZjmyaK6KaOnqdY0675iRSK+14tTIFdRIc19qlPpvAa2nKLmZRgMtLDAZJwJCUCy+37NUjqYVrctCoh2j+Eb8P1lD8cbuyBrRBWqNMY4wwx/QB+8V2J1ikLdHl9HGpFAS7sFHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWB03NhB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWB03NhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3B01F00A3A;
	Mon,  7 Sep 2026 07:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764435;
	bh=Vc3A6zR9ubtmfR6AAteA5d4ZerbijRD5Wt+Z/EHE2dE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWB03NhB2a6L5SEIjFuPCB3PfRkaMDmkoL4RNKgUSSr7pgpGns4fUkJrxGKmLmS0q
	 XFOhezYMlrICyDBAG7wruyOA6Ujb6lC+IXTqeitAxdpKOYGK7roJO1RRu7mALOcuJ8
	 JoX04fbE3qwVsdzQdFsIWth1VBTLkn4LGdlbKtqehRs71QzDZs7q2eUwnLP+5QZ/M8
	 zym6XzoGk3kQ+MS5QAm9Rg7F6ZIM+DcqjHSubzGHWZBj+mFTsuF9sGd6t2NiiTvOyj
	 VsAxwhJMLROhu/1hK3CxuvZRVQfQusEavCHr9jvINFQznzidWnQiGqmOdyR9HNk+zi
	 coMrtxmhoxZ3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] serial: fix ioctl hangup race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907064418.92953-3-johan@kernel.org>
References: <20260907064418.92953-1-johan@kernel.org>
 <20260907064418.92953-3-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:00:34 +0000
Message-Id: <20260907070034.DF3B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] uart_set_ldisc misses the tty_io_error(tty) check while holding po=
rt->mutex, allowing hardware access after the port has been shut down.
--

commit 3a1dbe6dd850d3b9aa0ddbed8997abbaa897c8af
Author: Johan Hovold <johan@kernel.org>

    serial: fix ioctl hangup race
   =20
    The tty ioctls can race with hangup and end up calling into a tty
    driver for a device that is already gone or powered down.
   =20
    Add the missing checks to make sure the port has not been hung up before
    accessing the hardware to avoid issues like kernel panic due to
    unclocked accesses.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 1553bc6cbe7ba..4213fa3dc988b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c

[ ... ]

> @@ -1647,7 +1658,7 @@ static void uart_set_termios(struct tty_struct *tty,
>  	guard(mutex)(&state->port.mutex);
> =20
>  	uport =3D uart_port_check(state);
> -	if (!uport)
> +	if (!uport || tty_io_error(tty))
>  		return;
> =20
>  	/*

[Severity: High]
This isn't a bug introduced by this patch, but should a similar check be
added to uart_set_ldisc?

uart_set_ldisc() also acquires port->mutex and checks if the port is valid,
but it does not check tty_io_error(tty) before calling uport->ops->set_ldis=
c:

static void uart_set_ldisc(struct tty_struct *tty)
{
        ...
        guard(mutex)(&state->port.mutex);
        uport =3D uart_port_check(state);
        if (uport && uport->ops->set_ldisc)
                uport->ops->set_ldisc(uport, &tty->termios);
}

If a privileged user executes TIOCSERCONFIG concurrently with a TIOCSETD io=
ctl,
uart_do_autoconfig() can acquire the mutex, call uart_shutdown() to shut do=
wn
the hardware, and set TTY_IO_ERROR.  If uart_set_ldisc() then acquires the
mutex, could it invoke the uport->ops->set_ldisc hardware callback on a
powered-down device since it doesn't verify tty_io_error(tty)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907064418.9295=
3-1-johan@kernel.org?part=3D2
