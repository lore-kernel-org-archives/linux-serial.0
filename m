Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743442;
	b=vzmAiM7jExSwNOmPHdTrdiV6MUWQkehrSsdxEdWU6uFuSrx3rzj0U8GDkR/6r53xC7Ez
	 2uqnADEuF5F2MSMOJ3FWwFJHxNf8BlyqjYEEIynKZEQ59qVlkyC1hwwo1EE9r0QvzrUz5
	 hNGkw0ageXDy9cvEUkOmqOBg2njkhWCNzxupTjE9WFNR9c9Xi9RiJDL4s7lm4vTKBX+QC
	 J04FrglFcpNSXBuJCjLmed63XS4wNUDqcE/ZYREjAOoFVNlknqu9Fla/iHPRaVsY1qt/w
	 tgTatdrzxw02EQ505JFaqHlCt/dT98dNEIxvDf8Fe1UHKJM/MQr1SocboP/PBV3FVAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VruGlndLzp0Z93ZOHVVaJ+lNdqznHLQGyJmmRHRoqeU=;
	b=c2Qa7C39rTt/QO6VuDFl+O75EwLZMe16PkE+imxW1+M8R5BTfs2Fyrv0HetTrWjmnX2h
	 B6ZqGAkq2fMvdZxG/gUen/bfChaTz6c4DaW5YtlyOyKIVoYkrZm2mY5WT0bxme9zPxoen
	 dPvBdYW8b0KaAQ4AN68/JckNO5wwDD4zICuVjjkpT99rL0jWs9lAGKSvyFttrtKdpkqqW
	 jIiW8jd0YabFE87INaNTWRA95ycaUBE7pdgWxBR0sHD5E9WSPxCtQF5j8Vg7cHlTeKTbf
	 ja1Cgj9vjmhCLoOAsZzv861cIeKZgHP3JEGe0/bk9MMSdGWFxtCvir/4vKvmTZfT6zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8tqbOd2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6109606A31B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8tqbOd2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3171F000C1;
	Tue,  3 Nov 2026 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743441;
	bh=VruGlndLzp0Z93ZOHVVaJ+lNdqznHLQGyJmmRHRoqeU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N8tqbOd2L0++QaZawki95kZzxr1Mh6RmOs3JNZy6YMiIW6QQs2axxaYvUhm8pTSpM
	 g+SJkwyEYtmjbXCxjMVvfK5Ike7voplzf1sq+KAOlkKVxySQYapq3hkt5vqCyqgJwX
	 v1+5Krm05/AmDe/Mn1zmzygZvMQ7E3DhUnXo7WPjkYwhKLubQspa7u6h1HTTZVkq6W
	 OMejoUwOT9nIBimx1B1Fx0PgvEEsl9VKELCmlQiu8XWx+RlsB4G+iHHAw8qihrsYgY
	 4cm0KlsmDg2PhbLF6Uw9u977Kh1Wfj8sAanfSSBGXQ5UbIzFnP/e/fMN3PVcpoor0A
	 7yfUy8KEtm9RQ==
Message-ID: <sashiko-outbox-196092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tty: replace chan->device->dev with
 dmaengine_get_provider_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlRUWSBMQVlFUiBBTkQgU0VS?=
 =?utf-8?b?SUFMIERSSVZFUlM=?= <linux-serial@vger.kernel.org>
In-Reply-To: <20261103215949.1827937-1-Frank.Li@oss.nxp.com>
References: <20261103215949.1827937-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:04:00 +0000
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
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
>=20
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103215949.1827=
937-1-Frank.Li@oss.nxp.com?part=3D1

