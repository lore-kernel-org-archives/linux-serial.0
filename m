Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB1A31;
	Fri, 20 Dec 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707208; cv=none; b=W235xIiNThFafHYAJgw15ihkbtnRux60/NE17a56u17HzXWlxkbA4Jb//JRhNruqpqyukLyphCvpNySr6rdL1Imuriud7u+3UkcWN7+K50lLVqf+tAnhrZBsMesPvLK5SxXxh47cbg8ebpH/9yhp8txRg7H8oMZfIxqNPPXewgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707208; c=relaxed/simple;
	bh=NmsM/F4zqleWHb4Qc1ZS20C8EsTD9cxVATkXcgWq7V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svY4EdCnulAiO36dmXSQMK5FN0tZQBfZ5LojtkT33jQu+28Ts9w7UJZjcd3b5xbp5A5peoij+tYPeRo2vgrJvvuI6Undcl40SFVr6Bb9OoQciul5eBn05oMXMkqa1Ew4fh2XsP9CLACSnlEuSNLpX9Ksodj0ggJYCPAPueOrcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pPRfCtPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pPRfCtPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A4FC4CECD;
	Fri, 20 Dec 2024 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734707207;
	bh=NmsM/F4zqleWHb4Qc1ZS20C8EsTD9cxVATkXcgWq7V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPRfCtPJV51UhtrzYU1WQvf3fdzS2Z6c4rp6KXWsT5iSBwQexzx+Z/HjjakCRRSe+
	 26NAsv291+EqKPN51R8bJKh5TPO/HGAWc1bhs9S1iZVm+TaQ0g2i4/gpYI5RpG9bpa
	 7DUtd9LlRwCj5c0kcNsrr3T7C8XzMGG3fZW2jpdM=
Date: Fri, 20 Dec 2024 16:06:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: mips_ejtag_fdc: Call cpu_relax() in registers
 polling busy loops
Message-ID: <2024122019-blame-multitask-8d83@gregkh>
References: <20241219124254.321778-1-quic_zhonhan@quicinc.com>
 <2024121943-spearmint-yard-4cab@gregkh>
 <edfed594-a22a-4cd1-90d2-2b9f9f878f73@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfed594-a22a-4cd1-90d2-2b9f9f878f73@quicinc.com>

On Fri, Dec 20, 2024 at 09:46:27PM +0800, Zhongqiu Han wrote:
> On 12/19/2024 9:28 PM, Greg KH wrote:
> > On Thu, Dec 19, 2024 at 08:42:54PM +0800, Zhongqiu Han wrote:
> > > It is considered good practice to call cpu_relax() in busy loops, see
> > > Documentation/process/volatile-considered-harmful.rst. This can lower CPU
> > > power consumption or yield to a hyperthreaded twin processor, or serve as
> > > a compiler barrier. In addition, if something goes wrong in the busy loop
> > > at least it can prevent things from getting worse.
> > > 
> > > Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> > > ---
> > >   drivers/tty/mips_ejtag_fdc.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> > > index afbf7738c7c4..b17ead1e9698 100644
> > > --- a/drivers/tty/mips_ejtag_fdc.c
> > > +++ b/drivers/tty/mips_ejtag_fdc.c
> > > @@ -346,7 +346,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
> > >   		/* Busy wait until there's space in fifo */
> > >   		while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
> > > -			;
> > > +			cpu_relax();
> > >   		__raw_writel(word.word, regs + REG_FDTX(c->index));
> > >   	}
> > >   out:
> > > @@ -1233,7 +1233,7 @@ static void kgdbfdc_push_one(void)
> > >   	/* Busy wait until there's space in fifo */
> > >   	while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
> > > -		;
> > > +		cpu_relax();
> > 
> > How did you test this?  Are you _sure_ it is needed at all?  I think you
> > just made these loops take a lot longer than before :(
> > 
> > Have you had problems with these tight loops doing anything bad to your
> > system?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> Thanks a lot for the review~
> 
> Perhaps I should submit an RFC patch and explain the situation, as I
> don't have a MIPS device for testing. Indeed, the cpu_relax()
> implementation for MIPS is a memory barrier, which, compared to busy
> waiting, doesn't save power and can make loops slower than before.
> However, according to its definition file, for certain MIPS-based
> architectures like Loongarch-3, it can help force the Loongson-3 SFB
> (Store-Fill-Buffer) flush to avoid pending writes. Below is the
> implementation of cpu_relax() for the MIPS architecture and its
> comments.
> 
> -----------------------------------------------------------------
> arch/mips/include/asm/vdso/processor.h
> 
> #ifdef CONFIG_CPU_LOONGSON64
> /*
>  * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely
>  * when a tight read loop is executed, because reads take priority over
>  * writes & the hardware (incorrectly) doesn't ensure that writes will
>  * eventually occur.
>  *
>  * Since spin loops of any kind should have a cpu_relax() in them, force
>  * an SFB flush from cpu_relax() such that any pending writes will
>  * become visible as expected.
>  */
> #define cpu_relax()	smp_mb()
> #else
> #define cpu_relax()	barrier()
> #endif
> ----------------------------------------------------------------
> 
> Based on this, cpu_relax() should be needed here? :)

I don't know, please test and let us know!

Without testing of this on real hardware, we can't take this change for
obvious reasons.

thanks,

greg k-h
