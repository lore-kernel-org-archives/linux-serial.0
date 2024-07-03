Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B11891C1
	for <linux-serial@vger.kernel.org>; Wed,  3 Jul 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005734; cv=none; b=ZXGaRTP93hD6xLkzJ5936N+mrTBnWUv/vVWgh+/I0G2LZPqEOA3I/i7B3vDXFB+4f/angav+kXuwuJa1fwa2OaOLN2Y/gMXpEAsnGaqCgX5+wf4dUTV2uOGS84QXeJuaA2viY1DF81Y596VA7U7QXWPgSOmq/qOrjRBBqklHfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005734; c=relaxed/simple;
	bh=XGvJWi2ACdeOImN/SwBAgmGV5CjAcEGdLvKIxHnA/Ig=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK0eAw5p64xMya3uwcJqdOQwY6QmrCzj3k+IELDD5hTsdpdDlAtB29MQC7j/7Nc6zhBl7W+vQXsgZmXuDOoTf1k5Y6jzwLE4FxPEhaETAfiufNIKXNv2Aydosc+ch8S76TG04DcT6HoosZTuJlGu3fD46tuDpgGKI0uG/K11cZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cz2tAQ3Y; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cz2tAQ3Y"
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 007CD404AA
	for <linux-serial@vger.kernel.org>; Wed,  3 Jul 2024 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720005728;
	bh=1qFVnINiw1OmtrqIdL6Ri9JaQ6L530vAhDFXUjoyBpE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cz2tAQ3YJgplOqOIOjBs0tLeTtOEWjAYaWzOn0Kkvj1l0Qu6sDQrlAfvZUOlkXMWZ
	 R5klxSZC55XlRIV9SlRWqjJ1tD2PlrOxaJhrD/XU2gRO6GS63hb4qqphMeQA3+PFmU
	 jCEwNKXNxoy3oa64PprG6PWOfoxfF9lmyAwzirn9AOtX3C9H1qI5RKUuJQA/AE1jfz
	 +SV3ocD4y2KqHyPmLGsrbNIwt3rep5QXG2IB4nSbm9AZ8vcEHI54eWj30zX9hr4b5z
	 48IQcotTfJqCtINscQ/CTTLmDoGbmdLv6cX6e+CLvwGsnT72ZfN8pMoieJ6wjVeYJJ
	 s9eTdwdVUusQA==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-444fd3f52fbso74030041cf.1
        for <linux-serial@vger.kernel.org>; Wed, 03 Jul 2024 04:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720005725; x=1720610525;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1qFVnINiw1OmtrqIdL6Ri9JaQ6L530vAhDFXUjoyBpE=;
        b=GPaAOryVBRUQL4tyWuCw4dmQGN2xjX+8AJIi9OCTfSAeVQFLD36/TcyQ4OZd0cQKYS
         U+1nynqvZ8pac5Qtnt+Qi5QbQPRtl6QfJxpQAQwFttxWuYyajzd/Xq/oTluS70260X3k
         AbMv7ynTfFYC24iGRUxpl/o3rYiDd525Ycm1z3O9D+IuOK3jlLo1RA+C8FIUi25efvWo
         naTAf5S4GUJURh83cUYz4B6sy0zbr22tomAyy435bUrXqVD1t3E+AxKlvO+SsL2EnIoP
         VC8F4QDkh1ujtqVlkx+P0FftjnwomU+P0AdQgULUfI0wftDeC/cwygBjtLomYH7D0VQ+
         yggQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC/k0M3dWO083cnxE7J2+2ZJV7RAbiJSB7U60nl4dG/BKgaF0JxdCS5POQ3gc5t90ZDUNbmRYruEOnjabFtevL0J5M+bbUhILhGfpS
X-Gm-Message-State: AOJu0Yy+RierXhXIO4i6EnFriTNbjlup8DUclNShIiI8SlVRRWd6FX24
	8FS2JZ5tYaH25mbqRmENhwS2+urKVOun103yudMD0ejEnGi8h8GNBVIqwrQQevnqLv6nurv45Yq
	JJgz4bQtYSzned3yzZdaOmxwdcNMvETL50oyOxU+T0tSE7alUHNujdmCopVviTMBofZDcO33Cca
	5t7TsJpuSf7cZOiFBWiBicsmlyy/w41TXPF71JRzSovODOdlQh70q9
X-Received: by 2002:ac8:58c8:0:b0:446:5d98:bbb1 with SMTP id d75a77b69052e-44662e5b600mr160719561cf.32.1720005725499;
        Wed, 03 Jul 2024 04:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKJRX5E4PZN5AIkzZDqalz4GIxVyhLTZcy2t5CI2qf3j37GtaHnJJ1/0FVMsH63722yIHL+BLfMdPGdU70kDQ=
