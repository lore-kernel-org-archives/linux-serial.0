Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC32253B0;
	Wed, 23 Jul 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258167; cv=none; b=qIz77PHXoK97/Yas+S4JtPslkXdViQBuDg8NXpcfCvUCmS0EP4SYD8KLiBges7XVb+HnQTTWubwkztP9RzZ/HmYzIfVd0g4nx3GFLs15xzcjDIxFmUofh0XcQETHHIByq632uxSHXWmrH/1WAsxQHkm+rJw7Vgl6010EKG7B4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258167; c=relaxed/simple;
	bh=Ps8lFEsqvSDPfqjyEHkRolWkzi8nZTybWl72cOLzPno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca3/jg6IuP7naP2V9KtURCbNwOkBYo52qa41nI0KoIY7yv81jeRpgpE06r2cdx7Q2EXw2bv3n1RCW+kSdGfoROGMpRxMsmVSBOeWwMVEmxrcgbgaZeBoXxHaumIx/5rQ4rBoD8DLbp7X5iGMdcAHgdbA/KNmIyBA8ZqoclgKC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uix81rvM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uix81rvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1794C4CEE7;
	Wed, 23 Jul 2025 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753258166;
	bh=Ps8lFEsqvSDPfqjyEHkRolWkzi8nZTybWl72cOLzPno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uix81rvMcekf6fNVD3Zug9kTiegXw5q8COm+Q2Hcyy4UeQhVdjCrP/hOaIgOClCAS
	 JhhJHqXEixVcXREM2p5F6zdM2gRTfk0LXN1r8Sw1s+mMjfDBrkLMYELPASET63nY70
	 lWYoTpPCOD8mT5GzvtBhYKDeixTqPMi+cefGUi70p32DPGXdSlxSI8JWc4/29Un0c/
	 C5TEWXY2Y729ClPk39JbJ+olD4TNKCCfOJ8epIaiik6Gazm8RpBXmvZAZwpjzxFjJI
	 EDqZ9qpxrZ19TIYHkpB0PqZs52ocKCQkLtNkTNDS3zcLhorm02SHKnyd0MqMpmHRYK
	 SeE8p1HNJntZw==
Date: Wed, 23 Jul 2025 10:09:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: serial: samsung: add
 samsung,exynos2200-uart compatible
Message-ID: <20250723-adventurous-chameleon-of-intensity-8d97bd@kuoka>
References: <20250722120859.443283-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722120859.443283-1-ivo.ivanov.ivanov1@gmail.com>

On Tue, Jul 22, 2025 at 03:08:59PM +0300, Ivaylo Ivanov wrote:
> Add dedicated samsung,exynos2200-uart compatible to the dt-schema for
> representing uart of the exynos2200.
> 
> Like GS101, it has a required DT property samsung,uart-fifosize and
> exhibits the 32 bit register access limit, so reuse support for it.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

