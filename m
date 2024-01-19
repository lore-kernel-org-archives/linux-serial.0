Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60ED3C467
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658975; cv=none; b=ML8r3yEPN+mt9zGP6TqhKdYLdMny3mvcZYwZKfHCSMxBcvvUK2abX+BUre9MeuwqNYj+kW6M4TvwpUkyqRIEG/en3nXX6IMQNA0jt2yOGwTLpBhNnuoBQpfG+/YEpr+gC7NcFZKE+JRT1ukMy+Jo/fO6vhnNPeaUB7G+2AJpb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658975; c=relaxed/simple;
	bh=lUAVtgaJ0bprSpHAgPNiOEqKghOV7Hz56cuKVazrV94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTM5qrni2eNeFHQ5p9C9l8tiCEsUNHgAj0qP7vhl6nbb8rF+HsomGU+DC50EuZeiDCISOeISsJok1e5wZkRDaXMMFrwXyqJ7wvl+qSbYopzo6H8KHWpwxHfHmmpZiuY2k66z9SHGBviRebhaC56hOnj/DEGoHFDIdDgYHY/7FPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lWjBuygq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lWjBuygq"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e766937ddso672792e87.3
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705658971; x=1706263771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nujauiSJ02Zrdg5BkB4mk+zSnAXh7vp4Jlf9tWWb5Vs=;
        b=lWjBuygqNVUOHlk0jA9ECKf2TejBawZF8S6inNweMf/aS6+Xo6nCgovYXILIT3y9E6
         lIyHFS0Evrm1xLCo+v7lMbDKdPjTtijXIwPEayC5+63PeiT/ZKAdF+gzgjPF/enZHPIJ
         HjFDrKpFvyRcEdGAKF+abgRS5JR9eJc/Q6Ag+mJgOzqhdpuOIRIqIStn1sMsZLrv+pFC
         u9/Yb0IaOYAAAlAz32F6y6f5wrvuydJyKEl0H7RyNLwMHn3Nf0S17smCcCAiodg6p9+l
         nHAvSrdLLvVsWMVrqtaBYfnZY8IAwriIwKG1rYapUZ+Wk63E4wqftwliykp4d/IKtbQH
         MDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705658971; x=1706263771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nujauiSJ02Zrdg5BkB4mk+zSnAXh7vp4Jlf9tWWb5Vs=;
        b=HUJuaYFcHTUVaxinCjca/Ga5lOxiUtYLGm1sdNUhPGmnZYa9ydZSq78scgk44rm7BD
         cQ5JSVfdwAZL/SmpzCo00n90jPWtlChdW9+CeBoVSkLMYEpLWr44+kgfFmpmAKvIRnUD
         BTUgOaFEH4PHZ5MFCwCghxIi02cn1uCe0idKTaHUye2nzhucypn7ZuFQqsqA6p93hi3M
         YGXyFbLYj0p66gWM5oKe09Mhl4pTB7Wj39s4LMvy6JM7blQkQ+2TxQBLRhW/0wbpE5RB
         QTJPl+ileVYkX3+lBFgk3JpivCqr7dDE1VJFlvQTFytt4KfoVbWG3VTCERZxYxLl6UbZ
         RJVg==
X-Gm-Message-State: AOJu0Ywo+vUGpSMbNQjFuAKMb6GK+figPQ3d9PI9rOWZgi1La2i/9jfI
	MnzxBkuQd2iQYqIOY7WJHgnLp2jwanTR7b0em+kFGxmpMTiEaD7y4h86zzixnPzoMnP7Oj12vVl
	pboigo/Trdp49f3vAlmML1Tlz3fnV+3zoH7gKzA==
X-Google-Smtp-Source: AGHT+IHa/MIEYQlMLAmgsbbIMQodojNHus//+YiXCwZclJTJDmp0EnnAZVroAF6CDUc971U4uLo9+++Hzxp9zvHBhpo=
X-Received: by 2002:a05:6512:1328:b0:50e:e557:f1c4 with SMTP id
 x40-20020a056512132800b0050ee557f1c4mr675944lfu.0.1705658970552; Fri, 19 Jan
 2024 02:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170498463783.20080.10723421328706946354.git-patchwork-notify@kernel.org>
 <mhng-2a34d0e2-170f-47a5-a688-ab454a70f06b@palmer-ri-x1c9>
In-Reply-To: <mhng-2a34d0e2-170f-47a5-a688-ab454a70f06b@palmer-ri-x1c9>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 19 Jan 2024 15:39:18 +0530
Message-ID: <CAK9=C2UV8J52a1pZjsNpFNwpUKn5K3nhS-+bS-3pohDwi3HrfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] RISC-V SBI debug console extension support
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	jirislaby@kernel.org, Conor Dooley <conor@kernel.org>, ajones@ventanamicro.com, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 12:00=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Thu, 11 Jan 2024 06:50:37 PST (-0800), patchwork-bot+linux-riscv@kerne=
l.org wrote:
> > Hello:
> >
> > This series was applied to riscv/linux.git (for-next)
> > by Palmer Dabbelt <palmer@rivosinc.com>:
> >
> > On Fri, 24 Nov 2023 12:39:00 +0530 you wrote:
> >> The SBI v2.0 specification is now frozen. The SBI v2.0 specification d=
efines
> >> SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
> >> functions sbi_console_putchar() and sbi_console_getchar().
> >> (Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/rele=
ases)
> >>
> >> This series adds support for SBI debug console (DBCN) extension in
> >> Linux RISC-V.
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - [v5,1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
> >     https://git.kernel.org/riscv/c/f503b167b660
> >   - [v5,2/5] RISC-V: Add SBI debug console helper routines
> >     https://git.kernel.org/riscv/c/f43fabf444ca
> >   - [v5,3/5] tty/serial: Add RISC-V SBI debug console based earlycon
> >     https://git.kernel.org/riscv/c/c77bf3607a0f
> >   - [v5,4/5] tty: Add SBI debug console support to HVC SBI driver
> >     https://git.kernel.org/riscv/c/88ead68e764c
> >   - [v5,5/5] RISC-V: Enable SBI based earlycon support
> >     https://git.kernel.org/riscv/c/50942ad6ddb5
> >
> > You are awesome, thank you!
>
> Nathan points out that this has some semantic conflicts with a patch in
> Greg's TTY tree: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/t=
ty.git/commit/?id=3Df32fcbedbe9290565e4eac3fd7c4c451d5478787
>
> So I think the best bet is to wait on Greg's patch to land in Linus'
> tree, and then base a v6 of this patch set on that merged patch.  I'm
> going to drop this one from for-next.

Greg's patch is now available in upstream Linux so I will rebase and
send out v6.

Thanks,
Anup
