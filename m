Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470830CD95
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395639; cv=none; b=BVJM9ElxaVC/9Hu76osf90YrdI9Hh1WC0O6nEEhCas5gOU2YMsxPMAeauXE34n1AcnDYfJ52I6LcsC+r17Y+5J9pejOelzpVfB1yEiv5Mv/BeEzgH2gU9obeWPi5aSjsLH1zkU1oG2JO1SJ1AdasJ2PQ/8GD8V5bMOn93mPCQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395639; c=relaxed/simple;
	bh=f3aAd8TRGvgzszWxZ6Ud1mmv3jorF91PLX3uVFKYvuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pI2zr1BBa6q19s+T/vswWwYpXeKoGka6IuL/KaoWYmk2auWVyknv3ydK+PDonmSmOL/HYKwoVzCLBYR8MUnCD/IqnlDiZ3YE4kAPC12vO03rCD/CIMxlhBjWB2JxgCXrwBPUuxWRxD99+nGYP5BdEe6gbctZ0e1vKwV8yO34cXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=zyG5EqIA; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="zyG5EqIA"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-644715aad1aso4416774d50.0
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 01:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766395636; x=1767000436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9JR9FWj1NW5H0iyl0VHxuC1HgCMCwXIwoDdNUbZEwk=;
        b=zyG5EqIAV5+afClVBqWa4ItpkDw05aFETmX6I99ZpK6uWLBbhZdtsAlRa/EXU115gq
         /UULI7aq2VcBVHLSQUFAsNCxpUhxnNSI2q/3u19efciM5Bu2/uA8J0jqDRO+AKCo3n8f
         TkjEvg2ZOtXFdiK8Y45r3FK7l6IKqcfl5ozKk3X2Ke74fPLSxlSQo0kP1bUXYN7VvitV
         p17lkgHfLcPQtLAcINKKvVupX8r1SGPrlBLbKDWZtIibVuDbUK0NkpZZAASJkoPCihYd
         ipHznlPZVlIRRiC/Z5OuFkBf4+uPp94iI2VCRQGkkDEdf3tsi2afdLdi7zmtOt/p0INl
         htOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766395636; x=1767000436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9JR9FWj1NW5H0iyl0VHxuC1HgCMCwXIwoDdNUbZEwk=;
        b=Y2Oa7AeartuAsa/eu+y7Z0yEzYNRS0GCiDXtVmBjjiVh6g90KETadgp5VQ0J2bAZ1l
         Mnc5x5wzCqup2fhYOkfTqZui7CRX0+E1dOOWVCXtlIw67s66QXprCI45pX+SVfN6XEXj
         EIN0iKK6JptdVESJ6qL3U3NEAkhcXyL8BdVtB671MmOysmHazoq/3wHxw+BYlp+zymuG
         g4c1CSrLzK2MuhNVhFF15PIOcg0JinqtbiI1mQCwYwqKRUD2Dy7adugqQ/7p/RlJvjLj
         nbaQdDfe+d1BjG3jSeM/GxYuEC5sMR0C7FFtC0nAvJOuRmalmYTzAaXMWkvXLd8h23yl
         OTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfSzlmBG2PbYZ6TdB3Xc26qQdHv5SJHM5yyTdWQtA1T2ATn7PzPotcx8geBjPYo8+l9OiaUUeDIlZ4kC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpwxQu+ydX/rnT7gmj+SmcDwI3YFJ1MbmluEv09N5+oNPuq/O
	LDxT3yo1hpx1VwNIbQZjyR5vT2jz77k9nEHxE7JIEOYipngXpzTLlwnNnnwqHJ/rhKLteVNt++n
	EEOVSUBxI/O5bXIePrphEALDTFh35f/Q81cgEXAQLQw==
X-Gm-Gg: AY/fxX68n3pWAwNzOaybBTWvxrx6RgVHtu5delEvQTmemiar+IxeKtZk4+TSMuj+gQA
	XZ63QsO35zjJQ8bUK/TpiHvlunAq81oAiy5b69ml3vFO04S1+g0W1aPMt+oBTriPHWhASv+mCZn
	sgnoL3vvVdD4aD0eWA9jYCORPBBsVK63zw98vwU2coKsil3RckJGwi9UAVBkOPY0T1ASmT2dzSW
	8s/2Yn7vSFTTR2SZCFp2lSoYJDTbXKAwiV15P1p2Mr0bngq449Zu8o3ESjFkwhEqAMv39vHS3Du
	zc6OLtJa+79R2VxlgDtrjAOP2KK2fhtlNxn5R4yJCE+w
X-Google-Smtp-Source: AGHT+IEopdaH4VEXup08bA/QV1AhBuiIpBK4mPcZpQfYrRFDnvPhOVpgLeIitUz/0ef9xzGYyIV1deEuXbqK8/M1Otw=
X-Received: by 2002:a53:d056:0:10b0:645:527b:bc25 with SMTP id
 956f58d0204a3-646632e04d3mr8907715d50.43.1766395636333; Mon, 22 Dec 2025
 01:27:16 -0800 (PST)
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
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com> <aUYOgl8ffcJ0Xfwg@pie>
In-Reply-To: <aUYOgl8ffcJ0Xfwg@pie>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 17:27:04 +0800
X-Gm-Features: AQt7F2rD9S1VFl45xvpftmdWgFdR_R_Ul403nTlRAGDTs5jIW1Osdpar_Os9kF0
Message-ID: <CAH1PCMb7aUNt7VnYiZF=_V4nVziM-A0JpAqmU26ezwgk36=kKQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Yao Zi <me@ziyao.cc>
Cc: Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
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

On Sat, Dec 20, 2025 at 10:48=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Fri, Dec 19, 2025 at 10:03:24AM +0800, Guodong Xu wrote:
> > Hi, Conor and Heinrich
> >
> > On Thu, Dec 18, 2025 at 8:56=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
> > > > On 12/17/25 08:11, Guodong Xu wrote:
> > >
> > > > > Specifically, I must adhere to
> > > > > Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus=
.yaml for
> > > > > properties like 'riscv,sv39' which stands for the extension Sv39)=
. If I
> > > > > add extension strings that are not yet defined in these schemas, =
such as
> > > > > supm, running 'make dtbs_check W=3D3' fails with: 'supm' is not o=
ne of
> > > > > ['i', 'm', 'a', ...], followed by "Unevaluated properties are not=
 allowed."
> > > >
> > > > If Documentation/devicetree/bindings/riscv/extensions.yaml is incom=
plete
> > > > with respect to ratified extensions, I guess the right approach is =
to amend
> > > > it and not to curtail the CPU description.
> > >
> > > Absolutely. If the cpu supports something that is not documented, the=
n
> > > please document it rather than omit from the devicetree.
> >
>
> ...
>
> > Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-complia=
nt
> > requires adding these extensions that are currently missing from
> > the kernel bindings:
> > RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
> > RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
> >           Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsatpa, S=
hgatpa
> > Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports them =
but
>
> Please note B is just the abbreviation of "zba", "zbb", and "zbs", all
> of them have been documented in extensions.yaml.
>

Yes, Yao Zi. I'll include 'B' in my next version, and add the schema check.
Thanks.

BR,
Guodong Xu

> > they are not literally documented in yaml.
> >
> > Is this approach acceptable to you? If so, I will proceed with submitti=
ng them.
> >
> > Thank you very much.
> >
> > Best regards,
> > Guodong Xu
> >
>
> Regards,
> Yao Zi
