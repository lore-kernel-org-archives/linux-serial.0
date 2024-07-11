Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE68479;
	Thu, 11 Jul 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713081; cv=none; b=mKZZShUB41uMTVpAlgNHHpmzMbkEil7R1P8R9wZHpYMpYLPWdfyWH39AAY5LYdTKtoZPZSrhApLPjnn9AIgVWVQB5KESC9W2xtBQD50Argos6XhMr+EWyjlfo80LyljnjYD9XDQbPFNiEOAZXR78Z8un/Ch6stXM+1bkUxg5XDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713081; c=relaxed/simple;
	bh=Kdn4yBHek2NTiF7hAs11T2gTBUI2nFR7JGBd9fLx2MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc8js9N49Kdu4oqKXJMTQ9UxocYOlDBp7LBXd/Mytck6gH3R2P4C1xb5tX/2lXZ4r2qorc+0QsmvDVe9t6tgY8IJgXTpysHzjQ98L3ms01cRyQ3SG/Jim7W6tByH9+a7WER9EGMoUmazpHtqmDg2zpUjumhmZO7x1kfTYb8nRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfBp3l6R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfBp3l6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F93EC4AF0B;
	Thu, 11 Jul 2024 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720713081;
	bh=Kdn4yBHek2NTiF7hAs11T2gTBUI2nFR7JGBd9fLx2MY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UfBp3l6R84Er64lHrZ1+8IF9Xw6KD1q9Q82537YVxCbY0JmVUAWe/9DYpjS/XjLa0
	 WIQ32JUL7Jdj2/DxWMIgU2gHGLOYhhuET58fy/87CX7nAPM/98lyJ3oAE36dFW8jh1
	 Z/LYm8V5mOLF9vhtGRuKaGDDy+VZvQwJq7KwYcNn94BjCV4yVgzmyWya8WORlibYsq
	 c3vyO0eBulE1WXIxJWR3zEJpK0Dm0/L7lYfO0pgvbQTjAhTOzg1TSemTkf3PCE9BM+
	 V7ZFlgcyL8Cp38U8UAi1lLbQuKl1kM0XzbT9i/hYm89MeHxrQVFmHyBTBOswitS37s
	 b4cVPtT2FiWZg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso1513114e87.2;
        Thu, 11 Jul 2024 08:51:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvg40gpMuu69toi5iXnKTThfGwz/sOw1yIZxQokh6x5WuBnsmKPhuFhzd8ZQ3tMHtftKixzmeuDsr1k1aYn+iGxlWRc3l31CIw3sy2npSCOgkXTkh0aHBXMIepZI4jpLYWkFFgLJmsFhDvLxHnOBB3MryHADOUbz/bNjhXMmZ8irYSvz1bRMotIG+Q1548HRhvnSi/jguDUcLxtrcGzagE2EG5UwKzZYEEBKDo4BBX9U6MqmyenqkOnvgyEfa+cmyLNTio
X-Gm-Message-State: AOJu0YxpK3edfNUKQ25ziARP2xbXR8ySaXF5Xv8n/gnRjnhmg56TyKYI
	D/5uM1eJF6DFonsLa26om+O9odnsdWhc2Ge1yfUfHwUfjZmHetNTf+ytss34zcbc4GadrhKgL0n
	5pXhj15WhHz/FjsI0FrXiEwraMg==
X-Google-Smtp-Source: AGHT+IElxwI3DTbhcXoQnMJVlvwdauqS5RzGBQrc6N5zhGBYTcZbAbeLzaogiu4kSAPR8XV9dXyCGWkOpYxcz6H0KgM=
X-Received: by 2002:a05:6512:b18:b0:52c:dd25:9ac6 with SMTP id
 2adb3069b0e04-52eb99a3439mr7754037e87.29.1720713079582; Thu, 11 Jul 2024
 08:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
 <20240710-gs101-non-essential-clocks-2-v3-1-5dcb8d040d1c@linaro.org>
In-Reply-To: <20240710-gs101-non-essential-clocks-2-v3-1-5dcb8d040d1c@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Jul 2024 09:51:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsZAEx-c_12RPcR+HCjPcA_d12oKgZ7frX2Wo47sGTnA@mail.gmail.com>
Message-ID: <CAL_JsqLsZAEx-c_12RPcR+HCjPcA_d12oKgZ7frX2Wo47sGTnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: samsung: fix maxItems for
 gs101 & document earlycon requirements
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 7:29=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> While gs101 needs exactly two clocks for the UART, the schema doesn't
> currently limit the maximum number to this and instead the default of
> five from this schema is applied.
>
> Update the schema accordingly.
>
> Also, as pointed out in [1] before, the hand-over between earlycon and
> serial console is fragile due to clocking issues, at least on Google
> Tensor gs101. Therefore, document the clocking requirements for
> earlycon in the description for posterity, so the information is not
> lost.
>
> Link: https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783a=
e.camel@linaro.org/ [1]
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 14 ++++++++=
++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b=
/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 0f0131026911..2435c3d92158 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -145,6 +145,20 @@ allOf:
>          - samsung,uart-fifosize
>        properties:
>          reg-io-width: false

blank line between properties

> +        clocks:
> +          description: |
> +            Note that for earlycon to work, the respective ipclk and pcl=
k need
> +            to be running! The bootloader normally leaves them enabled, =
but the
> +            serial driver will start handling those clocks before the co=
nsole
> +            driver takes over from earlycon, breaking earlycon. If early=
con is
> +            required, please revert the patch "clk: samsung: gs101: don'=
t mark
> +            non-essential (UART) clocks critical" locally first to mark =
them
> +            CLK_IS_CRITICAL and avoid this problem.

That's a whole bunch of details that are Linux specific which have
little to do with the binding.

> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: uart
> +            - const: clk_uart_baud0

Which clock is pclk and ipclk? 'baud' would be sufficient for the
name. 'clk_' and 'uart' are redundant because it's all clocks and they
are all for the uart.

Rob
