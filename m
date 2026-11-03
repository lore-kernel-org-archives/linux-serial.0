Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721599;
	b=xBQtaccn+yxyTe+1St3C5hyey3F/GoLeD00tl+YoxTRRkxX4z0ZyfdGluNAyhuJyYWlv
	 HF5PmO+9ljef1IH4kRoJ43wd12pIGBNy+hM8XGcs1oLqbbG1Fd+irvquiqqd+69M+cBdW
	 HLlWsqCMDuvE+woyGdK1Ue/sXuPcKbOyBXXQDNewLvtvqxqo5OJldB65eABnAKPyUrefn
	 rDY4pyD0kFk3+RygH8btjI0+4wvX6/95QrqSqjog2pyAGGXkNlav/c3YNNIhFrg2auSD8
	 cBNlix+WIuw+wdSw4nDkzh7C56esJgKzk90mDaVMgqB3zehAO8FMU6LLbGi9rEOEBOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bp+Rqml5xcmjgF6FcThURwHmXY282A1HYdIlkbbypF0=;
	b=e6TOgIh8dalTBqUoTexQkIxwu9iOsMzew1BRD7x+RaNkwflVVLyQtnoASvbS7vIrO2LY
	 WNUxTodbo2CAfBDEv6yDVHwQbRRkRErcMCW+hFK57SeBOYABihxyOeMHwhPjkuppTgm/0
	 ihalcV7vIvTJepBTML1KZS2xKiYFhQaFo/lAgFxpPK0w64ul6gQ1KGzWd7AYZrUrY0dwE
	 uUBSGmnW5EgOWgrgjQx4BS4txM11Q9ofSi3W8CedLmFbAUSM4Eo6zyE1pKuzyzeY8qUuC
	 dPWwRiL3mBfzlrOENO44OKKmXsWBiR8sg6kasRZh5JsKjPumHUEOHAjPNp0BFs1A6Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn6D5EjP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8289606A328
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn6D5EjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524C51F00919;
	Tue,  3 Nov 2026 15:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721598;
	bh=Bp+Rqml5xcmjgF6FcThURwHmXY282A1HYdIlkbbypF0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hn6D5EjPyKpNI0CLBhYNPasWeVy37GDxwMODnvoUh0MN6Q/KFApL/+Bn4s2WSlKxY
	 ohlZEvAtg7xg+Zqkv/wjLsWgA05HdPPeNIBl3ZiUBHIzWz0lsfDLCOMeQIdWxZg9qw
	 hqgJ5pOZZ/btM+eH8B7TGiQnoN7DGSdVhQlCS+FWO/TdlJ347F0xjuUWYSKSo+e7ib
	 YKtPnVxLT+yoAcIgJfGMUPfN78y6RbBqesQc/F3fB84U8iZiJrH7m5JhW4moTEUzEo
	 FlhRWY2RvJUumvxRdwCKQCfxnD2IjSCIRd2pQkfTpuWOMIS2fdjqhqMq6/QEd75SO2
	 CKuQgMpVhO4/Q==
Message-ID: <sashiko-outbox-195674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] serial: core: Allow drivers to enable TTY wakeup
 at registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefano Radaelli" <stefano.radaelli21@gmail.com>, linux-serial@vger.kernel.org
In-Reply-To: <b73bdbabd8d8fba2a2ff5d8576261bda6d8b0b5c.1793719239.git.stefano.r@variscite.com>
References: <cover.1793719239.git.stefano.r@variscite.com>
 <b73bdbabd8d8fba2a2ff5d8576261bda6d8b0b5c.1793719239.git.stefano.r@variscite.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:59:57 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Stefano Radaelli <stefano.r@variscite.com>
>=20
> The serial core marks registered TTY devices as wakeup capable but leaves
> wakeup disabled. Drivers whose suspend path checks the TTY wakeup policy
> cannot enable that policy by initializing wakeup on the physical parent.
>=20
> Add tty_wakeup_default to struct uart_port so a driver can request that
> the core enable wakeup when registering its TTY device. The field only
> sets the initial policy; userspace can still change power/wakeup.
>=20
> Apply the setting only to the matching TTY device, leaving serdev wakeup
> policy unchanged. Drivers that do not set the field retain the existing
> default. Warn if enabling wakeup fails without preventing port use.
>=20
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793719239.gi=
t.stefano.r@variscite.com?part=3D2

