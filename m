Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083172;
	b=KztpSt2ehvHSp2riU1QaHmUbAcCv8RSt+O0Q8dK7bCCD880wAZ02SlcUGVecGqTD59PD
	 BBVavlgW8dqGgY6skuoLT53RChkUXsdHCJQl2bWa6Q6872OzJJ75iqRUcKlxXTDmTIVoT
	 e81Ej+QQraNSJnRx7lRSpmOw0s56h/2XQ+fRS0j9OtM8lJ40rjK8qYp49LpE0+mxjUk+8
	 7vTp5BKWCeS5K9nBvQ7Ho4SEqs4qY/z9t4VAAOzm0I9I7bE8rgiH6/fkj7nKJRIT/6qVO
	 h1empHQbB/x1yhTSRvDD5M+W4Iiwys64HG6iqnPUfqNgFNotosMTuEmRRG/bNSJHNEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083172;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3IWZ0ZetQEr2scMsmTJkZj0o13vHUuM09gDTSFEPdtA=;
	b=UTK+T0XPVZLTexXSo9Cv/IU/QiOrTeGflqz44vuspOVmJ0QOl9iVC5EbhtkmktGlDd8G
	 nYLwAaZuZ7S1qFQdqfxq0K97/aWn7d5kDnRWEJmtOnh6+33i1XBITn72Rs+jPexRi83Wj
	 MuRoWJBURg6c94phDeyMrKge9fXvQEbGR/NTlDPmZ/86ZE1CWWLW6J9DkUn+w+gBI1JjA
	 ZqGPmT8q0Zu7N5GBVLdiWZaE1rhRvTLA5CqyvnLMcW1aZ4vQuLH4bZGl3Gzc2L3FxKgcs
	 OebIALNjeTC//7vNfJNsIw10TP7VO4PNpIMLw8kCF90L0lMEne4qp1n+pg2pgWN7gIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g8G/fNbS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946ED606A320
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8G/fNbS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A0B1F000C4;
	Thu, 19 Nov 2026 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083172;
	bh=3IWZ0ZetQEr2scMsmTJkZj0o13vHUuM09gDTSFEPdtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8G/fNbSFbDRFiSDHlSShjnSw2PrLKAHu2tAKCd9YT7v0M5TfS13tBJy2RdugOETh
	 LcGNOy4bxwPV6TnVrKKJn+yLZqPH0shojtofj5CGReSmYpQdgEEUm1FeXWv/APsirr
	 K4D0rGrJcjAtmR9hhImBsuey5T8/HhV3/4as3Ne4rmyH9pgoriEcV57lHx9PQBYdBA
	 m9LxbU4BLaFm11OwsEOLj2wZbAi6i8X/qmnyf0z8dxXyJfDvRI9sC9UDRnXOGmuqPy
	 e5JKLTm6SCsC4XL3cTVMSjPZdmXIS2m4LwMwORasJPPD/dKvrNoof4ZYFCPlompckC
	 bSC48F2rP+z8A==
Message-ID: <sashiko-outbox-222924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/7] dmaengine: dw: Fix XFER bit set, but channel
 not idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-1-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-1-3a737597a0d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:12:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
>=20
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
>=20
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
>=20
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> [ ... ]
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-submit-dw-=
dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com?part=3D1

