Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394533C1BB
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205661; cv=none; b=WkenhPCfADYoBsQKGVANsG8xiodGUAK4eUybXtnJ7oQjjxz0+92ajA4ufHV23ulfPlSdmUBiPFN49fx3Fgq1xvAvvYt4btqVsfQfdfiewJTc8r8pmU5MRFRef+QmX7dwiLNGoWRj+Sqjae3BQpDFwrxdYMplqwDi6hdgYZT1Cxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205661; c=relaxed/simple;
	bh=VYy3AjnDSWMpdYMiu5+vuTaZIbRUvnr7IoGcdtG3324=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjY9LFNdp7zpdgvm2tCw3AhuqZ2uTt13uMKec2OuV2y2IfrCaGh5L5P8PeE5+ArxP5QkeUhisI8F6vkBEEw/pyzLJQCPQ8PJqpmuvYtORI0LkgEoCxbew762KgbWZIExqTqqe5uQTNehQYA46YVfemZhIgm1Ly8UkifBOKHaUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=J0MFZhW4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="J0MFZhW4"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79275e61c2cso12185487b3.3
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768205659; x=1768810459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdHYyTf8yNUB9PUhTyJBW4AOfvFKsuolfjygPMMLYzM=;
        b=J0MFZhW4MTeBTOo66s9Q8DXSKL7oRtlHiiYQN5fZpgfS02wGiFCaizitEONl4YaCrb
         MbQ7Lo4nxYZicoGQk0/tLZKqouO401lEH00cCWgrYf5VMRGYMQZlfECn1vaXBalxhsGm
         M/D9zX/goEJohR56sTzUue09o+ts7Y/TOPQzXhp/RB1qjQBl+Ph9Ubo0QC8u1scLOrID
         n91uUn/1tlYMHwZO1wKdj29ByP3/Op+WImR+Da9j4yD7hnX46aIIq05dUYn+MUbipZfy
         nCMuDl4sMYkh3gDqaD4eNRouL3eTUqk80APdoCWMa6Y5oSSZX3ZvkvSoMgaxSB61hJHd
         +5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768205659; x=1768810459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdHYyTf8yNUB9PUhTyJBW4AOfvFKsuolfjygPMMLYzM=;
        b=D1QCUYFe9Udk6bKvGklrarHE8b3lWjnyNQaEx3f7nt1l4+ZdREJtikUUl8Q7Lz3Cia
         tDWgJB5K6kYlQIJcqBgWP1mJHpX2sp4JQRzI/D70Y+tsPEJ2AwQJW0+ivCDANsJ4M3kk
         CMxJ0CnXqk7CcP3T8woam85TowhvvPv/DVflSzSMkYKS8vSqtT3DGPpqD4mH4rrwSCE1
         3+21U5Y92hgBE4Soibxxhfv4As68IOrmE4pyuP6Cmpo0JM/MAnX91MiBUizL+2+HP2Lc
         fzbkVkmwqb+8SIxCtJJ3deAkonJKy3bGkaycnvZ52jY5zwXdAVHsmKnXmIP1bC2IrPlT
         sKgA==
X-Forwarded-Encrypted: i=1; AJvYcCUQDRL0j9Cpv9hrja0zSbVVIuvRuDn8Ugu3wOHp0wTdbfFkA+tiiFIQKmx/RuwdkUKmHTbNUGBmsajpXrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFVwxojGAImuqCP2VcB08bEviX28/yYnJmLZp+GnEuGGxYz9B
	jf27QikA+oviGHmyr84ewZs+S9AcgYXDB8q7hUJm7f+5rEdU55+F3e9rZnDYZTJa57KzUtdwCLF
	kHHD0bX4vidJWyOeZFdif9Gt64Fi5IAjCGTa8kG7IYg==
