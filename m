Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB718BC3D
	for <linux-serial@vger.kernel.org>; Fri, 26 Dec 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766732006; cv=none; b=Bcp5VUAaptb6CsrRxsIBl168rqN039rgW6UVWivbXRm1RxW2Xghm1DtmR+0f/SkdremzYAduQsWfmDiyz4bE4V9WxJ5a/Cg3RkDQUgKU5gL4+aMiOPGRdZB2c1GyIA0/jpnprBpDxFG8B8BRa2ed41JjapOA/mJHADV+58wa9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766732006; c=relaxed/simple;
	bh=i8oMWMGJPsjm3Nw9AzoIzlGlrHPCVzUdZaegTERxqYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nx5mhp+4uYrWyapavUrmXVShdCLpOH7LvEgrvPf5gcNKvHaVEZBMYyqoKrO6f+bpyPSU1S2cqfHD8yIS3G0vR7n6bI+PVYAus6UIta2zZ5lZ1ns3GfynwsxAj24lAQIltuusV1tlrthp4t1hrfCRPMHE2b+McG25J0zli/2W4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZE9ni8IG; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZE9ni8IG"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso5873789d50.3
        for <linux-serial@vger.kernel.org>; Thu, 25 Dec 2025 22:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766732003; x=1767336803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In4D9uIw9WRI5SeupWLx7/A1v5eMK/I9jTjhCEC0gVE=;
        b=ZE9ni8IGRF1n70N5ZtJVE8zclyXDxu6fosyVDkyBnMimUKMtQBFTCh1hdxqZrzJhxZ
         B5/ceslTX1cD9jJf2Ja+yjnHNiPNq9Bw+uW53dbt3iY+8F9AxZRNNz1M8o8PEh+ETxKd
         Vlomq/bW0uVM1KL9m4FNj7qyevwwUGFDzOkMzyRyUNN9E+TTM1Qj4T2cDrgCJNWF/QHM
         nRV850h+AYEfDvcHdezrGV8L0gzdO+EEK524gETKjabt0qwJzp1oIkJyySpQaHq4oVMc
         pCxFqj6wXOzR2s11lEtNJDApIO8+GTEsOC60dbpFDnAk/UyPJqTejwNMTH2hVqg1kBsg
         4W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766732003; x=1767336803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=In4D9uIw9WRI5SeupWLx7/A1v5eMK/I9jTjhCEC0gVE=;
        b=Y/W0JXHH430T1eTn0OGpr5wVWJSk2ejvIqV37vUjyjZKiumD9PqYuydDFpG/Hy38fW
         ceYy5MPymI7I2Hh//EJIpvBIbaTHa/XQNZ7kvcg4VoH/TAmJMx/H8htWmtip0UnaDVQD
         atJ/F++yrpv5VCxcKDdRiC4sWur/QyWAfzfa86RHLuw2yetKG+Pp9LjpUDXUCnaq+xUY
         C8RszxB+Z/VpkNWz6S55EWmeuKobHhEXGxU0NRh7orHLZdqRTcRktsTawb3GBf66K40j
         Yy2+ZG7ksqsBgEhOz8zINHYJlei2urg9ibhToCT5U9Au56S+ryR23agXwBmld1UWZ/Ij
         XnkA==
X-Forwarded-Encrypted: i=1; AJvYcCWhcmPTWPCbYit2n3iindRdfq80TZdQ3TorWFbE+XoVmiUwdOTYNextpQaDXUJ5NGyOGf2aTWDZK/pSTRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7vylZafSuGnFQ9wLCpirAsmGWiDuvrIclsp1h8+mw31JLVlY
	7TYvuSN91b4A7m+fCXl5CwMnEbg5No41jyhYEIwC25CBhnmDg8Ad5PLSRJNU5Fg0KodXaLiH0UN
	jGFMbH8UP/yWg2WU1SDPYmuQnl+mc11NZ17wZx+5o5Q==
