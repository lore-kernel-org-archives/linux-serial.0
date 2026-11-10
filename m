Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280997;
	b=HpRel1GdzudimaMUFehdk2IwFBXG8yyenjK0nid748aoPRCWwQbALh63KECFO+Y9HvwT
	 glAg6qaYnBF/MASFyIGXMIqXOql+EDTmd8ixORh43JYpbYBgy8PaRfH5yTGwCkGMYj0Ex
	 n2Q7xYVn8FHBQIpl2zKCLBauUWws21OytSisryakdPZPAEl8l0LdyF6ZQH0tv+fDL12Hx
	 HaViFJs79D3lILlwrtAxI4P85m4NePwYKOS+SWbNwxXs/aHHOnT7GNqzfqSDXFVWIsuzD
	 1DqsY9iFSjq+uDkbAREnRJg3j0XQDtaDsobmjexdoGN4np0Y4n87/WKIGGygOVkwGpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l+02+gdZ/9hxnFPsOE+fV7x/4jM8DdNTeZ9035NoM6I=;
	b=dsI6JbnvogG1BT/w3dODnGggcShn/RM4nt8Udd/vRua9qZ79Kx2gc52y5ywU5js8iEYd
	 HGSqRiTW5XubxLI+Fv/6dL1KYgY5oeQv2AhfxTN33EgHkaWRzxbfqFlbcesInhdWX1Rmy
	 Vr62Vu4Ph/SiT7WYVjihua3FmHr9cjxq4qg49cb6qqA6zTZdK13PA0kS1BZV6MmusgI3B
	 4JMrF7JYDDQ+C/1ZzFa9EpfNZ6236YwDshalROmR8VdRwdk6lMFIohRFFEKC1ACcLa+kz
	 7x8KlRkXwSt1CLabQknFveCUZMs2YcD7uzmBVwGgyvKhQF9hyk62V4zrsTJ5LclFDQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjn5dNVE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5B60A380E
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjn5dNVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92621F008A3;
	Tue, 10 Nov 2026 03:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280996;
	bh=l+02+gdZ/9hxnFPsOE+fV7x/4jM8DdNTeZ9035NoM6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjn5dNVEE+wPTK9lyVOaiUuMLgyFX8wk+Mb9ULavkrEpDi0+nUNk1MVDq/coMEFnS
	 X1vSTOaeKowdsICxoqd5OAJ8xwtsSoJc+gQPU2ZkncITIKSqlO7q+iCj/5DrHJyWOY
	 hc7f+7YCaumknfST0YTP4usnlwY3XWCmIBp+RzRlhTkGG9m7F4JPT7vyDosvGtxmH2
	 lZjq2+QmsooQ5S4XmvJw5HwkEEaJQrmkgCAlg7kSWuQsIq3Vlo/u2OV500XDvaQ3g8
	 cIKG/NUDZOtCendNzh1P27kp/R3tTU5XPHvkAKW7WbvqDCrE6sHWe/TRHwjVvcjakl
	 SpgYcoczvvTpg==
Message-ID: <sashiko-outbox-206113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/11] serial: 8250_dw: configure RX trigger
 thresholds for Octeon
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-11-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-11-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:23:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Octeon uses the DesignWare receive-trigger mapping with a 64-byte FIFO,
> giving thresholds of 1, 16, 32 and 62 bytes. Its setup bypasses
> dw8250_setup_port(), so it does not install the common trigger callbacks.
> PORT_OCTEON also has no static trigger table, so rx_trig_bytes is not
> exposed.
>=20
> Supply the fixed depth from platform data when firmware has not provided
> one and initialize the common trigger table before port registration.
> This makes rx_trig_bytes available while preserving the Octeon port type
> and register accessors.
>=20
> Select DMA before filling in the default depth, as before when the 8250
> core supplied that default during registration. Thus the new trigger
> setup preserves which ports attach DMA and their existing burst sizes.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D11

