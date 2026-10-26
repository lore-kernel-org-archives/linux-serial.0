Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012620;
	b=O9ai6M5BMQ8XG7COTniq19v6Izp8LjmhqHt+RcH2jTCn2btlDYRhaNoUgrM1OGSXmpdR
	 GIQA+t2swf27UBMzO9ArtmgXcZ8y2k68+8VMBSL2cHFkuJRpOLB+BcqobDyu8HXTqLKFE
	 xlpJfBfyZn6ERO1AMlpmSc61M52tqbijV/S6Thh/yq5XqUQHykTq/N+jI6ac4ITFXNMyP
	 V2iDmyVEzTqxiOeeBZ0EC2MUUKir0gpUG9GBuNxrmkOxTFkBNH/L0rBvU36fMWV8m/650
	 xfDqV8v53tPuJ2yCYJWON9Co0aGJtet+DdAmHCCCxh0XmnAeO2YmvBnwxlmGjOKbSdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012620;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eG1IWLREFTkWMpvpEazIf5rlB72NKHWxSmueAZ+swbU=;
	b=g+X7Art43p9w5sUOWVrWylWj+8+KueKL3wq83Ay9adHZRJPxh63ECiXvDDIqyShWD3Ux
	 u0s6dAwPbVjCmleZ2FPkX5hI5co2kcfG3bsr5U64wQBvpWM1d7X0dGulO84nypsXJxwvr
	 +a1Cvp4TxMadYSYq5GmtNfd7d3dxp702T9e9RezUqzblG7CL/NPzJvJBr0RsV0i0VFEyu
	 1YJsMAgXzHNAoURI3ao4fY1yDaGcILfU5EgucFhE/72eW3N5ujjBsg4NM2WHbZMs1mLHJ
	 CJCIcOEA/651nuLXu+J7PX9MZbI4qDCpearqXvFnTH6V+6AE+8J5nYJA60vg7nvL9vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxIsOJPD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6860A2613;
	Mon, 26 Oct 2026 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxIsOJPD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88611F031F3;
	Mon, 26 Oct 2026 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012619;
	bh=eG1IWLREFTkWMpvpEazIf5rlB72NKHWxSmueAZ+swbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XxIsOJPDxzIvn55cRintgR63fsVu4U55VukLIJHXClcQvYNq3NLVCOg8+yiVbhxXq
	 sTGGIa78yieB4TAJF962NNZIdvVc+sgZ8yh5LOa9OQeHlIhQlF3XoI9nxXfapUGo5S
	 RXVSadvir99AkIqRrbjgYYdnxau1yMVFZYhm0UT2gGpmV/3PnqMo5eiejhJDngV3FD
	 Ld5kHZnEvR1AGqkhBKHKfLO/cFp7I19uWWVW3/a/siMRt0O9A2jF7LIhYjKHIjV012
	 62pEZSVVjg9hA6R+7cJmZcZ6SQVr7HJ3FfQGTr7BbN1IL3dpaI8X2fTxApL9u965gT
	 2qK2BVRTKcizg==
Date: Mon, 26 Oct 2026 12:03:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: ingenic: Add the X1600
Message-ID: <20261026-ancient-elfish-beluga-ca42ad@quoll>
References: <20261024051515.55639-1-olivier@mgcrea.io>
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
In-Reply-To: <20261024051515.55639-1-olivier@mgcrea.io>

On Sat, Oct 24, 2026 at 07:15:14AM +0200, Olivier Louvignes wrote:
> The X1600's UARTs have the X1000's registers as far as the 8250 core
> uses them, but the driver has to tell them apart to set their bit clock
> count. Add ingenic,x1600-uart, with the X1000's as fallback.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
> index d5f153bdeb0d..635342d43ddb 100644
> --- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
> @@ -32,6 +32,9 @@ properties:
>        - items:
>            - const: ingenic,jz4725b-uart
>            - const: ingenic,jz4740-uart
> +      - items:
> +          - const: ingenic,x1600-uart
> +          - const: ingenic,x1000-uart

These should be sorted by fallback, so list using x1000 should be the
last (x > j).

With this fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

