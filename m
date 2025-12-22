Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0E30B50D
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766399586; cv=none; b=THUVAHGQBp2xnV+PWDkZP+pp6f+F0lZYlxX2gVcnsT+aKTQ39663hc9+g3XPTU/lIkPydVsdECtMv0BEXQMKiCMasWZn3RWcEWgvXxL1ghhFO27DxqYHNketrvWRK9hvzFjY1f0cIXQjDdNeG8ynrD1HkRvRnSZBSZL/QTiwnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766399586; c=relaxed/simple;
	bh=ihhp8bMDgIJqPrScN02hWbwazhMSfMq+SetcfZIMviI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe/DDMPwFO7hK79G0YDdUWtl4ht8zzhoT2BZcW28YN2g+e/9EAX5tjY9KYABfwKup9ywaIVPWpHswhY4Gla9DVCd31a6ReU2H61wLdRAPKKLnfa+TMmRIgkks68D4nyi+tJVinV/6OPGSpI6dCgmA9vEZO8bLkEe6AUCeB6cMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=TKr4Tt0u; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="TKr4Tt0u"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64455a2a096so2947309d50.3
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 02:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766399583; x=1767004383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ0SU/C2/oKhfWTKzkhs1nGoI5MFAeFhWmplQ9HQCxc=;
        b=TKr4Tt0u9wmraLPTuUJvBZE9tlSYd+Hqi7HlkNWpsL5jyvidcwJCBn6Chn9vFMh8OX
         bMrfDB8AX7UUMQQajvREy7GdjQH25C1ftDl4AqaFr7qAw3DEXSldemtlkQLN6JOQmLS1
         CteEoPs9mW4/wIHXqOptkYFhaojf5IWXRPhQWjpzqNIgxWHJdxcvfXG5bwxjt/xjTCOk
         Zl+18dwPFD8mwQakii/09NrQA3vgjYpqQXhF7HUaIOHDR0RZWyZqXBlxQDxRB3ih7FRi
         el6OTlzJGJNpvxNo2dUiIzcwbNUeayefc8JGG7h8KiN7tjqxysjBMUE5+/CTeyI9SJkn
         k2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766399583; x=1767004383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZ0SU/C2/oKhfWTKzkhs1nGoI5MFAeFhWmplQ9HQCxc=;
        b=TjCjA62sr+6dCeK2qVWY2MJfaOFylUmGiOR/omH6CX3ts2scCBBnC4o7ggKy3nxSbf
         upWwhGsk4khdnXTaqX4x0zFwTnN1Gf05uH6++TDBMwhXLj5Gdw9r3ryrOZY6YUDazh7O
         nP7uT5Ftq/4UJzLV33sPYLsTUnC4zf2kQDm6IyqkoW/9FH3gnCchWTejbmUBe19j3Qsz
         269mUWDgeRJxtvgRRFi67vJ86bCQkvILZ0cD21GrCRFd1xVNNcJInfGp122HK8lTKqVF
         r4KuYguZuVN4kWMPkc8kvEFzlgbOgSHqGAXv31gvEMwP04PwsHjUnlhNdgYI1Oskd1Ez
         4z6A==
X-Forwarded-Encrypted: i=1; AJvYcCV6iD7gp/UXiU6ookuLoVO4TOkTxOj1YAw5Mf/yg1rKey0HougADFRF0/Boh4qrH5T7v5RblbNqDgbfGjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WXjNh6xLw/inNYFJpz/LfmKD6rR0r+ng9fcO1IAcCn2xAFLn
	kr/V2FvTNJan+1//gE7KBkXMeoSlwOouvCNS6XK1gW/V5GWwF83/ZqBwzSXGbW0frZfJ2uMW8AU
	6Pzaalzm54MzdCZW7kdXH7KtE9/3zW4f5eJIEoRKCYw==
X-Gm-Gg: AY/fxX6KQAosl82DgKJNKJ68ZcCOdkC10H300NFEvu0C11cTtmTqnJ8nQ6sEW1FcvdX
	rnjMUoKVaq/72Pe3cIkcJ5fyUOGv5an2L85HGOYFw4IUX6XynQmxfQrUVIwEBXX0lDTCjrAVmBb
	F5SYUFYsUKpJ1Su7Na/vmJ6L3r226m5WpSrcOCkOl7H5f1W/wTUN8qObSsuQ0ZyaNtm1kYn5p/t
	7aOhWsWy8wmMWiOqSgLgT6aZ3ves14PgRFXaeGPC8xp2LvWhDF6siNxCjTH4TqyDsBsfGn9o+aC
	tJJ5XMzYy8IA4dTPejNQLR6KqG8gG3T2pkhRVPRV4fGJiePt1RFJceY=
X-Google-Smtp-Source: AGHT+IHqSiya5Umbgv2VxGxG9x9i1trhsH7NUVZ065ciZZb3qy1mhHOdemYINnIm8Q+mAKDGyPq9nLimncteuIce7dM=
X-Received: by 2002:a05:690c:2601:b0:78c:697e:738 with SMTP id
 00721157ae682-78fb3f37a5amr188030327b3.18.1766399583277; Mon, 22 Dec 2025
 02:33:03 -0800 (PST)
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
In-Reply-To: <4e4c9e7b-d95c-4157-94c3-b06002f94a48@canonical.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 18:32:51 +0800
X-Gm-Features: AQt7F2oSFOE7ZFGZpkCtU3yoYwoQ_PEUIGqA90_XBkS-5NyyoL-mIJR7aV4jufs
Message-ID: <CAH1PCMZ=-ONwVuOFLPLOXvW7GfiUsFDxXX8P+mSSvhgDrWTHUA@mail.gmail.com>
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@sifive.com>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Conor, Heinrich

