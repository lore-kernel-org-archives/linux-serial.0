Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015660;
	b=1vb47rJsxczvIPsZMe0z7VDr2l2lvdQJqG4idCaYNIhXgXrvEYsPKTUP3jr6+MLX7dO3
	 kr7YOgOlgRQlB8eu047dAV7uPBweSSJzgTK/fUsA3EKzQFfcq2f6NUJDZf0B2rou6PlNU
	 AH/S4TYu7tPtVZjZ8iX5JqGSZdce2EZcemsU4fE1HcQc5DSkPFaimFjDdnn0vW3SquLRm
	 jxeyFWUl2afBSLHzkA9uH1+8+e8gic9X+SfWenJx51bnhc+8A97pFQqqpVgZtq8/Dk3gb
	 1tewXKDpgIDG/UB0Mvb+E2W1mPCQVmj2Ldm0hcsTLgEaCsCPC+Kwma5VDL/szp8A7hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=szBQZEcEpddLBN5BwYG2iNtTW8g8XkhGaYliBN31E1g=;
	b=TKnS0kc3YGafrtNgnWyL/h/H59A5dzic6mJn8s1vvf3/7jHVkK6jxVp7qrZxJugQPIfl
	 hfKdKXcVXMzdibyofRSil1viXO6LyV+JFY0dIolNIGYLx5CqjK1YIviI95BpoHIpkbR2l
	 83NyD479kJ4FL5Js7QXtz6jE2bhmi0dj92zet//6+LY7uN7dpu321NgGEQeEPu7Uzisbt
	 o4R/K6haoM3El663ijIm4HMDwKWmDlegjC97Htu13AHsctUKvpVEOGxX2EY7uBc58leeO
	 zU9xil5uPIuR2rtf6cfDeCzRHQE13+LQPXaZaXCCKtxvFhMgs9vuVjr4zHP1AeOcY+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L0F3x/Cz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A1606A31A
	for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0F3x/Cz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459BC1F01825;
	Mon, 26 Oct 2026 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015659;
	bh=szBQZEcEpddLBN5BwYG2iNtTW8g8XkhGaYliBN31E1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0F3x/Czb2emR+0PQcuON7CJhh0ZOApHDC0XHfKoznlk+1F1pqcTMUL5dT0uZ/4hI
	 mrSf4UKbDr9B/NytLrICFzDXjdpEW5JUUuorypTXqUQ3TwYFUqdVyj+79z+WIDCwG/
	 ANNjIOcHtS7hTw447rukqp27vxBhlyG8cpx8cmZRKc7gjvDnDzEwOwKiXT55fhVtL0
	 jKcx3/T6JFZ30hNG2E29nLfr0NZ7+Ir4rpIG3Knotdcvqw082V0Y6kTPz5UVjCplid
	 DQxFjm97qeYjngeexcLN+08i/+Vh2PYhBzIcTQWQ6VAZTuIRwAxwOi/x3DzWDKInZb
	 1UjM53VCkNjdg==
Message-ID: <sashiko-outbox-185133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] serial: sh-sci: Toggle TE when restoring SCSCR
 in console write on SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261026-g2ul_sci-v3-4-b3097163edd5@bp.renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261026-g2ul_sci-v3-4-b3097163edd5@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:54:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Au Dang <au.dang.jx@renesas.com>
>=20
> When SCI0 (PORT_SCI) is the system console on RZ/G2UL, the board can
> hang at the serial console output stage during boot.
>=20
> ftrace shows the following sequence:
>=20
> 1. sci_transmit_chars() is draining the TX kfifo through TXI
>    interrupts with SCSCR=3D0xf0 (TE=3D1, TIE=3D1, RE=3D1, RIE=3D1).
>=20
> 2. serial_console_write() runs in the middle of that drain. It saves
>    SCSCR=3D0xf0, switches to polling by writing SCSCR=3D0x30 (TE=3D1, TIE=
=3D0)
>    and outputs the characters with sci_poll_put_char().
>=20
> 3. It then restores SCSCR=3D0xf0 in a single write. TE is 1 both before
> [ ... ]
> TIE is being re-enabled, so TXI fires and the interrupted drain
> resumes.
>=20
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-g2ul_sci-v=
3-0-b3097163edd5@bp.renesas.com?part=3D4