X-Gm-Gg: AY/fxX5AMPEnANOP9YrQz/9/5v3a/yEZS8vw8yXgNIuIRCddkdukE1I4Sy53IhrAUd2
	3aL+pn0xqp5A8J9VsG+EFt2tHn8k8xUQbW1jBxGNhKlDgeDXPTWalYCoz+urQ1n9/+GOOjIRdUJ
	Bqj/294CJw56NVUC36gZ+SetZQ4p6KsSDU9+Q0uDaYesME8aIL6hXhew6n/Ed8DprCPvAnPOZjn
	KlRPZxUgmlzDywzo/iWP3L+OrCvMNmY+5JekYhc7A1WkeMaeo7I+icBki+RhN3EScd5M37WSfI8
	WxHHIOUncwl11rJ6uzVmP9DGs/ngh+94JJChins+
X-Google-Smtp-Source: AGHT+IEykdaZ4Rha9W0iaPgKCHo3kRALkhoNrPmt5lxv9NvuluuvBnDgd6routLnDG3edhTl56BVVI71jDU66ZvrElQ=
X-Received: by 2002:a05:690e:1a08:b0:644:5bba:e497 with SMTP id
 956f58d0204a3-6466a871e61mr13684712d50.38.1766732003513; Thu, 25 Dec 2025
 22:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com> <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com> <20251218-basil-quantum-225ce16e4699@spud>
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
 <20251220-repacking-football-c79e660e788a@spud> <4e4c9e7b-d95c-4157-94c3-b06002f94a48@canonical.com>
 <20251222-dimmer-wooing-db29fe925498@spud>
In-Reply-To: <20251222-dimmer-wooing-db29fe925498@spud>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 26 Dec 2025 14:53:10 +0800
X-Gm-Features: AQt7F2rBtU4YKSmnk202JjvlyhsDSwcTDORz2f5ucxaceC-cTv-SHH-Q_N8lHTA
Message-ID: <CAH1PCMbane4uN=N0UPRDG9x9NUbD9SYsbH+NnP-gzU6Bo8L2wQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Conor Dooley <conor@kernel.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 4:36=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> Heinrich, Samuel,
>
> On Sun, Dec 21, 2025 at 01:10:15AM +0100, Heinrich Schuchardt wrote:
> > On 12/21/25 00:23, Conor Dooley wrote:
> > > On Fri, Dec 19, 2025 at 10:03:24AM +0800, Guodong Xu wrote:
> > > > Hi, Conor and Heinrich
> > > >
> > > > On Thu, Dec 18, 2025 at 8:56=E2=80=AFAM Conor Dooley <conor@kernel.=
org> wrote:
> > > > >
> > > > > On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wro=
te:
> > > > > > On 12/17/25 08:11, Guodong Xu wrote:
> > > > >
> > > > > > > Specifically, I must adhere to
> > > > > > > Documentation/devicetree/bindings/riscv/extensions.yaml (and =
cpus.yaml for
> > > > > > > properties like 'riscv,sv39' which stands for the extension S=
v39). If I
> > > > > > > add extension strings that are not yet defined in these schem=
as, such as
> > > > > > > supm, running 'make dtbs_check W=3D3' fails with: 'supm' is n=
ot one of
> > > > > > > ['i', 'm', 'a', ...], followed by "Unevaluated properties are=
 not allowed."
> > > > > >
> > > > > > If Documentation/devicetree/bindings/riscv/extensions.yaml is i=
ncomplete
> > > > > > with respect to ratified extensions, I guess the right approach=
 is to amend
> > > > > > it and not to curtail the CPU description.
> > > > >
> > > > > Absolutely. If the cpu supports something that is not documented,=
 then
> > > > > please document it rather than omit from the devicetree.
> > > >
> > > > Thanks for the review. May I clarify one thing? Both of you mention=
ed
> > > > document them, given the amount of missing extensions, is it accept=
able if
> > > > I submit a prerequisite patch that only documents these strings in
> > > > riscv/extensions.yaml plus the necessary hwprobe export? Leaving th=
e actual
> > > > usage of these extensions (named features) to the future patches.
> > > >
> > > > To provide some context on why I ask: I've investigated the commits=
 & lkml
