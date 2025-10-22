Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384D34B420;
	Wed, 22 Oct 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142624; cv=none; b=Co1gVbp4LNOCpgx38ZRW7I3VeotL4nAEcH71YBBPJq3w2BnHaEsdeIcKgy3+6QANDjcnwWgDCUpFPATXqRWKuyonhqk+zBex6mNIC6QMXWM7AFKfqZ+2A68z2YPg2Jui/Al3fsxKF/19CD/RZH6N7UDY9z6YrQ2eBrJ/GxSzCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142624; c=relaxed/simple;
	bh=kEIdNZsYYnfkyuznqSp9VAPd2ZdXepekczU5RzpTfTU=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=A0ySh9o3FahKnB290jaPMdP75F2RQSG4zqncvziNlVU3B2NcJuTsA/wu+HR4LPme0Js3KVfVf5eWpjsjJ9gpAVqJ6K6iApwK5uIX/4gjiKr3KBkjMQZZ/ViXJpIyT7oPoftRk25RNJ2R3i/YEIKEPxHfQwhsZucYRWxdgokLTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=AEdiDaU+; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="AEdiDaU+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=1+PD1+X2bVQnaXpw26bvZRG1dWHXqNR8+UJ3fGypRBc=; b=AEdiDaU+ss1sUqqtNMckb1Mo9d
	n0oOmyJupvICWKCR+x8ZtDizgp9qCc3fpx4pRSzUpC2gm4uRibwxwtziZjTN02Z01H7s99cwHSDxW
	AU/V/kd3wLm7YqDKmUjeQy0O8uQzWXJE4CxWsiIX+oE7wgFClr9fFfLRW96eXKJflSnE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47074 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vBZe0-0005NK-5F; Wed, 22 Oct 2025 10:16:52 -0400
Date: Wed, 22 Oct 2025 10:16:51 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel test robot <lkp@intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, oe-kbuild-all@lists.linux.dev,
 linux-serial@vger.kernel.org
