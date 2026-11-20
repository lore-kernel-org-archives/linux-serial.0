Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190603;
	b=kzHHQXjA3c3ILaWWMzKGFYGNMWeSYhiDKyb8Mb7qOacCzurMue6x9VLcKqD2K7CG+5CF
	 cKOvUTHiy8Ts46kDDkspIJCXl+T07OpHeEqaSGFACQXC5YUDbVeF/kEGw9oAZ2gNpYnAn
	 r7aeLC/RT2O4/rz0KgsX2UNoJoLtWLwDLXJUVmd1a+T2tRQSetlTF2+O+b5fwaXIXdqUp
	 A2KETN10fpL42oTXJcVmK8nHQc8zAs4GA5O1ucfsU4KrLuCGmTXHR+QukuNrhtYuiOOtY
	 /1GOKelvpnhS9FG5pda8URf83NGDyy1YJ2sDYVebTGzKXJXaI6cNyaUD2fsq3/JSTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190603;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0fxeBQWA+Vv42RQyz76WkaDzLZasoMz+I7cHksuH6aY=;
	b=EKLEjzh0hlLnxinzi9D0ezVevlFd8buIypw/9nHE7PzjU53rL80nNkYDvUqyESvnDCzF
	 PvHqgGB+/Ni24oJYI8tnWW38XuNvdemZe6QMSEBlaLc5FSTYEcHjHgOB0AFJStnTTt95x
	 ZdzSmBN3L7Xi+M+NO2qIVpFHrRbdb3p1COc6heoz8JQNJEylcKfgGq4cVVs6OrWvx2QNr
	 jUaNKbfkR7kV5IEoBkcPcHfEfNWt+fCzsqY5th3nQ3K/bC1KA2atptcdCJc9vgnnoEJi0
	 smfB/aZbXDfiH6tlKl0gNK4R//NCBlqFn5YkEn9Dyu1jRlR1yQchnTKIgW6iMvCZKLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUg6glcs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918B606A330;
	Fri, 20 Nov 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUg6glcs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BBA1F000CA;
	Fri, 20 Nov 2026 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795190602;
	bh=0fxeBQWA+Vv42RQyz76WkaDzLZasoMz+I7cHksuH6aY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZUg6glcsCUv515/4tezA+6zALJjR0/Stptxvp4oW+weiR81JS3wMwE8qYPhCQmO4D
	 zTj0vF+6vmbSSRiz+h4RNTc8txkRUW20HjjfjKEGwZKM3elZbFSIgjeuzPFK8uQ95m
	 8VjGrSsjrTcoCY0KOyrggVcbaS6NAATQ1h7r3vFsixnIGsF+dyWZ6xe8HLZN0WYvk3
	 WCse8hY8VEVrf33czVN0zX+dPdAlpuE8d8W1WKeAFj9hT34f3TxkAapG/CD8ApaDfR
	 xhm9uVxqd7fBcxMEqwkfqNqjN1KlZzMRZrHXqeS3gRUgaxT6GFT8PyF4/0WWNDKT4D
	 twu84KBRef/Pg==
Message-ID: <e4b514e1-4b0d-4bb7-a19e-e13518ceb277@kernel.org>
Date: Fri, 20 Nov 2026 17:03:11 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mainline-linux 4/4] arm64: dts: renesas:
 r9a08g046l48-smarc: Add RS485 support on RSCI2
To: Diogo Ivo <diogo.ivo.sx@renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
 <20261120-divo-ssgrlpcsrc-2996-rs485-v1-4-a989baae3559@renesas.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-4-a989baae3559@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 16:49, Diogo Ivo wrote:
> Add an RS485_ENABLE macro (disabled by default) to configure RSCI2
> for RS485 operation using the RSCI2_DE pinmux instead of RTS/CTS
> hardware flow control.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
> ---

Odd subject prefix. :/

DTS cannot be combined in this patchset and must be split. Don't mix
patches from independent subsystems when you send something explicitly
targeting only one subsystem.
See also: Documentation/devicetree/bindings/submitting-patches.rst


>  arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> index 68d7b579e352..d583f52e61e7 100644
> --- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
> @@ -23,6 +23,8 @@
>  #define KEY_2_GPIO		RZG3L_GPIO(6, 4)
>  #define KEY_3_GPIO		RZG3L_GPIO(6, 5)
>  
> +#define RS485_ENABLE		0
> +
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h>
> @@ -185,8 +187,12 @@ rsci1_pins: rsci1 {
>  	rsci2_pins: rsci2 {
>  		pinmux = <RZG3L_PORT_PINMUX(7, 6, 5)>, /* RSCI2_RXD_MISO_SCL */
>  			 <RZG3L_PORT_PINMUX(7, 7, 5)>, /* RSCI2_TXD_MOSI_SDA */
> +#if RS485_ENABLE
> +			 <RZG3L_PORT_PINMUX(8, 1, 6)>; /* RSCI2_DE */
> +#else

That's dead code.


Best regards,
Krzysztof
