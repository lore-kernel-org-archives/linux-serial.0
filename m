Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1D38A706
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604746; cv=none; b=IlUM5JPMgnnaCrsLoFodnMoTFNr3GJ/CEiVLcx3JWqSfSj6tcPYYndiNnBggJg29RazWNgjiFcfofI6CZxGw04oIgcE8FD5z7pgfHhd06E4eaCgO5oy1ysE3GPj1qWuBFR6RjWzvR6I3/mFItc3mhyAJVWvSLHT31azBVYMSphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604746; c=relaxed/simple;
	bh=/toNRKPhfPtNQY010gTOr2ipLMjI1sfOs7dwYddI9V8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mnobA8Z00ezuibPT1kQRymppYBrd4TWFu7hjHcSY26gZguGcEvG8LNqwVU/07hGkOr5YmERjqNg8M5+ey3iEqC1e1DEfMmPgIgLW2Iyjb/3CacaCoQzg+waJxrF7PPmq6OejMUWbqVhJmRuvE45rDiBL2Pb6hQxhklgYD6hqmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRuy5j5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRuy5j5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED6D1F000FF;
	Sat, 10 Oct 2026 03:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791604745;
	bh=1EpWb1+SDy58mS1PCuMNF4YDnMgO/FyH5Fifv8+heJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRuy5j5H7VbfGSp9cNkC2On6B79jVpyt/vQQq33uspuoHIzaceUvf5lFrmz9I+c45
	 AKlS3phweJLYnDR2fGh5eQ1CQG5PbniIhaE3gXVjM6UTgpZl/uIMvKk43QbPuq+SeY
	 VPPDjwQiXWxmMalRkvzbXZdd9AF8G6HFCed9KrIPUVc4iJzP2HDMNODvfa6gYM37jn
	 Ah0xL3PIsf8fEh7JMYHSD/C1+v5Bwv1PcRLf8IoDOEpmP1WKATUvU8key4IYc2gNRS
	 bTUShinzDKns+i7RH4qsdxE4xSH/jSPrsZ+68oWiNUrQ7Qp0R6qKfdJ638lQqKVVxV
	 pXz2K7kpuBAyA==
Message-ID: <sashiko-outbox-166251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on
 uninitialised ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hengyu Liang" <hengyul@cs.unc.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261010034616.3915864-1-hengyul@cs.unc.edu>
References: <20261010034616.3915864-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 03:59:03 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: hw access without PM in uart_do_autoconfig()
--

commit f48636ab329a71ecd2a47c54111b53dd3b5b35da
Author: Hengyu Liang <hengyul@cs.unc.edu>

serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports

This commit changes the check in uart_set_info() and uart_do_autoconfig()
from tty_io_error() to tty_port_active(). This allows setserial to configure
a port that the kernel did not detect, fixing an issue where uninitialized
ports could not be configured.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 319a4b427f3a3..36c59f5fadebd 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
[ ... ]
> @@ -1143,7 +1147,8 @@ static int uart_do_autoconfig(struct tty_struct *tt=
y, struct uart_state *state)
>  	 */
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->mutex) {
>  		uport =3D uart_port_check(state);
> -		if (!uport || tty_io_error(tty))
> +		/* As in uart_set_info(), only refuse a hung up port. */
> +		if (!uport || !tty_port_active(port))
>  			return -EIO;

[Severity: High]
Does relaxing this check to tty_port_active() allow the ioctl to proceed on
uninitialized (PORT_UNKNOWN) ports where the power management state is still
OFF?

A user with CAP_SYS_ADMIN could call open() on an uninitialized port which
succeeds but sets TTY_IO_ERROR. If they then invoke the TIOCSERCONFIG ioctl,
the active but uninitialized port would pass this check.

Further down in uart_do_autoconfig(), the code executes:

    uport->ops->config_port(uport, flags);

Could this unconditionally invoke the driver's config_port callback before
uart_startup() has a chance to enable power and clocks? On architectures wi=
th
strict power domain management, accessing hardware registers without runtime
PM enabled can trigger a fatal bus error (synchronous external abort) and
kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010034616.3915=
864-1-hengyul@cs.unc.edu?part=3D1
