Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D66F27FD68
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272285; cv=none; b=Td3bQzARo4frdhtWgx/zXbNpSqNQrbkNhWJYiJa34dReKeZiKwDlma/F13OWpbw5eBext8e3l0gOC6GyBLzIsWyIKXBmxfkJSi1VThOFMgxIXYldVgADLm8nmh2OES+37HmZZvK87H75iZPwVbxVyIyFYj+MKrea1R8e8JoB+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272285; c=relaxed/simple;
	bh=AXpazA6SgKTW1vhNzpqG3QrGSTso7uVz9zzI2iC/vyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SH/9EOURd9GBWU/hbvm+p37RShICiHz15NcSFEG0XweiivMEUhEkdoKIIJzBcVAK28uu1HdWIVbGMwq37NNboKUTnq60mqMDSFVUZepiVSh8jeu73SBd6k5BK4C+7QklWAXnxCkgTF/fj0ZkWk4QLTsLzMS8pt/v78BgM3TTmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QVLqCnH4; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QVLqCnH4"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7927261a3acso26895257b3.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 18:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768272283; x=1768877083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXpazA6SgKTW1vhNzpqG3QrGSTso7uVz9zzI2iC/vyg=;
        b=QVLqCnH49MahB8inuO211KchkyF+duCLL2rpNU9KQ+PrJJntAtKxfPyWbWjOuoSD7x
         fc1BEX0yNW5/+1B7neJuorhYElXcO2j4qDS4WxvwDJg/zKw+Z84SDjHC3Q0ee06FLck9
         nacP2DZvNxpOp+YbSmbLFkeCZGZ0w8NDCac9exqXdENjcENOY5Dg1VG/8RaOU9m+LsZN
         1XTYAtsKl9+Fdg01ffIIWbIfszyYAivpzM+wRg3t3ZVgwXUQhF61uPj3F9dTkOA3+pET
         d93ytEQCculXtRxfF0C+/dHNFj7FJ/oiyDdsYsekr+Elgri0UfUcdjwVEJTvvqBKDJU/
         SnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768272283; x=1768877083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AXpazA6SgKTW1vhNzpqG3QrGSTso7uVz9zzI2iC/vyg=;
        b=IAeWoYTFur95N4a6H9NKrYE5f189IWx7IEnPZoyBN5hquzUzxlRPa7LorzJfm+vY1J
         RoPb0uxOHnmmrV+/fPtibZII6JnK6dmYDUSPnmLxBzTybJ4/26m+vlNDw98AePw3Z1FO
         dH/2wttACnvLPG0IWxuHF9CSX9MhDCV4THLqVmeScgp/wgLdcJ/0dcpp+nWzy/sHawz9
         +CipfMwtS9bjvdGpIQu/5+mBPlL78Of/hvSmI1Ts/0YD7vVmD8RVSnt7hVAH2aRfRg6e
         5meqldYikgOguztg+VtZV03+LIQBSISJmr3D01CyVohpHuCxPDpWpMG+LXaVh/L000Ck
         Fmew==
X-Forwarded-Encrypted: i=1; AJvYcCWO6K/n3d3AEfLZMH2wqbUXlDyMkgn10d+8W0/CD7tC+A2uNpVMHdkD7Ul1aMI8qx3cCIV9mbxC1VsD2lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChXfITpFlHZD+A01cFzsQfkKVcZayH7suWBa8pnIIeA2AjJal
	eLcJm1ooZ/9OhB5AcsYNR3BRTqg1TFs8krNTIOAqSSL2UFjCWO9Hbl/adE1YnjUPsKz9Ft3iLsJ
	o/OLmAQ5kNG26AtGVgL5eSr3JKsgTtkHmqHIMnGHvew==
X-Gm-Gg: AY/fxX6xZyI6fMUvtsEHiLDR0nAyDxg0HAVMBNnuQXB82vhz2qXafehYUggxMJZQXRe
	3JXNiN2og764grL0gqJNYY4rQnUlQtVcTH4u2X6qpfa3sO2ukUbrovHcBgDscWnUYOqImzbfYxo
	q18yxlM3hZGHxQ47At/85OgMN+5GJbAihaCjC2369erHxX3aISAO0nY8z9I8LnprCvT659dcsTV
	N4O8nqkB8imI/SCKhjcrI1LBJ8ziRcG3lyzhckDum0QvRl6uklcR9hYbH1aYB4sbFpJ4Ebv6QjF
	LFjIHNiJOHoqf3chutymeihyLHS4A5TklU+/Ow==
X-Google-Smtp-Source: AGHT+IHj3ypPU/NNMfpdHkNAGLFnFzOTMM7fMEliuRPTtrZJWbtlqHPi8+SGGYOwkosOTrtDx//q+fuT7Iu+SWMNFCA=
X-Received: by 2002:a05:690e:14c7:b0:641:f5bc:6991 with SMTP id
 956f58d0204a3-64716c6e1admr15279346d50.77.1768272283353; Mon, 12 Jan 2026
 18:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-6-d492f3a30ffa@riscstar.com> <20260112-veal-retaliate-7cf9a2981aaf@spud>
In-Reply-To: <20260112-veal-retaliate-7cf9a2981aaf@spud>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 13 Jan 2026 10:44:31 +0800
X-Gm-Features: AZwV_Qgw5WUVzIip-0vximPTfFaT5zWrcbo35d-VZT71kic6QgdIU7i9b69aOEs
Message-ID: <CAH1PCMYgGVm1uJMjoxVkOMvPeRLsvybi7PW9k3sWyj3ij8c4Vg@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] dt-bindings: riscv: Add B ISA extension description
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, Andrew Jones <ajones@ventanamicro.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Conor

On Tue, Jan 13, 2026 at 5:41=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sat, Jan 10, 2026 at 01:18:18PM +0800, Guodong Xu wrote:
> > Add description of the single-letter B extension for Bit Manipulation.
> > B is mandatory for RVA23U64.
> >
> > The B extension is ratified in the 20240411 version of the unprivileged
> > ISA specification. According to the ratified spec, the B standard
> > extension comprises instructions provided by the Zba, Zbb, and Zbs
> > extensions.
> >
> > Add two-way dependency check to enforce that B implies Zba/Zbb/Zbs; and
> > when Zba/Zbb/Zbs (all of them) are specified, then B must be added too.
> >
> > The reason why B/Zba/Zbb/Zbs must coexist at the same time is that
> > unlike other single-letter extensions, B was ratified (Apr/2024) much
> > later than its component extensions Zba/Zbb/Zbs (Jun/2021).
> >
> > When "b" is specified, zba/zbb/zbs must be present to ensure
> > backward compatibility with existing software and kernels that only
> > look for the explicit component strings.
> >
> > When all three components zba/zbb/zbs are specified, "b" should also be
> > present. Making "b" mandatory when all three components are present.
>
> > Existing devicetrees with zba/zbb/zbs but without "b" will generate
> > warnings that can be fixed in follow-up patches.
>
> Are you going to send these fixup patches for other devicetrees? The
> majority appear to be other spacemit devices.

Yes, I will. My check shows that these three dtsi files need to be updated =
to
include the newly ratified "b" extension:

arch/riscv/boot/dts/anlogic/dr1v90.dtsi
arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi
arch/riscv/boot/dts/spacemit/k1.dtsi

I will start a follow up patch to update these dtsi files. Basically, addin=
g
"b" into both the "riscv,isa-extensions" and "riscv,isa" (when available)
fields.

Thank you for your review.

Best regards,
Guodong Xu
