Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9548FF7D;
	Mon, 19 Oct 2026 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403095; cv=none; b=d4THmpbCrYJkmKNiInltfBxF/XdRt5B+nEksL1yfErtXrqufp7kM+QB+0sc3OTowyDWWzLeE0bJ9m4KVF9n7ErGScqPn6jsa6Vxqarp3qd4GBJAIxWH9PH9W/zkHCLyqRGX4kQB11IjHU5GnJaZxZ3BeyJ661JMfCW8Lm6IKwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403095; c=relaxed/simple;
	bh=YO6SI3mlZQHViU+ijICZvDsD67ekbKJofOSbC0bPG64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPzh8FItYY6One5xRC3MXI036wQcP8QmrAIWpxnlA2oIJf9zbkjymFH4ydaqupEyW1FNY1o2KHV4U147qXe+wBG8hdC1cK9V1gI9j8Iv4crG9HTgv7nn7gJwjtcHcqHdaGXJvffrA9lNJkzncGq8TXApuJgo6o/NxD4W9b/Oqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRpM1kfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRpM1kfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2391F000C5;
	Mon, 19 Oct 2026 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403084;
	bh=BjU+lCsa+wJqtJMmjDTe0djVhuOigs70r9AaD8jwKDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cRpM1kfSi8spSuvrgbOTT314LgvTPK2oYceZymHEUnVJWF46DFi4emKSErNeqd3Ya
	 ed3vGNV635eDH2wf2KIdcyZwn+33XG4lelXs6dFIV2RjbxHm3FT9L9uL1bnWJrcsii
	 9lErdwvpHGbIP7GjWdKs8YQ/0sLBr42p5VAwxSRTX7/rL2IRgTWbjdIJFPVAmUaL3P
	 9bN4YRxKdtvGdxApJ5RvnGmcHOIpx0SSCF42wEBI29QSDg5IFNOJJi7c2M9zh8sEaF
	 NORYr2VtLkvYDsRCPzH5kErdaQW2HxFt9HBei7fZlG8Y7id5tpxvAPBi7mP1HQSpEx
	 wcrBG7WA5zWtA==
Date: Mon, 19 Oct 2026 11:44:41 +0200
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
Subject: Re: [PATCH 2/8] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: Add MT8163
Message-ID: <20261019-wakeful-wrasse-of-purring-72a0c9@quoll>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-2-f2462b2d2437@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-2-f2462b2d2437@protonmail.ch>

On Mon, Oct 19, 2026 at 01:39:58AM +0100, Ben Grisdale wrote:
> Add a compatible string for the SYSIRQ interrupt polarity controller on
> the MediaTek MT8163 SoC, which is compatible with the MT6577 SYSIRQ.
> 
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
> ---
>  .../devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

