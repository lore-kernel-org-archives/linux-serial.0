Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA8370D63
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915225; cv=none; b=LpMf2a2QfobRI1sWbVlKsym1vx62zBED9tA8f1wYfHp6MUwC83hwuSAHl67M5b80cVu83Poi0LnWuUfIjtyrk42GKR3uZXKyluuft0chCEnjA3XTA0NUIZ1LDgvc6uVvYhkVNkj59nIVe5n4PdFcfHyp1jvSDRzziMbKKey8Q9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915225; c=relaxed/simple;
	bh=MRx0de1fHJT/x4o0jvZIfmVNfbCAU77OLllB7VvL31g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WG2eI48vf6autCh0qsa5ZBvVcp7Hn/Yjy42h3z7J9aKKpwS0UC9imhakSfDjI0de6QxJzySJoJcyDdgytaUYrmCy3qRqbztsOsH1CbklI8dr8EVEX0Djcun36ggHrdB9KVEBS5ithoLIUDlAcdBldoKnNZ0i4r2u7Qps4/+hwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJkOxzP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJkOxzP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B874E1F000FF;
	Sun, 20 Sep 2026 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915224;
	bh=w8Q6oKXVeMfoDDjygW0H4ZwjabElO3jswFPPZiyIKaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PJkOxzP+m6LKb3CuZqaXuDfj9aPfwTKCrhp+XA5hGBulcM1tsxnoTYjXuxQd2XvE5
	 cNiy5umI2LFKJtXa6doAWkrSwGykXa+2kesPn9IMIuz1BGtoWrAYgJ8en+Feny39C4
	 K5xhQQDRs2/of3ltxPkZOuEXSVim/QmEm3qa6i80Wm3vud6w7ilsyp0+7oRuAHo6OQ
	 A1d93+turGGaDJDErgswJeSrQY03m50H50O30kXxRC0QLYm2mXZlyJFALAIEcEq7IJ
	 kSu2VTMzD1yyaLEtDjBsmbe2ET7aMUsyaJKQKboyTftHfBAjVfFHP3jZFTqY22gSDc
	 lgKmfvH+UDkhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] tty: serdev: Export functions to pause
 receive_buf callback calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
 <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:40:23 +0000
Message-Id: <20260920144023.B874E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: missing hardware memory barrier after test_bit() on weakly or=
dered archs
--

commit 85ed03352c1176c6dcb07b7e3b1ab8aa8ce0db1d
Author: Markus Probst <markus.probst@posteo.de>

tty: serdev: Export functions to pause receive_buf callback calls

This commit introduces functions to pause and resume the receive_buf
callback in the serdev core. These changes are intended to simplify the
serdev Rust abstraction and help resolve race conditions in data
reception handling.

> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index bab1b143b8a68..e8aa89e733bd8 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -32,6 +34,14 @@ static size_t ttyport_receive_buf(struct tty_port *por=
t, const u8 *cp,
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
> =20
> +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
> +		return 0;
> +
> +	/*
> +	 * Ensure writes by the driver are visible before allowing traffic to r=
esume.
> +	 */
> +	smp_mb__after_atomic();
> +
>  	ret =3D serdev_controller_receive_buf(ctrl, cp, count);

[Severity: High]
Does this fail to provide a hardware memory barrier after test_bit() on wea=
kly
ordered architectures?

According to the kernel documentation for atomic bitops, test_bit() is a
non-RMW (read-modify-write) operation. The smp_mb__after_atomic() macro is
strictly intended for RMW operations.

On weakly ordered architectures where atomic RMWs are naturally ordered,
smp_mb__after_atomic() expands to a mere compiler barrier without emitting =
an
actual hardware fence. As a result, the CPU may be free to reorder the load=
 of
SERPORT_PAUSE_RX with subsequent driver data loads inside
serdev_controller_receive_buf().

Could this reordering lead to the consumer observing stale buffer state,
potentially causing data corruption or dropped RX data?

Would it be more appropriate to use test_bit_acquire() or a full smp_mb() h=
ere
to establish the necessary acquire barrier?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-rust_serde=
v_probe_refactor-v2-0-43b855162f5d@posteo.de?part=3D1
