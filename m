Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438C21D5B0;
	Tue, 13 Jan 2026 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768263690; cv=none; b=BozS5ADD4zECr/9Poh+AYvSamgtB1RgovNVgewOTrS/u/KDrsV/C6w/5/X+cBcaUEASS1rCw9IM5Ay2VjO6d24L85xvLW1EbuASTm27uq1sakwOaFsbRbUt0NOBr1061+rfZWQckiEjbrCnXuMTc8+p6ENW4wqhYD625MT+7NZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768263690; c=relaxed/simple;
	bh=pidtPHvMv8UnN4vChxsQ9PRc0Hl8a1FUcKrswoY1+sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANhEm+JsNjVbs0GfgAnx//WbN6lQTfoO/qUrh035anpHuubVkySsz/M9quFoNwcpNHW+fys6BNb84pn98y6+s9JHVSMlQzm9VO+hlsnBut5duyiaPVNYHuXnkUmQHVlArpNAUT1u5fDR/YsnLm07IW+f6i2yB3ERgB7oif+Knc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8524B3410D6;
	Tue, 13 Jan 2026 00:21:27 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:21:23 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
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
Message-ID: <20260113002123-GYA19926@gentoo.org>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260112-shrivel-sarcastic-36d9acd2d96a@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-shrivel-sarcastic-36d9acd2d96a@spud>

Hi Conor,

On 21:45 Mon 12 Jan     , Conor Dooley wrote:
> On Sat, Jan 10, 2026 at 01:18:12PM +0800, Guodong Xu wrote:
> 
> > Hi, Conor
> > 
> > For the binding riscv/extensions.ymal, here's what changed in v3 (no
> > change in v4):
> > 
> >  1. Dropped the patch of adding "supm" into extensions.yaml. At the same
> >     time, I will start another patchset which implements the strategy
> >     outlined by Conor in Link [2] and by Samuel in Link [3].
> 
> Okay, that seems reasonable to separate out.
> 
> > 
> >  2. Dropped the dependency checks for "sha" on "h", "shcounterenw", and
> >     6 others. "sha" implies these extensions, and it should be allowed
> >     to be declared independently. Like "a" implies "zaamo" and "zalrsc".
> > 
> >  3. Enchanced the dependency check of "ziccamoa" on "a". Specifically,
> >      - added the dependency check of "ziccamoa" on "zaamo" or on "a".
> >      - added the dependency check of "za64rs" on "zalrsc" or on "a".
> >      - added the dependency check of "ziccrse" on "zalrsc" or "a".
> >     The commit message of this patch is updated too, to better explain the
> >     relationship  between "ziccamoa", "za64rs", "ziccrse" and "a".
> > 
> >  4. Enhanced checking dependency of "b" and "zba", "zbb", "zbs", making the
> >     dependency check in both directions, as discussed in [4]. Since "b"
> >     was ratified much later than its component extensions (zba/zbb/zbs),
> >     existing software and kernels expect these explicit strings. This
> >     bidirectional check ensures cores declaring "b" remain compatible
> >     with older software that only recognizes zba/zbb/zbs.
> 
> This I asked about in the relevant patch, I would like to know what your
> plan for adding the "b"s is.
> 
..
> Spacemit folks, I assume you weren't planning on taking the
> extensions.yaml stuff via your tree? If you weren't, I'll grab it once
> the question about b is answered.

sure, please take extension stuff which are patches 6-9, for 1-5, it's
all about adding support for SpacemiT K3 SoC, to avoid petential conflicts,
I wouldn't mind if you also taking them? then I can handle the rest 10,11 for DT


-- 
Yixun Lan (dlan)
