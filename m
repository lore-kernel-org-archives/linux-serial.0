Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A9261B9C
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272703; cv=none; b=FjF1+MSOzG6th/6eLBovoAgCqTML10FPxvs9Az7HeSge9MT8BfgiF0MnAkuizFdhMxcQJnlhq4HU9LR+Xa3uQ1IdvjrYRxqpHRa5D8+v8V3T6hkYF6frV5RGJsoAW/rAAPbBTsz7BrYMvqrpuOby/Ac0QK9bZqgK+NJX5WvSaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272703; c=relaxed/simple;
	bh=ucRpV6w0bt2B3mlFHkbnKhNVeKaPi5p4NBMvpLeeRI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQ06VbGx8FEkPUBnOxUq2QywlIqGFnxjrYELMnf3rpDsLVg16PF/mpdK4Tgii+0jogBkyPwbOGUZTbhFDdjhnjfxDVbUVUK6El3PHGHrLuFbJwxnnAD/7VWZ7mans4obUWkdJnF4z1rGk0T0xLro+EHxLaN7kfexk3Gh99Ru6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=unriAT9A; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="unriAT9A"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6446fcddf2fso7205569d50.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 18:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768272701; x=1768877501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3EDLsI4gmCoGqH3Z2k2GRncDMxWHUvXOn29qxpSYSQ=;
        b=unriAT9A+UuJfMwrqZXlxNFtEvFk8rOgD2+2CBeXkISuKnPbaGfGFrkQkWXIggSV5u
         HyqIokkT6GNWa+j0BBgUsWjPx6DguHN2DxHZIeyUj32he9KkoW+2/yRoaAqRpuc34ZzH
         VewmEXQXd06LBmY1c+u1bPRYrqNzO5xhEm0nVrZqqf6xrO3Oqwdaw1icGR3ZOgk+6Feg
         cGfp25m0MY+RgX5nC3YVSQJMLg60nPE9pbTRawC1WWqTZ7bntrBWcNNk2hAeeossN58S
         60fBNTWuDeYkE0PBMmxQQ/ToZfZoQXaM6xlcBZWnnBxvpGQcQPly7ZLDFrggOyf+Q7Ko
         H5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768272701; x=1768877501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3EDLsI4gmCoGqH3Z2k2GRncDMxWHUvXOn29qxpSYSQ=;
        b=hTwkHZf7ZYOtpXHMppBbzH07aNPPqLU93Vp7irxpk/afkjvySYRyHp6dFOlzZe1JCV
         +abd6sYuXsmGOod5soTLwbi3IFCRLlrh1Ho5KYVbFmq8HzIVNEfXj3//RjtlK3xELWsu
         mgwzP9OSdYqazplreOJa0CFpul5MbaCSqI6WorGJMxXybcsbHRd0W0BzsOieJ+aUHyUe
         yWIIFvsJ/enCrLFSPUYFRZSo5rzfD3+sPP2nVsGQhlMErX3Pn0D73My37cOF+oEaCbu2
         givav7lNDaCSqXLOmmaWHpI5MyeTsJtewWDrWkDIM+U5TLOof4Sd0wSdNh9sa3Skd1Lz
         b0yg==
X-Forwarded-Encrypted: i=1; AJvYcCX0vg3aF6/ymv/ARDw6XAuZ8BwNYVxFuaF3fceWK3E1owBq6ytNw2PQQ/WlYLNZ22AHPHKWKOB3/ipaOxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/TL9ICb81nP2h/+Mrtbgm0ItaU2awrlnD24b8ZwfR14N3we7
	sTb7oY0amEzamfZOgoLFAmtlTdEWZCLfPchbKPtl3qsT27W7CmPgCc/qzRcgilKZ+worqwyKyjz
	zjmsa1K8n21/TXIGq66CsaELWlmynbqNsjxhjc8SX7g==
