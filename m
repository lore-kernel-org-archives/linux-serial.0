Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733635;
	b=YD6QYIKJlXpqENwznCLyxmy1mb/xb/LyPQG/hJBg3S7Lh6C3AhuWrDjL9K8wNtj4v259
	 ERW8XEIAlYzHd+yF2fX/zAJo1asn5bVsyFA0YwhT1HAypjhOixltd0/AzgFYucxQQXKkK
	 59FdU2xkCFAAnPmGzadXbDek63BRAqyAsdC/GgnS6W/UmmpAmk0xH+Sk197tH2g3F+df7
	 5tEHvP9szGDSOVMZJBwPUQEP35Br0BRCOSgB1o6VPN8uxVHmgWahSF5+hUHCPOR8umV0N
	 ZogCPuBC2uzvkQXS3DuJ7yJthoJyrACQWDBUT7/nDjDkDegl8UDIp5Lno7tXbgph8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733635;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UmLZHiTBpiEA74CO149SnAiNvAkyZQTAtyQASMhKktw=;
	b=GT723cabUP2UURGM9mU5mMnNTL/gjjVgEOwCX0CNOGGKjHFB7XKShvnha1W7yvaUWDT/
	 biTWUX1soontQhG5jusEmoBjgJJF0wrNaSuswHY0D0WMNn4O+YhYDpPrlB/P4RZfHsk/c
	 1cC5YteZVMikMQ5EaQnyG2S0YPpAp2rj8ZggLmmucFNBSTI6zn124TWvmx2ScmlnL/zE7
	 a6nuSMnU7jycXVAU6P/XWWlLhIRvgpNoLzOa6LK0Xmu0/ITpAmILJroOfHMAzjL55mTe/
	 r/3MCtWTVRjYS8XOrxQld1RXH/Mk9V5DtyL70eFTqn6HKwfDkXci7FyfbGbFvH0GPzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bu3VHxFm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A86606A319
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bu3VHxFm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A021F01825;
	Fri, 23 Oct 2026 05:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733634;
	bh=UmLZHiTBpiEA74CO149SnAiNvAkyZQTAtyQASMhKktw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bu3VHxFmfuGQWxfxxFLBNfXm6WO92/i9VLjP2wIDZrb4Te5lSWxUQ+jHfLDggch/+
	 +zYJ3ao7hocJHnwHry1LNLqvv55NKj9rJOvNEeuhNqigh7SsEtjbGLMOVD41MGOvtF
	 P00xuR/j6j00h1Qg10hOnBKhQXV8+OmAbDcHxm2FdBEOlSe5yL9P8UVYJvvuRKPvnt
	 d9w3Ry0Y9Wa8gfcvGGoXUe17u1jogH3VaADmLP8vN88/RxNB5O6cP8oIqE8y0feRFw
	 4j6vX1ZDVSnK0YtGougND1pJCIdGCAjeNMM8hzmG3e6SOcgrpzdEMOxJtV8xRM5R4e
	 bgy4YRSSaCeRQ==
Message-ID: <sashiko-outbox-182317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] serdev: handle devices without an ACPI or device
 tree node
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261023052717.2577234-2-an.wu@canonical.com>
References: <20261023052717.2577234-1-an.wu@canonical.com>
 <20261023052717.2577234-2-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:33:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Serdev clients instantiated by a driver have no ACPI companion and no
> device tree node. Their modalias read returns -ENODEV, their add uevent
> is suppressed, and they cannot be driver-matched, so creators force a
> bind with device_driver_attach().
>=20
> Resolve both TODOs in the serdev core by modelling matching on the SPI
> bus: add a creator-set modalias to struct serdev_device and an id_table
> to struct serdev_device_driver. ACPI and OF are still tried first;
> clients without their own modalias keep returning -ENODEV. The device
> name, derived from the controller, is unchanged.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023052717.2577=
234-1-an.wu@canonical.com?part=3D1

