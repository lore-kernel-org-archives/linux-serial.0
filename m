Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698861;
	b=gu8GmIxuYPYBdyjxIQ0aNwLn6014xQnhtrqe5aD3VqosUf932/wofUbpSx1ihvTo8LYX
	 edGIoS73ukHo5I+rwUp5EAwN7OV5Lol8Sg/FO5KrgjZjoBm61Id9N/F0gsK8J3qciDkTf
	 jZ2Ca7dQF7Z0u8HGOOCSz+6LF0l+hZEF/4L+GCry9Qd4nV9O96oZRTXhPPqLIYFC10Mri
	 m+bYeESlD6FK8oi5m9ejKrbgLSZuifetM/FJVqttbhcnJGaP1pObgLnakzeegKIvqKDiL
	 TGBtJYx85w0c57z8HCyCh2eiG7SZ+ghaVZBkRipP5xDbNTfQtkBWgD3EQDTg55e0Q5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698861;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f0CCnxWIOusi0hK8KTQlmItCqtzYpeq6Z+p5ovZps98=;
	b=DkoCzRFO8JnGvjnf3427jYqTOwjdok0DyNq8YJBJdNYJDMl7q3LvABKUn3kqnALBnKQr
	 H5/P3y9SxUj1eRwpbzZz7Wd0mHolbkrRtgeZhpq7ykN5Ns230HXi4jyCkFHlDMhkEBdOy
	 0CRfJAj+7w8rGRPfJoGRtYshs7Wb1dzz16NBTxSJjqWUT/zJEro1yGwqQc9YK+Y5auLaC
	 elwvYHEe1/poLFMhaQPrAq2pZoFB/wkT7mvh2pgqb+k/Pg3gghmMgqMrLzv80jwgRBEt4
	 VenoL2R/F6b5kJUhp1obF2vg0AZlh7n5BwuOm84WCPr+qh67esNvTG7yBhN7OPkZfxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmD9JCtG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C4606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmD9JCtG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D721F000C4;
	Sat, 14 Nov 2026 23:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698860;
	bh=f0CCnxWIOusi0hK8KTQlmItCqtzYpeq6Z+p5ovZps98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LmD9JCtGunWyfVTy0cn6kM9HdQfVbqYVlr4Aj892AKIeu7mt8c+C4SCWex9pe6crZ
	 jCbxX6GaS3KbaTOa5hg4egYmeIOLqk0ISRUuQaFbUN+dPuLO9tHEQ5+ujMYotFcVDb
	 gP3voE6D1Vycws52+iczYq+isYJyyOGt3IPwDxT1RP4PqRQp6/SqLuS+wM3HCxonTD
	 sEXIHKfsceZOn+/EscE21JnymxAnccKCos28H1H4PNSMO0u6+xJKEJbYfKXvc+jmYO
	 6uQhRKndcelHkivrxd903dYuq3OqMZWs14ddtmCYWanBwDBhXUkOShEMiPB830jHEf
	 j4wk5t4yTtbgQ==
Message-ID: <sashiko-outbox-215110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] HID: ft260: workaround for TN_189 errata
 endpoint STALL after enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114230800.1344401-12-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-12-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:27:40 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> FTDI errata TN_189 (Section 2.1) documents a silicon bug where the
> FT260's USB interrupt endpoints are occasionally halted right after
> enumeration. When this happens, Clear-Feature ENDPOINT_HALT does not
> recover the endpoint and the only known recovery is a USB device reset.
>=20
> Implement a workaround:
>=20
>   1. ft260_check_intr_ep_health() observes the STALL by attempting an
>      actual interrupt IN transfer. The FT260 does not honestly report
>      its halt state via USB_REQ_GET_STATUS (returns 0 even when
>      STALLed; confirmed separately by FTDI engineering [1] with a
>      USB analyzer trace), so we cannot rely on it; instead we let the
>      host controller return -EPIPE when it sees the STALL handshake.
>=20
>   2. ft260_check_dev_responsive() catches the broader broken state
> [ ... ]
>=20
> Reported-by: Andreas Boose <Andreas.Boose@almex.de>
> Closes: https://github.com/MichaelZaidman/hid-ft260/issues/40 [1]
> Link: https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata=
-Technical-Note.pdf
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D11

