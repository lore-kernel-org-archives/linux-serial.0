Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxdzWdj2"
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7E1D0
	for <linux-serial@vger.kernel.org>; Sun,  3 Dec 2023 13:21:26 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58fc1fa4d06so356007eaf.0
        for <linux-serial@vger.kernel.org>; Sun, 03 Dec 2023 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701638485; x=1702243285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MBALP8YV0QZwaMwdd2KBWcj9Tq1p2Z16LRDLKvabBto=;
        b=QxdzWdj2Adq+1FMGv2/fas25Mr2HqQdqka2/V56PA84tqjM8ns0LpH+We5MkNCIiFD
         GEgtEtz4SdcDeBKq3EmCbft5zlmDS3ofH+iihci1Zzwlh3dCJ7RB4y2Vfk1iM+uiwra9
         M6kIqZDgf3su24XfuYvAnEJ4BbCkWLoar/6US4luXNY+3Ke0vZYB5gqxbzqZi+pWr5L1
         XVRaBYBiSro1MOUN/a04trw5OwjpXmp7GeZAXsXxaw9UqWciP7m9ZTgqb0CUwV29TrTO
         Ni9nxijSfPpwhoC0z2wLerj8X7ZFAptUZNWRAF2gqCerfC/GMb1kn39PVdUDMNH1HR9I
         f6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701638485; x=1702243285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBALP8YV0QZwaMwdd2KBWcj9Tq1p2Z16LRDLKvabBto=;
        b=Ibsz9XG2r88lnE02xtZjfGrfzTllCw/AeBpjpSTCjjnCKwItzYO8dx+LRXodxhYIJQ
         F2oivOwQsH+BPAw1VmIAwdpcrclnONEZMJKhMTyXG1TMN99RDrAvbIFd9Y1eTyGLFOAr
         ZGg9sFIjownBesKP+xn8GZGsD1NDwgw4mKS+1YGihVEtqmwIEYT1WD3GUWJ9g0rvrdIJ
         E4QdaVVLs9VONJOZIGLXRutUXMMB9M4u853tyhwGfwL2CyrfIFY561uAeFRr+T6eGQiF
         u0tQr5SDoFTfKAGqrSRV3cQmqhnPAeDC5eTMse5DPGzqIxjettHwmlTjqTV3Mi6XczaR
         5QoQ==
X-Gm-Message-State: AOJu0YxaXqZ8L47lqVjweCk9pX8qOoTJJQgRbKHbSwyYE5HilZ39AtXH
	NBp9LwwIUyRJ0rPpY40FrmFOYNoZnmFM/tN9lIksqw==
X-Google-Smtp-Source: AGHT+IGtekMHkp852JA6RkiudAH5D96Q93RiRqk9YOj5heuqbhP+mmIk3wEQ0uwM4Ob7BzATccUT7+4SnMfM9Ymm5do=
X-Received: by 2002:a05:6358:1206:b0:170:8f0:c6c2 with SMTP id
 h6-20020a056358120600b0017008f0c6c2mr3905258rwi.21.1701638485268; Sun, 03 Dec
 2023 13:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org>
 <20231201160925.3136868-8-peter.griffin@linaro.org> <fedd4ec8-b4e6-472a-9bfd-063ea8b9658e@linaro.org>
In-Reply-To: <fedd4ec8-b4e6-472a-9bfd-063ea8b9658e@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sun, 3 Dec 2023 21:21:14 +0000
Message-ID: <CADrjBPrqWKdhiL8TCcBC3ohLAwrAZiRwtA8Yg0q4gkrf9qrKqw@mail.gmail.com>
Subject: Re: [PATCH v5 07/20] dt-bindings: pinctrl: samsung: add
 gs101-wakeup-eint compatible
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

Thanks for the review.

On Sun, 3 Dec 2023 at 15:11, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/12/2023 17:09, Peter Griffin wrote:
> > gs101 is similar to newer Exynos SoCs like Exynos850 and ExynosAutov9
> > where more than one pin controller can do external wake-up interrupt.
> > So add a dedicated compatible for it.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml      | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> > index 2bafa867aea2..de2209f8ba00 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> > @@ -44,6 +44,7 @@ properties:
> >            - const: samsung,exynos7-wakeup-eint
> >        - items:
> >            - enum:
> > +              - google,gs101-wakeup-eint
> >                - samsung,exynosautov9-wakeup-eint
> >                - samsung,exynosautov920-wakeup-eint
> >            - const: samsung,exynos850-wakeup-eint
> > @@ -111,6 +112,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - google,gs101-wakeup-eint
>
> Drop, not needed.

Will fix

Peter.