> > > > history of RISC-V extensions since v6.5, and I summarized the curre=
nt status
> > > > regarding the RVA23 profile here:
> > > > [1] status in v6.18 (inc. v6.19-rc1):
> > > > https://docularxu.github.io/rva23/linux-kernel-coverage.html
> > > > [2] support evolution since v6.5:
> > > > https://docularxu.github.io/rva23/rva23-kernel-support-evolution.ht=
ml
> > > >
> > > > Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-com=
pliant
> > > > requires adding these extensions that are currently missing from
> > > > the kernel bindings:
> > > > RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
> > > > RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
> > > >            Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsat=
pa, Shgatpa
> > >
> > >
> > > > Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports t=
hem but
> > > > they are not literally documented in yaml.
> > >
> > > I don't think Supm is suitable for devicetree, doesn't it describe
> > > what the kernel/userspace are capable of rather than hardware?
> > > Zic64b doesn't sound like hardware description (so not really suitabl=
e
> > > for devicetree either) but block size information is already represen=
ted
> > > by some existing properties (see riscv,cbo*-block-size in riscv/cpus.=
yaml)
> > > and duplicating that information is not really a great idea.
> > >
> > > I'll admit that I do not really understand Sxstateen and how they wor=
k,
> > > but my understanding was that knowing about Smstateen is sufficient a=
nd
> > > implied Sstateen, but having Ssstateen defined seems harmless and
> > > possible. I think kvm is the only user of this at the moment, so
> > > probably worth CCing Anup and maybe Drew Jones on the patch adding
> > > Ssstateen to make sure it makes sense.
> >
> > Supm is described in
> >
> > RISC-V Pointer Masking
> > Version 1.0, 10/2024: Ratified
> > https://raw.githubusercontent.com/riscv/riscv-j-extension/master/zjpm-s=
pec.pdf
> >
> > The interpretation taken by QEMU has been:
> >
> > * Supm implies Ssnpm and Smnpm
> > * RVA23 capable machine models display it in the device-tree
> >
> > If Supm is not shown in the device-tree, software might assume that the
> > system does not support pointer masking in user mode and is not RVA23
> > compliant.
> >
> > Hence I would suggest:
> >
> > If the X100 cores have Ssnpm and Smnpm, add Supm to the device-tree.
> >
> > If the kernel does not support user space pointer masking, the kernel s=
hould
> > filter out Supm and not announce it, neither in /proc/cpuinfo nor via
> > hwprobe.
>
> Samuel seems to have some specific thoughts on how this works, given he
> didn't blindly implement ssnpm and smnpm, but has made supm be mode
> dependent and not permitted in dt, hopefully he sees this.
>
> Personally I'm not convinced that putting supm in dt makes sense, but
> instead the kernel should imply it if the sxnpm extension matching the
> mode the kernel is operating in is present and RISCV_ISA_SUPM is set in
> Kconfig. That's effectively how it works at present, except it'd involve
> promoting RISCV_ISA_SUPM to a "real" extension instead of being a macro.
> A validate callback should easily be able to handle checking the
> mode and whether the Kconfig option is set.

Hi, Conor

As we wait for Samuel to share his opinion, maybe I can submit a patch in
(I already have it)
my next version or as in a different patchset to implement what you suggest=
ed.
 - Assign RISCV_ISA_EXT_SUPM a standalone ext number in hwcap.h
 - Implement a riscv_ext_supm_validate() and put it in the callback of both
    ssnpm and smnpm.
 - Kconfig will be kept as a top level gatekeeper, no change.
 - dt-binding entry for supm will not be added.

The only reason support me to add sump into to the dt binding
(extensions.yaml) is it's now a mandatory extension required by RVA23U64.
However, as you explained, that logic seems not strong enough.

Thank you.
Best regards,
Guodong Xu

> That way it would get exposed to userspace using the actual mechanisms,
> reading the devicetree itself from userspace is not a valid way of
> checking what extensions are usable after all.
>
