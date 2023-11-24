Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="fOyeZFM3"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330591;
	Thu, 23 Nov 2023 22:32:51 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 1DB30603EE;
	Fri, 24 Nov 2023 06:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1700807571;
	bh=+gS/X74h4UfVNPZhsitLFhRKfvXbk2HaAi+3m9/w4LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOyeZFM3XB/N1+TWPkAPihd+noaGWJronK71K0i3yOCY4UcLBv1uy0Mq2MrhaW5sw
	 L4fWQqlSnNwNM4oVau/CDo1e6vK0+H9Sa1Qnal8PBAV9kQ1REiOgueHKoHaCb/3t2t
	 yZntys8VgzYz07KKMJVtaV+czADccc7zutPFMiv2U1IAdF5JP2BH8MMUmHXvQ3WtHX
	 NXIe/acjhZKOzAA2QpDnySk9I7tLMJYuaJmMh0hsENtiUIIBnGFACcoG4S3WXHXI2R
	 H4BmW0ylNun2MKKfpeTN6NzDcA5hxRPfwA+u0B6d1pQF2SkROP87ijITBwdeXHIC+n
	 xAapRrmmE8Viw==
Date: Fri, 24 Nov 2023 08:32:10 +0200
From: Tony Lindgren <tony@atomide.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <20231124063210.GI5169@atomide.com>
References: <20231121113203.61341-4-tony@atomide.com>
 <6933c98f-7f76-4955-ba0f-89ea340b672d@suswa.mountain>
 <8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain>

* Dan Carpenter <dan.carpenter@linaro.org> [231123 07:29]:
> On Thu, Nov 23, 2023 at 10:24:24AM +0300, Dan Carpenter wrote:
> > Hi Tony,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/printk-Save-console-options-for-add_preferred_console_match/20231121-193809
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > patch link:    https://lore.kernel.org/r/20231121113203.61341-4-tony%40atomide.com
> > patch subject: [PATCH v3 3/3] serial: core: Move console character device handling from printk
> > config: parisc-randconfig-r081-20231122 (https://download.01.org/0day-ci/archive/20231122/202311221437.5Gil0Pml-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231122/202311221437.5Gil0Pml-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Closes: https://lore.kernel.org/r/202311221437.5Gil0Pml-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/tty/serial/serial_base_bus.c:266 serial_base_add_preferred_console() error: uninitialized symbol 'nmbr_match'.
> > drivers/tty/serial/serial_base_bus.c:265 serial_base_add_preferred_console() error: uninitialized symbol 'char_match'.
> > 
> > vim +/nmbr_match +266 drivers/tty/serial/serial_base_bus.c
> > 
> > e4ebdcd790e0f3 Tony Lindgren 2023-11-21  261  int serial_base_add_preferred_console(struct uart_driver *drv,
> > e4ebdcd790e0f3 Tony Lindgren 2023-11-21  262  				      struct uart_port *port)
> > e4ebdcd790e0f3 Tony Lindgren 2023-11-21  263  {
> > e4ebdcd790e0f3 Tony Lindgren 2023-11-21  264  	const char *port_match __free(kfree);
> > b1b8726ec3f40b Tony Lindgren 2023-11-21 @265  	const char *char_match __free(kfree);
> > b1b8726ec3f40b Tony Lindgren 2023-11-21 @266  	const char *nmbr_match __free(kfree);
> > 
> > These need to be initialized to NULL.
> > 
> > 	const char *char_match __free(kfree) = NULL;
> > 
> 
> Let's add a todo to make checkpatch warn about this.
> 
> KTODO: make checkpatch warn about __free() functions without an initializer

Yes good idea.

Thanks,

Tony
