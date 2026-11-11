Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430057;
	b=CiecN98zU405yho5KOeNPRtU4wkkoAFDa4Aiw57vNZSeHtY27lzlzuVbNYWgpW6rc3ZS
	 4RfxQKXlsNFRYa+/+1p6IXV+J0QIIKmzsWAFBZdFwIFp7pU5m4f59+L2FyASJNthPMFff
	 Al2jrhQR+hN7axJhTRfUzZfWJDRCQ6bnob+a2K+vXe4k2+UedSSYo5gL2hkY3d+/jtoVO
	 tRf5zmFlQ82FNiUS50x14b5q6vbvrUHPMSxNrc+gAuA4sLP5eGqHJTTALJm+Cw5Jq05S3
	 url8563e4sTmCn4614j2AVb/tcenkhT5SOZ1t7CTS33yq53EUnyTHAZNCVUGC+4Vffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430057;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H/xNYzRKiaDD92nvuhumfzCG9fwEc4NMmRk2u2mvEEE=;
	b=YcSHR9vpdHrKFCOtP/4HqJ0psRh6vExoyUPxxe2cqHmcO8sl7VfQqQeGp2R5xDVzqgjY
	 GDLqhkiHwZ1ve6yVLYNYyBO20I2z+5CQd4ozfJs+0sFkqgSnn13kLnflkYIncnv++brGw
	 xph+2OxSZE9iI9s090U5znh8im3XVr8DD29QtY5UjGZ+Wt5Q9mJW4wMOy/sjrRoEML9mG
	 TX+VbFf0t1N+envbsneap1alFUr5Mqsa6Su6a/b08JnnhBCLasppzf/zjFLY3R4M0uvSh
	 +YQk8zLZqHAa5J1sF3wysr1UP/NekTrlv7OWeXut5ZsXz6UTy5/AJL8RSBzWFa/EyEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcHHewM9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97957606A33A
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcHHewM9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CF31F00A09;
	Wed, 11 Nov 2026 20:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430057;
	bh=H/xNYzRKiaDD92nvuhumfzCG9fwEc4NMmRk2u2mvEEE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VcHHewM9VTwTyF6B0M0u39lyxCD9vo1Lz2HBX+AfikIQTSpOf+Bwa3DodIMAZTPjh
	 M05aG8JGiWTYtvN4OWugEw0g5uJL2P5UAy71r8dr303l5p5kniexhd76yuJRrsufEa
	 zeytcTvEP9ZuuG3BdxgQMwOzLYaiF2bvgWXB9LUlk9PFRQe9uz+o2zdBbt24eebgoP
	 aU7KUKlRgmqw3oHo6sUevxFvAvMW0kvvD4fx2OihdVx1fxBB9Yxrx9TZAA1TWLbXNU
	 evObjyBYWev+O3nptSTkpJV6m+2tNTSC4F2YAP2tb3tdNjuR69BeTI+vWHPimmmFbO
	 2LORQoYpfQUZg==
Message-ID: <sashiko-outbox-209678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tty: serial: amba-pl011: use dmaengine accessor API
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlRUWSBMQVlFUiBBTkQgU0VS?=
 =?utf-8?b?SUFMIERSSVZFUlM=?= <linux-serial@vger.kernel.org>
In-Reply-To: <20261111201835.3846654-1-Frank.Li@oss.nxp.com>
References: <20261111201835.3846654-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:47:36 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Use dmaengine_get_dma_device() and dmaengine_get_copy_align() accessors
> instead of directly accessing chan->device struct members. This follows
> the dmaengine API convention of using accessor helpers to decouple
> drivers from internal dmaengine structures.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111201835.3846=
654-1-Frank.Li@oss.nxp.com?part=3D1

