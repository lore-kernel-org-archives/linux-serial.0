Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689496;
	b=jRFkYX/P7Esa+0s5SkEY/4+WNymwSfp2J/TE+RG05RiWvgSvatt/LubsPRTMM7L8vtmY
	 m5YqvD42w4OYhm5+67tWdtaioaJt1xZmZ8xAD/z9tisu9nNIvWR2zcWjQqoBtUrQC3RyF
	 FuJgvu5B0mrFWBMv/oLqrxnBl/dCppfH8WQU6VrixeGq5unqr5J//8mW2GX65jCMVTnKV
	 G7/IDYuZNQmljgoyx4PXMCZyD3Ws/gjfgo/+69JDJbYo4cbdongAqKJ3ZaXq20tbhdf/j
	 H3vy4+B4INqFw/Z3lK/UXkgLjIn8T+97r98l3jowY1Painh8wAq+GHG5qgoMYOHgcmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/X4XejafuQIpUOwNFg22E5HeWcGy38qZ4HqGferYaFY=;
	b=0wwI1pyoPkzYkg9hTJGdesnIysByrKnE/gVSMjbt2sYYJHrhLrcxAbqjeLJbyBHGkI3c
	 Y+BXs+CmGHqysO+fVsli9Yum59Z9VCO18Tt4uINlpccDv5zMLhtQjjcBjxThKrdHVNtup
	 69ZlPxLwWpYBbHPwAvL17n3F9H44OEhe7LX5TH6S494AxTIKsPKVGR3bA6LGxnYlrv+DA
	 SUDQYQug2Z6dln01fYjPFvSYC4SsJKsPQWkOR24HcYTGTvn/Uyi9QGuvrBJFYV+DWVdrK
	 47oD1XZSs8hNI4NuqM8d6e13FJCtAw6lhM6Ih+8MhaDSyKN7U10suHBZXc5G9U4dT5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw4UREuj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C72606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw4UREuj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DFB1F01825;
	Thu, 22 Oct 2026 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689495;
	bh=/X4XejafuQIpUOwNFg22E5HeWcGy38qZ4HqGferYaFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hw4UREujOxM3iu1TeLc/mqJCZRbCciaGNEOcwB0SmXe8L6pvvyYpT6vZULoU5ZgP8
	 hlrPrp7aGMeDXL3Y5JF4H1I1cqh3GQ5UtEzfsX474isB9COLVO+vi1vpykdS9X9NAm
	 sjYXABH+UwGYH8hafxbwqwxKmomeXCrqLGg+/2hZQGK7uvW0JvoLaNqGAD+8DWx8/0
	 xq3PZZKJgSV1vDM1v16VCp8fg7aKIn0k9/zD8HYyyg8VA6Bf++pfc+j/PLa4Is6ueF
	 DgfsmGwDZb02HtSBI7qOC2kt8Hmu7cizaELg0hOM/RXr1Dx8SPzjSsCHgEgkWvR/JS
	 6cJlVmPe48gbw==
Message-ID: <sashiko-outbox-181854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: calculate TX length before preparing DMA
 flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-serial-8250-dma-tx-length-v1-v1-1-18cecc89a099@gmail.com>
References: <20261022-submit-serial-8250-dma-tx-length-v1-v1-1-18cecc89a099@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:18:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The Renesas RZ/N1 preparation hook programs the UART DMA block size from
> dma->tx_size. The generic TX path calls that hook before calculating the
> length of the new transfer, so it programs zero on the first transfer and
> the previous length on subsequent transfers.
>=20
> Calculate the scatterlist length before calling the preparation hook so
> the UART flow controller and DMA descriptor use the same transfer size.
>=20
> Fixes: aa63d786cea2 ("serial: 8250: dw: Add support for DMA flow controll=
ing devices")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-ser=
ial-8250-dma-tx-length-v1-v1-1-18cecc89a099@gmail.com?part=3D1

