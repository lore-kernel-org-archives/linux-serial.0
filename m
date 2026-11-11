Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402025;
	b=Fhb7x/w9kgwTJWVdhoukISvw/cjXx26DyfVJB4bjOJiNuojoUakviS8Km+zcEh3ifBUh
	 a9UMy9n5/+aHKame06ojyRYHXqvkjadIvVdZGhVaUms2VZlxqPmd6r8VP/eQXJgquXZ2y
	 CYYL7VrAaeycNPKoInFeYpHCEuyRYypJOg7LXx65gGqXI2aBPOQ5cU4cQyQWzO6X70jcR
	 kJkpbJ3ZTUI8S9yapIDDrd4ccykoLhyMLDm3F98q3PVPZFN2RcEpPxEC5pZyincee7wW0
	 dG3qrYqKRz8HjXsHkqZqhKrRnbM/6MwjzyIZ6n9LkxDlCz0h8J3792FARnPBrYaR9sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402025;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7mgWr1pZb7yNWIt4OPiuVc2e09ECAvShm7sgjMRNlNQ=;
	b=zmCL+63575eNnobjDyioixK9fh2WlqRu3fTGnCjhvolymOJ89QOICcvgxwEggFxupQrf
	 DtJwdgBDByWgSHdwmZ2qFrIxj+Xenxs3lD22NfQGFFrqzFBAHCmQqlNAKtBcqoDh+xIoJ
	 j4PQuv0yc/lgUpf9B2c2V8pkSsPrRoSCZ6B0lI32cb2Y/BApjr26rWAGQVos12S2XT9/X
	 DB4M8i34EgWohUBESFdl1rPcXbOfuCHGM2kq2DPRHL7jZnJHzbDEISb0ZoEL/o5XahLrn
	 qyoQxAq0nDsO49z4EUcwmFnPkGNoeg0PFQLKl1+X2aMHMDeQFKxQauAhEbCybRUtMWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fo3Hj1SD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC690606A327;
	Wed, 11 Nov 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fo3Hj1SD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9DF1F00A05;
	Wed, 11 Nov 2026 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402025;
	bh=7mgWr1pZb7yNWIt4OPiuVc2e09ECAvShm7sgjMRNlNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fo3Hj1SDwn8RxIMwTVvbptNy74Dg9lfDShmeUDHRK0LWAKBI2JcdNsKcsfM2LBoqm
	 VJh1Z3JR89/h1hzLWgtwWb1n53WOD9pFD2QenXg9lh+xAmwDA/Sj1SCV25W9gXLJdo
	 H9iaIsuEwP1pzEpJKwggSUat4m9tiiXDGad6u6M6viXklRc2PllfoGwk53NnX5F8YW
	 FNIV9xSdC7eamI8fVGkuG2Puw4mfgk6ZiVLWeDNTaZughW+kM882xvCVeRiE2sDS2P
	 upODuQhTU5gmaoxSUFXNYRN0OEsREreowqmDcfsTmFwf3B/akJA4qw2rU5fMnE0oqF
	 XUAzPuZboR7OQ==
Date: Wed, 11 Nov 2026 14:00:21 +0100
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
Subject: Re: [PATCH 1/4] dt-bindings: arm: mediatek: Add MT6833 and the
 Xiaomi Redmi Note 13 5G
Message-ID: <20261111-manipulative-fulmar-of-lightning-34bee8@quoll>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
 <20261107-mt6833-base-v1-1-bda21083e9f3@udp0.com>
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
In-Reply-To: <20261107-mt6833-base-v1-1-bda21083e9f3@udp0.com>

On Sat, Nov 07, 2026 at 08:21:58PM +0800, Rui Cao wrote:
> Add MediaTek's MT6833 (Dimensity 700) and the Xiaomi Redmi Note 13 5G,
> codenamed gold, which is built on it.
> 
> Signed-off-by: Rui Cao <i@udp0.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

