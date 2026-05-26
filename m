Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E13E0750;
	Tue, 26 May 2026 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802464; cv=none; b=u5f1tmopF19sdwkW96n7EmSDflUs9m/CcoNxAIWf04NrKtepxw3o4gPpB9hpwNY9wr/u9PMv0MSVsgHx/oopBZ1b/JQXHxRmJK5snb1E4F0D3K435OmVb3vIN4+yYb1Iw74utM0b15usLjS04DiVqUJN090t1qETz4KHXk0bo8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802464; c=relaxed/simple;
	bh=ZwHajdgjYGEag/wqmwGjod4oVWCV/+UfYsIoZES6H+8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pLCWiROlTDDzvF7pnuSYe+GvlyBceyEK19CtSndC09YxorLnsSkYnMyzU73odDl4zQ6uXW/HtAXmEgw2aZVgyRjqi+mtoUx7nnFEYye5wyxhcIag95k5a0ORToglQOdLak6wdDthxgtmJ8XQop3sS5KeL/LmPsaWSHZAohNLC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ze9Dgv0D; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ze9Dgv0D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=q7o+iQ1w9G1UiqEz7hJaJd1CaNPkTBiBvOdPIXnXgYw=; b=ze9Dgv0DqZ62Lq8IpF3VeSlR/W
	xXNfy2n240l4XkLCKY0giJvB2vrTI60jqaM+Kobk9oDWsCriEAdEdjPBqwCqJJnaDpycj0XgQZevv
	3lvX6t0p6cBghi7gzTsAMY0mfiUetE/xfBiqv49J34fN04ohza1KmzB7lPCqnNnEctX0=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wRrv9-0000000012L-1kn5;
	Tue, 26 May 2026 09:34:11 -0400
Date: Tue, 26 May 2026 09:34:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, kernel
 test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] serial: max310x: fix compile errors if
 CONFIG_SPI_MASTER is disabled
Message-Id: <20260526093410.6162be940a20372bf766db46@hugovil.com>
In-Reply-To: <48b0e694-e75c-4d0a-8698-b0848ccaefeb@infradead.org>
References: <20260521153333.2336642-1-hugo@hugovil.com>
	<48b0e694-e75c-4d0a-8698-b0848ccaefeb@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam_score: -2.0
X-Spam_bar: --

On Mon, 25 May 2026 10:43:40 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 5/21/26 8:33 AM, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Since commit 20ffe4b3330a8 ("serial: max310x: allow driver to be built with
> > SPI or I2C"), if I2C is enabled and SPI_MASTER is disabled, we have these
> > compile errors:
> > 
> >   drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
> >   drivers/tty/serial/max310x.c: error: 'max310x_spi_driver' undeclared...
> >   drivers/tty/serial/max310x.c: In function ‘max310x_uart_init’:
> >   drivers/tty/serial/max310x.c: error: label ‘err_spi_register’
> >   defined but not used...
> >   drivers/tty/serial/max310x.c: error: ‘regcfg’ defined but not used
> > 
> > Fix by properly encapsulating i2c/spi code/variables in their respective
> > context with IS_ENABLED() macros for CONFIG_I2C and CONFIG_SPI_MASTER.
> > 
> > Also fix link failure with SERIAL_MAX310X=y and I2C=m by modifying Kconfig
> > depends.
> > 
> > Fixes: 20ffe4b3330a8 ("serial: max310x: allow driver to be built with SPI or I2C")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202605121847.N9DVLNg2-lkp@intel.com/
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > note: not Cc-ing stable as the commit is still in tty-next, and even if the
> > errors originate from original commit that added I2C support, they were not
> > trigerred because the driver could not be selected/compiled if
> > CONFIG_SPI_MASTER was disabled.
> > 
> > Changes for v3:
> > - Fix link failure with SERIAL_MAX310X=y and I2C=m (Arnd Bergmann)
> > 
> > Changes for v2:
> > - replace #ifdef with #if IS_ENABLED() to suppoirt both built-in and modules
> >   options
> > ---
> >  drivers/tty/serial/Kconfig   |  2 +-
> >  drivers/tty/serial/max310x.c | 48 +++++++++++++++++++-----------------
> >  2 files changed, 27 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index f834e5d292fd7..4accbfa75074c 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -321,7 +321,7 @@ config SERIAL_MAX3100
> >  
> >  config SERIAL_MAX310X
> >  	tristate "MAX310X support"
> > -	depends on SPI_MASTER || I2C
> > +	depends on (SPI_MASTER && !I2C) || I2C
> >  	select SERIAL_CORE
> >  	select REGMAP_SPI if SPI_MASTER
> >  	select REGMAP_I2C if I2C
> 
> Other than preferring Arnd's Kconfig dependencies (easier to
> read/understand IMO), this is all good.
> Thanks.

Hi Randy,
thank you for testing this.

I personnaly think both syntaxes are confusing :)

I have a long term goal of converting this driver to core and
I2C/SPI parts eventually, like I did for the sc16is7xx...

Hugo.


> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> -- 
> ~Randy
