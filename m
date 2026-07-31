Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF74343E4;
	Fri, 31 Jul 2026 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510295; cv=none; b=bUjUCPAVA3XH94i6+wA4ogteJ05dOEmcW2qarb3E+MJKUKqUvHuDI49S4jmcv+KXRHuy2T2kH6MyV6oFuZJGGZHpczAeTC/7iRNhU914mIKpPeFv/5GNHp22zZKXOrx3SFkSc0+whTHE/D34p9EfTnFhF4qC67hcfD1mqG/H/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510295; c=relaxed/simple;
	bh=1tu9Tp1d3P2kX25hqgEdqtJXrHR/SYdpr8PpOpyp6AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwEJEnMGXoMuDiAF1dPP2c0+vuu8oCf654Pt0i0UPas4EA4WyDC8P6Ne97ZHLFPIbhwM6KqoSfXYA2eF95pGZeCHzgSEs0+xoVS9CfSws5ETKXkrxdXil2Diz3YJvlCE6axPtWDtd8xLpkGfukn0sf+tJH9r/Q5aL0oe4PTHKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=josv5lbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="josv5lbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80BB1F000E9;
	Fri, 31 Jul 2026 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785510294;
	bh=6UL2nI6b4Oh70aQ2g5fNpXAfi7n8Bn5/fpqQBMDrAsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=josv5lberjOjLgDuLq55JkGu0rQkGffTONYIMPuHi+cnAXCddaz4jOH/+Lz2i++6x
	 /ttaWQpsyk5i40juWtlHAfpGWpv0rfSeZ4VScmTvjEWKfTI2847JCBenkcLuENs0Rs
	 LQcfZjm+YurIwMmAj4C/tKLvLqu8wcpfdjjsMp4c=
Date: Fri, 31 Jul 2026 17:04:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xincheng Wang <22009200607@stu.xidian.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: limit TCSBRKP break duration
Message-ID: <2026073157-expend-unzip-cad7@gregkh>
References: <20260727055525.6170-1-22009200607@stu.xidian.edu.cn>
 <2026072700-causal-remarry-6edf@gregkh>
 <20260729111927.41154-1-22009200607@stu.xidian.edu.cn>
 <2026072921-curled-moonlike-1207@gregkh>
 <20260731143041.6400-1-22009200607@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731143041.6400-1-22009200607@stu.xidian.edu.cn>

On Fri, Jul 31, 2026 at 10:30:41PM +0800, Xincheng Wang wrote:
> Hi Greg,
> 
> Yes, it would still be user-visible.
> 
> My concern is that tty_ioctl() first multiplies the TCSBRKP argument by
> 100 before passing it to send_break(), whose duration argument is
> unsigned int. For values above UINT_MAX / 100, the current behavior uses
> the low 32 bits of the multiplied product, which can be a duration very
> different from the requested interval.
> 
> But I agree that rejecting or saturating that value would also change
> current behavior. Would you be open to a fix for this, or would you
> rather leave the path as-is?

I lost all context here :(

ANyway, keeping things as-is is always good, unless you know of a way
the current stuff is broken and you can fix it without changing any
existing users.  user apis are hard...

thanks,

greg k-h
