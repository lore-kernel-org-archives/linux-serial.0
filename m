Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74C33986F
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204756; cv=none; b=WX1ShB0L4M4JSdg4RkZlmrgNKx3qqgT7sd50zDgVMGgRsDSieQPazdVuAuesweTLXMvy4LRJQ0zWBEag71oBi9FlXhOpQ5Zq5U90NaPY/QLCe+XpQyz/VdfxfNU97pDbcXIWEWTvxq4xc5usfSTFFOslWpMTHuDQ1fJMGqvWH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204756; c=relaxed/simple;
	bh=vAzFJ4vqGfp1N5PM9i7xpuMtH/9hCVwEg7TaqBSdN/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3iSrqFNkmJv4NJUkSjXFlBH8Rid1MEiR2eEdMKa+yWAKa/DcGbz2kimOXGO3LvNlYxO9t2CbA8UdU0JD0HGZJq/BBZjDjdQ/6cZNnHihIwdS2NWT0impfazvQqDtRyxPV/VaNrUEou9jfVY952PAD+//zJYqWet1QYmFMYgFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=hN35lIPr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="hN35lIPr"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc3572431so68025917b3.0
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 23:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768204754; x=1768809554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSAM4RH7cy/5YTgp+Z6CFhylkii8NBgRSJLcb1PkkO8=;
        b=hN35lIPr3erViCqpXNop7SqdRodfiuXkysGhWsK/L79LUPYTWI5efCBCLoAFGMgytS
         sKDQP9vsnKMEmrHFcgivzF1OVH9ai6UO1Z49+YqZrQup1b10P4OLYDSCMDERecbeZ/3m
         hYv5ntavvAX51XWsZ977RaHW8R4VNid7XlxIq6iswrgzzyU7ipXzUFtF8AzTX9szPnAN
         toEwQs4iGuPrHismNsV+0ns2VVw/MDWUyfu1xiCF6ugsfeoAk48Ay2LAfd4Pth0kF7KU
         8/UvniAOTGpyQKdaaxAonnPrYHNcOml8+lUhdYNDTTluuCdxJsp1fVy+5IqpStzzvYjF
         ZQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768204754; x=1768809554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZSAM4RH7cy/5YTgp+Z6CFhylkii8NBgRSJLcb1PkkO8=;
        b=PN1Rt0N6gqDPCP2SqpTCuyZILEKZwNoKrGsjUu6lnxkMEu8asDDlO/1xdckM8f4WZX
         G3S47GrATamsxTAXs0PyKT+2FyOsa2yk928xFxMwIqaS/ioR/ZNfGHULbyug3bOIY7k3
         Amb4fTw9IkbXaBqXNDZtde8qmmrLOx/769obYNS9i2S0ajOF6puKvgmKiGjTx/1gjwR3
         AHL6XfXE2oFBSjRoEvWGLll9dvZNCzkyAT/IB3qA5KxPgjNE6f93DWjWSr5qDaWdsiEj
         +jsPK/wcTcfMwW+w+fozsYdLiLvDyqwPfnMLrS/tgubZPR3nO0xC3aa4u4kwSYYmXQ7S
         72/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/rBWCcMrDHRTVa41QdWm2lbu7tuVtSt2+vhgdKRAhkfX8aZfvtFkJecJwIS7BPIFFbsqmtHqxuQ44WgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoj9A+gZFVUuYVhis7T0uwR+8qC6+uCEaZHCoSCBUoPUy6VW80
	BZ5FCvCxANHrfwSfhMKxSXoSrEW8hGRMuh30EEdITM3z2A/G4o8rPhhoDwP/fOGzBrIl//KXemA
	pdEg9XZub9AP3UWPRHyIW3GQn1GSoRdgSUwFY8wNC7A==
X-Gm-Gg: AY/fxX4TyhQ96Mv6vyJDFqgbVtWjubz0/Vk65grNjTu6AWRjpL18uECA06qKwdtm9NN
	QVabdiIHAM+rBkF0W2ktwl4mDC8Tu6Xot7drM40Ft3Bd/R0zfINChl4aweQpsmbxhkJrklsrewQ
	PkQcFwKV3MO+f+H7lDRFTQAKLLWuGtndsKVAmiarssv/V/0ZRp8/ofwF/FeP8HtQvXlJLv9r5g8
	GPKLxfHTHP5Qo1Us56GF6T9BDl4U3bPQimhqyiBpu32rLXCVBX8nJ8DgqRjLVRdkLaggDo+lD4R
	5h7Gd7fFc+SXr0qOmoiDDbbXkiX/EELDoSfpMsh1RCfn
X-Google-Smtp-Source: AGHT+IHzovDi2wYX7QS5E17vTw6EfrmwMxXUMWfzaTca+VnZ75agggH0jw0Z9Nk1rpoyt6jY2b2DsuWSrr3IaSzijEA=
X-Received: by 2002:a05:690e:13cb:b0:644:ca2b:b64f with SMTP id
 956f58d0204a3-64716c0f720mr14418176d50.41.1768204753933; Sun, 11 Jan 2026
 23:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com> <AM7P189MB10095424D5EECEF98761C227E381A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <AM7P189MB10095424D5EECEF98761C227E381A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 12 Jan 2026 15:59:02 +0800
X-Gm-Features: AZwV_QjBH78ep5ci-BN1t8eHhgINXSJDHXMbo8PMNGMoYTwSPL4cPXhT6kWXYBE
Message-ID: <CAH1PCMatYTfE58-O7ftt4dmr3tvssnD4UrSGEJSbHkFYgT_afQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, conor+dt@kernel.org, conor@kernel.org, 
	cyy@cyyself.name, daniel.lezcano@linaro.org, devicetree@vger.kernel.org, 
	dlan@gentoo.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, lkundrak@v3.sk, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, pjw@kernel.org, robh@kernel.org, 
	samuel.holland@sifive.com, spacemit@lists.linux.dev, tglx@linutronix.de, 
	xypron.glpk@gmx.de, zhangmeng.kevin@linux.spacemit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 3:43=E2=80=AFPM Maud Spierings
<maud_spierings@hotmail.com> wrote:
>
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
> > +                     status =3D "disabled";
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
> > +                     riscv,delegate =3D <&saplic 1 512>;
> > +                     riscv,num-sources =3D <512>;
> > +
> > +                     status =3D "disabled";
> > +             };
>
>
> from reading the chatter on v3 I think the right status here may be
> "reserved", for elements that are reserved by firmware. But I could be
> mistaken.

Thanks Maud. Good catch. I think you are right, both M-mode maplic and mims=
ic
should be listed as "reserved" to signify that they are intended to be used
in OpenSBI, not the S-mode kernel.

I will fix that in the next version.

BR,
Guodong Xu

>
> Kind regards,
> Maud
