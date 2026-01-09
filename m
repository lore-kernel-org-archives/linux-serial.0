Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354D335568
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952730; cv=none; b=XhyWXrxCrMSzFMERz3VxB8Al1JwnPFOp7FyCw54xfrsH9eTLAZoEkQFXKr0cdOPYdfy5iq4zNtzmOI/LyttrCorKthuY2m2ih30uFCMmA6OYABJ1+SgGuvKeymnKTzcHGnOmlo0nGw6qcHYD1bI9HMD1RT7t5oJ67kdL8rNZ6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952730; c=relaxed/simple;
	bh=HfqN5rsCzLuNeeHAJM65+FWteRwaiCNG9V1ApHVnkXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLUWFIMz1j3/nv8w+a5K8bi1qG//CL3CwF8eR5wuyzlRXk64g+lMwK4ZC0PjnQtxOt2xHXg9lOA/P047RnDxjJi4YKZB5YXbCZ0rAZPy6hWI2psN8crnF/DmQMdqDIj29EKo+uoaGn6XybbtWZOYfSeZpCI2dn6LqvTaFXOmovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Lfp4C7jR; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Lfp4C7jR"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-644715aad1aso3515553d50.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 01:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767952727; x=1768557527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRyjYSTtXcl5FXFODcJzwoMzy+oOw8NWF5mztWKmicQ=;
        b=Lfp4C7jRqgq6E/biD7yqtBZyExrT/LR3/QALDuG77fJFAzRmM6qMVYcRhtWMc5yh0x
         1T0n7ePnYGXy7hNJx4/w3AP1oxF2UctxG1iCEmcAxqI1y3i2zWzmEpaaruLvuD8RMVNs
         Qa/x0pZ0cBBTMiPB4YNfpuPMp6MZ6yVWzgbEwbFJ06jxoSopWQWIV72vYhRiIwpoSjWx
         M3A+Ty4vBkUgNbXiBhD4PIVdHpRKsSI/+DmFw2FfpQwIjs9RKngEvnq+CoomzFflO/ZR
         eeHrhtAndBun0uewVQjiHS4wpFAJv4PZpTmZoua7kT1ND/pvW2cN3feLpFH8zfX/VpgQ
         Q90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767952727; x=1768557527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRyjYSTtXcl5FXFODcJzwoMzy+oOw8NWF5mztWKmicQ=;
        b=YK+21+OUBSGNFINkGUyfZhgeFJzsmyjaPHKnhSTvoXq83GCqD2/e0gmPq7BvRUJCzT
         vB9AiWZ+9CPaQ2VkhouSK35srxusEK3pIIfV8PG6g8VhFAlxoOGuCYuXC+Ah0Z6E/ZUN
         8oipRZEU/+8Dk+dZZFwBlRydXdsG8UmXpmAQ/2Zx+6DtBYG/H9Xs7Hi1w5nUguGwt6TD
         k80lJ/bNu+66wwowi7mF/OHqyAYbMORrmhHvtYXY3R7kUmPexgmwkzu+WUl6jSrkP1xc
         oMzPuetkLGqZMerCMqva5oTNUa7ZmYRvybB8jXp7p4PkABxKLp92OClB6ag3WC6MJWgm
         6qQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfO2aphtQqssn3PkdmDsDYM5rQ9lx8vUrGkzK8uAfgan8FUqFJ7rQaG86ovZMdZr2o4qbS13m3cCVK6+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblU56BuyVYkhyipL8HVpNwdZoCOL1+KY4Bm5NnH/kzqNBJvkE
	07ng/Kv1dpCjr1IC0ht3fr2NHSC3kolaZNVEPZMNYnJVGTbhjAYBRYOzG40K2NNbfQOAOt7IMGP
	mus4xq/aAJQATkziAsoDcEeUz0KYXAPRsZCsUnY+tPA==
X-Gm-Gg: AY/fxX7rvESTwUN14gIjJTklLQ4h9qgmcbE+LAy8817Y0AMLB2902v/WOI78itCF1qW
	HGtZaUdbk7e2GhNrpEVc7qSB2UBSaJUFeA/0bgtCB7L21MjvvYjWlgyr3UI37RCOeceHyegE235
	pRue7PuQW9KoHwc9xToR59BNT2EV+1rO2Qy7BZl4exDaAPFrMZlX2ZQGODD5JUa86skdREJZx6q
	momdzdgHHYGxhx2J56vMfjfHkZ54niGtyoQBmzayF98b/XJiHBd7lt0E/cMEdoIUtMv8ywANXOm
	igzaFWqUJWBEttgwdRy1D4SK4pEr2y1tMGZ8dC3knxE=
