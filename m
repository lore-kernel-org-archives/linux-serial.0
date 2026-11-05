Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914027;
	b=KATUIxSq0+JWQPzry9H3YAfNiHAzTMWxKntGlWVgSPNWEwu4L2dQlMH750WBxoj2/cb6
	 tR3lmMIPZItKqyzHlHJgJhU91HSzwJpPl8TfaTI8+oEok0xLCsPuWAFrddzUNLZ/l0lpI
	 q1qWXiuW8ziCFEXSc7phX6+qrsorG/r/ltPi5TVhbVpG1K0Rl/055XlEWhzo7go4TgpuC
	 MR6UBKV+wuHNWQKorV1dEa5brZeFtXuvQG9X/sdT9A9Joim1TfVF6KP0yKgfufYc8tFPF
	 qbVoOUgUUyk1ichEuxkdnizWDY7rsE8MFcrnpL9qCxQvIck0GwPQp64iekgvSU4tSKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lw58lpNgMTHTqKaH0dNXqGXWnrIeH/ZJkqpYsFAG9hk=;
	b=DKlDG1IEYni8WPFAYdvzzsjWtvAq1Z5d2vi9VT726gSxQzbKpvD7sr//Ox0LLnBARs6N
	 xjc2IjEwc5CQD63fm1cxSThjAmsdmb1j6x4Da+yiT9OPovmg+t4ilpsheO7Hb3P8zgDph
	 8FsS6ebRL9OpL6BKn8nK2ReTpLiLtUNWqtXzyiPUc+9H+OYfHXzfLTr5kYkIwOFxtruY0
	 ++u2Q10DsynIoOiRpi1GGjIYSjkRbkMbt2e1XB2xfTUkl/YdxGjZj6binw5mWWD0eTeDj
	 Lh/l5PREIHXY9zq4Krm33gflZPdSwFTr/a5dMziFYB0mQ/44697zG2pr23nHpsGW5FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bje+xiVE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F791606A328
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bje+xiVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAF81F008A1;
	Thu,  5 Nov 2026 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914027;
	bh=Lw58lpNgMTHTqKaH0dNXqGXWnrIeH/ZJkqpYsFAG9hk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bje+xiVEDI40fSdW0elbaItCjCF/3NFIa2fATxStY9v3dJqO+KAoIW1jXPx2eHP8X
	 wG7SsGUmRH0g85wAiDF30GOCnWfTiAMWPP/ikHXE0rnQ5mu8fUzHaJ9B0rp/tRigZ1
	 ebguauHk4Zh2Yj10TRGOJnUwETiDba/E+gqF8TK2KaAYJx+rTrFFX+iQMN+iK5RdMa
	 lM5EDtQYFZrvVaBH5WXCoKkUxUCiD1YMszk57T3vwmxvlerwRwxX4/BHYWXeLxid43
	 fFuj60zm9UIMBxJ0UJStdPH5tqpFa3n3H3QN/lFVca13DIpeIrcJDaqG9Kf/6j8/Hd
	 Hw/JWjF97Z45A==
Message-ID: <sashiko-outbox-200226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/11] serial: 8250_dw: configure the Allwinner H616
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-8-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-8-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:27:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> H616 has 256-byte transmit and receive FIFOs, but its optional DesignWare
> component parameter register reads as zero. Generic 16550 probing leaves
> the port using the 16-byte FIFO configuration and its trigger-level table.
>=20
> Keep PORT_16550A and supply the fixed FIFO depth through platform data.
> The 8250 core derives the transmit load from that depth. Use the shared
> DesignWare receive-trigger setup to describe the 1, 64, 128 and 254-byte
> thresholds, with the normal half-full FCR setting selecting 128 bytes.
>=20
> Advertise automatic flow control so CRTSCTS enables MCR.AFCE, matching the
> DesignWare termios path for hardware CTS handling.
>=20
> Select this configuration through the platform setup callback. H616
> has debug-divisor and RS485 control registers overlapping the optional
> DesignWare feature probes. Use the fixed configuration with BUSY-safe
> integer divisor programming and software RS485 handling.
>=20
> Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
> Its clock is a gate on the shared APB2 source rather than an independent
> baud-rate generator.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D8

