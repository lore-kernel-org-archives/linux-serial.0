Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889077;
	b=u1673NmAGtMUIp8noybMSrWWDUHO4lMI29IHklT7YwxfjawSja6Mbjw/Qo1wd/AKEPd/
	 qMfhboBqCFIkWXlC1bmWXJcJFfATOqI0QxYWA6yAQYoGoHehL6DP9f/IYySNWEsb3rONA
	 sBCD16XMafJ3GNxgmxC/dfNeCJ3OZ8YWcQm9Rv7Isk+WlR3UkwKhTmxR1/+jRlResVHxu
	 bB8/0LFkNsF/yWx5zYxphV6s3I/ctak7qSn7oeLWYNs/GaGIqIqwmKn2OXN6eGtBE56HI
	 hAQf/GbF5AMOFiopS2he5mY2xwgDVqBdef7ziDgQGPUmUfB4Nc4F0eDRzYRtW3gQFvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889077;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XAiZlrxYJTBeFWO1NATnaqqWktA3O6B4Dhs7RAjdO4Y=;
	b=iqeflXoQc7uNsxPfG1Nr/H4BCbRux6bz2VXDykLWem95ZDUWlkNhfqOWn6TjWnEvZN4Z
	 UH2lRyMg2ytJZCVEpr3Jsq9uvbmkXWAvtAwYiHIuaiF1xmShN4hxsyxdhiJVJHcCOCnU6
	 ZU2jdWhwXd9Ev6EWmi4HAvWp5dKbknAj+r0xh+autiNZOJ3a0EDW19ESlifoZNVWk8B0d
	 4FZ229cQjbbFt9/iW788AI9ojyBgQ3RU9hsLRnjQIxDBfzy1Huom0eNifyoCeyJW805de
	 /BuN4VsqytI4w26/walU1msYFr0stjsHmi2Lb4PCndHNDb3q3tc1lWL8eKU6WYSN8mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwAxNOwg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EA606A326
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwAxNOwg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D951F000C1;
	Thu,  5 Nov 2026 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889076;
	bh=XAiZlrxYJTBeFWO1NATnaqqWktA3O6B4Dhs7RAjdO4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WwAxNOwg4xMpDYp55TaxQ4mGnHSie6j7LCW0T1fbuqUpGGZxpyPRR2uYLZio+T/nD
	 J+zyztvy55rWD/5T5EM0CbNSNhl/C6siVN63nkwNaY3+MeMP+yeTxajjP5UreRAXse
	 bW5n8rK1dxKkIoLuWA0zyapNj+AmGXUdJ997a0aDZ3QAy1/MTxy0RQTZo056jBmiPj
	 dpntvqfat1UJRPllPeU0S4XXNKTa9TSu/Fd9ZvhNltElTdsNegZ+bMKukycZKvc0as
	 mtcOKjdi7Rm4QwUDJV3H005foRmLo05yXETzc8pkAUKSBF+ukamqPxNmhTe+t/V+JA
	 SA6XhyJN2r8jQ==
Message-ID: <sashiko-outbox-199246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: serial: mediatek,uart: Add MT8163
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-4-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
 <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-4-e68d7d428f99@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:31:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add a compatible string for the UART controllers on the MediaTek MT8163
> SoC, which are compatible with the MT6577 UART.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-arm64-init=
ial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch?part=3D4

