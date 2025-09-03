Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0B2BD015;
	Wed,  3 Sep 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916365; cv=none; b=oKW8geNGv+AADKSMnwds0zV4s4WPswqavGefgdog0AGeuymY7QXFxX3wcQOOX9ar0HMKMnsJQfDWm1SGvH6bHBP19XUFpLis5Ap8dGBDze5fltJ7RvumDf0la3FfkdkDS5bAn3a5n2sjVylePrWbIVBquw3g51ZKHntBSrmGj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916365; c=relaxed/simple;
	bh=nJLUtoBhFMwhPe7EM+OsdriyrpDoWVFsUNUD8cBC0Ec=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=Bv3bMZPQbwBtfStdN3v0Oah+R7jsBtqyqzClSRTojOaD2Wd+sJIT4SwNjspAWsqwVUhGhYu840zMMWs1Yjr5hDBhgvXzup6TbXz4EDRESMMHTxz+wHUCdqx8nBJkPYmhFJs9SO8zh5Lj7oPoCzarEnQyq1pynoq/FONnhWv/99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=eS31jYrk; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="eS31jYrk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=AjeNXlDXHIZuFoDWq8mczdVnxoiHEn6n2ReMUKbxEmI=; b=eS31jYrkCqgk2rvfzA+7Zspq5o
	JWlDn286LoZzyCNB+IMD8OnV/QvCcTiYaItQOfsBKqnTA4Fheo0RaiP496aNPZ6/GFVgn1xr5NP5p
	YE0CaULC6D81mTRV3jxEyUkqRcANHw3z5BXV45Fm4jDQUVTQqLwTLWIc+gZoYZGhycrI=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:57240 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1utpYC-0008U6-JZ; Wed, 03 Sep 2025 11:37:33 -0400
Date: Wed, 3 Sep 2025 11:37:31 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <20250903113731.24f5ac2499e92246bc0c93eb@hugovil.com>
In-Reply-To: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
References: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.6 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH] serial: max310x: improve interrupt handling
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,

On Wed, 03 Sep 2025 09:23:04 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> When there is a heavy load of receiving characters to all
> four UART's, the warning 'Hardware RX FIFO overrun' is
> sometimes detected.
> The current implementation always service first UART3 until
> no more interrupt and then service another UARTs.

To improve clarity and reduce confusion, maybe change to
something like:

... always service first the highest UART until
no more interrupt and then service another UART (ex: UART3 will be
serviced for as long as there are interrupts for it, then UART2, etc).


> 
> This commit improve interrupt service routine to handle all
> interrupt sources, e.g. UARTs when a global IRQ is detected.

The current code already handle all interrupt sources. What you
maybe could be saying is that you handle all individual interrupt
sources before reading the global IRQ register again?

You could also add in your commit message that your modification has the
nice side-effect of improving the efficiency of the driver by reducing
the number of reads of the global IRQ register.


> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  drivers/tty/serial/max310x.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index ce260e9949c3c268e706b2615d6fc01adc21e49b..3234ed7c688ff423d25a007ed8b938b249ae0b82 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -824,15 +824,26 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
>  
>  	if (s->devtype->nr > 1) {
>  		do {
> -			unsigned int val = ~0;
> +			unsigned int val;
> +			unsigned int global_irq = ~0;
> +			int port;
>  
>  			WARN_ON_ONCE(regmap_read(s->regmap,
> -						 MAX310X_GLOBALIRQ_REG, &val));
> -			val = ((1 << s->devtype->nr) - 1) & ~val;
> +				MAX310X_GLOBALIRQ_REG, &global_irq));

You changed the indentation here...

> +
> +			val = ((1 << s->devtype->nr) - 1) & ~global_irq;
> +
>  			if (!val)
>  				break;
> -			if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
> -				handled = true;
> +
> +			do {
> +				port = fls(val) - 1;
> +				if (max310x_port_irq(s, port) == IRQ_HANDLED)
> +					handled = true;
> +
> +				global_irq |= 1 << port;
> +				val = ((1 << s->devtype->nr) - 1) & ~global_irq;
> +			} while (val);
>  		} while (1);
>  	} else {
>  		if (max310x_port_irq(s, 0) == IRQ_HANDLED)

Maybe you could simplify (and improve readability) with this instead:

---
                        val = ((1 << s->devtype->nr) - 1) & ~val;
                        if (!val)
                                break;

-                       if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
-                               handled = true;
+
+                       do {
+                               unsigned int channel;
+
+                               channel = fls(val) - 1;
+
+                               if (max310x_port_irq(s, channel) == IRQ_HANDLED)
+                                       handled = true;
+
+                               val &= ~(1 << channel);
+                       } while (val);
---

> 
> ---
> base-commit: c8bc81a52d5a2ac2e4b257ae123677cf94112755
> change-id: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d
> 
> Best regards,
> -- 
> Tapio Reijonen <tapio.reijonen@vaisala.com>
> 
> 
> 

-- 
Hugo Villeneuve
