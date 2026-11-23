Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436742;
	b=cEEqtTTAmajlVjp0YC0oz2zN6pFuScGGMYJoyzkJbYV+H7trfxTSVH/xrBVqBjjoQknM
	 Io/uOJPEtCZJMl0nM71fn3xn99hgkKRUIz0SO3Pxa6Q3CTl3xuGDy4ZNDvm232HlPPGoM
	 O6lbCU+5RpmQE1AREAicpKUm1toi8mLeh46B4GblrTFcKwlC3bvDkAWviroLgcfxNIjnj
	 Dz8xePXJ+J0/3sQL9NW32hAZ6L1DbdhJZLgET48Pozs82kDhxDdFlEe8/sFnacJADgdSR
	 YW02qGxrqJKFeiXzETCqZobg0sISm1/p00ywb7X6UxEIxlkioPtDR3oG6FVTQZZFJ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436742;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bqbUZFybYwrKL6TCArPSsR3vEqPnEk4U4p4dC8FCLAE=;
	b=YRsbGhQb8u/2FJLZvC9z55yAaFUIRmNEPIJZoJfQYJ8jdWtQr6ynkCYCyflFSgbU7po2
	 /tXsUSFS6ZlMxwRSj6kAut1hQxReQI4gJcZ8JjVAwtuDlpeoYXyDi/Kc5ArMzhiGTPyTO
	 HlQZs9VqqDsKAgellj3vzmzzQpRUN7s8tcgpibr3OP6jGzuS7jjOZjOqsKBX2MA5KxV7c
	 XmiZ8X/uCBMlEro9AMak77qWTr6yC+eKMHwG9H7XUJBiSzlkQNlBsvHoxCOWe57TCYVLY
	 6kq+Wx8r1bykmOr8bgwYsA2qqIG18YdEfDE2bwIxgIzJWlE1yrSZ+MmYDM8qproVIwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyV2PCBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425D606A31A;
	Mon, 23 Nov 2026 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyV2PCBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABDE1F000CA;
	Mon, 23 Nov 2026 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436741;
	bh=bqbUZFybYwrKL6TCArPSsR3vEqPnEk4U4p4dC8FCLAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OyV2PCBJJ+im5vPd3xyuANOjncvF8C1bCv0h2kafDuHWsWqdc/RrtvsCYCVBNf2sZ
	 hE8C8j9By19o58nXKo0bTBiZ0GAz2TZNmv4aqVbpHjweT2AK85Zg+d16vRzfO7CZ+C
	 AFvtpIPT225W1kPUPuknuXCiO7sFli/BTDxuca7TfKmKf4j1uu/jfFxKI9ZqMuaiHJ
	 B3o+6+rPu/2M3n7j88L69i0B6a4B1eI9A4yY0smhPoAWmze7f8VgV6psvWfExo31w3
	 Qd3CKUTnqX52ta8UzCFXREkp+AvTCMznaLYdScQ7nhxgDQX6UDLZax39fa9ZdfkO5t
	 4on4/LFaOVg5g==
Date: Mon, 23 Nov 2026 13:25:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rui Cao <i@udp0.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, 
	phone-devel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 MT6833
Message-ID: <20261123-puffin-of-splendid-fertility-fb7ba0@quoll>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>

On Tue, Nov 17, 2026 at 05:11:32PM +0800, Rui Cao wrote:
> Add MediaTek's MT6833 (Dimensity 700) as a compatible of its own.
> 
> It can't fall back to mediatek,mt6589-wdt, which also describes
> MT6589's twelve TOPRGU reset lines: MediaTek's kernel for MT6833 resets
> the connectivity CPU through bit 12 of WDT_SWSYSRST, past them, and has
> no full reset table for the SoC to take one from.
> 
> Signed-off-by: Rui Cao <i@udp0.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

