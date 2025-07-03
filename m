Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E31A8412;
	Thu,  3 Jul 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559467; cv=none; b=ojl0Mt3xHfjhF+JumDQjaOP80j6frkrMrJcPvVt9D4OpDruaLi9paE/zRNGGRWEcqYwtkrBcUvULL8nAunNISuyOFvJjbs0VIKqcSnC6b4CSuXZnJdfpOcatE0DShjEqzgr6JdR0H+tkHZCr47StF5s2wORD//yuXEVkW/bC5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559467; c=relaxed/simple;
	bh=Pq3AETd1SVMqawnncg9rRcGdGL51L5idsNTl0vc7ulU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkeKwJIG6oX6npemyjvCcLdW7fKS+8b92PN3lZXX8wGUKPqUeAMORB3xl9pvQ6xQWPrFPvQL7pLKm7cdOJkkZfBvGoC9io8LjX6gJOhn7tm2m6Np85GM3J/KUD+GFC3L0odTFIKtutsftfygn9vbiQD4x2m2A5cklfyH/pmcRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F9331596;
	Thu,  3 Jul 2025 09:17:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 627B93F6A8;
	Thu,  3 Jul 2025 09:17:44 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:17:42 +0100
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, mark.rutland@arm.com,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <20250703161742.GF1039028@e132581.arm.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <20250702172036.GC1039028@e132581.arm.com>
 <aGZVP8A2a3VVQwzt@gmail.com>
 <20250703114557.GD1039028@e132581.arm.com>
 <aGabYkQixrVeYlLD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGabYkQixrVeYlLD@gmail.com>

Hi Breno,

On Thu, Jul 03, 2025 at 04:01:54PM +0100, Breno Leitao wrote:

[...]

> That is an interesting experiment, thanks for the heads-up.
> 
> I got `earlycon=pl011,mmio32,0xc280000` working, the machine boots fine,
> and I see different behaviours.
> 
> Booting up the system the following lines (as examples):
> 
> 	[    0.000000] earlycon: pl11 at MMIO32 0x000000000c280000 (options '115200')
> 	[    0.000000] printk: legacy bootconsole [pl11] enabled
> 	[    0.493205] smp: Brought up 1 node, 72 CPUs
> 	[    4.232864] SMP: Total of 72 processors activated.
> 	[    4.242788] CPU: All CPU(s) started at EL2
> 	[    6.318137] ARMH0011:00: ttyAMA0 at MMIO 0xc280000 (irq = 66, base_baud = 0) is a SBSA
> 	[    6.978245] netpoll: netconsole: local port 6666
> 	[    7.234429] Run /init as init process
> 
> Also, I have a trace_printk() in pl011_console_write_atomic, and it only
> start later in the code. More precisely at:
> 
>        swapper/0-1       [000] dN.1.     6.334581: pl011_console_write_atomic: Printing 49 [    6.334573] printk: console [ttyAMA0] enabled
> 
> I understand that the early boot messages got sent by some other
> function? (Or maybe the tracing framework was not initialized?)
> 
> Anyway, pl011_console_write_atomic() continues to call ~20K times cpu_relax()
> waiting for the BUSY bit to disappear, as before.

If earlycon works correctly, it means the UART clock has been prepared
before the kernel boots.

I noticed that pl011_console_write_atomic() enables and disables the
uap->clk clock dynamically. The clock is a SoC implementation. If the
UART clock is already properly enabled for earlycon, we can assume it
doesn't need to be managed again in the UART driver.

So, perhaps it's worth an experiment by commenting out the clock
operations in the UART driver?

Thanks,
Leo
