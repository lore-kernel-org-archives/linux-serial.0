Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caIlE7gz"
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282BFFC
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 12:39:37 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so769221a12.2
        for <linux-serial@vger.kernel.org>; Fri, 01 Dec 2023 12:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701463176; x=1702067976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIkFSFKTNqG5pJgN73rHGp3fFqpS3rYpv0qft22FsBI=;
        b=caIlE7gzEG4OAJ9T7SGopsu/lu6cTxbYRn0DW7gbc+AcEA8fgMx8t2BQ6oKjSl/tCp
         1OZ0il81UJWD7ErElR+h5wjycd9/QaAZyADkA5sxl6wTu/V7li149/BTZUWAtEvVtejm
         yFhs1vD559e4aIccusEly+rxEsGXZtffOnbj5Ekr8ysBKEp07gG3YM0eZY6FC1dvMgXA
         vm/noNhMY5adArffYxjaZKXkrzdQnmd9d0Y4L/JAwDPsY6xsAwc4eyU90anee7l7xgzb
         TsY5uu262DbUQZqSXt72Lm9ipJD7H1TI6m86Zs50d4K64wBYHVOUa1W/oFYOEohIls3n
         RLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463176; x=1702067976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIkFSFKTNqG5pJgN73rHGp3fFqpS3rYpv0qft22FsBI=;
        b=iDedA6KETQonpcwSzXHXqNTuehLU/FRfH+HM6a7b22n4aRCTV0jYwKLMn/8I87Pi3x
         pHJ6gulncvQ280FlqEcd0szC1mD9h6KUI51nviqTmS0k1i9JmmkvKQRz5up2YsviGzK+
         djPZt+vdPTJQMYUdEkxQM5b8qtpRilGnnslZoSS499ZdYmCSoH/9xU4lNv/9qwA6eh35
         /E1SkxdoDglVkjd2xB70Z5DAYHg/q66qrUsa8bCV7fsZ7kgWYa/Y0Cm7HzlR8zbewM7M
         eAp5a2of/BAkuwafG4SdKpltD2vCM8oXjwGSrvkf0AXlVI9R08mzv7wWbprLIoDR1/5b
         bTjQ==
X-Gm-Message-State: AOJu0YyMoLsNeLFIeNvd5LukdKJl26cQHpkj4gNlnOJmhjwdlIbO7lMk
	C0fp5I6sny22fikg4g6APeXbD+Us6may3DDpGOkA3Q==
X-Google-Smtp-Source: AGHT+IH43vrh31UX2rertdGqcGoKOrUcSkFAhN2ABa2Tjpy7c4Re8Gr5gHANOJcx9cdbUKLq+BVtXmQ/7DBOMK7M+mo=
X-Received: by 2002:a17:90a:de90:b0:286:6cc1:3f24 with SMTP id
 n16-20020a17090ade9000b002866cc13f24mr75683pjv.91.1701463176618; Fri, 01 Dec
 2023 12:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org> <20231201160925.3136868-11-peter.griffin@linaro.org>
In-Reply-To: <20231201160925.3136868-11-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Dec 2023 14:39:25 -0600
Message-ID: <CAPLW+4n+Gg6yzFeKVw+p5M-Lxznt8X-jrNQ9NoJojdDhvjiFHQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] dt-bindings: soc: samsung: usi: add
 google,gs101-usi compatible
To: Peter Griffin <peter.griffin@linaro.org>, krzysztof.kozlowski+dt@linaro.org
Cc: robh+dt@kernel.org, mturquette@baylibre.com, conor+dt@kernel.org, 
	sboyd@kernel.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, 
	linus.walleij@linaro.org, wim@linux-watchdog.org, linux@roeck-us.net, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, olof@lixom.net, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, cw00.choi@samsung.com, 
	alim.akhtar@samsung.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, soc@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	kernel-team@android.com, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:11=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>
> Add google,gs101-usi dedicated compatible for representing USI of Google
> GS101 SoC.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yam=
l b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> index 61be1f2ddbe7..a10a438d89f0 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> @@ -28,6 +28,9 @@ properties:
>                - samsung,exynosautov9-usi
>                - samsung,exynosautov920-usi
>            - const: samsung,exynos850-usi
> +      - items:
> +          - const: google,gs101-usi
> +          - const: samsung,exynos850-usi
>        - enum:
>            - samsung,exynos850-usi

Krzysztof, Peter: can you please point me out the doc which explains
the need to have all those enums/consts here repeating for exynos850?
I kinda forgot why it's needed, can't find any documentation, and now
it just looks confusing to me.

>
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
