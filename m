Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193388;
	b=A9gJZqajirfCPsVv72oNOdaL7T+KZryt62h2l1eDFra3pRD+O8fYwj8MMAU1mZ07VMdm
	 9TFw/hEqalKQI5S2RY9cvnWhCm43TEVewu4QwdE4i51DOJSbq3IX3oNf/bBiWZOpk1d63
	 9XMIg030Tclc8XsNTZ4QN61a1ZLhsXw4kpVxdvw8HHxIFfAdrHtbFD5ddYgLP2egktcrw
	 GaHtg2eE9YGeYPH427HFPpEZcD/UIxLvBQprVZF/xvCAf6/5i0J2lP1i0bU6gtH9nk2XZ
	 VndF2hRG1M1fvX9YDPFUO7bOJjNWUVdN1RHjewHj1V6QZTCfxIH0qb8Mzf874GzBBHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C38jZBhhrDZsMai3YNV9LE51kzClH+122/fuVnvkwEs=;
	b=VX1xxAz6jifDnwcHNHKxWcR9aq/IBY2qRJuJRQVD1x20k53COX3zTveJ32f+kmF5+7EI
	 LKtY0P7tDlMK5o3E4qiCn+GqfOkEwt50uhZrXV7ZH4sjvt7qXtVXiJKpcEs+KmFX0AH0W
	 iIVwqWH2uGxuafmu5u81MfFE8Iuoqb3Fskw/GABR/KbmHbCQ20mQL3VdnddaMZ5MlhnMK
	 cXauGzw/efzGXpYIupC9gTpauRVNeZ3i/rFFMC5ahoef4ZqbLKuz6VaAkmo/Lr78eeKFb
	 kbeoX5LLShBBcEMVAC6+xCdvLW7tm2rKq4+UMCNoUYQJyyQuLYU6uXceiqfO2X1+32g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcLQZLCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAB606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcLQZLCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42051F008A2;
	Mon,  9 Nov 2026 03:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794193387;
	bh=C38jZBhhrDZsMai3YNV9LE51kzClH+122/fuVnvkwEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YcLQZLCHfBv0xkyrmVlDBLgE7MMvnJRCAoAiugYbu8gNGivyjHEl0guO9bLQxXBas
	 +8QOoh0ko4wTj9uaQFhRBSrSYjqvYWNlZENUNPq9n9KDtq7DyUpvzvLVRpJ3RkeRMe
	 Je6NX/0UMnvTHm8wb66LDeOLW793Z5Yxh7iaNevUsyfX3+5ugwBs2evkvfD1SP5KUN
	 ysts/qTETLmkcS8va/zZ0sp4swn9PoRSFuL/wY51EId6Kns7vmjV/2k6rUfkhxM01C
	 qVJTvT5ya+OzqlBxhBzfhfIhYWkpZSuiFM8Qww1gnWFB5I6V7l/w/vAlZnV1I94E1K
	 j20qF6dXyQI6Q==
Message-ID: <sashiko-outbox-204361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_of: drop RS-485 RTS on Microchip
 Core16550
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Otsuka" <kohei@spacemachines.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-core16550-rs485-v2-2-a15933c7b907@spacemachines.com>
References: <20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com>
 <20261109-core16550-rs485-v2-2-a15933c7b907@spacemachines.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:03:07 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Kohei Otsuka <kohei@spacemachines.com>
>=20
> Core16550, a 16550-compatible UART for Microchip FPGAs, interrupts on
> THRE but not on TEMT. When the last character moves from the FIFO into
> the shift register, the THRE interrupt calls __stop_tx(), which finds
> TEMT clear and, without UART_CAP_NOTEMT, returns to wait for a TEMT
> interrupt that never comes. RTS, and with it the RS-485 driver enable,
> then stays asserted after the frame, and receive interrupts, disabled
> for the half-duplex transmission, stay off.
>=20
> Set UART_CAP_NOTEMT for nodes compatible with
> "microchip,core16550-rtl-v3", so em485 drops RTS from its stop timer
> one frame time (plus 1/7) after THRE, as it does for DesignWare UARTs.
>=20
> Set UART_CAP_FIFO as well: with the capabilities already non-zero,
> serial8250_do_startup() no longer fills in the PORT_16550A default,
> and without UART_CAP_FIFO serial8250_clear_fifos() does nothing, so
> the RX FIFO is not flushed at the end of a half-duplex transmission.
>=20
> Link: https://github.com/linux4microchip/meta-mchp/issues/5
> Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-core16550-=
rs485-v2-0-a15933c7b907@spacemachines.com?part=3D2

