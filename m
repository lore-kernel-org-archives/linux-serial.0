Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931152F25FB;
	Wed, 14 Jan 2026 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356852; cv=none; b=fCTrpqWSET96IvNsgju+lfukHlqtvUWLafc1RWcUMVZibrNMXVTkvO8Y80zAYkPUq8elMsyNMHWtBgz89mG+bSA49fJcynvxokk7a9NYj5S1F5rqRMT+3TJiSY7EzWSQMfRyUQyS1F5FWhSlwRnb10fLaxHboE0Ub3gTc3WR+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356852; c=relaxed/simple;
	bh=vwtGEmt9gJmYSfL0GnZ1AXkZ5AEWUxDZZhCG8UgGjWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+8TGPgvMyrVsMEhad4ahpTnakgzufEcNh93gAcOkpKLBdse4GNLwA3nXSByHgejXLonNHB6Sv7af3EkapRh0gjC+P2jeHlW734v31ZCD4iWZrqi5rd6OO7/IN1h10Bb6Vvlw6XsxL0EfZ/XPHxEvecDxoJKLj4WeXCSeKDDQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DA74C341030;
	Wed, 14 Jan 2026 02:14:09 +0000 (UTC)
Date: Wed, 14 Jan 2026 10:14:05 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>, Paul Walmsley <pjw@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 00/11] riscv: spacemit: Add SpacemiT K3 SoC and K3
 Pico-ITX board
Message-ID: <20260114021405-GYB25466@gentoo.org>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260112-shrivel-sarcastic-36d9acd2d96a@spud>
 <20260113002123-GYA19926@gentoo.org>
 <20260113-swarm-mama-cbd7d0546578@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-swarm-mama-cbd7d0546578@spud>


On 22:17 Tue 13 Jan     , Conor Dooley wrote:
> On Tue, Jan 13, 2026 at 08:21:23AM +0800, Yixun Lan wrote:
> > Hi Conor,
> > 
> > On 21:45 Mon 12 Jan     , Conor Dooley wrote:
> > > On Sat, Jan 10, 2026 at 01:18:12PM +0800, Guodong Xu wrote:
> > > 
> > > > Hi, Conor
> > > > 
> > > > For the binding riscv/extensions.ymal, here's what changed in v3 (no
> > > > change in v4):
> > > > 
> > > >  1. Dropped the patch of adding "supm" into extensions.yaml. At the same
> > > >     time, I will start another patchset which implements the strategy
> > > >     outlined by Conor in Link [2] and by Samuel in Link [3].
> > > 
> > > Okay, that seems reasonable to separate out.
> > > 
> > > > 
> > > >  2. Dropped the dependency checks for "sha" on "h", "shcounterenw", and
> > > >     6 others. "sha" implies these extensions, and it should be allowed
> > > >     to be declared independently. Like "a" implies "zaamo" and "zalrsc".
> > > > 
> > > >  3. Enchanced the dependency check of "ziccamoa" on "a". Specifically,
> > > >      - added the dependency check of "ziccamoa" on "zaamo" or on "a".
> > > >      - added the dependency check of "za64rs" on "zalrsc" or on "a".
> > > >      - added the dependency check of "ziccrse" on "zalrsc" or "a".
> > > >     The commit message of this patch is updated too, to better explain the
> > > >     relationship  between "ziccamoa", "za64rs", "ziccrse" and "a".
> > > > 
> > > >  4. Enhanced checking dependency of "b" and "zba", "zbb", "zbs", making the
> > > >     dependency check in both directions, as discussed in [4]. Since "b"
> > > >     was ratified much later than its component extensions (zba/zbb/zbs),
> > > >     existing software and kernels expect these explicit strings. This
> > > >     bidirectional check ensures cores declaring "b" remain compatible
> > > >     with older software that only recognizes zba/zbb/zbs.
> > > 
> > > This I asked about in the relevant patch, I would like to know what your
> > > plan for adding the "b"s is.
> > > 
> > ..
> > > Spacemit folks, I assume you weren't planning on taking the
> > > extensions.yaml stuff via your tree? If you weren't, I'll grab it once
> > > the question about b is answered.
> > 
> > sure, please take extension stuff which are patches 6-9, for 1-5, it's
> > all about adding support for SpacemiT K3 SoC, to avoid petential conflicts,
> > I wouldn't mind if you also taking them? then I can handle the rest 10,11 for DT
> 
> Stuff for spacemit is either for you or for the relevant subsystem
> maintainers. You're probably safe enough taking the
> timer/interrupt-controller stuff if the maintainers don't apply it in a
> reasonable period, it's not abnormal for those in particular to go via
> the platform maintainer in my experience. Just be clear that you have
> done so. I'm only interested in taking 6-9.
Hi Conor,
  Ok, I got, thank you!

Hi Paul Walmsley,
  I assume you're responsible for more general riscv stuff with your
effective maintainer hat, so do you mind if I take patches 1-5 via SpacemiT
SoC tree? I think the potential conflicts should be low and easy to fix.
  Or, in the other hand, just let me know which patches you would like
to take, then I will handle the rest. Thanks

-- 
Yixun Lan (dlan)