On Sun, Dec 21, 2025 at 8:10=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/21/25 00:23, Conor Dooley wrote:
> > On Fri, Dec 19, 2025 at 10:03:24AM +0800, Guodong Xu wrote:
> >> Hi, Conor and Heinrich
> >>
> >> On Thu, Dec 18, 2025 at 8:56=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> >>>
> >>> On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
> >>>> On 12/17/25 08:11, Guodong Xu wrote:
> >>>
> >>>>> Specifically, I must adhere to
> >>>>> Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus.y=
aml for
> >>>>> properties like 'riscv,sv39' which stands for the extension Sv39). =
If I
> >>>>> add extension strings that are not yet defined in these schemas, su=
ch as
> >>>>> supm, running 'make dtbs_check W=3D3' fails with: 'supm' is not one=
 of
> >>>>> ['i', 'm', 'a', ...], followed by "Unevaluated properties are not a=
llowed."
> >>>>
> >>>> If Documentation/devicetree/bindings/riscv/extensions.yaml is incomp=
lete
> >>>> with respect to ratified extensions, I guess the right approach is t=
o amend
> >>>> it and not to curtail the CPU description.
> >>>
> >>> Absolutely. If the cpu supports something that is not documented, the=
n
> >>> please document it rather than omit from the devicetree.
> >>
> >> Thanks for the review. May I clarify one thing? Both of you mentioned
> >> document them, given the amount of missing extensions, is it acceptabl=
e if
> >> I submit a prerequisite patch that only documents these strings in
> >> riscv/extensions.yaml plus the necessary hwprobe export? Leaving the a=
ctual
> >> usage of these extensions (named features) to the future patches.
> >>
> >> To provide some context on why I ask: I've investigated the commits & =
lkml
> >> history of RISC-V extensions since v6.5, and I summarized the current =
status
> >> regarding the RVA23 profile here:
> >> [1] status in v6.18 (inc. v6.19-rc1):
> >> https://docularxu.github.io/rva23/linux-kernel-coverage.html
> >> [2] support evolution since v6.5:
> >> https://docularxu.github.io/rva23/rva23-kernel-support-evolution.html
> >>
> >> Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-compli=
ant
> >> requires adding these extensions that are currently missing from
> >> the kernel bindings:
> >> RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
> >> RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
> >>            Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsatpa,=
 Shgatpa
> >
> >
> >> Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports them=
 but
> >> they are not literally documented in yaml.
> >
> > I don't think Supm is suitable for devicetree, doesn't it describe
> > what the kernel/userspace are capable of rather than hardware?

I see your point. While the Pointer Masking spec (v1.0) does distinguishes
Supm (and Sspm) as extensions describing an execution environment, it also
states these are intended to be used in profile specs.

With RVA23 ratification, Supm is formally included as a mandatory extension
in the RVA23S64 profile.

If riscv,isa-extensions property is the standard way (and I believe it is)
to describe a RISC-V CPU about its compliance with ratified profile, then I
believe Supm should be included in the YAML binding, alongside other
extensions.

> > Zic64b doesn't sound like hardware description (so not really suitable
> > for devicetree either) but block size information is already represente=
d
> > by some existing properties (see riscv,cbo*-block-size in riscv/cpus.ya=
ml)
> > and duplicating that information is not really a great idea.

Yes. Thanks for clarifying this.

Even Zic64b can be add, then some kind of schema check should be implemente=
d
to avoid the potential and possible mismatch, and ensure
riscv,cob*-block-size in cpus.yaml are 64 bytes. Duplication is not good.

> >
> > I'll admit that I do not really understand Sxstateen and how they work,
> > but my understanding was that knowing about Smstateen is sufficient and
> > implied Sstateen, but having Ssstateen defined seems harmless and
> > possible. I think kvm is the only user of this at the moment, so
> > probably worth CCing Anup and maybe Drew Jones on the patch adding
> > Ssstateen to make sure it makes sense.

I will Cc them. Thanks for your advice.

>
> Supm is described in
>
> RISC-V Pointer Masking
> Version 1.0, 10/2024: Ratified
> https://raw.githubusercontent.com/riscv/riscv-j-extension/master/zjpm-spe=
c.pdf
>
> The interpretation taken by QEMU has been:
>
> * Supm implies Ssnpm and Smnpm
> * RVA23 capable machine models display it in the device-tree
>
> If Supm is not shown in the device-tree, software might assume that the
> system does not support pointer masking in user mode and is not RVA23
> compliant.
>
> Hence I would suggest:
>
> If the X100 cores have Ssnpm and Smnpm, add Supm to the device-tree.

Thanks. Heinrich.
Let me add Supm in my next version.

BR,
Guodong

>
> If the kernel does not support user space pointer masking, the kernel
> should filter out Supm and not announce it, neither in /proc/cpuinfo nor
> via hwprobe.
>
> Best regards
>
> Heinrich
