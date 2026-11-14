Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663798;
	b=cOsJsx3fYSfcDEhOPWQEkGfPN34WqITkpEM+zqNLlb4ChiuCFsIstW+aZQ6AvSsBydan
	 IbO8ON7DVQjroKLJHIm0X3MYGGD2Nb33BHBBsHRlmGLAYS2LDDRZwUE7MUC80JhgpuxvU
	 uXmjDTKmNXKU/KjDeuuMErHu1S2ZGaCma6dIYtM6dEJ76NX88lPYm8vWiM1L5F/pux+Dn
	 n6FXg92G9U0PR0yEY47lWlkYeujF2amt+1uq7c0KVVMur4Pmw5KH6Wz/cf3I/VAERU+63
	 12kmYuAWkG6Pwo4nEo7ZE17yC7ahApImYMSmF5dWXw9KSV4j+8/WjqWBF9tPNQVZMgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IUBx/e/eT1uT96LejZhsxbGn2FQSoagRQDKEsZ9VXB0=;
	b=GF5E8CCsZz9MBWPF3UPR6ZL/2LsSz4IPbz/wh0zK/GJgMgvF1a379WevAKPPQHG+4+sp
	 +i4gwvXV8Fzmjy+BzGEvpcGUDeBiyVkSZJvRw42ol1vA6VXZc3TIB20LlU9kZLDU1MeTX
	 SUMOysM+e9JAMq2UacSRHfg2wxe/4cIzDk3TmhafGCJyC5YnTUehFSUDcw4jDY09W8ewN
	 TcEwrbq+BmE5xppVoJwy4Qn/mL0RrJFQvK7iS+75QVmsOYFYJKdkEUKIJB2KO1LEwvblv
	 Ah9U6vMO9zxtWJP22ebrcA9/91tsK/M/TDtqoX90guga7HZYFRHOV/+lsVoMWIs0qDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfzYoQJG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C800606A323
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfzYoQJG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103D71F000C4;
	Sat, 14 Nov 2026 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663798;
	bh=IUBx/e/eT1uT96LejZhsxbGn2FQSoagRQDKEsZ9VXB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfzYoQJG+GjIp35azfKjjvAxTZZ3zRzGM45OBy7C/kK9u6mjckXlQvHMd6junMKWx
	 h6a1TbQvC9P5zy0rzy6HA7Pp/3lteqlXiDJifiEPouHwVcL7v4o/eoBBFzv4Ltv4gR
	 y8j1tMXNxcrw/8fcEew5b6ZHIFfNJ064JQFYUWLYIzpioVrGHOuXreg4K/r3TEl/JN
	 pl9zJf8ZB/OrGnHPv57UvBc2MOai90Hz4WGOzgBVD/DtM6tVOYQ5SxWBFwtK0kkNJU
	 XYQK29zIV+/VgDdy19gVQVR/4G+t/VWCU2UTqcJ27LI4V/lNjb9pSAnOFHIkSddCEq
	 aA7MZOH6Jfrtw==
Message-ID: <sashiko-outbox-214584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] dt-bindings: vendor-prefixes: Add Securifi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-1-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-1-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:43:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
> Add a vendor prefix for it.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D1

