Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597013;
	b=YD0z+oEVvIwv8Euh5Lmt966C4i9PFsTF65S3NU2fxexKv7W/6D1iR3BEEstxjJwrvSgk
	 /tFAtJWidekIUgJzXD6/kd/XVWEGSyiiWKi2gJLRnpk8mcHJkBuRUmTGtAgfWfaR5XwNA
	 vfTvXj4XqwwmJunUj+vwhV2TaQLfErj9hSFgt7B1KhkUx3gG4Fd55kIsOX8gV0mUAeKac
	 O5MJzdU5Cv35RxJSSnquIubXga03UwwUxpmJUND/qceXBLM3t3hUYGWv20sphTjYNpUJT
	 UVK4sdKRCCHlErGfXRg9241tuiLgB4Ad3IiobEcbE5ujbtBvCZRwy2/d2sknDltg6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597013;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5SJIDg3mCydIlUEYcEOn5pg7lXUeLObkQS3jzrmNN64=;
	b=RHipQhC3GJL7KR/51HUekI1EQ5fjqOytH+DRyCMQnBj6tv6Oju+7MX0dZt+LIRwboXrG
	 PM1XAAoRZIDrcX+VwnVi0BkdR2rd22H+HE7+lO3RmjQcy3tBm9H64T3rMJCupU1hGD7Jp
	 P9hA6xTNBzMhteR/FBFEB3BaYSQLnKdMSqBk3yZ0zSKbKhBMR7nWFROAssG/1BrdKytyK
	 MiF8J5Gpc/DV1h18jLzmgudjmTszHHEduVLC8YtfyWZ77CZSSbUC0eXpSnsxW9nWQCRzO
	 sb6p85Nxh8biTKVWMk8g3x3t79aAkParXfgDvtsVMFatPOVlQnRK4cbPyFLLKPyasTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZVKaPYp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F8606F319
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZVKaPYp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CB61F000CA;
	Fri, 13 Nov 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597012;
	bh=5SJIDg3mCydIlUEYcEOn5pg7lXUeLObkQS3jzrmNN64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZVKaPYp+OLmU+QwbRaKkioAmeF+GhcFKa29Ljxlxguoeaz1Sy7u4sQSIPvlWF6dG
	 S5Ulvbl+bA6FYiO7PGTgjT3C8ZN3st3Jd+u6bZvrbA6vxUI/fhd2yrQWlv8asO4Jzs
	 mF7EFCXI49NDtynMXkrhMfdfKmqy6hR2SLMytbe9aJNYWKmsicC2AiKeQlQ71k/pYX
	 ukyJCo+ZfbKHTyPPwEXpAmX2Tv4Ok8rH/2cuAiVHuK7z4N5Dc1sx7U2bMyVjuwImTk
	 BiKUIJWRu02tiGG6Xx1ieeooRFJ0Ga4Lw16cjleKFCU8Ifway0O6d8iRh0oztZ8Dfp
	 DplwAH9X65eqA==
Message-ID: <sashiko-outbox-213515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] dt-bindings: input: mediatek,mt6779-keypad: Add
 compatible for MT6895
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:10:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its registers are the same as on MT6779, so it works
> with the existing driver through the mediatek,mt6779-keypad fallback.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D6

