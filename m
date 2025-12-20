Received: from mail73.out.titan.email (mail73.out.titan.email [3.216.99.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697A158535
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766198940; cv=none; b=RQqX4VWVWesXRSKinqfg6sTKnAwhAo4DNSj9vT0SPP3s9XhHelRWDHMQDqArdWBF8g3bztm+YbaegUdCMIdTWeRzMcTSjcitHl2aTuTRLMzka5U094Cgll39hmremSeHCaOH+qH0gtOv9yGJGZy71CMSrsDDIUxPT/SRmrx5tL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766198940; c=relaxed/simple;
	bh=m2Ah9/mD8Z6fhlkypXmz8p9HUX/8q/HEg/WIFvEGCzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHwA0xP0XNKRY65NZEOmPCYMsnf1dY07ReU6tqofbPr/EhaL2Mlo1QgO8LrcUwBwPvbgKQLl+RAEJXdpcL4jurCYduHcwX1O7A8r7CGI1eIRBfDNPYyXmhG60/uPkr3cf/fREpjPV887aEy4O7R4JHEg8+ID5CM42nCdeqd/N2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=M/f85/qf; arc=none smtp.client-ip=3.216.99.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="M/f85/qf"
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dY8440vgrz2xCv;
	Sat, 20 Dec 2025 02:48:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=9hs/mZnXRigs3cVOr+/B8POWZbewDtqV2rmBsfTbDWM=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=cc:subject:date:from:references:in-reply-to:to:message-id:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1766198932; v=1;
	b=M/f85/qfW08nQRYIBpNbEjp184VrhycoRo3YXYO38q7f3n7nA//0VcqX6P/J9dnUzGg7tnxO
	OZbcKlq9JtraIdn5MVcsNpMbYnukrAmaF2FSHLFM3s3csWhorlZTS34g0fHsaT+aHTFFEeQlJ+3
	Z+epGopsLFMpYwU6lW0HACvA=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dY83v45t9z2xB2;
	Sat, 20 Dec 2025 02:48:43 +0000 (UTC)
Date: Sat, 20 Dec 2025 02:48:34 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Guodong Xu <guodong@riscstar.com>, Conor Dooley <conor@kernel.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
Message-ID: <aUYOgl8ffcJ0Xfwg@pie>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
 <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
 <20251218-basil-quantum-225ce16e4699@spud>
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766198931978633735.27573.7898649982977667917@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69460e93
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=jDTaAnbEAQuvd0Yd3F0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
	a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22

On Fri, Dec 19, 2025 at 10:03:24AM +0800, Guodong Xu wrote:
> Hi, Conor and Heinrich
> 
> On Thu, Dec 18, 2025 at 8:56 AM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
> > > On 12/17/25 08:11, Guodong Xu wrote:
> >
> > > > Specifically, I must adhere to
> > > > Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus.yaml for
> > > > properties like 'riscv,sv39' which stands for the extension Sv39). If I
> > > > add extension strings that are not yet defined in these schemas, such as
> > > > supm, running 'make dtbs_check W=3' fails with: 'supm' is not one of
> > > > ['i', 'm', 'a', ...], followed by "Unevaluated properties are not allowed."
> > >
> > > If Documentation/devicetree/bindings/riscv/extensions.yaml is incomplete
> > > with respect to ratified extensions, I guess the right approach is to amend
> > > it and not to curtail the CPU description.
> >
> > Absolutely. If the cpu supports something that is not documented, then
> > please document it rather than omit from the devicetree.
> 

...

> Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-compliant
> requires adding these extensions that are currently missing from
> the kernel bindings:
> RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
> RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
>           Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsatpa, Shgatpa
> Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports them but

Please note B is just the abbreviation of "zba", "zbb", and "zbs", all
of them have been documented in extensions.yaml.

> they are not literally documented in yaml.
> 
> Is this approach acceptable to you? If so, I will proceed with submitting them.
> 
> Thank you very much.
> 
> Best regards,
> Guodong Xu
> 

Regards,
Yao Zi
