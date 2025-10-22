Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1134B664;
	Wed, 22 Oct 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142105; cv=none; b=re7c0J7YJiTQ5IkjlPD/NuqjKUVKQmFQWqinJ4eLsJeRLofVfSIOu1AEFqQ9IfrQjSjDrgX7TxWeYCF8Q5KuwTTkS5SIljahEpC7FJQ2s3RWnfrqJiHg6FXn55Ge21Dya+cK8vgippYkZ+rEjitOTUkFD0VhNay2IRh+1mgm+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142105; c=relaxed/simple;
	bh=0cntgMCkpELX2mMus6h4KC/81rRj41w66TUYtJFxMb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfGTneoRiYDQ5JMCiCwMZ1adNLiIoLdFit1GfeJEGKYwRrzqRagTHxkNq+Sxu58Inioq2T+7zQ39cVldeeGRkiuBS8hqsvlMcmUc0PTlIPxtisHTkLV6+bWLqaZxE1yCf1mkDdQ1XmA3JjRCKcQhjOPx8elSDTLBfechvQ081a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kIDhETLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kIDhETLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BABBC4CEFF;
	Wed, 22 Oct 2025 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761142104;
	bh=0cntgMCkpELX2mMus6h4KC/81rRj41w66TUYtJFxMb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIDhETLYYAF4HvxrNI0FiscUxcSx03WFX1jz1dYQ/QMYO7UXFNE0LPoKemAQaDm9P
	 TW/vN3VwWSjxd42cAe/Whnox9FNHwqiYLzuUAgw0F/W818dmODW9JOd6AjxXZTx7hI
	 ucwGhxrjzKAbQZxcE2JeS+EOUZDNl7QYI9FJucvg=
Date: Wed, 22 Oct 2025 16:08:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: kernel test robot <lkp@intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [tty:tty-testing 11/22] drivers/tty/serial/sc16is7xx.c:596:9:
 error: implicit declaration of function 'sc16is7xx_efr_lock'; did you mean
 'sc16is7xx_regs_lock'?
Message-ID: <2025102247-siesta-straw-5006@gregkh>
References: <202510222048.fnK8S60G-lkp@intel.com>
 <20251022095524.76e0377f7efcbce531ba52be@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022095524.76e0377f7efcbce531ba52be@hugovil.com>