X-Gm-Gg: AY/fxX4A0O6Jb3deCNkbc4tvdBduuhCpgGgLLYHFY6g1oOqENmGZTP0CBi3nrLDUcCt
	q+aYsRMCj8M/Hwu3ccGhvYdhz1Quj3MQoKS5ZnStiXIzQi5DACxdGYy3AJdN6Cbeyw1+kOHlvRK
	7ucqmlYuvjjWJ3Jy3Ja4i4yhqx3vErdEoSV5INqD1hEFEkYrauJEIPcMDuoMj3489sqO45Tzz2l
	mJ12RCZrD2fz0SnTnI5pztg00qdtt7BieDu0h0yQdhFK2V64UXS8Aj+hVKpDBTvoocB4GUViZVj
	xBKT4OMivKbIop/Hvod0NF3Jb/CZzQbP9b/lSg==
X-Google-Smtp-Source: AGHT+IGY8QkMTn4FKDtsguPkPZlInIEAk3s30SOaRJ7i+o+AsKUMCFEY8+PBpcpdqGZl22WHl4ejg4hQ7dqsombF9rE=
X-Received: by 2002:a05:690e:e8a:b0:641:f5bc:6983 with SMTP id
 956f58d0204a3-64716c2c6eamr15484452d50.79.1768272701490; Mon, 12 Jan 2026
 18:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com> <20260112-shrivel-sarcastic-36d9acd2d96a@spud>
In-Reply-To: <20260112-shrivel-sarcastic-36d9acd2d96a@spud>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 13 Jan 2026 10:51:29 +0800
X-Gm-Features: AZwV_Qh6psUrOlkmdvJ5XMadMeDGqdGdDoMMCEqx-N5Umm_2TBrLFIEtUXleAvI
Message-ID: <CAH1PCMa_rGWJsNiu3dGiOBxF9df-RL6qyanoGde3YqvmfGLyxA@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] riscv: spacemit: Add SpacemiT K3 SoC and K3
 Pico-ITX board
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
	linux-serial@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:46=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sat, Jan 10, 2026 at 01:18:12PM +0800, Guodong Xu wrote:
>
> > Hi, Conor
> >
> > For the binding riscv/extensions.ymal, here's what changed in v3 (no
> > change in v4):
> >
> >  1. Dropped the patch of adding "supm" into extensions.yaml. At the sam=
e
> >     time, I will start another patchset which implements the strategy
> >     outlined by Conor in Link [2] and by Samuel in Link [3].
>
> Okay, that seems reasonable to separate out.
>
> >
> >  2. Dropped the dependency checks for "sha" on "h", "shcounterenw", and
> >     6 others. "sha" implies these extensions, and it should be allowed
> >     to be declared independently. Like "a" implies "zaamo" and "zalrsc"=
.
> >
> >  3. Enchanced the dependency check of "ziccamoa" on "a". Specifically,
> >      - added the dependency check of "ziccamoa" on "zaamo" or on "a".
> >      - added the dependency check of "za64rs" on "zalrsc" or on "a".
> >      - added the dependency check of "ziccrse" on "zalrsc" or "a".
> >     The commit message of this patch is updated too, to better explain =
the
> >     relationship  between "ziccamoa", "za64rs", "ziccrse" and "a".
> >
> >  4. Enhanced checking dependency of "b" and "zba", "zbb", "zbs", making=
 the
> >     dependency check in both directions, as discussed in [4]. Since "b"
> >     was ratified much later than its component extensions (zba/zbb/zbs)=
,
> >     existing software and kernels expect these explicit strings. This
> >     bidirectional check ensures cores declaring "b" remain compatible
> >     with older software that only recognizes zba/zbb/zbs.
>
> This I asked about in the relevant patch, I would like to know what your
> plan for adding the "b"s is.

Thanks for confirming the above. Yes, I will start a follow up patch to upd=
ate
the dtsi files related to the "b" extension.

Best regards,
Guodong Xu

>
> Spacemit folks, I assume you weren't planning on taking the
> extensions.yaml stuff via your tree? If you weren't, I'll grab it once
> the question about b is answered.
