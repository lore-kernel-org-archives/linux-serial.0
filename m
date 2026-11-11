Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402040;
	b=X6M6QL69bcEdWhavoapa3Sx/tMwoMXMKMCxnsCPCXHE2FEIzLAHWZmhswD2KbZ1RMPDB
	 KWIu5RaZIjcpy2IhB4Vxm/nPRnLSVaDv/r4re+ui9ozgXXMTOa6p262qmtJdEJnQFPkTU
	 PGKM5MVa5Oef2/iusttmAPEQCj72QRlJZlwsLR5DYa1ZeV8Cw6JUVmkb9FppxjRnNJov1
	 0FKBAJVWe0QPwOqVI2aEK3m4H2bSO7zZ/rKdl0ngFkHOS/DXYp0fSbNPdJEIi99Id3aiZ
	 DVrDCCTaQjgLhnYBMJENl+OlKRK7WSKDamnoGcqPhByPN29R9PYGh4xgiWvnlId+M2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402040;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uH/TcuxN1DkH/KAf2C/W26e1z2CE8UYhXOwejDcIfK8=;
	b=bBSoi08jRLTvhfMbaQh5RTX8W4izoz/Il4JxGVtZj7MbyuEDbgklAwtTKz5KZT7OSq1b
	 v9gcgQTqRHAImbaf6HSDoidVGtu1GyY9Q9ocZYk8ccXEhgkEnUQFJLFqA3eoqnxl1R0SH
	 qhO6ajZf38bFM05P08K/4HEDnUlDd6eHQWzpsVURStfFwNaGrLCaTqzOR0GXwTzcnObJI
	 w9zDYxQDj0tFRUBXtzGObb+d/rcfFlaGepKKsHTsHwPZ7Sf8Q+rJ1aKFUixFkkm55kkDF
	 QIVxS5iIojhsnUnKah1uO382gaCKmr09bDvXWYKPuzBATf6AV5GZHKwILPc9uBagtiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJVyBSlw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A374606A31C;
	Wed, 11 Nov 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJVyBSlw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9461F00A05;
	Wed, 11 Nov 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402040;
	bh=uH/TcuxN1DkH/KAf2C/W26e1z2CE8UYhXOwejDcIfK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cJVyBSlwdlOQ1r4Ldh5sNFFOjSmbNxhb9JpdmVse/biFBpvMMCR4al9NvyfbwxW7g
	 rlXPb8LhixKHvYy9dERoE+Z74pgJPNz+XHPtwzwBsjZYo4OmSwOJv0+FnA7ILpD0gd
	 MjMPwjdbEzaE0ah/+u+5HIApWv/kFeuCS7/GM3s0kt/WxpXv8Uld5JjlrHRaLHHXPv
	 eufmxx/1foqgMPMzDDVbTUCZr0n2sDIsqvS1uJjQnfy3Zipnu+iG7uTymSzDuH7frg
	 /Iol41yGDLbkwB4DlJ5SW/fpVJawMxUV54FyAyV1ato4rIa40yuz4Mk/W0jkei7W0/
	 3CFZEzOo0D71A==
Date: Wed, 11 Nov 2026 14:00:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rui Cao <i@udp0.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
Message-ID: <20261111-dexterous-fennec-of-leadership-c69fa0@quoll>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>
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
In-Reply-To: <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>

On Sat, Nov 07, 2026 at 08:21:59PM +0800, Rui Cao wrote:
> Add MediaTek's MT6833 (Dimensity 700). Its watchdog works as MT6589's,
> which it falls back to.
> 
> Signed-off-by: Rui Cao <i@udp0.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

