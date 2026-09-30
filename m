Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A8476680
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760248; cv=none; b=JeuMdHZV9dnUQpSm/BQxtEozo1rBiHoh+CRmK/f9sPnjohtDypFTjhV10Xnrh5wwSgikzXqtJbso7kSscJjnDLPzERl3T8/mEJqVfcQJE2RF6jI4V9G8kPjEM8xuHOXEutWi6WuHh39z0LXjnjza18n3hq5Kgj/LJFBskOekOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760248; c=relaxed/simple;
	bh=msUhdfZDj8zG6t08RKYRwg+vy9mBFZJsBLOusQlM77Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIlAykSMtHwsX7jFU1bTRGGl4TshQCUQUbmPZumXl7dA7dIrD+xUVu11L1rIIB2U6ddaA9Vn7bJu5R3/Mwj9LhyDPqLZ1nVHX7b9eB4/BLGOEetpeWuwtWKlLA8zCdsePvko1/mOXwUMarpTP/gAjHx7zjr/WGbmQLDth7srqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETK0d99W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETK0d99W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379EB1F00898;
	Wed, 30 Sep 2026 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760247;
	bh=7mbfJRAyMm40U2dVSHGR87zHda4fIY6MVKlHaNJFZXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETK0d99Wi/036916qOtVzcz0vv2iNjd4kFXPjz9A7B5G6TgxHYZKkNI/dHtNKdMZb
	 nwinrj2BVtxdfAPqvJkIw/JV+fKHhRgzKtaIpqwUAuv//crnKzzUPNbFYK6/Hregg0
	 pgNjhP8OSC3hE9qZ2QeCNoYt3v5YL9Wtd5TWUyX799fkUc95dntg/HRN7efvjG2rBc
	 zR113N07fjM5IdvJCc6z0HtZ/B8LJEMjgoJmFsppA8AlU+Sz+Pg4LNOItMuym4Py6e
	 w1Y5qiVQBZOkUFVpnuKgIVzLdPCKJKrkcUE1XNLR/SDfkOesbOTDdStGUrwKy95saC
	 RCJ+y+DXkB2dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: fix saved termios reset race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930091938.1715754-1-johan@kernel.org>
References: <20260930091938.1715754-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:24:06 +0000
Message-Id: <20260930092407.379EB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] tty: logical AND bypasses TTY_DRIVER_RESET_SAVED_TERMIOS check
--

commit c7c5b67aff9403896b61f084f64a1630c60063f9
Author: Johan Hovold <johan@kernel.org>

tty: fix saved termios reset race

This commit adds a new flag, TTY_DRIVER_RESET_SAVED_TERMIOS, to selectively
reset termios state only for drivers that ensure the minor number is no
longer in use. This aims to prevent a use-after-free race during device
re-registration.

Link: https://lore.kernel.org/20260926184154.3017929-1-nicoyip.dev@gmail.com

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 1c30faae9ec13..c9da7b25e3fb1 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3256,14 +3256,16 @@ struct device *tty_register_device_attr(struct tt=
y_driver *driver,
>  		goto err_put;
> =20
>  	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
> -		/*
> -		 * Free any saved termios data so that the termios state is
> -		 * reset when reusing a minor number.
> -		 */
> -		tp =3D driver->termios[index];
> -		if (tp) {
> -			driver->termios[index] =3D NULL;
> -			kfree(tp);
> +		if (driver->flags && TTY_DRIVER_RESET_SAVED_TERMIOS) {

[Severity: Critical]
Does this code use a logical AND where a bitwise AND is needed?

Since TTY_DRIVER_RESET_SAVED_TERMIOS is a non-zero constant, using && means
this condition evaluates to true for any driver with at least one flag set =
in
driver->flags. This appears to bypass the intended safety filter in
tty_register_device_attr() and would still apply the termios reset globally=
 to
those drivers, leaving the use-after-free vulnerability unfixed.

> +			/*
> +			 * Free any saved termios data so that the termios state is
> +			 * reset when reusing a minor number.
> +			 */
> +			tp =3D driver->termios[index];
> +			if (tp) {
> +				driver->termios[index] =3D NULL;
> +				kfree(tp);
> +			}
>  		}
> =20
>  		retval =3D tty_cdev_add(driver, devt, index, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930091938.1715=
754-1-johan@kernel.org?part=3D1
