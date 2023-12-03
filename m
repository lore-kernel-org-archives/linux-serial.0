Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5L7AweH"
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5458FC4
	for <linux-serial@vger.kernel.org>; Sun,  3 Dec 2023 13:39:55 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a51d80a02so26947246d6.2
        for <linux-serial@vger.kernel.org>; Sun, 03 Dec 2023 13:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701639594; x=1702244394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7gO8de0lce7HaKv0/P/qdh9+Js5noC/xSOjvtz3e/WM=;
        b=N5L7AweHBYhyJpgx6fgGw3aIrBLFOzeVEu3xxmSMt+OkZY/WQLPG6/SZ1PtvvquNPO
         DAgQmu7nqLc9pzD4GF4X+Us6KppvuMh76rIOa5puv8WAk5lBqru+2x+rhV269rfqBpsP
         afSCFGYwSfth18SQA59kBvmBvhlqXOKE2c4bZu9coSn8Yqof2c/XbsBatJw2Xb1rQ88i
         XZuxXxA0NKFDaSmfK6PufcA9vABx22hUNOpEkXyQN5I45Uth/hy6Xz2pkXrIcJ5aRrGU
         WAgtLd7juIiMtZTJUWvwzpIHk+oltqJpN7yRm39NMC/iGU9H+HuSVVRPeHOMDTiuD9Y6
         n8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701639594; x=1702244394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gO8de0lce7HaKv0/P/qdh9+Js5noC/xSOjvtz3e/WM=;
        b=AHdAZTKrlNtagbbi41pNX+2/SixGd6My/mISVTJ+CLdiWOMAb5zfl3YgL/b1F0xgX7
         BJOGpSDmU8wNRtNdWfAWN4IVzFtjL1oLGBFjSh6+RAXnG6VR/tzmBvUDI/CwhPxON8KX
         POrU2Q66wKKP09UnR9fFKOENSthqJ+sXs7dj+taSXpk/pvwCgYzGnrOrMykmgpsvWLbc
         1+yj+KYgLfGsXqwC203SsI2TTK6xnUaW4LtqXNNr2JWqnSIwKf+UeefPQad7ESE6FgEg
         ZZShjtkRqvKq3OeFNy4hdKfILnT2MeKjPZnpH89d/rgdJZzv+Nnkumt4QNpkgkYNhybV
         y7pQ==
X-Gm-Message-State: AOJu0Yx7vz0UzLsGu+EnEJl4jrpEqHzImigo50JY1GPgx9Z8JMt4rOFB
	HzM1nccYJeUIxIoOfED6EQs97TUA3X+TTq9Lrh3Qvg==
X-Google-Smtp-Source: AGHT+IGU7r7x9r9+baipwfFC2Z6LHKfOwxTcuFhaimGYhCIcueT+DijNUTVWF4dXUB1M1ZX2RA1n39vU5/gLge1bopA=
X-Received: by 2002:a0c:e94b:0:b0:67a:a394:e20c with SMTP id
 n11-20020a0ce94b000000b0067aa394e20cmr4222616qvo.38.1701639594412; Sun, 03
 Dec 2023 13:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org>
 <20231201160925.3136868-10-peter.griffin@linaro.org> <b4e710c0-dddb-4217-9979-21bdc20ee302@linaro.org>
In-Reply-To: <b4e710c0-dddb-4217-9979-21bdc20ee302@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sun, 3 Dec 2023 21:39:43 +0000
Message-ID: <CADrjBPpcknRifds+WpuwmdzGxxFq-osLf7_Rn1ENjoRcXwCRxw@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] dt-bindings: serial: samsung: Make
 samsung,uart-fifosize required property
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

On Sun, 3 Dec 2023 at 15:11, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/12/2023 17:09, Peter Griffin wrote:
> > Specifying samsung,uart-fifosize in both DT and driver static data is error
> > prone and relies on driver probe order and dt aliases to be correct.
> >
> > Additionally on many Exynos platforms these are (USI) universal serial
> > interfaces which can be uart, spi or i2c, so it can change per board.
> >
> > For google,gs101-uart and exynosautov9-uart make samsung,uart-fifosize a
> > required property. For these platforms fifosize now *only* comes from DT.
>
> I don't see ExynosAutov9 compatible in your patch.

I dropped exynosautov9-uart compatible from this patch due to the ABI
breakage. It seems I forgot to update the commit wording though. Will
fix.

Peter.
>
> >
> > It is hoped other Exynos platforms will also switch over time.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  .../devicetree/bindings/serial/samsung_uart.yaml       | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > index ccc3626779d9..65d5d361e8f4 100644
> > --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > @@ -133,6 +133,16 @@ allOf:
> >              - const: uart
> >              - const: clk_uart_baud0
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - google,gs101-uart
> Best regards,
> Krzysztof
>
