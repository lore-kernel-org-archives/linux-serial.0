Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7D331A61
	for <linux-serial@vger.kernel.org>; Sun, 18 Jan 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744710; cv=none; b=TXGRmu+ipL1d/HzJCsupjReJ1kP/o5bLbinYQlx9OwocGIMiDCHy213WPNh3PJYbar6LatD+lBaOmfczTrnSmQxrUOZDKPuLhugTp4qKpcan823c6HtJMCrNcNBP0OhO2TY1eqqS/JSo4bhpTU0xFowF/qD/3AYbmdukePa0lVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744710; c=relaxed/simple;
	bh=QdtgPi/rU0rrjBmd+UtPdHfDTOcS+BagnVYyyB9I9sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHVbIHSnhSiqxphIoOr2bz5/+KT4VmihrI/Wsi/CYhgsDiEcq2JP6uQ/FnSHQVprc3R91US3yY3bWnE1kkj+ikWk6KFYERrHA96neJLmS+PFNv2AimFfhv0bh7RF6hHTw7ek3zCU0SZ7y0O1Rxf2umLK78JY79TTUvmi2UJ6oWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DyZGWcDP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DyZGWcDP"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-790884840baso33098197b3.0
        for <linux-serial@vger.kernel.org>; Sun, 18 Jan 2026 05:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768744707; x=1769349507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCG09MblElewZc4XYrwM1nFVohwbJ64zpVfajZmPugQ=;
        b=DyZGWcDPCmkdnrDCaGkptouAusmqKB1UJFBeFW2XjTanyr8PfHy9ORk5iyLdrTRlVn
         EV3QPgYrczoevM30++CLKhdrAAeJUKoqp58P6a5ZNdd5gRnWT3t3zWHwbQc2pcDbts82
         vDLmaMPI8HDkxjoBHNtZfY0i8QvtO289YOcgV6EavL0ybtYYQt56lAUu+iY20QofxU7J
         WeAMqppuLnAWifaWcHtGrVvPI8Y1MnBDIiWs9vp6z/A8v8QeUeOFX1cX5BGPbbjRnE+q
         vqFZOCsp1wt4XJ4d4jH6MKMUgzmecS0IviQuElahcS0jX558WkNwNd60yNNsbiM8dyuz
         7ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768744707; x=1769349507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCG09MblElewZc4XYrwM1nFVohwbJ64zpVfajZmPugQ=;
        b=KslFfI4+m9UjfATFzMtIIA2T9t0vrGUwX4lmGPRKXUouCkrBTaxhFNJwj6saLSNbgE
         daN9MFC3+bqAuZPNpdGocRjF+vhTQa1MA4QNBUYnYSg9Hl0Bjd74SitT4ViavSd505kj
         diAs/8iYZmDQEo7NgQBy0bBuZGGXzx1gV3gZE+b5OhibOA7fImDJrx8vXfDSENDyRA4M
         x8Sd3OSxCV60DHq7WWkohOEyzjm0ydrnM9zBgn1zg1gRtVMAshlwOteTkd+P0X33XeOs
         80JuGMlQ0oBssFJzdSLNIbn/9spVTVtRlw/Nw1GcBNnfLB0ABHIa2qNjRGa+eHwGlWNs
         yn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPJXgqE7ko5Rp+RLNcoWH9EpoTkvBucwm1EjLLxWTA7HhkZPiwM4RqT6fmKnjXbyCXpglzJ62Lbu/wo/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRagdmpzNGOs5VrGhQvp001sj4aLvatyIR5714udLgTPG1Rsjr
	4mRK+P8Z6eum3Dz4meZ8eHlybjufN+6E2h4rN7mAtNQNkbML98bv2V6jS0aiLN62N8kb0lZRskb
	N1dtKLPuKp6txrVGbxokp+1+fsg48c/45S110gdPJMQ==
X-Gm-Gg: AY/fxX4JLEX4k6eefMTwGky2/d8RJLXwN5yOwb82TivyH1jHslGs/FNkiC586Pgi4jf
	hDvv7Ff/XogeJ1DhOFw67Z7B8Ab3j64FOrLBQLBn+BINBXpEDxHo/JUNxAP58OGnQgrwUneTu7n
	ON0IN/q1DDGjiWXzemYal63GA21+3Sf6mmRHf69Mlqim3ylgrJEKD9MTWOR2lOojX5Sg9x0XbVs
	I8Ju3QlxpqyJ7ClL3/NLgjqGPDHnaAw8Nomu+4skz2nWQwOyR2awIeM+y4Qrm6s3wNOgZ8SBqYR
	I/ByfKQhmHhBqFomyRaDBtZLUxnFSdoGKWBugf/0OKM=
