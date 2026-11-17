Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946864;
	b=f6o/PmbdEhNTu1/ecAFpzUY+OtPxgzlVhYnn5d/429EIrluk01ud7o7KhxGbQ9yQmtqk
	 1ZxfKaraH/MjO0B/TfjbAVy/+SqKExUBVwC1wgZ5gaqSSOCTQOG7gKyp6joPoQON1ieCt
	 I7DaJ7aIH0Y99VYWrTq2GFOboljZUo2JPKREYM9KbEONklTc4l1uRd7sJr+UggUCAkiEn
	 ARZL1u8XvTSNOm/oon6jSp6vnB0UgT6UX0WD6BgV7WORVTif9ElGb1iSHCvwLd8/FBNn0
	 2J4ZbRFGrPc4dwg5SyLcg997PtNzRE7WYFho1zVm0Hm7TyRetNN/edojHHwckPli1ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZmiANcbW5tmKrq0jLOACh80c0Pzm2VN4RJcZoJjWdfM=;
	b=0pqOiHfiwUjRXavhcfJGsbjVktNem+O360DvZeJw3tbG5jRGmLj0yQJBopZL85P4Mqu5
	 hVI95mk+WN/NB3WBO1yZII2GVOGDCqJHK3sYBeOOOZ9rpb4LjYm6vdrTbgiSL8fEpbEve
	 u2cQQFrU75Sbhoe1MoqA3gM7ro+USdufZgxIcH7gdrdYGydUgjeetQB6KCSz6UDAA3Uaw
	 +RGt5nKjLeF8r4Xf5ldJuMX00ye348e2duGqKcH3v3xDEBNn5fWGhbiTqUDT7Au8EZhAO
	 6mpO3wpi96kMvj/oOoqb46EUP4dWUCD3wW1r0CveBnRw2mMwpA0j1La4W+hYVPJ2u6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPjuLvd7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4BC606A32A
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPjuLvd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B731F000C6;
	Tue, 17 Nov 2026 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946864;
	bh=ZmiANcbW5tmKrq0jLOACh80c0Pzm2VN4RJcZoJjWdfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FPjuLvd7BVA4WTruQtoNcQEdlqiR7qySz/y2r55Op1fsZY5f9NSap3tQ0Jvl3+3TL
	 RA0Msay0NcCrbz3UpNPOHILwrrumukjGpQkCdoOQLGTE5W91CboWgmF4VJNX9NjHCN
	 CwmGg/gM0oIFUCE2NWDkD3UHaAjohhics1SO3Y46NEfuxVLLoxA9gm8wOBGjQuTNDa
	 JY+e0OdNrMYOa63XVvbicl2mux7zAUiA0yjQUxFvEajUj0QIzSrbj+jwjuLPmwzsVE
	 y+tMu4iDsGsAXmPl9Od6+6g2TzAXxUJAV5fk857cFgW/bOELFP6g3ts/vx0PPf41mA
	 ZsgMCXYI2My4A==
Message-ID: <sashiko-outbox-219591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/16] HID: ft260: uart: enable flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117200423.19561-8-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-8-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:21:03 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The FT260 is a full-speed USB device. Interrupt transfers poll at 1 ms
> with a 64-byte max packet size, so the theoretical UART payload ceiling
> is about 60 kB/s (~600 kbaud in 8N1). The chip advertises baud rates
> above 1M and small transfers can work there, but large transfers are not
> reliable above 460800 baud without flow control.
>=20
> Stop forcing FT260_UART_CFG_FLOW_CTRL_NONE after termios setup. Honor
> CRTSCTS (RTS/CTS) and IXON/IXOFF (XON/XOFF) when configuring the UART.
>=20
> Tested at 1500000 baud both directions against an FT2232H with XON/XOFF
> and with RTS/CTS (~2.9 MB transfers, no data corruption).
>=20
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D7

