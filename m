Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE42737F9
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331828; cv=none; b=U4b6KH3hm14qSER7/Vl5Ouy/AtNAinfxt7KXVhPlnBpFUTnJoZn1OdSE9fPXyEVLnfNA84UIZ6ZyHMjA+QvBeMM0mLXzgZAVogR0+isNBLSYnj2FUf+YWdpZmuCmLIBW4JHYldIymXhkqAk6MZCGUXa/XofKUdtmkXiiYbM4Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331828; c=relaxed/simple;
	bh=okVt5l+fu3ZSBrYAa70ATWKnBF8n/qhM3G2QVqr4vGM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oSwhF2L//lc7cJ6mErg5YrGArxTFHyseArC1W6IYXRAmNmX1Dmri2IjAwzsdgs2XrXzkVKLkWWwLQvESbLZFiZu7VkO5bAF2ZPXjAJNfZCTAQ3tfl4iW+nzj7m2OyeYLedgP5RiCcmqP3dY2b15yCGemkKu+41aNXTVjud08L1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/5Ar6Nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/5Ar6Nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAAA1F000C4;
	Sun, 18 Oct 2026 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331827;
	bh=okVt5l+fu3ZSBrYAa70ATWKnBF8n/qhM3G2QVqr4vGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/5Ar6NmrUw/tRxNBrvAgPUVvveZXmZV63FaqT9nocHRDKfyWGT8semQvFeDYtwyD
	 Ri2G8sFE44H9PEKciGVUqRxl/nL6T1EKov/9NAoqFJjdqhGTpHyqSUM3SjjMiy1ECi
	 uAQK0nbx6o0k+VqEQixDO9SbjpGNIuyOji4twIa31c0Rgp4h7kxV21oRxNT9v2EsKX
	 dNJbZ7hpsaQtu8XrSc7TheopbyM+xVlYfFZfAOK802Z96qUf+UV4SM+7SnXb8fS2qj
	 Y4yvGtqz8lMv7DsjmmRjXUzCJ28vGf7BEpK/z7V2xknRNeHqvefireyckdIzmWskhK
	 I6nGlwB5FvxQw==
Message-ID: <sashiko-outbox-176169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] sparc64: add M3000 Oberon PCIe support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-10-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-10-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:57:06 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Recognize Oberon from its firmware compatible property without a platform
> Kconfig option, preserving firmware link setup. Flush DVMA translations
> and changed noncoherent IOTSB cache lines, and route legacy interrupts
> using the bridge's ten-bit target ID.
>=20
> Cache the bridge type and share target encoding. Leave MSI queues
> uninitialized so the existing architecture path uses legacy interrupts
> even with CONFIG_PCI_MSI=3Dy; native bridge error handling is not provide=
d.
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D9

