Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AA2550CF;
	Thu,  3 Jul 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560276; cv=none; b=mlvaTOwq0AfmMWv+JWmn2YuGqzPTq+ZuiMZwJGUNgK/QwbCT06/5TjPvumLOKcuoJIhaaixmd74yoSLPUnfKWXZA9D3cVkE48Mi9tdC13MUR0z03ktl7um6YEPNscGNWrp1qwa/jqsLvVuF24rgoRpkvgf20/r0dRBlDPWqyZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560276; c=relaxed/simple;
	bh=+vt57VWzBdJjPWmw3ULSUUlX6k9y5W3q1Z+hvF4S8kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9yr/KOSQEOijLt2ApeGNFzZf/V/PgBb1pUKZE5z+SLrymHyDFHTw8xF+J2atRIuTX9sfoYNEYGuawiOHO49vuu0FMDsgbKwo1oUVxtcW0MDYCOeAhhuRrv1LQaB1TadmD5At7+mjQsRylriS/9fg/WYnIJMM0CcdnuEOQUP0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714C41596;
	Thu,  3 Jul 2025 09:30:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D6E33F6A8;
	Thu,  3 Jul 2025 09:31:12 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:31:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, catalin.marinas@arm.com,
	linux-serial@vger.kernel.org, rmikey@meta.com,
	linux-arm-kernel@lists.infradead.org, usamaarif642@gmail.com,
	leo.yan@arm.com, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	Ankit Agrawal <ankita@nvidia.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <aGawTd8N2i8MDCmL@J2N7QTR9R3>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGaQBghdAl8VGWmV@gmail.com>

On Thu, Jul 03, 2025 at 03:13:26PM +0100, Breno Leitao wrote:
> On Thu, Jul 03, 2025 at 11:28:50AM +0100, Mark Rutland wrote:
> > On Wed, Jul 02, 2025 at 10:10:21AM -0700, Breno Leitao wrote:
> > > I'm observing two unusual behaviors during the boot process on my SBSA
> > > ARM machine, with upstream kernel (6.16-rc4):
> > 
> > Can you say which SoC in particular that is? Knowing that would help to
> > identify whether there's some known erratum, clocking issue, etc.
> 
> This is custom made rack mounted machine based on Grace CPU. Here are
> some info about the hardware:
> 
> 	# lscpu:
> 		Vendor ID:                   ARM
> 		  Model name:                Neoverse-V2
> 		    Model:                   0
> 		    Thread(s) per core:      1
> 		    Core(s) per socket:      72
> 		    Socket(s):               1
> 		    Stepping:                r0p0
> 
> 	# /proc/cpuinfo
> 		processor	: 71
> 		BogoMIPS	: 2000.00
> 		Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 sm3 sm4 asimddp sha512 sve asimdfhm dit uscat ilrcpc flagm sb paca pacg dcpodp sve2 sveaes svepmull svebitperm svesha3 svesm4 flagm2 frint svei8mm svebf16 i8mm bf16 dgh bti
> 		CPU implementer	: 0x41
> 		CPU architecture: 8
> 		CPU variant	: 0x0
> 		CPU part	: 0xd4f
> 		CPU revision	: 0
> 
> 	# lshw
> 	    description: Rack Mount Chassis
> 	    product: <Internal name>
> 	    vendor: Quanta
> 	    version: <Internal name>
> 	    width: 64 bits
> 	    capabilities: smbios-3.6.0 dmi-3.6.0 smp sve_default_vector_length tagged_addr_disabled
> 	    configuration: boot=normal chassis=rackmount family=Default string sku=Default string uuid=...
> 
> How do I find the SoC exactly?

From what you've told me above, the SoC is Nvidia Grace; what they call
the CPU is the whole SoC.

> > Likewise that might imply more folk to add to Cc.

I've added Ankit and Besar, since they've both worked on some system
level bits on Grace, and might have an idea.

Ankit, Besar, are you aware of any UART issues on Grace (as described in
Breno's messages below), or do you know of anyone who might have an
idea?

Thanks,
Mark.

> > [...]
> > 
> > > At timestamp 9.69 seconds, the serial console is still flushing messages from
> > > 0.92 seconds, indicating that the initial 9-second gap is spent looping in
> > > cpu_relax()-about 20,000 times per message, which is clearly suboptimal.
> > > 
> > > Further debugging revealed the following sequence with the pl011 registers:
> > > 
> > > 	1) uart_console_write()
> > > 	2) REG_FR has BUSY | RXFE | TXFF for a while (~1k cpu_relax())
> > > 	3) RXFE and TXFF are cleaned, and BUSY stay on for another 17k-19k cpu_relax()
> > > 
> > > Michael has reported a hardware issue where the BUSY bit could get
> > > stuck (see commit d8a4995bcea1: "tty: pl011: Work around QDF2400 E44 stuck BUSY
> > > bit"), which is very similar. TXFE goes down, but BUSY is(?) still stuck for long.
> > 
> > Looking at the commit message, that was an issue with the a "custom
> > (non-PrimeCell) implementation of the SBSA UART" present on QDF400. I
> > assume that was soemthing that Qualcomm Datacenter Technologies designed
> > themselves.
> > 
> > It's possible that your SoC has a similar issue with whatever IP block
> > is being used as the UART, but the issue in that commit certainly
> > doesn't apply to most PL011 / SBSA-UART implementations.
> 
> That makes total sense. Decoding SPCR I see the following:
> 
> 	# iasl -d spcr.dat
> 	Intel ACPI Component Architecture
> 	ASL+ Optimizing Compiler/Disassembler version 20210604
> 	Copyright (c) 2000 - 2021 Intel Corporation
> 
> 	File appears to be binary: found 56 non-ASCII characters, disassembling
> 	Binary file appears to be a valid ACPI table, disassembling
> 	Input file spcr.dat, Length 0x50 (80) bytes
> 	ACPI: SPCR 0x0000000000000000 000050 (v02 NVIDIA A M I    00000001 ARMH 00010000)
> 	Acpi Data Table [SPCR] decoded
> 	Formatted output:  spcr.dsl - 2624 bytes
> 
> Thanks,
> --breno
