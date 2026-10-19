Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBF4B1B42;
	Mon, 19 Oct 2026 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403115; cv=none; b=neNrFvwNKIMv5KdXouTJe2K+bcR5QiYDoGJffCK0G98iHogXFSwrbShe5PL/0PU8xsLlnGgoNgN1pfhpH4DzRHxt/FWUa/5fav4dk4XPrme7RVTLQ1rIlBWXM0uuCOqR3X+8T1obyYoTLzuFbVFSdEyFYhx69OxYoLJLmu2Q/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403115; c=relaxed/simple;
	bh=6jHC/xNbrIN2cVrVFabptwZfKzhPz3K0h8Wm3FnX+J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qICSMeIsio7/Od7Z8PpkFzP9W7fKXV3qEQ744CZD0kWafNCu0o/2ZNtrzBsUu0/HWim2pLE5ItMypevfaX5U2/fzcJWmLKxFWg3eJD5HWojwlmcaidEDy/MEyq1jXCN3kTrB1pCfmhpik/miWcEe+Z1blQs7RvzhcZuxqe21lFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi8Az5UE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi8Az5UE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B961F000C6;
	Mon, 19 Oct 2026 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403114;
	bh=TfIgP2F0UjnpfeyonWfYgy6p2kSRUt7R+KarqRZ8Z3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pi8Az5UEDU724xgXcqeSPm5CHi2yKWAtm5vrkXCTezJYRKgoR704E3Ew66vkxS440
	 nEuRREEKz/FsjFE/mnZZP6Tf0OVl/VrJlO4M9aLm7fHC5Z23wUw5MqkKpvadmwet4R
	 FYqIyW0vdQX32ego0GtSqJXzC6ZtKjsKILh8hP2PhaAIM2tjUiqzdUbSyH34zKTVGw
	 UANh1+cg6c5692prADQGy0b1JckFIJbGwK+MRA2iNW/OnY3QHK1MhkuEacGKC9KCrM
	 VC6gsvPfmZV5WFLVMVr2U5OFN/ORiuAGkAuR9xuKkTBFSOzPHvm8tSd9DDSGKJwAhf
	 qU+K/vDP2C30A==
Date: Mon, 19 Oct 2026 11:45:11 +0200
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
Subject: Re: [PATCH 4/8] dt-bindings: serial: mediatek,uart: Add MT8163
Message-ID: <20261019-friendly-notorious-giraffe-dae2e9@quoll>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-4-f2462b2d2437@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-4-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:40:00AM +0100, Ben Grisdale wrote:
> Add a compatible string for the UART controllers on the MediaTek MT8163
> SoC, which are compatible with the MT6577 UART.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> ---
>  Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

