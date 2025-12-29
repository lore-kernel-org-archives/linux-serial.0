Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A91624E9
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766970525; cv=none; b=nDVbjgV45MRhaDxi4X2l3T4xaa2WCHXSVPu7cJXSR6bCEApJqUZpDM8ph5BDd2vzfdoARdeK0E3rKREnGeVrCLQRnnrAErfJu+QUbfzkg47MDdSVNmbjxDbXmwqnMRRbmNq+hKoZzpOemKilg3tY37FHHBaBNAI0VkAKGvNVCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766970525; c=relaxed/simple;
	bh=f8xb7f7Wc6cleIreUIT0R3KFYnTxJ7Zn4E5sKYJ6J/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfbR2rxdSLHQNYKqqi6Z7wRPArFzbF4mqGgu9YUl3GhJACgzkOzSGzxikHhM+METswFYlG33oAu7dwFrnegGirhN+Wo79n+wW50z55FslAhOwFNFIrsNGKwW/MLl1j/1LdIa8GG8wX4ghHafiS/k0oIDgtgF4LN2dz4Shge4Pm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=m8Ttw+Ty; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="m8Ttw+Ty"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787da30c53dso81638047b3.0
        for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 17:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766970521; x=1767575321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UE85kVGf+q8GmraHlXZAv1blLIu7cHa4ZcemBTV+hE=;
        b=m8Ttw+TyKjH9U+HMyMNR+M8wgMwLaMUG+DgCB3WpJumdxLxKcSvKCasHdZDthzGSR2
         mIGgeFP80wmFmV04fX28rtiErLIITFyA825hCxKYPyA2OkjAYfsPkzPTLoWfIIaHHtMJ
         VyeUk+z0pNtotYaGCgwOg1AWcCfjcsq8Xr0Vm/xFlPX8fAHfaW2hrMhPLfA1N4glKvlr
         4WcV48TQJnycpwjPIiinvmyDhVUgX5iqMvJ/rr3mOQxqy8Usb9hCitylJOlhxdV3e2Hv
         heTRspCj5kbkHJLkcM8VqpZvCXojl5k0zvk2Sd8dieJLeELMoMrf5OJsclDc91OvHOVM
         JmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766970521; x=1767575321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UE85kVGf+q8GmraHlXZAv1blLIu7cHa4ZcemBTV+hE=;
        b=HwrgLPLjeJgNpT3vtN9x7mPDV2M8r4/ugJKXZUyrwdSkvIsRK3VDQjQbYjVE+4q1Jo
         npUwwOwNXlIvT9gcZVJEjOkwKvleeaBeyxQT/QbCTNOakIJvoWNcfYCzAVkW0rK2Yz4N
         8PLRTym/iCT9JB80wAAljdTEbulFS0ExCwKqIdegLGAFGPL8UUy0GV0so1PkddoVkl9t
         Zl2rdcNleYAGAD6lSZTiB/eNuX91ALAkxd3P21jf0MBdrmltlWx5oSduUIwRXCV55Rpm
         8Y4KfaPAnJ2Y7j7Gb/WvN3YYxD75E7I7XsnaYRwoZXoSoqO6XAeShqivkrg2lHCVYhU5
         lv7A==
X-Forwarded-Encrypted: i=1; AJvYcCUS8LoRAr1t35VR2soo3tVdL9kqn5kak2Zufl3JdRXFZyQy8l3WiFZAMgH/HMYI/aSL/wzVu9J3ca4XKzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UF6SrBa629pUeAhMhSBAWoCEQo5y1Ur14S2SplE7ywTyCT4A
	7voTv8dBd4PxM2si6n36JMen+Sto0JlB6/fejqHhq3yvkglRcQGiBpdek+IWf0wZLLBVnEcXpHs
	whv+xH6Xv0dxPt+XJJtYlN5RadjHesUrlDXmSUkiklQ==
