Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873797;
	b=1FVMskQJ3wUmxMmoeX/RrrHoNF9XMg8Vhr7tWcT6uTsVtvKqunaYYWoMzV/UBN/mOQEu
	 xJw8mQOfmaq7ox86oaz1j2jtjdDi0I9H/pTd6Ihw4eoEjda2DCt6/hFsts86nBuGCQivt
	 IUMzfPYenkvv4s2fBsW9TK80p/DTweBf/9FUAJQsrQxBW7eksO8g9C1pGeXZJV2LEwzJT
	 ozZ2qjTl6r7TEtLeI+MpXCosY1DuO7D9bzyXSgattE5ZpXt2vilpekCXwT4vwfzMaieSa
	 CyWxVoCzE3uTXZC5NBI8ZGCQ+J+qDsq3Im6r1yNiwTxpaP4tr4vd8ns2jvuKiQOOgjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873797;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UJ8WFKj46xtooLg76DwxfnD5GTf8u9fR3oimponCEUw=;
	b=0riDE1Bvo73DKIo2IPeHXJapmIfzMsXoPmxtEs3eFdi/kzen6xbi69JiHCzM1v8TnHQP
	 EeMLu7tkyXnGvRjBeeE/wm45oO/k74M2EpOVkiQQh9SLMU+XBRgHZGdvTBga87NzkLyzL
	 6AEAV6PrZzmTXSOrhe/ZgJJI8wMkcmcUv8N2eAgr/ST0UE6SKKaYTlSghyfuAryvQ3fBN
	 MxrBkuite0E0UqGtO0gwx/1DpfO35E7Y+BJNrzrZxFznqPCP2qTljuxtggifeiXHMaLlk
	 PKOnHsx5l5nPivt0ntJ5oVMZwMWCThTvv43yAgZcpwLwtt8mpoTxUXTWCDzCld1NdwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fs2YxjE0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB8606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fs2YxjE0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7701F01825;
	Sat, 24 Oct 2026 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792873797;
	bh=UJ8WFKj46xtooLg76DwxfnD5GTf8u9fR3oimponCEUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fs2YxjE0OX084uFFOJvmluQMgcG0dqTecY5OYttUlglePvhlAlSlc8wBfFZooWPNc
	 Y9wDni8YX+cRFbZ4qJmOkcfy9Dk+V5oCcPBSTEaTJ8gqHSnIWr2LJdEYfF28GBlSw8
	 C/CjaHJuXT+9i7hmtgQWgzwd1XK7XyGCOnJetLkCPQhswctPBj9ig3wlzRAbK8oeUm
	 dNWXzPXDiSWiUm+UmUQJS+1T8wl3TqD46TaxY6sQSlXS1ap+7+kyX/lbOmAMpcd5Go
	 72Okl7M/oOBV7WxvP98b+XxjxyTzWmaUBAiZK33pk7o0/b4r51KtUlGLNs7ZbhpDBi
	 qpxGhB4DTOZJw==
Message-ID: <sashiko-outbox-183872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: allwinner: h616: describe the UART
 integration and FIFO size
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-4-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-4-286fc1b8c3c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 20:29:56 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the H616 UART integration and describe its 256-byte transmit and
> receive FIFOs on each of the six controllers. The specific compatible
> selects the register layout and receive-trigger mapping, while fifo-size
> provides the capacity that the component parameter register cannot report.
>=20
> Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
> and uses the same UART integration.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-h61=
6-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com?part=3D4