X-Received: by 2002:a05:690c:2504:b0:78f:c08d:7d9c with SMTP id
 00721157ae682-793c536b62emr65831397b3.32.1768744707082; Sun, 18 Jan 2026
 05:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
 <20260115-k3-basic-dt-v5-6-6990ac9f4308@riscstar.com> <c0395221-4248-4eb7-949e-ac86c40ec99b@gmx.de>
In-Reply-To: <c0395221-4248-4eb7-949e-ac86c40ec99b@gmx.de>
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 18 Jan 2026 21:58:14 +0800
X-Gm-Features: AZwV_QiOwOpvXeR65bqyHQR28QdYt34VIMrk6I6qxcYZnv0zcZ0PveaRnWIAU04
Message-ID: <CAH1PCMZ920oE4ix0TJuCsWp-27KVk3_6OASm47zJD8j2E7EZOw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] riscv: dts: spacemit: add initial support for K3 SoC
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, Andrew Jones <ajones@ventanamicro.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Heinrich

On Sun, Jan 18, 2026 at 7:41=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 1/15/26 07:51, Guodong Xu wrote:
> > SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> > Add nodes of uarts, timer and interrupt-controllers. Also add M-mode
> > APLIC (maplic) and IMSIC (mimsic) nodes to represent the hardware
> > topology and ready for potential firmware usage.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v5: Update the copyright year to 2026.
> >      Set M-mode maplic and mimsic status to "reserved".
> >      Update the commit message per Yixun's suggestion.
> >      In maplic node, use riscv,delegation to match kernel binding. Open=
SBI
> >       accepts both delegate and delegation, but the binding documents o=
nly
> >       riscv,delegation.
> > v4: Fix missing blank space after commas in compatible string.
> >      Add m-mode imsic and aplic node.
> >      Reorder properties in simsic, saplic, mimsic, and maplic nodes
> >       to match DTS coding style.
> > v3: Remove "supm" from the riscv,isa-extensions list.
> > v2: Remove aliases from k3.dtsi, they should be in board DTS.
> >      Updated riscv,isa-extensions with new extensions from the extensio=
ns.yaml.
> > ---
> >   arch/riscv/boot/dts/spacemit/k3.dtsi | 590 ++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 590 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts=
/spacemit/k3.dtsi
> > new file mode 100644
> > index 000000000000..53425badfea9
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > @@ -0,0 +1,590 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (c) 2026 SpacemiT (Hangzhou) Technology Co. Ltd
> > + * Copyright (c) 2026 Guodong Xu <guodong@riscstar.com>
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
> > +     model =3D "SpacemiT K3";
> > +     compatible =3D "spacemit,k3";
> > +
> > +     cpus: cpus {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             timebase-frequency =3D <24000000>;
> > +
> > +             cpu_0: cpu@0 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <0>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu0_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu_1: cpu@1 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <1>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu1_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu_2: cpu@2 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <2>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu2_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu_3: cpu@3 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <3>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache0>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu3_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu_4: cpu@4 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <4>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache1>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu4_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu_5: cpu@5 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <5>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
>
> Should zvl256b be added to the X100 description to indicate the vector
> length?

This is a general topic relevant to all "v" capable RISC-V cores.

To my knowledge, there are currently no upstream Device Tree bindings defin=
ed
for zvl*b or vlen. Instead of defining this statically in the DTS, the kern=
el
history suggests a preference for dynamic discovery. With the existence of
CSR_VLENB, reading it during kernel boot (or say 'hart boot') makes more se=
nse.

This is what actually happening in the kernel right now.

This approach has been part of the design since the earliest
implementations [1].

Link: https://lore.kernel.org/linux-riscv/e896db91e3303f64ac401021f848e536e=
9d42aaa.1590474856.git.greentime.hu@sifive.com/
[1]

BR,
Guodong Xu

>
> Best regards
>
> Heinrich
>
>
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache1>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu5_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu_6: cpu@6 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <6>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache1>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu6_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             cpu_7: cpu@7 {
> > +                     compatible =3D "spacemit,x100", "riscv";
> > +                     device_type =3D "cpu";
> > +                     reg =3D <7>;
> > +                     riscv,isa-base =3D "rv64i";
> > +                     riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "b", "v", "h",
> > +                                            "sha", "shcounterenw", "sh=
gatpa", "shtvala",
> > +                                            "shvsatpa", "shvstvala", "=
shvstvecd", "smaia",
> > +                                            "smstateen", "ssaia", "ssc=
cptr", "sscofpmf",
> > +                                            "sscounterenw", "ssnpm", "=
ssstateen", "sstc",
> > +                                            "sstvala", "sstvecd", "ssu=
64xl", "svade",
> > +                                            "svinval", "svnapot", "svp=
bmt", "za64rs",
> > +                                            "zawrs", "zba", "zbb", "zb=
c", "zbs", "zca",
> > +                                            "zcb", "zcd", "zcmop", "zf=
a", "zfbfmin",
> > +                                            "zfh", "zfhmin", "zicbom",=
 "zicbop", "zicboz",
> > +                                            "ziccamoa", "ziccif", "zic=
clsm", "zicntr",
> > +                                            "zicond", "zicsr", "zifenc=
ei", "zihintntl",
> > +                                            "zihintpause", "zihpm", "z=
imop", "zkt", "zvbb",
> > +                                            "zvbc", "zvfbfmin", "zvfbf=
wma", "zvfh",
> > +                                            "zvfhmin", "zvkb", "zvkg",=
 "zvkn", "zvknc",
> > +                                            "zvkned", "zvkng", "zvknha=
", "zvknhb", "zvks",
> > +                                            "zvksc", "zvksed", "zvksg"=
, "zvksh", "zvkt";
> > +                     riscv,cbom-block-size =3D <64>;
> > +                     riscv,cbop-block-size =3D <64>;
> > +                     riscv,cboz-block-size =3D <64>;
> > +                     i-cache-block-size =3D <64>;
> > +                     i-cache-size =3D <65536>;
> > +                     i-cache-sets =3D <256>;
> > +                     d-cache-block-size =3D <64>;
> > +                     d-cache-size =3D <65536>;
> > +                     d-cache-sets =3D <256>;
> > +                     next-level-cache =3D <&l2_cache1>;
> > +                     mmu-type =3D "riscv,sv39";
> > +
> > +                     cpu7_intc: interrupt-controller {
> > +                             compatible =3D "riscv,cpu-intc";
> > +                             #interrupt-cells =3D <1>;
> > +                             interrupt-controller;
> > +                     };
> > +             };
> > +
> > +             l2_cache0: cache-controller-0 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <4194304>;
> > +                     cache-sets =3D <4096>;
> > +                     cache-unified;
> > +             };
> > +
> > +             l2_cache1: cache-controller-1 {
> > +                     compatible =3D "cache";
> > +                     cache-block-size =3D <64>;
> > +                     cache-level =3D <2>;
> > +                     cache-size =3D <4194304>;
> > +                     cache-sets =3D <4096>;
> > +                     cache-unified;
> > +             };
> > +
> > +             cpu-map {
> > +                     cluster0 {
> > +                             core0 {
> > +                                     cpu =3D <&cpu_0>;
> > +                             };
> > +                             core1 {
> > +                                     cpu =3D <&cpu_1>;
> > +                             };
> > +                             core2 {
> > +                                     cpu =3D <&cpu_2>;
> > +                             };
> > +                             core3 {
> > +                                     cpu =3D <&cpu_3>;
> > +                             };
> > +                     };
> > +
> > +                     cluster1 {
> > +                             core0 {
> > +                                     cpu =3D <&cpu_4>;
> > +                             };
> > +                             core1 {
> > +                                     cpu =3D <&cpu_5>;
> > +                             };
> > +                             core2 {
> > +                                     cpu =3D <&cpu_6>;
> > +                             };
> > +                             core3 {
> > +                                     cpu =3D <&cpu_7>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> > +     soc: soc {
> > +             compatible =3D "simple-bus";
> > +             interrupt-parent =3D <&saplic>;
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             dma-noncoherent;
> > +             ranges;
> > +
> > +             uart0: serial@d4017000 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017000 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <42 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart2: serial@d4017100 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017100 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <44 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart3: serial@d4017200 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017200 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <45 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart4: serial@d4017300 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017300 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <46 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart5: serial@d4017400 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017400 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <47 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart6: serial@d4017500 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017500 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <48 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart7: serial@d4017600 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017600 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <49 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart8: serial@d4017700 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017700 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <50 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart9: serial@d4017800 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd4017800 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <51 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             uart10: serial@d401f000 {
> > +                     compatible =3D "spacemit,k3-uart", "intel,xscale-=
uart";
> > +                     reg =3D <0x0 0xd401f000 0x0 0x100>;
> > +                     reg-shift =3D <2>;
> > +                     reg-io-width =3D <4>;
> > +                     clock-frequency =3D <14700000>;
> > +                     interrupts =3D <281 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             simsic: interrupt-controller@e0400000 {
> > +                     compatible =3D "spacemit,k3-imsics", "riscv,imsic=
s";
> > +                     reg =3D <0x0 0xe0400000 0x0 0x200000>;
> > +                     #interrupt-cells =3D <0>;
> > +                     #msi-cells =3D <0>;
> > +                     interrupt-controller;
> > +                     interrupts-extended =3D <&cpu0_intc 9>, <&cpu1_in=
tc 9>,
> > +                                           <&cpu2_intc 9>, <&cpu3_intc=
 9>,
> > +                                           <&cpu4_intc 9>, <&cpu5_intc=
 9>,
> > +                                           <&cpu6_intc 9>, <&cpu7_intc=
 9>;
> > +                     msi-controller;
> > +                     riscv,guest-index-bits =3D <6>;
> > +                     riscv,hart-index-bits =3D <4>;
> > +                     riscv,num-guest-ids =3D <511>;
> > +                     riscv,num-ids =3D <511>;
> > +             };
> > +
> > +             saplic: interrupt-controller@e0804000 {
> > +                     compatible =3D "spacemit,k3-aplic", "riscv,aplic"=
;
> > +                     reg =3D <0x0 0xe0804000 0x0 0x4000>;
> > +                     #interrupt-cells =3D <2>;
> > +                     interrupt-controller;
> > +                     msi-parent =3D <&simsic>;
> > +                     riscv,num-sources =3D <512>;
> > +             };
> > +
> > +             clint: timer@e081c000 {
> > +                     compatible =3D "spacemit,k3-clint", "sifive,clint=
0";
> > +                     reg =3D <0x0 0xe081c000 0x0 0x4000>;
> > +                     interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_in=
tc 7>,
> > +                                           <&cpu1_intc 3>, <&cpu1_intc=
 7>,
> > +                                           <&cpu2_intc 3>, <&cpu2_intc=
 7>,
> > +                                           <&cpu3_intc 3>, <&cpu3_intc=
 7>,
> > +                                           <&cpu4_intc 3>, <&cpu4_intc=
 7>,
> > +                                           <&cpu5_intc 3>, <&cpu5_intc=
 7>,
> > +                                           <&cpu6_intc 3>, <&cpu6_intc=
 7>,
> > +                                           <&cpu7_intc 3>, <&cpu7_intc=
 7>;
> > +             };
> > +
> > +             mimsic: interrupt-controller@f1000000 {
> > +                     compatible =3D "spacemit,k3-imsics", "riscv,imsic=
s";
> > +                     reg =3D <0x0 0xf1000000 0x0 0x10000>;
> > +                     #interrupt-cells =3D <0>;
> > +                     #msi-cells =3D <0>;
> > +                     interrupt-controller;
> > +                     interrupts-extended =3D <&cpu0_intc 11>, <&cpu1_i=
ntc 11>,
> > +                                           <&cpu2_intc 11>, <&cpu3_int=
c 11>,
> > +                                           <&cpu4_intc 11>, <&cpu5_int=
c 11>,
> > +                                           <&cpu6_intc 11>, <&cpu7_int=
c 11>;
> > +                     msi-controller;
> > +                     riscv,guest-index-bits =3D <6>;
> > +                     riscv,hart-index-bits =3D <4>;
> > +                     riscv,num-guest-ids =3D <511>;
> > +                     riscv,num-ids =3D <511>;
> > +
> > +                     status =3D "reserved";
> > +             };
> > +
> > +             maplic: interrupt-controller@f1800000 {
> > +                     compatible =3D "spacemit,k3-aplic", "riscv,aplic"=
;
> > +                     reg =3D <0x0 0xf1800000 0x0 0x4000>;
> > +                     #interrupt-cells =3D <2>;
> > +                     interrupt-controller;
> > +                     msi-parent =3D <&mimsic>;
> > +                     riscv,children =3D <&saplic>;
> > +                     riscv,delegation =3D <&saplic 1 512>;
> > +                     riscv,num-sources =3D <512>;
> > +
> > +                     status =3D "reserved";
> > +             };
> > +     };
> > +};
> >
>
