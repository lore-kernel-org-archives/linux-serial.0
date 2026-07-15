Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A24611E5;
	Wed, 15 Jul 2026 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143976; cv=none; b=RcmHZMDt6KjJCE2eoWhMipWexMgI7Ba/Znx7J/ZKLXzDc09UQYF9ESIyvrH3ZOiYBIWL3zBzs+0e2dayWTNyMnwLR/nn24j4daOpXz0D9fjbwVk6XOuQVwKGTmuBIjQMXpbIjDl3sK/wd4jU2ntIeRyLjPVuD0CQ8hLGb944eqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143976; c=relaxed/simple;
	bh=fRj98+0A3uUft5HnpIYJjNgmLVzXRwBVRPleXwZ6TB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fr7yg4PG+RU13oiOC6jYNYJANmEi0ColErUKndy4S8GI5mzpez51fU+UZ4ke6pDanJTFiA8mFIdu+Ju9kW8CRsfHSjaeCDP96OBe5KZ5qU3OZ2f4H7I3Bj+Mvm6OT65f9y0d8HfHdhIv4L9ybgmgK/W4Jm2reM8yf2XOQdxbr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nCrsCUz9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nCrsCUz9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=K2kRxoCAum/25lk+JMgZ5Et4r6PioAkR1hFgQluxBjo=; b=nCrsCUz9KVyqdkiPlRd3mu0BPT
	BY/lltifM6/ZbtqRxSSVVnMfwnl35jU1PkPGYv8A+wbOsLSpMRK/gb5sCfaHkhKsLqnEVYDUgmpNd
	5uQpr/PPok9rRtziKGPHpBUZ8W3XMUksi8/X8IePJZZ2oEaLTHHQ8RMRSqiCsYhAR3dCRgd/+c4iY
	57tkbVxfBWJ+8jYeCmFop9LlFXC0GOorAfeQIyY/XzyzbdKrtmZyo1kL5WaGTFDbuoywDiBHRTon7
	r4AfvXEBr55f9k89DnejsBRcgAWYPmXHtT/kKU+J3OYevOpTGz8abQTlmWkU/i+utCoaoWxcIjRWf
	9rr15+0g==;
From: Heiko Stuebner <heiko@sntech.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simon Glass <sjg@chromium.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-serial@vger.kernel.org,
 Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add RV1106 compatible
Date: Wed, 15 Jul 2026 21:32:47 +0200
Message-ID: <15791133.tv2OnDr8pf@phil>
In-Reply-To:
 <20260714132035.v2.1.c1d92213393f49330ec14d0c670a802181b4fcbf@changeid>
References:
 <20260714132035.v2.1.c1d92213393f49330ec14d0c670a802181b4fcbf@changeid>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 14. Juli 2026, 21:20:36 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Simon Glass:
> Add the compatible for the UARTs of the Rockchip RV1106, which are
> compatible with the Synopsys DesignWare APB UART.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>=20
> Changes in v2:
> - Split out into its own patch
>=20
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 49f51b002879..c0d0524458c1 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -72,6 +72,7 @@ properties:
>                - rockchip,rk3576-uart
>                - rockchip,rk3588-uart
>                - rockchip,rv1103b-uart
> +              - rockchip,rv1106-uart
>                - rockchip,rv1108-uart
>                - rockchip,rv1126-uart
>                - sophgo,sg2044-uart
> ---
> base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
> branch: rv1106c2
>=20
>=20




