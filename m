Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF842379A
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116629; cv=none; b=kyOR7w5Nxvvz5i6Yh30bK9/JBnBJY5PMupMngBK95BdbJz0m8qiOcM86W3zzi2IpzL492NNYIL5xIhdZkSPRal8ol32JENdelz8Ynzzfm38qu2DsaJw6chTtjds8DiZfb4w+CLYgIDrjRGbAK/PbWT1xqwmRzdncu7v9TyaFWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116629; c=relaxed/simple;
	bh=SkWxzysaonILOuuihKVy4Jefr+n3S8eD1qxT3JnNd1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d11MnofVSnuL8Sp2t6HtE7bi7q7ZmzyMyiA6C6RyWEAbYXpTJNGPeMbpRSyGjkMKWazu4WXAkibzHzABcZ4cmyaXCGtoGSX67hGQEF7KvW0w8QsQxDC3/e1SYoSo51B5XGgzDHJQV4bl+v0r8GYaQhGm5qBsYHQswHldeZRd5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKH8tfmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKH8tfmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2471F000FF;
	Sun,  4 Oct 2026 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116627;
	bh=SkWxzysaonILOuuihKVy4Jefr+n3S8eD1qxT3JnNd1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HKH8tfmKx3JlykrEjXi2Wqfb4a+sGEdIg3nWoBnmlefVEToQYTIJqft4DGp6zVYfi
	 2425jEX2ylG0SoHmEQnlMnOpR6yopHAQbsS+/74hURC6USwanxJ9AAbZQhjD87d4EU
	 iyLOcsJbnblh8q4Tv8f3XsOxdxMmrhf2GR1mmMtZjy1zuTlkca5ruZvuVnpPDkFOmd
	 Cr489OwRZ3rkiNRFuhgaFm/0nfFbLVjrCL7iaub1NpberwvxHhgHhIwgsLbP5EGu45
	 yW69j8F+T3jPnjad+GdwsWUpAyQv7d5Dy5As7W0QuZ7qq1VENNfnbKTie2Km6lhufh
	 zKi3V1ziNJyKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] serial: max310x: don't clobber the TX break bit
 in set_termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-1-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-1-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:23:46 +0000
Message-Id: <20261004122347.0F2471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> max310x_set_termios() overwrites the whole LCR register, but LCR
> also carries the TX break bit that max310x_break_ctl() drives. A break
> is a state, not an event: TIOCSBRK sets the bit and it must stay set
> until TIOCCBRK. Any termios change in between - no concurrency
> required - rewrites LCR from the termios bits alone and silently ends
> the break early.
>=20
> Update only the LCR bits that are derived from termios and leave the
> TX break and RTS pin control bits untouched. Since nothing clears a
> break when a port is closed with the break still asserted - the tty
> core sends no break-off on release, and the unconditional write here
> was the accidental recovery - clear TXBREAK in startup(), the same way
> 8250 does.
>=20
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D1

