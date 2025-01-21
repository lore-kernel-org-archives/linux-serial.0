Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5001AF0A6;
	Tue, 21 Jan 2025 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737492866; cv=none; b=lmD1VFWxoGbb7ZZqx7C1P56zNBY1M4cqcaE2CZN9MDysFOXr9nkOudWNgjpHQQgad8X8CNu0eNBWtAWxUC5nsyrCSGW6nnssA8PuSYJdWHlMJTCcAp5IUHuEzFaHrCaBExlIXJ+B6UDKmq087LzWKo24tfRV2WS7BO6jEWHWk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737492866; c=relaxed/simple;
	bh=fDwW3+zXEWPIyuupcaoAbKP80PX9KlsyNa8lnb4NlVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6gu3Ar80fpWYIxt8jtY95R/GlS8zxWkB79Mz28bT2gArXFaize3D7xW/uh8Y/iZikYnB3lkvrcRDuqdL8V/cDxKDjUqmSu5OtVKFmmgrX3CoDYlvkzoxYDSeBp1kxSb+F0HlGF16C3Eo1odv5X71dhI2Cv8Lg5V2zz091nPnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.227.99.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 97DBC340C57;
	Tue, 21 Jan 2025 20:54:23 +0000 (UTC)
Date: Tue, 21 Jan 2025 20:54:13 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/2] serial: 8250: move mmp|pxa uart earlycon code and
 add xscale earlycon
Message-ID: <20250121205413-GYA35009@gentoo>
References: <20240711160720.3488-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711160720.3488-1-jszhang@kernel.org>

Hi Greg, Jisheng:

how is this patch going, hope it isn't lost..
generally this patch looks good.

On 00:07 Fri 12 Jul     , Jisheng Zhang wrote:
> There are two other drivers that bind to "mrvl,mmp-uart": the 8250_of
> and the 8250_pxa. The previous one is generic and the latter is binded
> to ARCH_PXA || ARCH_MMP. Now we may have pxa programming compatible
> HW to support, making use of the generic 8250_of seems a good idea.
> However, there's no earlycon support if we go with this solution. So
> move the mmp|pxa-uart earlycon code to core 8250_early.c.
> 
> patch2 adds xscale earlycon support too, only build test since
> I have no xscale machine any more.
> 
> Since v1:
>   - split the patch into two as suggested by Greg
> 
> Jisheng Zhang (2):
>   serial: 8250: move mmp|pxa uart earlycon code
>   serial: 8250_early: add xscale earlycon support
> 
>  drivers/tty/serial/8250/8250_early.c | 11 +++++++++++
>  drivers/tty/serial/8250/8250_pxa.c   | 16 ----------------
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> -- 
> 2.43.0
> 
Reviewed-by: Yixun Lan <dlan@gentoo.org>
-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
