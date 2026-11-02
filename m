Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650715;
	b=sCEnDP0iIl9dSyFQiSHkZ0nfbSLkVKTEYvw/q5XWbdUSaBlU92S71lCaB8jBUdyBlAsM
	 jHTRrfEfv6iovu61JQghIJK45UPEuPQhk596F36VdS5CJasq8Xud+Ip0QmL2k6Wl/yjRG
	 44tOgSIyZVhI1N2jqcSOsFYcQPY6LrIM2cz+3RiPvClW0KFPiHXZTB/WuS1k5yiPdOE/S
	 adjWV/AFDBHkAKjwaoXoPNFED/GVJ0ON01rudMyxgc41SDSLkMutaLjoD9Rwwx0KtmU5I
	 xfWdwzSAraA2Gsi2e4ZdJOyByQ7z84GHKHQShaONmkMSQ3zymfUSUt/k+5dDgnj0chA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lq9v0nIZ4OtRMdsZF7J7xsRfa6HNn4swFcJg5qGOKC4=;
	b=2kqV0SxQZmvQHdEYPC3RAHfTUetLEg2wTklm4/1BInCbU8m298NyNcE0tQkr4C/eTXaN
	 xGsUmY0p4U7MvBdei7/E3IjrleJ7yeADGEf5wxgwySVL3Cvvl83bStuwF1uJWofcTiMwq
	 axm8e+IEZAcff5YZiKxy2rXpZTW7dBTMQDb0st9tbZN9g3t3jLdnDneEnjbQLn5Lq5Z6T
	 uVbFXSegFVqbCQCg5QIVpxSGmw9vkfPsWT+7P6aYMjqRq7zS+yADbQm3GDFrySngYL5UY
	 suF1N9e/eK1Z58fHIM3kEoUzcrMSrPAMP2EtLw5t0lTLhdqAglU9dsyOA+l+0eiQ62g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcLIhlyS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C81606A32F
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcLIhlyS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68581F00A17;
	Mon,  2 Nov 2026 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650714;
	bh=Lq9v0nIZ4OtRMdsZF7J7xsRfa6HNn4swFcJg5qGOKC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcLIhlySv1cARfLgKN8wbOIl2CZKxK9+uRiqrKq48UkWAqzaj3Dj5Fg3h1awdpI4M
	 VfGnv+S0pKueWzO6YzvOAS3KV1YwVFnZ08smW/6eMm92s9X99om10v2RWjIZ94CZ+X
	 8cF8AspJq4+Vg1ncV+RWGa/QL3eJu4uUfdyqPrCWiFTrs7ceoXHsNpVWORYMzQjkY2
	 vnbeUYaaD8UvWXH5datgsnv4yS23imTvLL4FIVCAvbVfLXrWuwTvjGkNelGbFxM+hl
	 D2etXDiLwFTesy0+yeXb8WDZ3Cf4vRsmo0M3QEU79GaTmm5Gb+4tfiRA5veqywC2Jm
	 N3Xw9QMaBIy+g==
Message-ID: <sashiko-outbox-194089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] serial: 8250_dw: configure the Allwinner H616
 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-4-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-4-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:18:34 +0000
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
> Keep PORT_16550A and supply H616's fixed FIFO depth through platform data.
> The 8250 core derives the transmit load from that depth.
>=20
> Allwinner encodes receive thresholds relative to the FIFO depth: one byte,
> quarter-full, half-full and depth minus two. Construct the RX trigger
> threshold array on the fly so other FIFO sizes can reuse the same mapping.
> For H616 the thresholds are 1, 64, 128 and 254 bytes, with the normal
> half-full FCR setting selecting 128 bytes. Use this array for both RX
> trigger callbacks and the shared bytes-to-FCR conversion.
>=20
> Serialize trigger changes with termios through the port mutex. Hold a
> [ ... ]
> Keep the UART clock enabled during termios changes with SKIP_SET_RATE.
> Its clock is a gate on the shared APB2 source rather than an independent
> baud-rate generator.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D4

