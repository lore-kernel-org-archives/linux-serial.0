Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6C1E8841;
	Mon, 20 Jan 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387552; cv=none; b=LDQ99KzrvSDvQbunGbfxTUyoUI0r8geGADoBxjR7y4E4qm39gvxLpPlS0KmxNOVoQUlTYMUfM4ZswJn2I3jG8H/IHKRLrOX8eSDCt+VvI9xfEUR0Wh5xObX5P0fEJEGoJ2AwtZEyqmrWK10zUzU+naPvdMOzSgPFrPGX7Tv/Q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387552; c=relaxed/simple;
	bh=NWX2ulKh7Warh77LBEu3HXadIlBBPy9zYKWQXPw5QEY=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=UYEUnCTcM1lVcEXGX7M8UYw9J3H+i6WxSq6sZL+CaEajlUKM20pBKAFyVK/bRW61wmpAAOD2yoej5Ih07bKkiN2/oqZfex51HDfpeW1XJQrNlaJmIDirJ0T/8Ue28x2hXaN1inEH2kbQrjuA/97PY90ewoRwv1HyKjJPZHLx9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=JumNLEMV; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="JumNLEMV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=w9n47EuUFUUx/rHh8ptS1gXUTnO2VIsHVQSacXkdXSE=; b=JumNLEMV3J3gJwUe6el/UYXF36
	22ZZNAR8bzCKJKR6BC1EOUPmze92u0GmVhiltuhoQvADHRQkN1/IJ/Vx9z0B94P+XfuzHiaO/ksFt
	izl2VChF6EPQ9qUHT/LgAbxOEsp7hMocH1vXQhxcke5vwgUsIAfh/ZF0uURsgTvlaRmw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47156 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tZtrY-0007ux-5x; Mon, 20 Jan 2025 10:38:53 -0500
Date: Mon, 20 Jan 2025 10:38:51 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 hvilleneuve@dimonoff.com, andy@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, lech.perczak@camlingroup.com
Message-Id: <20250120103851.6518f01800ed946d02bfb81b@hugovil.com>
In-Reply-To: <20250120073234.790315-1-andre.werner@systec-electronic.com>
References: <20250120073234.790315-1-andre.werner@systec-electronic.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.2 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3] serial: sc16is7xx: Fix IRQ number check behavior
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 20 Jan 2025 08:32:34 +0100
Andre Werner <andre.werner@systec-electronic.com> wrote:

Hi,

> The logical meaning of the previous version is wrong due to a typo.

Ok.

> The rest of the patch expects polling = true for irq = 0;
> 
> The behaviour is fixed for irq = 0 as well as extended to negative

What do you mean by "is fixed"? and also isnt it the same explanation
as above for the "=0" case ("The rest of the patch..."?

> values because the irq parameter is an integer such that negative values
> are not completely impossible. So negative values will also be treated as
> a fallback to polling mode.

Please try to rephrase the whole commit message so that it is
more concise and clearer to understand, and takes into account the
previous comments from Andy/Jiri/Marteen?

If I understood these comments correctly, maybe something like:

------
When IRQ = 0, this means that no interrupt is used, and activate
polling mode.

And since documentation still says that negative IRQ values cannot be
absolutely ruled-out, add a check for negative IRQ values to
increase robustness.
------


Hugo


> 
> Fixes: 104c1b9dde9d859dd01bd2d ("serial: sc16is7xx: Add polling mode if no IRQ pin is available")
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> V2:
> There are no changes to the patch itself. The previous patch submission
> had a very weird structure within the discussion thread:
> https://lore.kernel.org/all/20250116093203.460215-1-andre.werner@systec-electronic.com/
> This is simply a new thread opened for better handling.
> V3:
> Add Fixes tag and update commit message description.
> ---
>  drivers/tty/serial/sc16is7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 7b51cdc274fd..560f45ed19ae 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	/* Always ask for fixed clock rate from a property. */
>  	device_property_read_u32(dev, "clock-frequency", &uartclk);
>  
> -	s->polling = !!irq;
> +	s->polling = (irq <= 0);
>  	if (s->polling)
>  		dev_dbg(dev,
>  			"No interrupt pin definition, falling back to polling mode\n");
> -- 
> 2.48.0
> 
> 
> 
