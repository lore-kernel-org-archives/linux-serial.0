Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912969;
	b=4UVDevKGlwzL8eME17fztIZdxDd5WXnKuRK4RtLLkB6hyYw0PGpQboHc16+FaqP9gG/J
	 bQ+lUPlmDkpGbUXCsrenpmbuzgwTUymHKjV6e5bu4I4sTCSm0MKfWh0qBTsB1Ahut/M3i
	 m32FvRion9H76Ei8cUOEQ5pUWFlYY5e3cRSUoRh03LLud+VF6W6xqCX5tF2u4i0C8qF5L
	 B+c6m0MFh+0yR+O62E181QDaErw0zYKBZojkfNno7z1N9YFIexn/qW0KrAA2vHxl8U6p/
	 r3K25VDp7baVDVY0WUJqgNM5/KbOaQ2MEtwDfCzvrsiE31XscYQZGYUhA+yQuZT/rtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0WK48Dr5U3v+7zU08RJSl1PgWmAhZr37y7V0yMCXIeY=;
	b=dnWQMeXJNiFaryYSuPOoGsNjjEvxkeZ3S9tYsuoQnOr73fZyOuiqTzSs0YKNrEyPtFq2
	 uESHiVChvIlNAY45QAnQqbD22vwmIBek/3pYv35wjvqnlFcRDVfXg34DFAguKJlBNjWxn
	 QhndWLAfSx8VjGdbzAd+JJGUCpiCx4NywgXmCeXAKDj3V/2lkwjb6SRECcaFP11S0g4Ib
	 ti1g/WUY1SQ+qEL+6usldMvf/YgIOyPSxCb5HFXsJDwx8PdX2k3pwSB7T2XyzstrsJ3fj
	 YOyfrO/TrfHPOdO1gZy++AJjOPPXz8vl522Vogo5oOZjDXYSoY3lyPpgZT9qlMwZrqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGv4pCgo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C487606A329
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGv4pCgo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFE41F0089F;
	Thu,  5 Nov 2026 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912968;
	bh=0WK48Dr5U3v+7zU08RJSl1PgWmAhZr37y7V0yMCXIeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGv4pCgoPRW/sYdnIeil5Qa5ohQX1mJe2keHu1LOCTcKo1dwS8dtEbXLPFND5yDuD
	 VKPNXU+zQDdObCaptbvjKVBYfsnpBVZVFF3PHCOUEo2masiib+dELugFnl2NgTdFkn
	 GIPGL3rgH/abuZLF4kqJ6a9ULQ+TSMWAQqAVfAuTkHwt0HKhwNoR4ilTIjOTbYYuuM
	 H7CImrEt/KbMvJbGn4XRvjVxusHCtgvZduf6qfxQ7PfVRKbxNKUs6EH+I0h6Vcd6kR
	 ryr+oD3+tWRPyIAnSh8GzlBgbGZP4NIUmr5BWPRd/8SqLVY9xmqSz9uypC4d2S4zC4
	 mbemxvyHZxRHA==
Message-ID: <sashiko-outbox-200197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: serial: mediatek,uart: Add compatible
 for MT6895
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105210622.523747-3-asalde.le1@gmail.com>
References: <20261105210622.523747-1-asalde.le1@gmail.com>
 <20261105210622.523747-3-asalde.le1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:09:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
> 8100) SoC. It works with the existing driver through the
> mediatek,mt6577-uart fallback.
>=20
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105210622.5237=
47-1-asalde.le1@gmail.com?part=3D2

