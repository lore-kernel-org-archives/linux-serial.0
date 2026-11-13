Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598689;
	b=kTeHoEmREfBKzwTpLTfML5Zk9/s3/wDxRSiJYx1i5c05rZMIzLCQ65jowQ/fWiS2Ckc9
	 v02HtRQ+ep5DXSpdvC39ac4XRz0wq58Ht3I23n25188FKr4A2QZxp38j6hCzq9/nBO7ol
	 L4AJ4XH77Waer4TGiGcci7Y4KIk+gUR1uv5ktHYazPU/4GA2fOJA4ECQKwcI3dOTs+lQi
	 r8imycOoNoVtARfrYiN5O42ApNdy3K3g2De+RsmHZIZPwJDmR2RvQDcxMwontLcjQdcN1
	 Eiwh1Gng7yt4HaI4tjsWoXkyCANZC0dHZYOIEULrXdQx+5deo4CS1JFmsceOjDySSSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/4qx2vQsBQj5KA6DxY+lVZZt3cG3heuqlPh2x1WamoU=;
	b=zmmC/WsVhWKxxAQMkCrMNC7BdUi4EtOZ571PPqeblgL7m1QLVSdX1mZTuSV2C8wlR6hi
	 1iHz25RfKODSiU7BFd1PAAotpjEvkH14a6e+T+NTHpipQN/0DUgTcmivV3rmcX1sF90z7
	 ADccUf4gUj/34nuwhLmRaAESBJLmtKiVvn+fke/B1gFlNX5qQwgXCqvuNHD563wFR7O9H
	 UZDXsrfKcEbgbtdocZV2GN2vJq+eO2iULIZwKxsm+gbgkUXJ7+KtiO3gs0CNc8VjzMgtt
	 1HNzQYtO5t6HjLxMEsk7IVK2ebdYkCWRBsBkq/7O30qDc5x4e7hRrCMSMXqr5ni/gjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RP7UyM7f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF7606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RP7UyM7f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF461F000C5;
	Fri, 13 Nov 2026 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598689;
	bh=/4qx2vQsBQj5KA6DxY+lVZZt3cG3heuqlPh2x1WamoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RP7UyM7fGRZbSAuTHQnNGj1bhNXUi+PDTzTZCWsjb1RbeYua1RxDxpKCGHi6dQ1me
	 t29FW0vfFKF2OU94PDQe4tX87a4YH5amOuYhQiI2sTkKp1F4X0v6VmlhHuag0XT3hO
	 IIgfmvMoYeqMbLVQTQN6XfQ+9tFd6ZKYWYCP6nsa9nhpdXs9QW1GyJgo0UxLU40aNi
	 VI3I9DQIsqrIt/QzovJ+adLlEQKDyh1rm2wbvSLRWFSCLpffKS4g76bZKsoXCXWwzm
	 2FlQJlITaReyO7YTjOJNHWmaWeCKvkBeenFiZUQU+/0QZ/OfrQlu06u3rbHLRFZCdf
	 TRHrb7Zq4An4Q==
Message-ID: <sashiko-outbox-213557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] serial: sh-sci: Do not kick TX from
 sci_er_interrupt() on RSCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-g2ul_sci-v4-4-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-4-6815e41d90c5@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:38:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> On RSCI, the receive error interrupt (ERI) has its own dedicated
> interrupt line and status flags cleared via the write-only CFCLR
> register, with no hardware interaction with transmission.
>=20
> Calling sci_tx_interrupt() from sci_er_interrupt() on RSCI is
> unnecessary and causes rsci_transmit_chars() to run in invalid TX
> states:
> - If an RX error occurs while TX is idle (CCR0.TE =3D=3D 0 and CSR.TDRE =
=3D=3D 1)
>   and xmit_fifo is empty, rsci_transmit_chars() sets CCR0.TEIE while
>   CSR.TEND is 1, triggering a spurious TEI interrupt.
> - If an RX error occurs while the hardware TX FIFO is draining
>   (CSR.TDRE =3D=3D 0) after xmit_fifo was flushed, rsci_transmit_chars()
>   clears CCR0.TIE without setting CCR0.TEIE, leaving CCR0.TE set after
>   the hardware FIFO drains and stalling subsequent transmissions.
>=20
> Skip calling sci_tx_interrupt() in sci_er_interrupt() for RSCI ports.
>=20
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-g2ul_sci-v=
4-0-6815e41d90c5@renesas.com?part=3D4

