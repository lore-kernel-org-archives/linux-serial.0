Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECB3E6389;
	Wed, 20 May 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285906; cv=none; b=LkyMCWVxERoQtD0WIy7Dcx2922ZniaxTL4R5hWrAv4N9jC6sBF8X2Cb4eTrGYOO/lDUevJXArWpgk1O1itsBle6F3ukSchPturHt7xPg1LDMGAXYCePk2QhMcwqA+77RODcXKez8K8CBflOmUQkRMaAIW3TnyUqYLHkzgPfJCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285906; c=relaxed/simple;
	bh=hHtG79ODXKFLJJT9NAhSToW1IAv+VuA+80UdTr/GSwE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kG8m2lldy9NwEQhtwJp1msl/j0jXulpWOY/++bVkUaY1NDrhlrkztPoSRwc3AbHRAVBWXpuLeLq5wQDJZri0MvRXthXsy8q0TLFzWeA8Fobe6cOy1tKDymCybwbeYfzZpNOSgEGi06+8C2oQkPEALF50Ow+8nYgR+BBuxgaFuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ciTYS2vH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ciTYS2vH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=23Cr63eJ9hzSRFJrzP8aUEJvAkTf0E28e0heXWGf6tY=; b=ciTYS2vHI/Sha5v384+vxEy8u0
	jeSKH0201l/jH+ea1GleD5ssvD16NDHGt+R7U6zO+MQpWfc91rZxrhJrZMLGQEp5AIQQRrAPlBDr5
	t/fhsRHrB/xG5dYbudlCqD3HtqYpkAMFToK+d7AcvWBrlhqiTzMF9XRMZ9kiKWxri8dI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wPhXe-000000002hk-0y4y;
	Wed, 20 May 2026 10:04:58 -0400
Date: Wed, 20 May 2026 10:04:57 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 "Hugo Villeneuve" <hvilleneuve@dimonoff.com>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: fix I2C-only build
Message-Id: <20260520100457.0df23fe2d1c16fbb848a3de1@hugovil.com>
In-Reply-To: <8478838f-3821-44ea-b281-c890441b9a12@app.fastmail.com>
References: <20260519203506.1341241-1-arnd@kernel.org>
	<20260519171437.ff11a24d84c9ac8092348baf@hugovil.com>
	<8478838f-3821-44ea-b281-c890441b9a12@app.fastmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Arnd,

On Wed, 20 May 2026 08:47:05 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> [You don't often get email from arnd@arndb.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, May 19, 2026, at 23:14, Hugo Villeneuve wrote:
> >> now causes build failures:
> >
> > A few days ago i sent v2 of a patch to fix this problem:
> >
> > https://lore.kernel.org/all/20260515183217.3554037-1-hugo@hugovil.com/raw
> >
> > Did you saw it?
> 
> Sorry I hadn't checked for other patches. I verified that your
> changes are functionally the same as mine.
> 
> The one change I have that you didn't include is
> 
> >> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> >> index 811250bbbd39..b9b40e80ea81 100644
> >> --- a/drivers/tty/serial/Kconfig
> >> +++ b/drivers/tty/serial/Kconfig
> >> @@ -323,6 +323,7 @@ config SERIAL_MAX3100
> >>  config SERIAL_MAX310X
> >>      tristate "MAX310X support"
> >>      depends on SPI_MASTER || I2C
> >> +    depends on I2C || !I2C
> >>      select SERIAL_CORE
> >>      select REGMAP_SPI if SPI_MASTER
> >>      select REGMAP_I2C if I2C
> 
> This is still required to avoid a link failure with
> SERIAL_MAX310X=y and I2C=m. Do you want to include this in
> a v3 of your patch, or should I send this separately?

If I2C=m, i cannot select SERIAL_MAX310X=y, it is automatically set (or
reset) to "m", even if I manually force it to "y", do you have the same
behavior?

Before i converted the sc16is7xx driver to split i2c/spi, it was done
like this:

  depends on (SPI_MASTER && !I2C) || I2C

Based on what we agree on, I will include it in V3...

-- 
Hugo Villeneuve
