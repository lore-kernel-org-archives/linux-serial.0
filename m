Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8703DB31A;
	Mon, 19 Oct 2026 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403144; cv=none; b=YVV6zsylYbpC+3j7BOsChVs5jXkGDttwpfrwlUWKOXW10jhx61UXfKG6zDXG9kV+q0z1lMEw1I/uskjdIB18GP4fDXtMiPIQkg71fqMOiUvX+o9vEBTmrfXw2866Anb/MletMZcz5yJ70oEWgvpaM4YToE039CTk3cQijFCVyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403144; c=relaxed/simple;
	bh=rLs+E92BZ2HK+L8+pWvfjjLh/yX1ynRY5TGoEGdJ3Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCk6S0poCUg2BDFzEHGCGtomC0PnoU34r7ynbrGJb4gl2owQP3rvt4938KwaS+90e3ldhLEKc+jMuGPgfxBuabSFAE/64NCrjFvxtZUz50fOGskPqeTyem+Yn/gr/9BVDzdk6W7v0gtgVKdNyCPYyMTyOGm1lQfF+qn9o2zaOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXzDXaC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXzDXaC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0461F000C4;
	Mon, 19 Oct 2026 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403142;
	bh=/JplmjhIjd3VhaXGa0kbTCPiPnPU64Mu+Urlcbp2lmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fXzDXaC8MLvjws1UhdHOLd9MpZPZfvPuFMwvo3Du8hyssAdRFH4fXcdPY6LLws6v6
	 bC0lhOLO0t00cB9o7w6DsUfNg2MHERYEMOyPeCX8ZSREO6peI2ICcUW7Iac277Ol1Z
	 r8LrzZaxWrrDUquZQwcDBbQ1+JbrwDllV8yQSCVGgQUjLjJaCzc3fAPFHXduQdN6RI
	 8mLtC50KT3tsPxYmJHl0AdLCf14kpjfHHlh93uzj8hB52Cu45wQdh/ZS0mZc+8VlUH
	 0RFJEZXhiE1zWafj6nmFPOc8T/e4fbTfo7AlruD/BUCoR6oHUgZoVqd2wAniO/Bbe7
	 IbsvU3urNalbg==
Date: Mon, 19 Oct 2026 11:45:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Grisdale <bengris32@protonmail.ch>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT8163
Message-ID: <20261019-amazing-cerulean-avocet-e5bcae@quoll>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:40:01AM +0100, Ben Grisdale wrote:
> Add a compatible string for the Top Reset Generation Unit (TOPRGU) and
> watchdog timer on the MediaTek MT8163 SoC, along with a header defining
> the reset IDs it provides.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> ---
>  .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  1 +
>  include/dt-bindings/reset/mediatek,mt8163-wdt.h    | 23 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