X-Received: by 2002:ac8:58c8:0:b0:446:5d98:bbb1 with SMTP id
 d75a77b69052e-44662e5b600mr160719281cf.32.1720005725057; Wed, 03 Jul 2024
 04:22:05 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jul 2024 04:22:04 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240703094049.GB2676251@ofsar>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-8-cc06c7555f07@gentoo.org> <CAJM55Z9jeAQTsVjRiLeofDm1RyMWCuHXC0a-pdKtpUiTkSjJCA@mail.gmail.com>
 <20240702012847.GA2447193@ofsar> <IA1PR20MB4953C031CB453AA0E51657B3BBDC2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240702-appease-attire-6afbe758bf0f@spud> <20240703094049.GB2676251@ofsar>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 3 Jul 2024 04:22:04 -0700
Message-ID: <CAJM55Z9AdOq_yd7sK_VhkutokK+-QKscdq9i759H3N1UKVwJkQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] riscv: dts: add initial SpacemiT K1 SoC device tree
To: Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, Meng Zhang <zhangmeng.kevin@spacemit.com>, 
	Yangyu Chen <cyy@cyyself.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yixun Lan wrote:
> Hi Conor:
>
> On 16:25 Tue 02 Jul     , Conor Dooley wrote:
> > On Tue, Jul 02, 2024 at 09:35:45AM +0800, Inochi Amaoto wrote:
> > > On Tue, Jul 02, 2024 at 01:28:47AM GMT, Yixun Lan wrote:
> > > > On 12:49 Mon 01 Jul     , Emil Renner Berthing wrote:
> > > > > Yixun Lan wrote:
> > > > > > From: Yangyu Chen <cyy@cyyself.name>
> > > > > >
> > > > > > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> > > > > >
> > > > > > Key features:
> > > > > > - 4 cores per cluster, 2 clusters on chip
> > > > > > - UART IP is Intel XScale UART
> > > > > >
> > > > > > Some key considerations:
> > > > > > - ISA string is inferred from vendor documentation[2]
> > > > > > - Cluster topology is inferred from datasheet[1] and L2 in vend=
or dts[3]
> > > > > > - No coherent DMA on this board
> > > > > >     Inferred by taking vendor ethernet and MMC drivers to the m=
ainline
> > > > > >     kernel. Without dma-noncoherent in soc node, the driver fai=
ls.
> > > > > > - No cache nodes now
> > > > > >     The parameters from vendor dts are likely to be wrong. It h=
as 512
> > > > > >     sets for a 32KiB L1 Cache. In this case, each set is 64B in=
 size.
> > > > > >     When the size of the cache line is 64B, it is a directly ma=
pped
> > > > > >     cache rather than a set-associative cache, the latter is co=
mmonly
> > > > > >     used. Thus, I didn't use the parameters from vendor dts.
> > > > > >
> > > > > > Currently only support booting into console with only uart, oth=
er
> > > > > > features will be added soon later.
> > > > > >
> > > > ...
> > > >
> > > > > > +		clint: timer@e4000000 {
> > > > > > +			compatible =3D "spacemit,k1-clint", "sifive,clint0";
> > > > > > +			reg =3D <0x0 0xe4000000 0x0 0x10000>;
> > > > > > +			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>,
> > > > > > +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> > > > > > +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> > > > > > +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> > > > > > +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> > > > > > +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> > > > > > +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> > > > > > +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> > > > > > +		};
> > > > > > +
> > > > > > +		uart0: serial@d4017000 {
> > > > > > +			compatible =3D "spacemit,k1-uart", "intel,xscale-uart";
> > > > > > +			reg =3D <0x0 0xd4017000 0x0 0x100>;
> > > > > > +			interrupts =3D <42>;
> > > > > > +			clock-frequency =3D <14857000>;
> > > > > > +			reg-shift =3D <2>;
> > > > > > +			reg-io-width =3D <4>;
> > > > > > +			status =3D "disabled";
> > > > > > +		};
> > > > > > +
> > > > > > +		/* note: uart1 skipped */
> > > > >
> > > > > The datasheet page you link to above says "-UART (=C3=9710)", but=
 here you're
> > > > > skipping one of them. Why? I can see the vendor tree does the sam=
e, but it
> > > > > would be nice with an explanation of what's going on.
> > > > >
> > > > /* note: uart1 in 0xf0612000, reserved for TEE usage */
> > > > I would put something like this, does this sound ok to you?
> > > >
> > > > more detail, iomem range from 0xf000,0000 - 0xf080,0000 are dedicat=
ed for TEE purpose,
> > > > It won't be exposed to Linux once TEE feature is enabled..
> > > >
> > > > skipping uart1 may make people confused but we are trying to follow=
 datasheet..
> > >
> > > Instead of skipping it, I suggest adding this to reserved-memory area=
,
> > > which make all node visible and avoid uart1 being touched by mistake.
> >
> > No, don't make it reserved-memory - instead add it as
> > status =3D "reserved"; /* explanation for why */
> Ok, got
>
> > Also, I'd appreciate if the nodes were sorted by unit address in the
> > dtsi.
> so I would move "plic, clint" after node of uart9 as this suggestion
>
> for uart1, its unit-address is 0xf0610000, it should be moved to after cl=
int
> (once unit-address sorted), if we follow this rule strictly.
> but it occur to me this is not very intuitive, if no objection, I would p=
ut
> it between uart0 and uart2 (thus slightly break the rule..)

No, please order nodes by their address as Conor said. It actually says so =
in
the DTS coding style:

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

/Emil
