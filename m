Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794059936;
	b=y+fy+vF8dvUxNO0ULDezQHRo9m8OfW0XIAZeXX4Fsi9m/OkMkRR7D50iwuoD3YGep4Ah
	 baocrpxFs7CNokEquGf/NYuAU/rm/KJG3pyhKZ8ENvK3BUoX/GjUqw80sJwIPsfBr+fEl
	 K11JQtIJWDWB/8wBBwEuX3vlijNUMt9fAuU2nDRq4bSn/vspPmvdSLkG3Y2wj5ZuCvkmo
	 1qfwceRjI362r85eiYQyS6AL151CSTL2rXSjvypdLyMxrm09oFPHDxD/vGqUOCD312y74
	 usLorSSRIPDMXSCzHgb9pyTVTI0xAqDhCW9v6x3j550hv2akacCbf8jvfZPsiKC8TMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059936;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ggxRUmnt8EfrK5EcxblzoupqkjNgWhTE5turDSMEfKI=;
	b=E+DqnP6uxawzLjAYlZ/wMl4zLINqm+rxmybe6AmzSJ31jSV45UkAXy0FaXH/zAWbGU+z
	 CdASafnhh3+pxsKoWLVdersOCFuy9jTlJI7dgEArvOrA/rHKlO33i4KDhkds13Jp2F5Vx
	 J6+9cCc/7U92dfwpJYLTE2fPS6W+0ey1ttxvn2oZ05dTEdnSXGygArf4iJu/koKu+t4ev
	 5EUHlsdvg9BCzHQ6H9FQ2XdkY9WEeTu0BrnEGdw9QYo3UJk5Q05QqqVytHjL3TF7z199A
	 eKY3OrDQ80Gh95LUFaC6jsvxTOBfTLmuCxpi/9nYnGdJebJndtVt1RfJCdhilqx0B4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=bFrtAkQ6;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA648606A32C;
	Sat,  7 Nov 2026 13:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA648606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=bFrtAkQ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794059933; x=1794319133;
	bh=ggxRUmnt8EfrK5EcxblzoupqkjNgWhTE5turDSMEfKI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bFrtAkQ6tOUYKqXxdmzhmLZTs+vVerVwCQS2wqUgfoqUBHCTqSAGYyW2sk7sa+ytU
	 5bqqUyliFofSzrM4Lx+tbRQmezdKwc9CBTNXMVvo/gjzu+H92XgQGHHpZHhlIgowrg
	 W5oxsYadM07IKkJ3+4KHWsfvsh/BJxcweK7aPfFrAk/+cY9dr5EMufjySKmWRb1r4+
	 Vq/JGbxI7/5IQ/6Q5P3fohRgNtj3YshpOPRWgsKz2/eNyZSuoERSSl9puPZa7BU/9D
	 Z8Lva58ocSKiVfQjOmYnOw1tZFrK5f5d6czowWDv1c1kRricbK0n3AGcSeB+CsUX4X
	 UcAL4QekVkb8g==
Date: Sat, 07 Nov 2026 13:58:45 +0000
To: i@udp0.com
From: Roman Vivchar <rva333@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: mediatek: Add MT6833 and the Xiaomi Redmi Note 13 5G
Message-ID: <ZZQvVFkEtu09SueBM4cpOyT8Lvc5AE5kjAhCYj_i90Yy_HGK05NgwpMXjnrG-yoPdoUOdMZU78ixaR67bHKg6oto5txtZci-CevsM21bJqA=@protonmail.com>
In-Reply-To: <20261107-mt6833-base-v1-1-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com> <20261107-mt6833-base-v1-1-bda21083e9f3@udp0.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 91a443bb6ab5850971b9019c18190fcdd348bbc6
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
Content-Transfer-Encoding: quoted-printable

On Saturday, November 7th, 2026 at 2:22 PM, Rui Cao via B4 Relay <devnull+i=
.udp0.com@kernel.org> wrote:

> From: Rui Cao <i@udp0.com>
>=20
> Add MediaTek's MT6833 (Dimensity 700) and the Xiaomi Redmi Note 13 5G,
> codenamed gold, which is built on it.
>=20
> Signed-off-by: Rui Cao <i@udp0.com>

Reviewed-by: Roman Vivchar <rva333@protonmail.com>

Best regards,
Roman

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 180e6e4948e..900f16b57dc 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -72,6 +72,10 @@ properties:
>                - archermind,mt6797-x20-dev
>                - mediatek,mt6797-evb
>            - const: mediatek,mt6797
> +      - items:
> +          - enum:
> +              - xiaomi,gold
> +          - const: mediatek,mt6833
>        - items:
>            - enum:
>                - bananapi,bpi-r64
>=20
> --
> Git-157)
>=20
>=20
>=20
>
