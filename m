Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EBDB641;
	Mon, 20 Jan 2025 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737343285; cv=none; b=T4iwBbkuMcHU5R9zFIk9Z2nC3V5vAq3KFQjTYGxdTK8hv9yECruQN9bZ3h004PhXvy2HyMAZbRSFuz/s2AV4SVmTh8zxTIrmjYZDGnqKmjUogSnEEkccQmsHt+rAeiGU+B9anvMW8oXxgeV9U8SqlY1L1YEC9nP2DGKldc6DCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737343285; c=relaxed/simple;
	bh=7i/anLQLRyPO4A5Pd+l3gpK+N/mcIqCBf/4JrDcWkVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNb6YIdO2fKFjUqC/x3wWxC5CXNl/KxyuzcV+l1EerKaHQfWExXEkMJHm0M4FU+cdRaE2dxd//Q78/0XRQ0n8SLXnoq2Mgcjr6iaS77jMECTCnWScSRdAU8e0EdsQfrnMAgMgQu3JLfgN1iGehR+kpTON2JDaEfsIH30Flj7TQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnlD3M/a; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnlD3M/a"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so5217523a91.2;
        Sun, 19 Jan 2025 19:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737343283; x=1737948083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnVkumt0JcPO+BzIMkSwW7tqNH01vxd/Nb1s4rMGcVU=;
        b=DnlD3M/aXbdxWdXnzMaddoQ3HXO6hWLYcnLw0VygihQXzO+aAsGR3R7tklRSBLA4n+
         m8aIuYp2tCqG9eZfqmymTMd51aQSExv92rxUR6tTQt9PrDDO5Bncn0xg5I+WukpiIpnh
         2OMu1+ls//LPa193v1sZsgv8lztPXZqikJ07sBZwoB+9bsxViiijmLGv1J18jJzARxLG
         TjJ79LPOj1NrmVHpqo9AcorDhgW4VhzMA1yENJIw0YNWGJPdXrtJurH/VtYuyOtC0YIn
         MCURR8K3oENhQHv/d0U+KUpb17yFkeziTRVdEbsLQOrA39JGoz8HIlyLE7qWBkeIU+Zd
         AiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737343283; x=1737948083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnVkumt0JcPO+BzIMkSwW7tqNH01vxd/Nb1s4rMGcVU=;
        b=XF+mQ3+xyjIZZYjIC+e0pDV56NVOaoOtppBHShtcYpl8ZvLKBRvGlp4nltqRqzdFa0
         MkZVYRxCWy5YBsbHiVN1Ohz/DJgFk3cZPze+L1mLCWjlxHXwvW+1os2PT+CyR6R9FZzE
         pNBT5WwXz0eud5UqGAVcrOWUiUIqgQYvPbQvIlItLcwAYc00e/II/n+UDpaWazpcL4M9
         vPrNyNh8qVKP3zfD3F7c8DNzEe89usUTbylsn1uHrObSXMoLnte7hhyWJWSlkt8CrY4L
         vvUH1POf0V0jMweviyAQxKOHNZa3ZrlobQhu37rkfppbXP3WWaR2SQZ2jH+ZvyCI0AzY
         CmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7VcfP7a+bOEqG4YMQYFzygI4RG4T7b0qV/UwJoc97M8K4rcr8TgjPkpFEBIiC7HEUCGJw+4bwzdB2@vger.kernel.org, AJvYcCUf82cC2t1tHh0FZHZYdoU9a/b9EBWnz2jU5y2MjrsNZjijttTKGKrZ54cw1WrbFmsQ7hpggSmDON/PqhIo@vger.kernel.org, AJvYcCXa0NhBQxtkOWS/4vtG+6TldZPJVOiJ0ji9WWsHtLcDuBuOo6yWp90RKppCP/ey8i1/i8SIe0mfILzqapiN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PQvkba58p8ls74MrNhEH0IKl5EXKqn3sfPsqByYlWesqSW3y
	vvGbI92Mm2JA8kxfxT4yClOyZW5aeUSqyThYRVKnMBjKzfzkwsnAJjbsEX+JWgMpZ5sR+/9ruyI
	Yk4n6Ws6c4hJaa1RlpUxxMDK4eyFXNRGMoVg=
X-Gm-Gg: ASbGncvtepOg5Tu8P2KLMuxlTNN0Y+/dQRA2Rzupd70gBnHWJF/glvtJVNZuorERhR1
	ALqQTJTrhrDuaPw+H1BSHApSx1ispo0hUWk5Nwd3rI5w731cu4nBU
