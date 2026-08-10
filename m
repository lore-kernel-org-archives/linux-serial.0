Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E73F6C32;
	Mon, 10 Aug 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374144; cv=none; b=JB7151+nP58r1A9d9PG6fuKWxFwnyJh5DS6Dpo9C7rwvilovlV9sOfvEdNqRBoeyR7zpz5Du7LHijWaDfc6x+lIXGD3E13TsDHsx+CiLFZ+TqxBMZUcxWhm5HQMaUyii63+i+xtPm7qO9O3/u1MbixhnChSfXdiHn5pX2QYtYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374144; c=relaxed/simple;
	bh=mHwp+L/3M87TIoJKndQwDBb6s2qsCG+sXW6DY2wqyew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q08zDGiICqL0WSl0mnrvda4n22luqqJhV3mOGgHwwRtxE/wbI9RasWU0Z43Q6PJQ7GaGGwEEd4ehtHiHYXb7fY0LcWPk78Vt2YJ7b63gDR1mw7/k1iZs+RHYm3gMoM8IE10njaXPXYU384xCV2MpIYw7p5Ue8wycOx7PjxEk34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdTFYFFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdTFYFFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5E01F00A3A;
	Mon, 10 Aug 2026 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786374142;
	bh=RutbF3WCRdnTiBEVOjXEBFpb9G7xRlWAvF5tNiZ28TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fdTFYFFonDVMxmQC48gkZfaFuRcJGhUDYihUH4dyJJbxmKzyO4dXChrfqJPcHotej
	 4Gnnc11OZb8gZZVb2f5iGw1zMj59Jqq14hArDEVlMda7WxFJeIln1D7NHilQP6puXz
	 zRBKNzCDimIqbWp7U+rYI9KboGMloCD343fkKLZ3bCOtlVmuA/hEjl0H91nFrpvdUy
	 LwmvB98TWGf6+iE9bhu/qwk8abxJU2cmb4H718c+vsXUTHiT5QbhhPnY9P6G6iuln6
	 2ErIfS1Ko/nem4E7IcD7qTpOudGiYnIY4Kkt8i1DNL4XU6TKBcyMDBVBGx78MfnIGC
	 doL3IhkyJ0XfQ==
Date: Mon, 10 Aug 2026 10:02:21 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>, Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Message-ID: <20260810150221.GA1621358-robh@kernel.org>
References: <20260809121449.574277-1-ansuelsmth@gmail.com>
 <20260809121449.574277-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809121449.574277-2-ansuelsmth@gmail.com>

On Sun, Aug 09, 2026 at 02:14:46PM +0200, Christian Marangi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> 
> The Airoha SoC family have a mostly 16550-compatible UART
> and High-Speed UART hardware with the exception of custom
> baud rate settings register.
> 
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index bb7b9c87a807..b6f7e093d8d7 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -110,6 +110,11 @@ properties:
>        - const: mrvl,pxa-uart
>        - const: nuvoton,wpcm450-uart
>        - const: nuvoton,npcm750-uart
> +      - const: airoha,en7523-uart
> +      - items:
> +          - const: airoha,an7581-uart
> +          - const: airoha,en7523-uart

Don't stick this in the middle of a bunch single entry items (which 
should really be an 'enum' if you would like to clean that up).

> +      - const: airoha,an7581-hsuart
>        - const: nvidia,tegra20-uart
>        - const: nxp,lpc3220-uart

>        - items:
> -- 
> 2.53.0
> 
