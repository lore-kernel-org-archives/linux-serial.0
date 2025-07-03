Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1592E267E;
	Thu,  3 Jul 2025 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538541; cv=none; b=Q81Gnp5l2qCZM56SNBUTkoz9w7UcfhB/5ORceSw1Zp4YrdAMoTzhq0qB4uZ5Qk0uEVWmbDxISI1R4bmsRC3YJqSS/3X40jGccYiHf2bcfy3LYvYyZuJHmbQAiFhMvHiSUK3/Zxxw50sM/ZERP078zwcJTgsNQ5CAbml3PxMTBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538541; c=relaxed/simple;
	bh=QgODXWHI2tyVBN541OBtPqSM9qBlaZwvrMl6XRMd3OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbaDlExp4xJCoZdJ3PceiLiwc44LmG8IwcKFNskTp9LfV30jwB3DYh4f+aoXX1IUhBneR/vIJMRgRWmO+Jsh1+iMT0iUcZhb0eS1SYPEp+JVyJibkEnJjo+RJbmQgL5Jt6D3LZX2/IRp6RqJ9QjLHwh7ozfNa2AfYSZG9xc5SYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 129CD1596;
	Thu,  3 Jul 2025 03:28:44 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 981903F58B;
	Thu,  3 Jul 2025 03:28:56 -0700 (PDT)
Date: Thu, 3 Jul 2025 11:28:50 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, catalin.marinas@arm.com,
	linux-serial@vger.kernel.org, rmikey@meta.com,
	linux-arm-kernel@lists.infradead.org, usamaarif642@gmail.com,
	leo.yan@arm.com, linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <aGZbYmV26kUKJwu_@J2N7QTR9R3>
References: <aGVn/SnOvwWewkOW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGVn/SnOvwWewkOW@gmail.com>

Hi Breno,

On Wed, Jul 02, 2025 at 10:10:21AM -0700, Breno Leitao wrote:
> Hello,
> 
> I'm observing two unusual behaviors during the boot process on my SBSA
> ARM machine, with upstream kernel (6.16-rc4):

Can you say which SoC in particular that is? Knowing that would help to
identify whether there's some known erratum, clocking issue, etc.

Likewise that might imply more folk to add to Cc.

[...]

> At timestamp 9.69 seconds, the serial console is still flushing messages from
> 0.92 seconds, indicating that the initial 9-second gap is spent looping in
> cpu_relax()—about 20,000 times per message, which is clearly suboptimal.
> 
> Further debugging revealed the following sequence with the pl011 registers:
> 
> 	1) uart_console_write()
> 	2) REG_FR has BUSY | RXFE | TXFF for a while (~1k cpu_relax())
> 	3) RXFE and TXFF are cleaned, and BUSY stay on for another 17k-19k cpu_relax()
> 
> Michael has reported a hardware issue where the BUSY bit could get
> stuck (see commit d8a4995bcea1: "tty: pl011: Work around QDF2400 E44 stuck BUSY
> bit"), which is very similar. TXFE goes down, but BUSY is(?) still stuck for long.

Looking at the commit message, that was an issue with the a "custom
(non-PrimeCell) implementation of the SBSA UART" present on QDF400. I
assume that was soemthing that Qualcomm Datacenter Technologies designed
themselves.

It's possible that your SoC has a similar issue with whatever IP block
is being used as the UART, but the issue in that commit certainly
doesn't apply to most PL011 / SBSA-UART implementations.

> If I am having the same hardware issue, I suppose I need to change that logic
> to exist the cpu_relax() loop by checking when Transmit FIFO Empty (TXFE) is 0
> instead of BUSY.

If you have the same issue, then applying the same workaround makes
sense. As above, it's not clear that this is necessarily the same issue.
Any more detail that you can share regarding the SoC would be very
helpful.

Mark.
