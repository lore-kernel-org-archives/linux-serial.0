Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235959;
	b=u1+EdI0b8eNLd4h4VOxDooNRw4WOhKOfleFJ4WiF5NjqWlf8Sc/lFczRSnafAiE1Yfaw
	 wiBmEDKE6r8gN1hWRjdAerFDMwzYZiadxwWKFImKJpJQRtUodWShO/YXPGtskb1669GUU
	 Tu9BwQsQnHCy6DFGsYrDXH/uhnn021gI8WtE2+YNuzfDgFyHpFjaiYcVdfRFoid1LXlE5
	 +gG0gIT4lOKbyqLh3Yck/j3zPHSDeFUMsn+qkNWIh4XxvgJnLga+wBMpT6MssaBCVNqHk
	 Yl1lxyrnkaFofLgAA368B8CfLqs3EfbkFRq9IWFYC4IvUDeH8gPhyoK0ZKA58bxMXwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hQgetV36XWJ6M57bdj76mUhG5NwfkE612cRnpJ4o8iw=;
	b=VrGPFxa513uaIE561lFgkoVujjM5+PgBL1GEPs25zGIkoGap/hqnc5FblEgOyYUN1M3t
	 f58n9DoRs9RvTJ4Bu2FU4mTzwRWx4XVPCSeKNzJz0o699iY03KBS9eITYVFsB0G6k2EVb
	 pssTHo5+nGhDJ/BHgrHYGE2zHKxspXRYNjD7euM6vhcxSy5qbOb1ub7tavwnqrPwUOWSF
	 Jyq/SjWoD/ttm5ic0Hhz5eg2a/TOQZNT9a+0MaYo594jxVpkKTTcMPK9Zwm2jeD6aGah6
	 rdLGNQOF5CRZeYE3KabViyunU0bQkPfYuOxDII0IpJperUvCGD+MHEdRV7DCwsXouqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jsM/ujAI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084E606A321
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsM/ujAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95301F0089F;
	Mon,  9 Nov 2026 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235959;
	bh=hQgetV36XWJ6M57bdj76mUhG5NwfkE612cRnpJ4o8iw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsM/ujAIcYT0UkbVqaykRtd+bnLZrJUHwGCoMVQ+L41GYNWC3IxAo3NXfokkCMBX2
	 T1oV1iWI+lAL1/0FZnRzStNjTKP2ADqpKFwiOzUbD6hHm+K9qNQCMvml5oSklMvTCt
	 NQrydb3qUnb85b4VFkntb+96+filwLRHHDZEu3SsngNNcR/4HtkK0wihaoJ4sLbIKZ
	 vq9f2ARQlkFLAVaPY5sclAkvhBYdesE7gl/icNw7A7U6HlTiD2A2ob4CBAq0SurKdV
	 UbS/ruIKuduP2DruNr/A8+o7FC2mU6kmD4rWWwIPwxCrI9WZ3rYcUuuo7Kgi19POZo
	 79VV6TAqvR0HQ==
Message-ID: <sashiko-outbox-205136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: Add RX trigger levels for U6_16550A
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-8250-select-u6-64bit-v1-1-04bc8332fa34@gmail.com>
References: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
 <20261109-8250-select-u6-64bit-v1-1-04bc8332fa34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:52:38 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] serial: 8250: unpopulated rxtrig_bytes states in
  bytes_to_fcr_rxtrig() [1]
--

commit a186be2f155b931d20413d24643c82a17676db0e
Author: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

serial: 8250: Add RX trigger levels for U6_16550A

This commit populates the rxtrig_bytes table for PORT_U6_16550A in
uart_config[] so that the rx_trig_bytes sysfs attribute is exposed for
ports of this type.

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 36b2b0a2c05cd..a7acede62f40f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -163,6 +163,7 @@ static const struct serial8250_config uart_config[] =
=3D {
>  		.fifo_size	=3D 64,
>  		.tx_loadsz	=3D 64,
>  		.fcr		=3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +		.rxtrig_bytes	=3D {1, 16, 32, 62},
>  		.flags		=3D UART_CAP_FIFO | UART_CAP_AFE,
>  	},
>  	[PORT_TEGRA] =3D {

[Severity: Medium]
This problem wasn't introduced by this patch, but in the same
uart_config[] table, can writing a value of 4 or greater to rx_trig_bytes
on UART_PORT_AIROHA_HS select an unpopulated trigger state [1]?

drivers/tty/serial/8250/8250_port.c:
	[UART_PORT_AIROHA_HS] =3D {
		...
		.rxtrig_bytes	=3D {1, 4},
		.flags		=3D UART_CAP_FIFO,
	},

Because rxtrig_bytes only initializes the first two entries (unlike
UART_PORT_AIROHA, which uses {1, 4, 4, 4}), indices 2 and 3 are 0.
serial8250_bytes_to_fcr() expects all four UART_FCR_R_TRIG_MAX_STATE
entries to be populated in non-decreasing order whenever entry 0 is
non-zero.  Writing 4 or more through rx_trig_bytes_store() ->
do_set_rxtrig() -> bytes_to_fcr_rxtrig() falls through the loop and
programs UART_FCR_R_TRIG_11 into UART_FCR, after which reading
rx_trig_bytes via fcr_get_rxtrig_bytes() sees rxtrig_bytes[3] =3D=3D 0 and
fails with -EOPNOTSUPP.

[1] https://sashiko.dev/#/bug/linux-02824c35-118d-40cd-ba5b-57ffe1817328

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-8250-selec=
t-u6-64bit-v1-0-04bc8332fa34@gmail.com?part=3D1
