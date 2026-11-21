Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274116;
	b=cujs54Kz3c1psIx+FBgXrAlk5tskDlnFAookLTEYfambhef8wT1fCUFyZasX/mLKN6SZ
	 Rox7vyNw1118Dgd694itlj2hckVUj3EJWX2cjnymrtohiRYn8AI8BxkJCPvoOXF8sR1fL
	 ur5yFTYDZXNJlefBmQJ3pbGfp70RRGfTnjbOsg0GbNW1rYCdoRlLtjCmXpZybp5wTFFrd
	 VkCsMzMT0TUDmUWxAZHoKii/UxymjSRxbPiXBeO3SlPHTgZf7HY2fMyD9utxyaUhtqs7E
	 KDocLEL9fUrrMypADQSGqwqygCw3csaShVFNUAxRatVW2zkRjEsy/hjSOMGyD981OBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oLB+Is0UI1uAjoDbOFdo12WWZgiE7xh/bLiE1erupBw=;
	b=UouFcVgP8q5mf/nsmRqWROrT8FIWoNfDwd9lEtOPRqilNGZY8uwpIT7IO13lC1zWQhJM
	 9PjFo2sBPmKM/YiXiU1mlbA0TVUmp/4GOx4/VvY1uZEl1mbAegShOWs1FrnNqx6dssIm1
	 iZMUJlw/maNK8cavykM7uXD8eQ2rlAEMoM/PqHabf8oRkcllYXGZAgbmzjlZ8luyfOzfy
	 FXMxFcsU4tnU/JyB/h/vidkzcnzaDuDUcv6OwoRSN5JPAiMnEKkcYhI10MXFnl48WWlI2
	 Fyh0a8YenRptt3eQtCNbJwUYW/oy4mSKb2EGVm1UMTrOqsGKqOTtbRITXvccN3EWisA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtL7aQXX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722D606A331
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtL7aQXX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331071F000C0;
	Sat, 21 Nov 2026 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274116;
	bh=oLB+Is0UI1uAjoDbOFdo12WWZgiE7xh/bLiE1erupBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OtL7aQXXjsHSo6nOyUOSrlgAbBDipijQ+be2CA/7CCsaKgk4oXFvPTNkWCajbYW9w
	 7WlguSt0fx2goZtKbrmBxT6z2fnHEXyvmQX2Ki7PG4b+j3i0dXw4SrKwUEEW81kwX9
	 NGNiXCSJ9pZQs96hWyUMOCFukdFak9/dIyWuSY3HcBRFunYHbwQuyozWmmOF5VZ7PY
	 bysw+NVpaLrgM6HCbM3qpJ0V6KzQifVdWxHtquC8N+q/aj38EwgXUqkfJAWaKfoZgP
	 9rp5MqgR0+CDBh03vWtT9lzZrPcgRqVSuD9xzJhdC4TeivduaAd3DCYISauGjQlN4D
	 6/ij6Ova2bBjQ==
Message-ID: <sashiko-outbox-227117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: pl011: Reference rs485.yaml
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-pl011-rs485-v1-1-0d18008f4a12@gmail.com>
References: <20261121-pl011-rs485-v1-1-0d18008f4a12@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 15:15:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
>=20
> The amba-pl011 driver supports RS-485 and parses the generic RS-485
> properties with uart_get_rs485_mode(), but the binding does not allow
> them. Reference rs485.yaml.
>=20
> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
>=20
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-pl011-rs48=
5-v1-1-0d18008f4a12@gmail.com?part=3D1