X-Google-Smtp-Source: AGHT+IEhvlUjM0GcetxifujHj8qs5X8oAIMHsasdHaqwMAgPLkQYxu9FwNWbHg1CVqvxN91lp6ovH62Wa17wGYxWPNk=
X-Received: by 2002:a05:6a00:1954:b0:724:f86e:e3d9 with SMTP id
 d2e1a72fcca58-72daf99ed20mr14258814b3a.14.1737343282774; Sun, 19 Jan 2025
 19:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114054553.3376837-1-Wenhua.Lin@unisoc.com> <4591ac0a-80fc-4922-b463-79395c9f41d1@kernel.org>
In-Reply-To: <4591ac0a-80fc-4922-b463-79395c9f41d1@kernel.org>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Mon, 20 Jan 2025 11:21:11 +0800
X-Gm-Features: AbW1kvbYrLoK4BvyETMKF6bFZyIgxGKzyh24KxZF-5__BE-NE_-EmlstL8yrhEw
Message-ID: <CAB9BWhfvbY9-_0tbpFOpGjzG8U9wwiZhdKnSVfx-GGx-Mis1jA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: Add a new compatible string for UMS9632
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 3:38=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 14/01/2025 06:45, Wenhua Lin wrote:
> > Due to the platform's new project uart ip upgrade,
> > the new project's timeout interrupt needs to use bit17
> > while other projects' timeout interrupt needs to use
> > bit13, using private data to adapt and be compatible
>
> Where is private data in this patch?

Hi Krzysztof:
   This private data is a modification of the serial driver.
   Due to the modification of the driver, the new project ums9632 SoC
   needs to use SC9632 to be compatible.
Thanks

>
> > with all projects. The sc9632-uart is incompatible
> > with sc9836-uart, Add sc9632-uart dedicated compatible
> > for representing uart of the new project UMS9632 SoC.
>
> First part of commit said these are not compatible. Here you claim they
> are compatible, so this is just confusing.
>
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597
>

Hi Krzysztof:
   Sorry, I may have made a mistake, the patch version was submitted
incorrectly.
   We want to submit this version
https://lore.kernel.org/all/987b764e-17a6-4280-95e2-858d4c74a8d5@kernel.org=
/,
   but since this submission PATCH V1 has been merged, we made a new submis=
sion,
   but when doing the dtbs_check and dt_binding_check checks locally,
   we deliberately changed an error to see if the check is effective,
   but when submitting, the patch version was submitted incorrectly.
Thanks

> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/=
Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > index a2a5056eba04..35fe9c301cd2 100644
> > --- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > @@ -17,13 +17,17 @@ properties:
> >      oneOf:
> >        - items:
> >            - enum:
> > -              - sprd,sc9632-uart
>
> No, not explained, not justified.
>
> >                - sprd,sc9860-uart
> >                - sprd,sc9863a-uart
> >                - sprd,ums512-uart
> >                - sprd,ums9620-uart
> >            - const: sprd,sc9836-uart
> >        - const: sprd,sc9836-uart
> > +      - items:
> > +          - enum:
> > +              - sprd,sc9632-uart
> > +          - const: sprd,sc9632-uart
>
> This means nothing. Device cannot be compatible with itself.
>

Hi Krzysztof:
   We need UMS9632 SoC to compatible with sc9632.
   But now this patch version is submitted incorrectly,
   we will modify it in PATCH V2 version.
Example:
@@ -188,8 +188,8 @@ apb@20200000 {
                        #size-cells =3D <1>;

                        uart0: serial@0 {
-                               compatible =3D "sprd,ums9620-uart",
-                                            "sprd,sc9836-uart";
+                               compatible =3D "sprd,ums9632-uart",
+                                            "sprd,sc9632-uart";
                                reg =3D <0 0x100>;
                                interrupts =3D <GIC_SPI 196 IRQ_TYPE_LEVEL_=
HIGH>;
                                clocks =3D <&ext_26m>;
@@ -197,8 +197,8 @@ uart0: serial@0 {
                        };

                        uart1: serial@10000 {
-                               compatible =3D "sprd,ums9620-uart",
-                                            "sprd,sc9836-uart";
+                               compatible =3D "sprd,ums9632-uart",
+                                            "sprd,sc9632-uart";
                                reg =3D <0x10000 0x100>;
                                interrupts =3D <GIC_SPI 195 IRQ_TYPE_LEVEL_=
HIGH>;
                                clocks =3D <&ext_26m>;
Thanks

>
> Best regards,
> Krzysztof
