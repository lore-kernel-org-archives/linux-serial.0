Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1412F373;
	Sat,  6 Jul 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720275852; cv=none; b=GrEwp/rBmqhAmtI9dKYtlpwFw/qln+FzRiUbbKHqvNli75lJHczj61ZirZrBnaCX3huO8pFku0wfQ2T+xvUmi1yeopJVqPiKdeQy/ylYECS07pVcAto5llNMDWsasqe+hJFRlOr1xPR/+bw73jeLGF5kWfBTXQXnKcDkSy3vhI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720275852; c=relaxed/simple;
	bh=PBsPO+YKSohn+zPrkJZTxqbLvA5nZ887JQZQarjYxXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcRByoT//nrqqFOXsF8PMXL8LLyMX5xRGiNz9YsPievnzFtgr95PztAJIDOuYihOVvBFc6nnqtUajUBmwvYCEPdfRRU2XG1jiLpw8fh2SDhNKeJTq+/pKt8QHZAT5JaEXTGyycKcLmMcaQtyAM9DnaHqSsWqpByjGT8svI6s3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sat, 6 Jul 2024 14:24:03 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
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
	Yangyu Chen <cyy@cyyself.name>,
	Inochi Amaoto <inochiama@outlook.com>, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>
Subject: Re: [PATCH v3 08/11] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240706142403.GYA4138928.dlan.gentoo>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-8-12f73b47461e@gentoo.org>
 <Zoanxksn0nio4MPg@xhacker>
 <20240705063839.GA3042186@ofsar>
 <ZojEEAdUwxPJwqIS@xhacker>
 <20240706050556.GA3590714@ofsar>
 <ZokfBzjvwN0IUQIX@xhacker>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZokfBzjvwN0IUQIX@xhacker>