X-Gm-Gg: AY/fxX7xQUPPvzG1wyYzsNXqYLxJwYlQMxw1TMN/2lNeJAeDFg76q6DwcJPq8P8WAm/
	wBwr+CmsGxdiGzbhc8Gs8VqQWa46M2iRzXL6Oij+dLrAxwnY33LBBiYxPWjYCfFViyb0ZVaa8QZ
	vywh8vzncMUayvPZk0YhnaHNtZCN54pi3mfDBZ2GoJ1nd+ars4Z4+6h9S9X6ttn1L1nrVR+OR5s
	h05WmaO90152mk/IpXSAko+BY8zhkr0hziIs3BdrVyS8RIx/cW9oI/1OMaqCp7VvXbKtFyev3yE
	eNkQo7fqM2JSE/mbWnT8fy6nrcVzhGLQIL5zLwpKLXSsCVrIZMDFGoY=
X-Google-Smtp-Source: AGHT+IGaUMti/es8KDCK9VKF8Pq/ZGqb+Pn4kB7n8HEpQA0mof3jCeBYsxR3EZFKC9/bg55lrEWXaPLSWS2ilkC4UcA=
X-Received: by 2002:a05:690e:13c3:b0:640:d255:2d6f with SMTP id
 956f58d0204a3-64716bda139mr14249893d50.34.1768205658908; Mon, 12 Jan 2026
 00:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com> <aWIi9LFdqSF3c-FP@inochi.infowork>
 <20260110110502-GYB12783@gentoo.org>
In-Reply-To: <20260110110502-GYB12783@gentoo.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 12 Jan 2026 16:14:06 +0800
X-Gm-Features: AZwV_Qhr0dttuBvrLtxWYoEzTqFnHiF6Qe7y0CQjr_1X00MIdkxaUixcgPpB4IM
Message-ID: <CAH1PCMbh4f1fcZ1sUWGtYoZCH_G1x626rb7YvoNTnKjfm9znXw@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yixun and Inochi

On Sat, Jan 10, 2026 at 7:05=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 18:00 Sat 10 Jan     , Inochi Amaoto wrote:
> > On Sat, Jan 10, 2026 at 01:18:22PM +0800, Guodong Xu wrote:
> > > SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> > > Add nodes of uarts, timer and interrupt-controllers.
> > >
> > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > ---
> > > v4: Fix missing blank space after commas in compatible string.
> > >     Add m-mode imsic and aplic node.
> > >     Reorder properties in simsic, saplic, mimsic, and maplic nodes
> > >      to match DTS coding style.
> > > v3: Remove "supm" from the riscv,isa-extensions list.
> > > v2: Remove aliases from k3.dtsi, they should be in board DTS.
> > >     Updated riscv,isa-extensions with new extensions from the extensi=
ons.yaml.
> > > ---
> > >  arch/riscv/boot/dts/spacemit/k3.dtsi | 590 +++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 590 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/d=
ts/spacemit/k3.dtsi
> > > new file mode 100644
> > > index 000000000000..a815f85cf5a6
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > > @@ -0,0 +1,590 @@
> ...
> > > +                   d-cache-sets =3D <256>;
> > > +                   next-level-cache =3D <&l2_cache0>;
> >
> > > +                   mmu-type =3D "riscv,sv39";
> >
> > I think this should be riscv,sv48? IIRC K3 supports it.

You are right that the underlying X100 IP core is capable of supporting
both SV39 and SV48. However, not K3.

> >
> I would second the idea here, if the underlying hardware support sv48,
> there is no reason we should limit it in DTS, DT should reflect the actua=
l
> hardware.. if user still prefer to use sv39 for simplicity, a "no4lvl"
> command line argument can be passed.. see
>  arch/riscv/mm/init.c +860 -> set_satp_mode()

I have double-checked with SpacemiT, according to SpacemiT, while the X100
core itself supports both SV39 and SV48, when it was integrated into the K3
SoC, it was specifically configured to support only SV39.

In this case, the K3 SoC's MMU is configured for SV39 only, so mmu-type =3D
"riscv,sv39" is the correct representation.

Best regards,
Guodong Xu

>
> --
> Yixun Lan (dlan)
