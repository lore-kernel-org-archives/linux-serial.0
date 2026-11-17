Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907140;
	b=v5yBS/xGwR+RHuXZ+KR4knb7cCqnSW5zwWrplp0IasZiXLG6z1pTwAhIs4p8stV3crQt
	 ybO6psUyW0kKLr1/IpzWySHTcmfNAC5Yc6YEtFO6pv3YWjrxEJVRUx6TU2/VxhWfpeDpT
	 9KEIwrfT2Q6WetdzaFADKeq5E6jtQyEk4YK0OeW8BvKY3DeoMPvJCWrCeUhG4qgZLMPfL
	 MTeGHNgGaWj+uFmE0MqpQ+NNPf61ny5AMaP5uJa+FyWDdT0UOVGLULow7f7r67GG2QyPO
	 d1pgSb9ACbB0BTLXoU13BeeuhkWkurAQI8m7xwtkMA5mqOvz6+4kc4aOa/zzNdm9H2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907140;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zwBJrxYrGD8J631VhTz/eYLlctz4VP5StsaNyaNeOco=;
	b=0UyrtkRLqs4B3Sx85KaBoX9Tkz6xy+petbGbjaPBHJYHGgEZ7MI4RL+hWGFGMb5qNEfF
	 AVzXMwJHdVtZ0+oc2nJZP7Rbb/pt8MQrITdeWSRa56GkJ833sD++O0jsgTqHQyj+faC/w
	 u6gCjiS0mx64Ys3LE0FhT3He/aptiQLfNyrpTEflorCWnQMYBMsgUwC8CUThY57UM96pT
	 vOxf096pNPSYf9psPdteVd75cQqv62JD5BGnCAjqRytQX41DRatbNAw9pd//PenbxUG8C
	 OW/NAGJQlPXYHJZgoj6NeCZGbAQKWQaHxPyzIgcX2dMJwhUMtlvRnhciPkV/rKdZHuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eST09LxR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B920606A32C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eST09LxR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5666D1F000C4;
	Tue, 17 Nov 2026 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794907140;
	bh=zwBJrxYrGD8J631VhTz/eYLlctz4VP5StsaNyaNeOco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eST09LxRNOfB2gaxXj3nz6THiJDDShIPAovFNyeKBJTIA81tcCm9nUwPVJg/16uDn
	 y5w02XYtDhhKvHkAG5GegSocG8ctCHxSrmz7RBz+U2t7y9EPNuqB5XDzx6JGIpG+JH
	 rJ3tYRsWEV5gZUQmHzYS24mEAh8Wi3hsFGugK+1TaBJnNxsSWFL3CsB38pTn48mYMF
	 BDxmF4uwpumLtzNkSiTA9d9gR2mM78a3ZZAOhCEQVUDNtJOlfm2yuffF8uzHl3G5Pa
	 vj42DV+mKMChPRym8WWl5jPiaMVz0/L547mJnKa3TbFRYLxX8gywZGs62lR/EvIOXu
	 hSyzzZCFiiYGQ==
Message-ID: <sashiko-outbox-218470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: mediatek: Add MT6833 and the Xiaomi
 Redmi Note 13 5G
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Cao" <i@udp0.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-mt6833-base-v2-5-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-5-058a0685c40c@udp0.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:18:58 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Rui Cao <i@udp0.com>
>=20
> Add a device tree for MediaTek's MT6833 (Dimensity 700): its eight
> cores, six Cortex-A55 and two Cortex-A76 in one DynamIQ cluster, with
> their caches and PMUs, PSCI, the architected timer, the GICv3, the
> watchdog and the first UART.
>=20
> Add the Xiaomi Redmi Note 13 5G (gold) on it, with the framebuffer the
> bootloader leaves the panel scanning out and a ramoops region. The
> memory size and the regions reserved for the firmware the bootloader
> starts depend on the RAM variant, so they are left to the bootloader:
> the memory node has no size, and reserved-memory holds only the regions
> the kernel uses itself.
>=20
> The cache sizes are the ones the cores report in CCSIDR_EL1. The
> bootloader programs CNTFRQ_EL0 (13 MHz), so the timer has no
> clock-frequency.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-mt6833-bas=
e-v2-0-058a0685c40c@udp0.com?part=3D5

