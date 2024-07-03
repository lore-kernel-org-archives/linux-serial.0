Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C21EA90;
	Wed,  3 Jul 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016539; cv=none; b=BuBdtig0WIc3TBPLB8CknGRtuKWmWLJEfnGUz/Smj1BltBGxWP3PS3gqySHBVdkPHD8cv/Vwq6Ft/mb/G8i+A7IFHJEdC2ZNO+KQjpA+ssZPU2exDukGmsOXBrCkpoUK1Sp4GXN8HFezmOYOv6KloXxSadwn7PrjvzpJlvCoBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016539; c=relaxed/simple;
	bh=f4NbyDhmUMSoMc3JreD102aM4vkKTbicMQZs0rsnIK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okgw7DhXql/selLDY7rI35IFLm7IQXyRs5Y/DXY+ASa2uah/cp+qQVaLRMxEsI2sfi+4CakE5ISlg2jT/omZrRh/zRnejlWQMUxtOzwRNwrwESbwqGDZbBhSkJ8nQ6XEORlDaI8LmTwM1qKd6r0EckRMUUsg8Eb3z7sEyZcS044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Wed, 3 Jul 2024 14:22:13 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH v2 08/10] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240703142213.GA2734247@ofsar>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
 <20240627-k1-01-basic-dt-v2-8-cc06c7555f07@gentoo.org>
 <CAJM55Z9jeAQTsVjRiLeofDm1RyMWCuHXC0a-pdKtpUiTkSjJCA@mail.gmail.com>
 <20240702012847.GA2447193@ofsar>
 <IA1PR20MB4953C031CB453AA0E51657B3BBDC2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240702-appease-attire-6afbe758bf0f@spud>
 <20240703094049.GB2676251@ofsar>
 <CAJM55Z9AdOq_yd7sK_VhkutokK+-QKscdq9i759H3N1UKVwJkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJM55Z9AdOq_yd7sK_VhkutokK+-QKscdq9i759H3N1UKVwJkQ@mail.gmail.com>

On 04:22 Wed 03 Jul     , Emil Renner Berthing wrote:
> Yixun Lan wrote:
> > Hi Conor:
> >
> > On 16:25 Tue 02 Jul     , Conor Dooley wrote:
> > > On Tue, Jul 02, 2024 at 09:35:45AM +0800, Inochi Amaoto wrote:
> > > > On Tue, Jul 02, 2024 at 01:28:47AM GMT, Yixun Lan wrote:
> > > > > On 12:49 Mon 01 Jul     , Emil Renner Berthing wrote:
> > > > > > Yixun Lan wrote:
> > > > > > > From: Yangyu Chen <cyy@cyyself.name>
> > > > > > >
> > > > > > > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> > > > > > >
> > > > > > > Key features:
> > > > > > > - 4 cores per cluster, 2 clusters on chip
> > > > > > > - UART IP is Intel XScale UART
> > > > > > >
> > > > > > > Some key considerations:
> > > > > > > - ISA string is inferred from vendor documentation[2]
> > > > > > > - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> > > > > > > - No coherent DMA on this board
> > > > > > >     Inferred by taking vendor ethernet and MMC drivers to the mainline
> > > > > > >     kernel. Without dma-noncoherent in soc node, the driver fails.
> > > > > > > - No cache nodes now
> > > > > > >     The parameters from vendor dts are likely to be wrong. It has 512
> > > > > > >     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
> > > > > > >     When the size of the cache line is 64B, it is a directly mapped
> > > > > > >     cache rather than a set-associative cache, the latter is commonly
> > > > > > >     used. Thus, I didn't use the parameters from vendor dts.
> > > > > > >
> > > > > > > Currently only support booting into console with only uart, other
> > > > > > > features will be added soon later.
> > > > > > >
> > > > > ...
> > > > >
> > > > > > > +		clint: timer@e4000000 {
> > > > > > > +			compatible = "spacemit,k1-clint", "sifive,clint0";
> > > > > > > +			reg = <0x0 0xe4000000 0x0 0x10000>;
> > > > > > > +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> > > > > > > +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> > > > > > > +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> > > > > > > +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> > > > > > > +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> > > > > > > +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> > > > > > > +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> > > > > > > +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> > > > > > > +		};
> > > > > > > +
> > > > > > > +		uart0: serial@d4017000 {
> > > > > > > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > > > > > > +			reg = <0x0 0xd4017000 0x0 0x100>;
> > > > > > > +			interrupts = <42>;
> > > > > > > +			clock-frequency = <14857000>;
> > > > > > > +			reg-shift = <2>;
> > > > > > > +			reg-io-width = <4>;
> > > > > > > +			status = "disabled";
> > > > > > > +		};
> > > > > > > +
> > > > > > > +		/* note: uart1 skipped */
> > > > > >
> > > > > > The datasheet page you link to above says "-UART (×10)", but here you're
> > > > > > skipping one of them. Why? I can see the vendor tree does the same, but it
> > > > > > would be nice with an explanation of what's going on.
> > > > > >
> > > > > /* note: uart1 in 0xf0612000, reserved for TEE usage */
> > > > > I would put something like this, does this sound ok to you?
> > > > >
> > > > > more detail, iomem range from 0xf000,0000 - 0xf080,0000 are dedicated for TEE purpose,
> > > > > It won't be exposed to Linux once TEE feature is enabled..
> > > > >
> > > > > skipping uart1 may make people confused but we are trying to follow datasheet..
> > > >
> > > > Instead of skipping it, I suggest adding this to reserved-memory area,
> > > > which make all node visible and avoid uart1 being touched by mistake.
> > >
> > > No, don't make it reserved-memory - instead add it as
> > > status = "reserved"; /* explanation for why */
> > Ok, got
> >
> > > Also, I'd appreciate if the nodes were sorted by unit address in the
> > > dtsi.
> > so I would move "plic, clint" after node of uart9 as this suggestion
> >
> > for uart1, its unit-address is 0xf0610000, it should be moved to after clint
> > (once unit-address sorted), if we follow this rule strictly.
> > but it occur to me this is not very intuitive, if no objection, I would put
> > it between uart0 and uart2 (thus slightly break the rule..)
> 
> No, please order nodes by their address as Conor said. It actually says so in
> the DTS coding style:
> 
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> 
I was thinking about grouping all same type devices (uart here) together
according to "1. Order of Nodes", but after reconsideration, I'd just follow
yours and Conor's suggestion, thus it will be more straightforward, also match
more well with datasheet[1] if we have to add more "reserved" nodes in the future.

Link: https://developer.spacemit.com/#/documentation?token=LzJyw97BCipK1dkUygrcbT0NnMg [1]

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