On 18:40 Sat 06 Jul     , Jisheng Zhang wrote:
> On Sat, Jul 06, 2024 at 05:05:56AM +0000, Yixun Lan wrote:
> > 
> > On 12:12 Sat 06 Jul     , Jisheng Zhang wrote:
> > > On Fri, Jul 05, 2024 at 06:38:39AM +0000, Yixun Lan wrote:
> > > > 
> > > > On 21:46 Thu 04 Jul     , Jisheng Zhang wrote:
> > > > > On Wed, Jul 03, 2024 at 02:55:11PM +0000, Yixun Lan wrote:
> > > > > > From: Yangyu Chen <cyy@cyyself.name>
> > > > > > 
> > > > > > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> > > > > > 
> > > > > > Key features:
> > > > > > - 4 cores per cluster, 2 clusters on chip
> > > > > > - UART IP is Intel XScale UART
> > > > > > 
> > > > > > Some key considerations:
> > > > > > - ISA string is inferred from vendor documentation[2]
> > > > > > - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> > > > > > - No coherent DMA on this board
> > > > > >     Inferred by taking vendor ethernet and MMC drivers to the mainline
> > > > > >     kernel. Without dma-noncoherent in soc node, the driver fails.
> > > > > > - No cache nodes now
> > > > > >     The parameters from vendor dts are likely to be wrong. It has 512
> > > > > >     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
> > > > > >     When the size of the cache line is 64B, it is a directly mapped
> > > > > >     cache rather than a set-associative cache, the latter is commonly
> > > > > >     used. Thus, I didn't use the parameters from vendor dts.
> > > > > > 
> > > > > > Currently only support booting into console with only uart, other
> > > > > > features will be added soon later.
> > > > > > 
> > > > > > Link: https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet [1]
> > > > > > Link: https://developer.spacemit.com/#/documentation?token=BWbGwbx7liGW21kq9lucSA6Vnpb [2]
> > > > > > Link: https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/boot/dts/spacemit/k1-x.dtsi [3]
> > > > > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > > > > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > > > > ---
> > > > > >  arch/riscv/boot/dts/spacemit/k1.dtsi | 376 +++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 376 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > > > > new file mode 100644
> > > > > > index 0000000000000..a076e35855a2e
> > > > > > --- /dev/null
> > > > > > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > > > > > @@ -0,0 +1,376 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > > > > +/*
> > > > > > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +/ {
> > > > > > +	#address-cells = <2>;
> > > > > > +	#size-cells = <2>;
> > > > > > +	model = "SpacemiT K1";
> > > > > > +	compatible = "spacemit,k1";
> > > > > > +
> > > > > > +
> ...
> > > > > > +	soc {
> > > > > > +		compatible = "simple-bus";
> > > > > > +		interrupt-parent = <&plic>;
> > > > > > +		#address-cells = <2>;
> > > > > > +		#size-cells = <2>;
> > > > > > +		dma-noncoherent;
> > > > > > +		ranges;
> > > > > > +
> > > > > > +		uart0: serial@d4017000 {
> > > > > > +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> > > > > 
> > > > > no, this is not a correct hw modeling. The doc on spacemit says
> > > > > all the uart support 64 bytes FIFO, declaring xscale only makes
> > > > > use of 32 bytes FIFO.
> > > > yes, I also noticed it's 64 bytes FIFO
> > > > 
> > > > > 
> > > > > IIRC, 8250_pxa is a xscale uart with 64 bytes FIFO, so this should be
> > > > > "mrvl,pxa-uart" or "mrvl,mmp-uart"
> > > > 
> > > > 
> > > > for mrvl,pxa-uart, I think you imply to use drivers/tty/serial/8250/8250_pxa.c,
> > > > which turn out doesn't work on k1 SoC, for the record, we need to adjust
> > > 
> > > Really? I just tried "mrvl,pxa-uart" with rc6, it works perfectly, and the FIFO
> > > in the driver logic is 64bytes now. Am I misssing something or you never tried it?
> > > 
> > Ok, I realised it's the clock issue
> > 
> > still, I'm not fully convinced about using "mrvl,pxa-uart",
> > e.g this driver hardcoded tz_loadsz to 32, not sure if K1 suffer same problem
> > 5208e7ced520 ("serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level")
> 
> I believe the problem commit 5208e7ced520 tries to solve is: the
> mmp|pxa-uart only support threshold up to 32Bytes, tz_loadsz will be
> fifo size by default, this will cause probleme with 64Bytes FIFO.
> 
yes, exactly

> > 
> > also, what's the preference when choosing driver between 8250_pxa.c vs 8250_of.c?
> 
> Good question. I have no preference. But there are two problems with
> 8250_of, I have sent out patches[1][2] to address them.
> 
> After these two patches, both the earlycon and uart FIFO logic work too
> with below dts properties:
> 		uart0: serial@d4017000 {
> 			compatible = "mrvl,mmp-uart";
to be precise, I think here should be compatible = "mrvl,mmp-uart", "intel,xscale-uart"

but can you check this patch below? it should be ok with your two proposed patches applied
https://lore.kernel.org/all/20240703-k1-01-basic-dt-v3-6-12f73b47461e@gentoo.org/

> 			...
>                         reg-shift = <2>;
>                         reg-io-width = <4>;
>                         tx-threshold = <32>;
>                         fifo-size = <64>;
..
>                         no-loopback-test;
            need to check, from vendor docs, there is a loopback mode
            see 16.2.4.1 SSCR register description, bit12

https://developer.spacemit.com/#/documentation?token=Rn9Kw3iFHirAMgkIpTAcV2Arnkf
> 			...
> 		}
> 
> Link: https://lore.kernel.org/linux-riscv/20240706082928.2238-1-jszhang@kernel.org/ [1]
I have some comments for this patch, and I believe it's a valid fix,
without this patch, K1 will also have problem duo to "UART_CAP_UUE | UART_CAP_RTOIE" lost

> Link: https://lore.kernel.org/linux-riscv/20240706101856.3077-1-jszhang@kernel.org/ [2]
> 
> > it occur to me that 8250_pxa.c is more specially tailored for pxa hardware, while
> > 8250_of.c is more generic.. besides, should we consider one more step if we want to
> 
> there's a work around for Erratum #74 in 8250_pxa, while I believe the
do you have any link for this Erratum? let's double check it..

> Errata doesn't exisit in K1, so from this PoV it seems 8250_of is
> better, no?
> 
> > support DMA mode in the future (vendor uart driver has DMA support)?
> 
> Adding dma engine support to 8250_of is doable.
Ok, sounds good to me
> 
> > 
> > 
> > > >  drivers/tty/serial/8250/Kconfig to enable the driver for ARCH_SPACEMIT,
> > > >  and change uart compatible to "spacemit,k1-uart", "mrvl,pxa-uart"
> > > > 
> > > > for mrvl,mmp-uart, I see two choices, one using 8250_pxa.c which has same result
> > > > as mrvl,pxa-uart, another choice would using the driver of 8250_of.c 
> > > > and it work as same as "intel,xscale-uart", I don't see any difference..
> > > > 
> > > > P.S: there is possibly a side problem that "mrvl,mmp-uart" from 8250_of.c doesn't 
> > > > really compatile with "mrvl,mmp-uart" from 8250_pxa.c, but I think it's another story
> > 
> > -- 
> > Yixun Lan (dlan)
> > Gentoo Linux Developer
> > GPG Key ID AABEFD55

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
