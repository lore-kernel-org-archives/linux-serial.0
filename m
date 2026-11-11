Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401619;
	b=woxwl7i0diH0fhBK2KdDArQZhTaFU9E7CqJ5fccwMP9y8WiAJ92Jz/0eAn9M0lSgcaMB
	 Dx0AHwRhDwFOiNqIEUj/AxoiKAtr0RbKbei14f2h6XaLdvjV6GazgQ+dxNmvqrEAEHZ4D
	 OMjoBqNyXCj8SKXUm5z5Vo6/eWzNnqOT98E23MEWA4bQNCbAve+KyVQ08rSI4aTpRGD5A
	 Z5Y1JpUyKBATnApEkc5sXYx1mzGLFWLd6XlDk5vLnfcqAbSVzyT+OzWHgO6WXj6RNxK7y
	 zbHP4yZfQtuFkx4K+xLwAGN9dtneCwZwESiTv0GzMorHhPiuS4ngixuwNiPZGFLDhzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401619;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SVO4JREjdPswGkLuqdoICEAR5hACf015ahHUYKivr3k=;
	b=CbTXfDNVaZEgyZJ+YVg6badxPjf+4oKv5f1XP0PaHfwpUfImHpzl0+ibgN3AJapZKGrL
	 +qEdSX0SsRiUZqb5mMqF8SUkNI/nEwXfx95MuZmWJXF9Lva312Qn7VcuRxErLj298o8Rz
	 AU0Md1/R0LtVq3tEQvWCVUTrYjD/MOWPy+j1mHMuQi0CgZ3nM/ncHv553uajVcYnlPnGE
	 GXqQI4Am+Pq00b7RMC7yv5QHoAFnfFwBVaR+hD1J9gxYUYlJrw2elF3CowuTzr6XIjWAi
	 5lBdd2Ng33AfQDHPErWRFjREBoI6tC1dqG8UcXjvhxzdQmh9ZeBpou2QRo8Evzc2NgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNl3yGK6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70B606A324
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNl3yGK6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D111F00A05;
	Wed, 11 Nov 2026 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401619;
	bh=SVO4JREjdPswGkLuqdoICEAR5hACf015ahHUYKivr3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNl3yGK6tTa9UOaZ+LxGeBEArWxr8JZSerPKTJIontQs3lT84BMPmbuQwBF3HMO/T
	 D7AolBIWqkDJrFXuM62uq6Q61R2K8+0q17beplkMcvQpI3m2ui+mATD1FNpbx5SecZ
	 D+YuFlKX3XEHxGskwJ2+qCI//VNKbU1OKNhuAJLR+2rmcPM0sIjrv0P/gmR1VstyDL
	 pn+Rr+t1CprLJnmkqNHQhENHJrFiGkQy1Kx4ezvxm+w4TU2xUWl/JeKJjgM/1DdA3/
	 5mp+zSG6z8p4BGC3/3vdm53z/RTL+dcj6Cm2S/NjKK/1cWeC9Wtyx06Zk2x5b78We7
	 pDxUbKlEvS42A==
Message-ID: <sashiko-outbox-209021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: serial: Add the line transceiver
 enable GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111-serial-transceiver-supply-v1-2-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-2-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:53:38 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A UART's line transceiver (RS-232, RS-485, an isolated or a
> multiprotocol part) is a dumb device with no node of its own, yet on
> many boards it is the largest consumer behind the port and can be
> switched off, through a shutdown input of the part or a switch in its
> supply. Device trees have no way to say so, and the transceiver stays
> powered for as long as the system is up, whether or not the port is
> open.
>=20
> Add transceiver-enable-gpios, the GPIO that turns the transceiver on,
> as a property of the UART node alongside the transceiver pins that
> rs485.yaml already describes, and transceiver-startup-delay-us for the
> time the part needs to become operational: a transceiver that
> generates its own supplies behind a shutdown input can take a
> millisecond until they are up. The GPIO belongs to one port; on a
> multi-port controller it is a property of the port's child node. A
> serial device with a driver of its own, such as a Bluetooth module,
> remains a child node of the UART.
>=20
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-serial-tra=
nsceiver-supply-v1-0-40bad0f912f2@vaisala.com?part=3D2

