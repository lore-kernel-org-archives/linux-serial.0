Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klrcDzH1"
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFCDB
	for <linux-serial@vger.kernel.org>; Sun,  3 Dec 2023 13:47:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-42542b1ed5dso17537591cf.1
        for <linux-serial@vger.kernel.org>; Sun, 03 Dec 2023 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701640047; x=1702244847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ypEtajSEZ/3+dju5T9JaBFEQ3JvraP41o/ylPX1p/IQ=;
        b=klrcDzH1TM+HzbNLMLzDzDQXMq2zCpdLsEyZdIq6a+TUjTn+JQfzr5s1KzecLlr7v5
         uCdPMmzBvWULsI1TD51henPtCmQ7c9M4IieN1rXCZUuQApndVWnD25ZZiyWe9UpXgEyZ
         tbg4YY6+BeRVxN1fY+NIi1rSHoQfQCGsdrMb0Ym/0GoKycr4wUmchBurHNoFX2vr1ndv
         FSjvomzDHJ7IsCVgFq9pzv/SvAqpagAf1CBP7segKEzbbyh5/k/y1dtQFNPPhrbnR+f6
         Hod++Dt1K/Slv/M0iqutH36NJS9PN1MU9FM+LsMniPxgGoX7cp7zXKFiDR/mLiZnOj/9
         wXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701640047; x=1702244847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypEtajSEZ/3+dju5T9JaBFEQ3JvraP41o/ylPX1p/IQ=;
        b=JDZQHfPp71zVGLi2P0AJ2cg7SlkjB6Eiiv7dxxgetEL5UryQvBaTrH3s6GcAyXSCFg
         pH6lWJn/UKHi54xBpEspz1ZXsKpC/za3nvqyvOPzuZSfcLo4MCbQS7M50Oa5E6gDaqVd
         Hyj4u3+kVhYphg57NyV3kv0STtLCiEXSQjQAVPRrVf9HFiEZRjQ7aUWKNsn6tTX6DJ+r
         nyQ0Y7yKTGk3Bt1Oxx6E+SbdtSCj2YCQUSavCUcBY8+J8Ka54GGltvoKlKVmKzJv22Ts
         8Fb9LSQOSaEUKGDwwVmb1p99ODq7JctfR6JPrZMmkGAcoyAJ34Ql7RDsSG7/dAEiKs/W
         7l2g==
X-Gm-Message-State: AOJu0YyjRts/KZmjrPv51V4VU7pmmMMqdyOPTHReiwO9vPgFu2fSUwTy
	XcOivBI63Jh5dLsY1foatWMMDlVvxchvQmnCNkWAkg==
X-Google-Smtp-Source: AGHT+IHc/rln86HWRtRO8D+k4deS4wGOzHWIyvONBd5JHCCN4rJ37HsOLKPo9YqdJjypf9JsSc1dyZOBRmsFYFPuzZM=
X-Received: by 2002:a05:622a:1752:b0:425:4043:96cc with SMTP id
 l18-20020a05622a175200b00425404396ccmr5772334qtk.89.1701640047675; Sun, 03
 Dec 2023 13:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org>
 <20231201160925.3136868-11-peter.griffin@linaro.org> <2854a9b5-d6c8-454c-bc3b-79744e613686@linaro.org>
In-Reply-To: <2854a9b5-d6c8-454c-bc3b-79744e613686@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sun, 3 Dec 2023 21:47:16 +0000
Message-ID: <CADrjBPofpjB7iA3u1LGy61F_0dPX40ZrtJsHd6zumTOFu3bEjg@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] dt-bindings: soc: samsung: usi: add
 google,gs101-usi compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	semen.protsenko@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Sun, 3 Dec 2023 at 15:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/12/2023 17:09, Peter Griffin wrote:
> > From: Tudor Ambarus <tudor.ambarus@linaro.org>
> >
> > Add google,gs101-usi dedicated compatible for representing USI of Google
> > GS101 SoC.
> >
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > index 61be1f2ddbe7..a10a438d89f0 100644
> > --- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > @@ -28,6 +28,9 @@ properties:
> >                - samsung,exynosautov9-usi
> >                - samsung,exynosautov920-usi
> >            - const: samsung,exynos850-usi
> > +      - items:
> > +          - const: google,gs101-usi
>
> This should be part of previous enum.

will fix,

Thanks,

Peter.
