Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6736FD6;
	Mon, 18 Dec 2023 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Oz3efwNp"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 094486034F;
	Mon, 18 Dec 2023 06:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1702881550;
	bh=GLn3ZdId44kKuoXDyTPyXwA7XHwYr/rDf/W6Y2K7uH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oz3efwNpCCA2yRrD/l/kGm7l3o8CjWsdxkkWABTbImDluEBBjnV5tkkGORMYkhSfX
	 EVYHCRASKXoo1zFtCzMrowtfc3KRA1VeRBq6WaFwGHqdqQKG6VQqSOQkYMTSacaj8E
	 tGLqBor/xOnkbA73lM9p5CvhcSJXQMu8cW/gsI0pUKv0d9bYBnTeejmyODz0k/25Qu
	 +VVHfeeo8osQ7l5gNt8f8rIktOcSApZ0pKFAawDKgY/7BcE7pAEDiwMyOlyBJ/l1gC
	 YP8hTEYGdM1oOGazWLAzFN0nK+tcaauota9MQ4JWxOgMDOO4dX4zQp/SEW/0G+MOd5
	 4L8mzZJPEfB1g==
Date: Mon, 18 Dec 2023 08:38:37 +0200
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add support for DEVNAME:0.0 style hardware based
 addressing
Message-ID: <20231218063837.GS5166@atomide.com>
References: <20231205073255.20562-1-tony@atomide.com>
 <20231205074557.GM5169@atomide.com>
 <20231208082832.GV5169@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208082832.GV5169@atomide.com>

* Tony Lindgren <tony@atomide.com> [231208 10:29]:
> * Tony Lindgren <tony@atomide.com> [700101 02:00]:
> > * Tony Lindgren <tony@atomide.com> [700101 02:00]:
> > > We also prepare the serial core to handle the ttyS related quirks done
> > > in console_setup() to prepare things for eventually dropping the parsing
> > > from console_setup(). This can only happen after further changes to
> > > register_console().
> > 
> > Petr FYI, so for dropping the console_setup() parsing, below is a hack
> > patch to see what goes wrong in register_console() if you have some ideas
> > on how to handle this.
> > 
> > We end up with the console device backed up seria8250 instead of ttyS0,
> > and earlycon won't get properly disabled. And of course other consoles
> > beyond ttyS need to be also considered.
> 
> Hmm so the following extra patch seems to fix the issues based on light
> testing. But is it safe to assume that if CON_PRINTBUFFER is set we can
> disable the bootconsole?

OK so no need for the CON_PRINTBUFFER change, it's wrong. I found a few
bugs causing this issue and a lot of other confusion while testing:

- In console_setup(), a DEVNAME:0.0 style console can get added with the
  IO address turned into a ttyS console with some crazy index :) So we
  need to bail out early on consoles with ':' in the name.

- The brl_opts can be empty or NULL, but we need to pass NULL to
  __add_preferred_console() to get CON_CONSDEV flag set for DEVNAME:0.0
  console. Otherwise the preferred_console won't get set and the boot
  console won't get disabled.

- The console_set_on_cmdline flag needs to be set if console_setup()
  does not call __add_preferred_console() for DEVNAME:0.0 style console
  as otherwise try_enable_default_console() may get called before the
  console handling driver has added the preferred console.

I think with these the remaining issues are sorted out :) I'll post a
v5 set with as RFC as it's getting close to the merge window.

Regards,

Tony