Message-Id: <20251022101651.7c3ba0adb027f60bcf25be2e@hugovil.com>
In-Reply-To: <2025102247-siesta-straw-5006@gregkh>
References: <202510222048.fnK8S60G-lkp@intel.com>
	<20251022095524.76e0377f7efcbce531ba52be@hugovil.com>
	<2025102247-siesta-straw-5006@gregkh>
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
	* -1.9 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [tty:tty-testing 11/22] drivers/tty/serial/sc16is7xx.c:596:9:
 error: implicit declaration of function 'sc16is7xx_efr_lock'; did you mean
 'sc16is7xx_regs_lock'?
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 22 Oct 2025 16:08:21 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Oct 22, 2025 at 09:55:24AM -0400, Hugo Villeneuve wrote:
> > On Wed, 22 Oct 2025 21:07:24 +0800
> > kernel test robot <lkp@intel.com> wrote:
> > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> > > head:   cdca3a77b423691b0e3780653642cd5b31de8bd8
> > > commit: 5a91e16ba44d9850088278ebe209b5c533f87cb8 [11/22] serial: sc16is7xx: define common register access function
> > > config: x86_64-buildonly-randconfig-003-20251022 (https://download.01.org/0day-ci/archive/20251022/202510222048.fnK8S60G-lkp@intel.com/config)
> > > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510222048.fnK8S60G-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202510222048.fnK8S60G-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_set_baud':
> > > >> drivers/tty/serial/sc16is7xx.c:596:9: error: implicit declaration of function 'sc16is7xx_efr_lock'; did you mean 'sc16is7xx_regs_lock'? [-Wimplicit-function-declaration]
> > >      596 |         sc16is7xx_efr_lock(port);
> > >          |         ^~~~~~~~~~~~~~~~~~
> > >          |         sc16is7xx_regs_lock
> > > >> drivers/tty/serial/sc16is7xx.c:600:9: error: implicit declaration of function 'sc16is7xx_efr_unlock'; did you mean 'sc16is7xx_regs_unlock'? [-Wimplicit-function-declaration]
> > >      600 |         sc16is7xx_efr_unlock(port);
> > >          |         ^~~~~~~~~~~~~~~~~~~~
> > >          |         sc16is7xx_regs_unlock
> > > 
> > > 
> > > vim +596 drivers/tty/serial/sc16is7xx.c
> > > 
> > > dbf4ab821804df0 Hugo Villeneuve 2023-12-11  572  
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  573  /*
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  574   * Configure programmable baud rate generator (divisor) according to the
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  575   * desired baud rate.
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  576   *
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  577   * From the datasheet, the divisor is computed according to:
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  578   *
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  579   *              XTAL1 input frequency
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  580   *             -----------------------
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  581   *                    prescaler
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  582   * divisor = ---------------------------
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  583   *            baud-rate x sampling-rate
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  584   */
> > > dfeae619d781dee Jon Ringle      2014-04-24  585  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> > > dfeae619d781dee Jon Ringle      2014-04-24  586  {
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  587  	unsigned int prescaler = 1;
> > > dfeae619d781dee Jon Ringle      2014-04-24  588  	unsigned long clk = port->uartclk, div = clk / 16 / baud;
> > > dfeae619d781dee Jon Ringle      2014-04-24  589  
> > > 2e57cefc4477659 Hugo Villeneuve 2023-12-21  590  	if (div >= BIT(16)) {
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  591  		prescaler = 4;
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  592  		div /= prescaler;
> > > dfeae619d781dee Jon Ringle      2014-04-24  593  	}
> > > dfeae619d781dee Jon Ringle      2014-04-24  594  
> > > dfeae619d781dee Jon Ringle      2014-04-24  595  	/* Enable enhanced features */
> > > 0c84bea0cabc4e2 Hugo Villeneuve 2023-12-21 @596  	sc16is7xx_efr_lock(port);
> > > c112653b89e0cea Lech Perczak    2022-02-21  597  	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
> > > c112653b89e0cea Lech Perczak    2022-02-21  598  			      SC16IS7XX_EFR_ENABLE_BIT,
> > > dfeae619d781dee Jon Ringle      2014-04-24  599  			      SC16IS7XX_EFR_ENABLE_BIT);
> > > 0c84bea0cabc4e2 Hugo Villeneuve 2023-12-21 @600  	sc16is7xx_efr_unlock(port);
> > > 30ec514d440cf2c Phil Elwell     2018-09-12  601  
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  602  	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
> > > dfeae619d781dee Jon Ringle      2014-04-24  603  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
> > > dfeae619d781dee Jon Ringle      2014-04-24  604  			      SC16IS7XX_MCR_CLKSEL_BIT,
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  605  			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
> > > dfeae619d781dee Jon Ringle      2014-04-24  606  
> > > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  607  	/* Access special register set (DLL/DLH) */
> > > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  608  	sc16is7xx_regs_lock(port, SC16IS7XX_LCR_REG_SET_SPECIAL);
> > > dfeae619d781dee Jon Ringle      2014-04-24  609  
> > > dfeae619d781dee Jon Ringle      2014-04-24  610  	/* Write the new divisor */
> > > dfeae619d781dee Jon Ringle      2014-04-24  611  	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
> > > dfeae619d781dee Jon Ringle      2014-04-24  612  	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
> > > dfeae619d781dee Jon Ringle      2014-04-24  613  
> > > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  614  	/* Restore access to general register set */
> > > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  615  	sc16is7xx_regs_unlock(port);
> > > 7d3b793faaab130 Hugo Villeneuve 2024-07-23  616  
> > > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  617  	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
> > > dfeae619d781dee Jon Ringle      2014-04-24  618  }
> > > dfeae619d781dee Jon Ringle      2014-04-24  619  
> > > 
> > > :::::: The code at line 596 was first introduced by commit
> > > :::::: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056 serial: sc16is7xx: refactor EFR lock
> > > 
> > > :::::: TO: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > 
> > Hi Greg,
> > this patch, and other patches in this series, depends on the patch
> > "serial: sc16is7xx: remove useless enable of enhanced features"
> > that you just added to your tty-linus tree.
> > 
> > If you first add this patch to tty-testing, then the error
> > disappear.
> 

> Ugh, that was not obvious at all :(

Hi Greg,
sorry about that.

> I'll go drop all of these from my tty-next branch, can you resend them
> when I merge -rc3 into that branch so that things do not break?

No problem, in fact that is what I was planning to do all along,
sending a v3 of the series once patch "serial: sc16is7xx: remove
useless enable of enhanced features" lands in tty-testing or tty-next.

Hugo.