X-Gm-Gg: AY/fxX7OS8EMCIYSXXqbEcoE5ZNmKVK+mSIsociTC9G6LQMXDSol1+CATXBxdg76AIR
	IwMDuvpGl9zLi9zIGpfA08j3ezaUpIE5CeEaZ/GlCp9JtzGebLsPVp7SM4i83IOagoaeRiuf8DI
	ZkGuADXuDnQeNmVALp7COscnKMKpUye8XXxI0Ua40tIO4d7twCnB8XHajaedE5pP3o0JMMO/HyA
	L+Y7hJfzbc5uw0xMJNujteSocvIUCB4fnDdX7seVjmxUC2RM5jmSU+XB6d6cw82/hWQrtiVMXvZ
	5NC01jzELw6NeKCaj8sfG4WnrQrK58LAkuYBe82b6JOl
X-Google-Smtp-Source: AGHT+IGlhu2CzzIyPT/4Xs4SuTdCSDyVQF/LBTPCx5u8EgG/qGO3ektOwcMaY7F0RocF4UkJ/Asz5Nn328g1rSwFXmQ=
X-Received: by 2002:a05:690c:6186:b0:78f:a615:2739 with SMTP id
 00721157ae682-78fb418785cmr210976517b3.55.1766970521358; Sun, 28 Dec 2025
 17:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com> <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
 <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com> <CAH1PCMbBURb=DpChf+Y-DjYjzpXG-pKgoaHAu=TUuG4oVC56cg@mail.gmail.com>
 <5979c8ef-b0fa-40c8-944d-96e226fbcbe8@riscstar.com>
In-Reply-To: <5979c8ef-b0fa-40c8-944d-96e226fbcbe8@riscstar.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 29 Dec 2025 09:08:30 +0800
X-Gm-Features: AQt7F2pCBTgDDH1FNzfMutsdekE-nmpYuROoap71sR-N9Z3O3k31kEU3EyBRcKQ
Message-ID: <CAH1PCMZkQ11-Uk5GnyetLkNLOuO3gs2o0WPWHrFMWVH9R6s8mQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension description
To: Alex Elder <elder@riscstar.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
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

On Mon, Dec 29, 2025 at 7:50=E2=80=AFAM Alex Elder <elder@riscstar.com> wro=
te:
>
> On 12/27/25 8:51 PM, Guodong Xu wrote:
> >> That's what I understand it to mean, anyway.
> >>     https://github.com/riscv/riscv-b
> >>
> >> There's no point in supporting "b" in devicetree to represent
> >> the others if it also requires the others to be present.
> >>
> >> I think that, instead, "b", "zba", "zbb", and "zbs" should all
> >> be allowed.
> >>
> >> I might even go further and harden the requirement, saying that
> >> if you specify "b" you should*not* specify "zba", "zbb", or "zbs".
> > Historical reasons here. "b" came too late. The chip vendors have publi=
shed
> > cores with "zba", "zbb", and "zbs"already.
> >
> > That's a migration bridge to require "b" must be listed
> > together with the other three.
>
> Are you saying "b" has already been included with "zba", "zbb", and
> "zbs" in an existing DTS file?


The risc-v ratification timeline is:
"b" was ratified in Apr/2024, which is about 2 years later than its
components zba/zbb/zbs (these were ratified in Jun/2021).

I can do this in linux kernel, writing a dts file which contains only "b",
but no zba/zbb/zbs. The linux kernel can correctly extend "b" to zba/zbb/zb=
s.
ps: after I or somebody adds the logic into cpufeature.c.

However, the problem is with the older software who reuse kernel's DTS file=
s,
and recognizes only 'zba/zbb/zbs'. (If you search in the riscv/boot/dts,
you will notice a lot platforms supports zba/zbb/zbs.)

When there is only "b", these older software may just disable the features
related to 'zba/zbb/zbs', because when they developed their feature,
"b" doesn't exist yet.

Hopefully I explained the logic clear this time.

BR,
Guodong

>
> What I'm suggesting is that (unless someone has already done this in
> a DTS file), there is no reason to require "b" *and* the other three.
> You should allow either "b" *or* all of the other three, not both.
> That would support older platforms as well as newer ones that use
> the more concise "b" only.
>
>                                         -Alex
