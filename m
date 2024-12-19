Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A685226528;
	Thu, 19 Dec 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614909; cv=none; b=SIWOkkGWwHTUXSzW+FLyCfApuWTrDyuFTNEsDx+Igim6h0EFSeiXWVzwobzwrVuIz05fVOeGVc6hIMXIAm9XNxGNIvpR8dTSaF5AdzQxvNew1RZxSqLXGOfMwhCW7Jr2ZVFZ+fuOW9GmNf3EpxjOL3azpEpG9auI1srg04BuV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614909; c=relaxed/simple;
	bh=3ZdB6wUlztytCxnpI2Ps761cZeT6Iz58QHFnQ2xMyv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVfKrSjX8QpgUnuplf8DRG8P2rL8hF2oCc7aUWJk/d7e81s3J/s3wo40QYFpzhOcDrWQ/xkyokrNY1mtG0Z107PusXgafLwMFKDrjDksCKCjtv398ksjm8HsQStjThw/80rRElVcltFjzEXkSlyWbqwk61cHbKwU3N+Pt6HptlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kUmr8FWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kUmr8FWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CCDC4CED0;
	Thu, 19 Dec 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734614908;
	bh=3ZdB6wUlztytCxnpI2Ps761cZeT6Iz58QHFnQ2xMyv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUmr8FWs+XHF4CunsmErMMZeKVnb9M6qCbGiH9IngpLQUiaUy2sCmMaygj+3p+lOf
	 Vs1ouWwEJFGoWlWVZbl6FInBzdtohCIH5fMYx1QDLM0GNBkJxhTnBlfgy6WGnhcf0T
	 qHGGGiewQxYsWfRWY0/jYIU2Uz9AubzA891W2mOc=
Date: Thu, 19 Dec 2024 14:28:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: mips_ejtag_fdc: Call cpu_relax() in registers
 polling busy loops
Message-ID: <2024121943-spearmint-yard-4cab@gregkh>
References: <20241219124254.321778-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219124254.321778-1-quic_zhonhan@quicinc.com>

On Thu, Dec 19, 2024 at 08:42:54PM +0800, Zhongqiu Han wrote:
> It is considered good practice to call cpu_relax() in busy loops, see
> Documentation/process/volatile-considered-harmful.rst. This can lower CPU
> power consumption or yield to a hyperthreaded twin processor, or serve as
> a compiler barrier. In addition, if something goes wrong in the busy loop
> at least it can prevent things from getting worse.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  drivers/tty/mips_ejtag_fdc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> index afbf7738c7c4..b17ead1e9698 100644
> --- a/drivers/tty/mips_ejtag_fdc.c
> +++ b/drivers/tty/mips_ejtag_fdc.c
> @@ -346,7 +346,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
>  
>  		/* Busy wait until there's space in fifo */
>  		while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
> -			;
> +			cpu_relax();
>  		__raw_writel(word.word, regs + REG_FDTX(c->index));
>  	}
>  out:
> @@ -1233,7 +1233,7 @@ static void kgdbfdc_push_one(void)
>  
>  	/* Busy wait until there's space in fifo */
>  	while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
> -		;
> +		cpu_relax();

How did you test this?  Are you _sure_ it is needed at all?  I think you
just made these loops take a lot longer than before :(

Have you had problems with these tight loops doing anything bad to your
system?

thanks,

greg k-h
