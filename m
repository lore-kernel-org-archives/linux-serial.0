Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3717B50F
	for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846199; cv=none; b=WgGsQusg55UItJSqs8x2TUZshS6GToBbEtEFShOgy91FOCmSjzRtaynwRtu4e/6nrTCBzl7AyszqPTy+g4R/GI3K9DUzTgCJ5uGCqbaL5VDxAc7jDFGYiKlzpJd9hnu6oYzjG6JzsPY9m74omBFEkWiz3OV6oN70SUY5bMx1DqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846199; c=relaxed/simple;
	bh=n2yGyaBroR8uh1k56YVYIo5BA7RzxUHMyA9Cfm5RTtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZyXSFvrnMpW2e2hUsm+QRZhKYhkFt+SeOWvv8Ff2xLybySao7y17ruBMAi7WRYqjW5VQSco0XgxWFsfVAjIlqjSglWIxsx9tzCf8XAFhaFACoOmkBsa0oMIcaPyskmK+vzhPgArcGoHSwzv+VEvJhaPB2y9ddWFhvMrVJsyrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux1H/7Zg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux1H/7Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD581F000FF;
	Sat, 19 Sep 2026 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789846197;
	bh=n2yGyaBroR8uh1k56YVYIo5BA7RzxUHMyA9Cfm5RTtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ux1H/7Zg+HZ7Fi1el1LtvBPtA/Kq6cGbn6bhSzR3MZ0c8wZVdonkQSI6ZWNSyM2oi
	 yJN3ZeyqHQIpYoCG89JoHluksbCh/zwbWmcJwQVePCcEv44FfYC3N9N1U4g2WvvGfE
	 oVwC2Zw4t0MeY1sYmZOluaTBTVtw4Slzz/hJX3OfzQNcEZ7kAklF7gZUBv6/BPuDqx
	 DhKNykVih1XaYkTq0t3IFawONj0AR65KCWxhFlJuhvQU8rNQ3U51IFcDM8DC14vVSV
	 ECfDIg7Ex29sYKrnPPxrwTXBBwrl5hwLtFUWbGrygn5YMnyKj8cT6aePbY/ctMnUDX
	 WSasRX25Wapow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: nozomi: lock tty_icount reads against the IRQ
 update path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Bilal" <meatuni001@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260919192349.272409-1-meatuni001@gmail.com>
References: <20260919192349.272409-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 19:29:57 +0000
Message-Id: <20260919192957.BAD581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> receive_flow_control() updates port->tty_icount.{cts,dsr,rng,dcd}
> while interrupt_handler() holds dc->spin_mutex, but ntty_tiocgicount()
> and the TIOCMIWAIT snapshot/compare loop in ntty_ioctl()/
> ntty_cflags_changed() read the same multi-field struct with no lock
> at all. A concurrent update can be observed mid-copy, and KCSAN flags
> the unlocked access.
>=20
> Add ntty_get_icount() to snapshot port->tty_icount under
> dc->spin_mutex and use it at all three read sites, matching the lock
> already used on the update side.
>=20
> Fixes: 20fd1e3bea55 ("nozomi driver")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919192349.2724=
09-1-meatuni001@gmail.com?part=3D1