On Wed, Oct 22, 2025 at 09:55:24AM -0400, Hugo Villeneuve wrote:
> On Wed, 22 Oct 2025 21:07:24 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> > head:   cdca3a77b423691b0e3780653642cd5b31de8bd8
> > commit: 5a91e16ba44d9850088278ebe209b5c533f87cb8 [11/22] serial: sc16is7xx: define common register access function
> > config: x86_64-buildonly-randconfig-003-20251022 (https://download.01.org/0day-ci/archive/20251022/202510222048.fnK8S60G-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510222048.fnK8S60G-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202510222048.fnK8S60G-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_set_baud':
> > >> drivers/tty/serial/sc16is7xx.c:596:9: error: implicit declaration of function 'sc16is7xx_efr_lock'; did you mean 'sc16is7xx_regs_lock'? [-Wimplicit-function-declaration]
> >      596 |         sc16is7xx_efr_lock(port);
> >          |         ^~~~~~~~~~~~~~~~~~
> >          |         sc16is7xx_regs_lock
> > >> drivers/tty/serial/sc16is7xx.c:600:9: error: implicit declaration of function 'sc16is7xx_efr_unlock'; did you mean 'sc16is7xx_regs_unlock'? [-Wimplicit-function-declaration]
> >      600 |         sc16is7xx_efr_unlock(port);
> >          |         ^~~~~~~~~~~~~~~~~~~~
> >          |         sc16is7xx_regs_unlock
> > 
> > 
> > vim +596 drivers/tty/serial/sc16is7xx.c
> > 
> > dbf4ab821804df0 Hugo Villeneuve 2023-12-11  572  
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  573  /*
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  574   * Configure programmable baud rate generator (divisor) according to the
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  575   * desired baud rate.
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  576   *
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  577   * From the datasheet, the divisor is computed according to:
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  578   *
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  579   *              XTAL1 input frequency
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  580   *             -----------------------
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  581   *                    prescaler
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  582   * divisor = ---------------------------
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  583   *            baud-rate x sampling-rate
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  584   */
> > dfeae619d781dee Jon Ringle      2014-04-24  585  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
> > dfeae619d781dee Jon Ringle      2014-04-24  586  {
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  587  	unsigned int prescaler = 1;
> > dfeae619d781dee Jon Ringle      2014-04-24  588  	unsigned long clk = port->uartclk, div = clk / 16 / baud;
> > dfeae619d781dee Jon Ringle      2014-04-24  589  
> > 2e57cefc4477659 Hugo Villeneuve 2023-12-21  590  	if (div >= BIT(16)) {
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  591  		prescaler = 4;
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  592  		div /= prescaler;
> > dfeae619d781dee Jon Ringle      2014-04-24  593  	}
> > dfeae619d781dee Jon Ringle      2014-04-24  594  
> > dfeae619d781dee Jon Ringle      2014-04-24  595  	/* Enable enhanced features */
> > 0c84bea0cabc4e2 Hugo Villeneuve 2023-12-21 @596  	sc16is7xx_efr_lock(port);
> > c112653b89e0cea Lech Perczak    2022-02-21  597  	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
> > c112653b89e0cea Lech Perczak    2022-02-21  598  			      SC16IS7XX_EFR_ENABLE_BIT,
> > dfeae619d781dee Jon Ringle      2014-04-24  599  			      SC16IS7XX_EFR_ENABLE_BIT);
> > 0c84bea0cabc4e2 Hugo Villeneuve 2023-12-21 @600  	sc16is7xx_efr_unlock(port);
> > 30ec514d440cf2c Phil Elwell     2018-09-12  601  
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  602  	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
> > dfeae619d781dee Jon Ringle      2014-04-24  603  	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
> > dfeae619d781dee Jon Ringle      2014-04-24  604  			      SC16IS7XX_MCR_CLKSEL_BIT,
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  605  			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
> > dfeae619d781dee Jon Ringle      2014-04-24  606  
> > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  607  	/* Access special register set (DLL/DLH) */
> > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  608  	sc16is7xx_regs_lock(port, SC16IS7XX_LCR_REG_SET_SPECIAL);
> > dfeae619d781dee Jon Ringle      2014-04-24  609  
> > dfeae619d781dee Jon Ringle      2014-04-24  610  	/* Write the new divisor */
> > dfeae619d781dee Jon Ringle      2014-04-24  611  	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
> > dfeae619d781dee Jon Ringle      2014-04-24  612  	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
> > dfeae619d781dee Jon Ringle      2014-04-24  613  
> > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  614  	/* Restore access to general register set */
> > 5a91e16ba44d985 Hugo Villeneuve 2025-10-02  615  	sc16is7xx_regs_unlock(port);
> > 7d3b793faaab130 Hugo Villeneuve 2024-07-23  616  
> > 8492bd91aa05590 Hugo Villeneuve 2024-04-30  617  	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
> > dfeae619d781dee Jon Ringle      2014-04-24  618  }
> > dfeae619d781dee Jon Ringle      2014-04-24  619  
> > 
> > :::::: The code at line 596 was first introduced by commit
> > :::::: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056 serial: sc16is7xx: refactor EFR lock
> > 
> > :::::: TO: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> Hi Greg,
> this patch, and other patches in this series, depends on the patch
> "serial: sc16is7xx: remove useless enable of enhanced features"
> that you just added to your tty-linus tree.
> 
> If you first add this patch to tty-testing, then the error
> disappear.

Ugh, that was not obvious at all :(

I'll go drop all of these from my tty-next branch, can you resend them
when I merge -rc3 into that branch so that things do not break?

thanks,

greg k-h
