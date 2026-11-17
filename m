Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794896539;
	b=KrnUJP8KkUsxxzAY3PllKrF+5bOcUeUU8O+rtRK1o6cym+3CKOzbpkslyOL5oHHdZLtX
	 UtJFwrq3R8CVQqR1DQ18okm2+qKt7A4NZaSAmX2anBW6Vql4/4uw3474BHBLIOVwW8nVY
	 ntNyT68izan5pa65WbpI7mxWYACcIAPy3oj2RnuE11tSUbJfRnpiAL8FFORMt1jUTxxLA
	 oFe4DFlMSaHqFdDjUTldMrgNczJAepbxwpVdmOAJXfZS36V0DF65IuPSwQmAPeDS/xLlV
	 DHXUdO8qZqJTMSdInWipJ4su6QHMYNpN/Qrc9q8e9+mwgAwfjREcdSq+ySAAUTJfZ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896539;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ALbYQ8BHKGYwLP8Of0K8AidEmzgVKPEnyIWvWO0pC5U=;
	b=aFEzj5n7aAexCHSrrTydkWMSUxDEsFDEQ4bbn7iif6lRDB0Jgu8yAXMvNGglR0V1TVKR
	 PpShjt+DU1oetZamhc0gT1uDjCPyz87d40SMUzD7lM9hYlchBcuAPjRuWM0cbzTzyRTjC
	 wUD//l+4iEZeKGm9SBf2qEcAlNxi7rgRodXDsrgeWnKQ9b+8GCkSgCp0BrUuVWUItewVe
	 taUo6VhFKIoyXOOZFJBJnC5frOenqkOmR2drXx59wNOIZK96LqsCs/BrRSAEGFw/zoMxp
	 89GspQsslI2/yYDMd9w8tc2q3qoy2vaYdrMzBdPMgDCrmAqkBNgWEyWIKv+Dg5Mpa/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPsATYwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEC606A331
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPsATYwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7081F000D1;
	Tue, 17 Nov 2026 06:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794896539;
	bh=ALbYQ8BHKGYwLP8Of0K8AidEmzgVKPEnyIWvWO0pC5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bPsATYwEBalm0wg+7ZQKZi+OxooH0FtCpCxz73noEbRruJHV/KvwPktBs7p7knZCY
	 acG6J5fVTRQDrwQN8Y+n0XZAfaTNAZWyGtqSwRXUsdqlkeJiI+mlgqjoDhe/9+8v+J
	 hb8nCvUH35UQZ2EmhlkM5d2/diT5sLHaJ3GlKq0SpPeQjwOAbqQfZSrbbl1WbryrDO
	 oNk53gu6BD0NyL2kmde3aIvvJv7I3Cs+OebphXQRJwDkDHb79pc+ZmjGGUtTJaUryB
	 OowYOMkuZaRt8kEkCO3WnbbnXeNYnUf6/fWvuC2AMQhBxERBQNvgWKeiAUN+ifq64D
	 XN3FTho7ggTdw==
Message-ID: <sashiko-outbox-218248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] serial: max310x: end the RTS envelope when a
 flush leaves nothing to send
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-max310x-tx-fixes-v2-4-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
 <20261117-max310x-tx-fixes-v2-4-b395126fd23d@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 06:22:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> With software-timed RTS, max310x_handle_tx() ends the envelope only at
> its entry check, when it finds the transmit fifo empty. If
> uart_flush_buffer() empties the fifo after that check, while the
> function reads TXFIFOLVL, the loop ends without writing to the chip and
> the function returns. Nothing was written, so no TX-empty interrupt
> follows. tx_state stays at MAX310X_TX_SEND and RTS stays asserted until
> the next write or until the port is closed, and an RS-485 transceiver
> blocks the bus for that time.
>=20
> A tcflush(TCOFLUSH) timed to the end of the delay before send
> reproduces it: 68 of 975 flushes left the port in the send state, seen
> by a following byte that left without the delay.
>=20
> Call max310x_delayed_stop_tx() when the loop has pushed nothing. It
> returns when data is still queued or the chip FIFO still drains, and
> arms the after-send hold otherwise. With the change, 9509 such flushes
> left no port in the send state.
>=20
> Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardwar=
e delays are too short")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261116-max310x-tx-fixes-v1-0-61c=
01f180911%40vaisala.com
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-max310x-tx=
-fixes-v2-0-b395126fd23d@vaisala.com?part=3D4