X-Google-Smtp-Source: AGHT+IFW7FLnowocr8JpPLfWWYtEHi7OSPLnkmturePvB00jhuMA0kdr6u8Qb5NpLIfs41qOnuD4QPSn0aG0bk5mMPQ=
X-Received: by 2002:a05:690e:1188:b0:641:f5bc:692b with SMTP id
 956f58d0204a3-6470d2f46b7mr10319192d50.36.1767952727498; Fri, 09 Jan 2026
 01:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
 <20260108-k3-basic-dt-v3-10-ed99eb4c3ad3@riscstar.com> <77f9a001-7f0a-4c29-abcb-501e875da117@sifive.com>
In-Reply-To: <77f9a001-7f0a-4c29-abcb-501e875da117@sifive.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 9 Jan 2026 17:58:36 +0800
X-Gm-Features: AQt7F2phDg1o6vGA0EN2FWkwF5OD2jGO_aKHZYYtROeDAwedA-GsX86VaBlzTIs
Message-ID: <CAH1PCMZ5rKbG8xEbB9jt6TqyB28T5aLgRtf3iJ8Gt6Fk+3XFhQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Samuel

On Fri, Jan 9, 2026 at 2:19=E2=80=AFAM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> On 2026-01-08 6:26 AM, Guodong Xu wrote:
> > SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> > Add nodes of uarts, timer and interrupt-controllers.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v3: Remove "supm" from the riscv,isa-extensions list.
> > v2: Remove aliases from k3.dtsi, they should be in board DTS.
> >     Updated riscv,isa-extensions with new extensions from the extension=
s.yaml
> > ---
> >  arch/riscv/boot/dts/spacemit/k3.dtsi | 548 +++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 548 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts=
/spacemit/k3.dtsi
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..be9335fba32cb9e81915b2b=
91cf08c55a5e96809
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > [...]
> > +
> > +             simsic: interrupt-controller@e0400000 {
> > +                     compatible =3D "spacemit,k3-imsics","riscv,imsics=
";
>
> style: missing space after comma

Thanks, Samuel. I will fix that.

>
> > +                     reg =3D <0x0 0xe0400000 0x0 0x00200000>;
> > +                     interrupt-controller;
> > +                     #interrupt-cells =3D <0>;
> > +                     msi-controller;
> > +                     #msi-cells =3D <0>;
> > +                     interrupts-extended =3D <&cpu0_intc 9>, <&cpu1_in=
tc 9>,
> > +                                           <&cpu2_intc 9>, <&cpu3_intc=
 9>,
> > +                                           <&cpu4_intc 9>, <&cpu5_intc=
 9>,
> > +                                           <&cpu6_intc 9>, <&cpu7_intc=
 9>;
> > +                     riscv,num-ids =3D <511>;
> > +                     riscv,num-guest-ids =3D <511>;
> > +                     riscv,hart-index-bits =3D <4>;
> > +                     riscv,guest-index-bits =3D <6>;
> > +             };
> > +
> > +             saplic: interrupt-controller@e0804000 {
> > +                     compatible =3D "spacemit,k3-aplic", "riscv,aplic"=
;
> > +                     reg =3D <0x0 0xe0804000 0x0 0x4000>;
> > +                     msi-parent =3D <&simsic>;
> > +                     #interrupt-cells =3D <2>;
> > +                     interrupt-controller;
> > +                     riscv,num-sources =3D <512>;
> > +             };
>
> Does the chip also have M-mode IMSIC and APLIC instances? Those need to b=
e
> represented in the devicetree as well, for M-mode firmware to access them=
, just
> like the CLINT below.

Yes, the K3 chip does have M-mode IMSIC and APLIC instances. Currently, the
boot firmware (U-Boot) transfers information about these nodes to OpenSBI.
However, you are correct that they should be properly described in the DT.

In the next version, I will add the M-mode APLIC (maplic) and IMSIC (mimsic=
)
nodes to k3.dtsi, for topology representation and potential firmware usage.
I will set their status to "disabled" because exposing them as "okay" to Li=
nux
causes access faults during driver probing.

Please let me know if this approach (adding them but keeping them disabled)
looks okay to you.

Best regards,
Guodong Xu

>
> Regards,
> Samuel
>
> > +
> > +             clint: timer@e081c000 {
> > +                     compatible =3D "spacemit,k3-clint", "sifive,clint=
0";
> > +                     reg =3D <0x0 0xe081c000 0x0 0x0004000>;
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
> > +     };
> > +};
> >
>
