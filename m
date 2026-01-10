Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816B03382C9;
	Sat, 10 Jan 2026 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768043111; cv=none; b=c2JNfoWEZL7nYmM34hIof+qUSqxCoOh0e0tL6oX2BBV3obVlsMOqS7zRHr+SrhOsN7977VvkSqFM3IUjKkOZh7srioK+9Psx4akK9xCUpH1sKOU62nzXbDCmBN4YValN6xtrtcPQC5jGFwtbSmLBwHBDZVPzxrJzZETA+1OJLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768043111; c=relaxed/simple;
	bh=yhblASGMwjZl8k0XnBA+TOJEr69kbObgz3Nz8WWXILs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/i4po6WTdM62J/vMPREimXRfp2LxmclVr6UGGi9VeGBp6AgneHJvwUyFe8bP8Tyhf7eslXhdaJRNXbdlF1AxJDWX5Gim909giggYQehcSsfCsf9GFQMoM771G1ouM8rRtYuJOb1N8U++1oqJefcN9VlXISCr8vwLerishI/lT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C6D76340C98;
	Sat, 10 Jan 2026 11:05:06 +0000 (UTC)
Date: Sat, 10 Jan 2026 19:05:02 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
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
	Conor Dooley <conor@kernel.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 10/11] riscv: dts: spacemit: add initial device tree
 of SpacemiT K3 SoC
Message-ID: <20260110110502-GYB12783@gentoo.org>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com>
 <aWIi9LFdqSF3c-FP@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWIi9LFdqSF3c-FP@inochi.infowork>

Hi Guodong,

On 18:00 Sat 10 Jan     , Inochi Amaoto wrote:
> On Sat, Jan 10, 2026 at 01:18:22PM +0800, Guodong Xu wrote:
> > SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> > Add nodes of uarts, timer and interrupt-controllers.
> > 
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v4: Fix missing blank space after commas in compatible string.
> >     Add m-mode imsic and aplic node.
> >     Reorder properties in simsic, saplic, mimsic, and maplic nodes
> >      to match DTS coding style.
> > v3: Remove "supm" from the riscv,isa-extensions list.
> > v2: Remove aliases from k3.dtsi, they should be in board DTS.
> >     Updated riscv,isa-extensions with new extensions from the extensions.yaml.
> > ---
> >  arch/riscv/boot/dts/spacemit/k3.dtsi | 590 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 590 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > new file mode 100644
> > index 000000000000..a815f85cf5a6
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > @@ -0,0 +1,590 @@
...
> > +			d-cache-sets = <256>;
> > +			next-level-cache = <&l2_cache0>;
> 
> > +			mmu-type = "riscv,sv39";
> 
> I think this should be riscv,sv48? IIRC K3 supports it.
> 
I would second the idea here, if the underlying hardware support sv48,
there is no reason we should limit it in DTS, DT should reflect the actual
hardware.. if user still prefer to use sv39 for simplicity, a "no4lvl"
command line argument can be passed.. see 
 arch/riscv/mm/init.c +860 -> set_satp_mode()

-- 
Yixun Lan (dlan)
