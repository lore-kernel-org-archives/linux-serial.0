Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Ui2Yfvh7"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5D1BB;
	Wed, 22 Nov 2023 00:16:29 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 7327760859;
	Wed, 22 Nov 2023 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1700640989;
	bh=iwEe8AChNtrIiZ7XKdpROYcuo5U7nwfBFHt7j6A3wdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ui2Yfvh7LyuXcYTSk07DZ43XbcDuV7/Iqan6N4V5EXikxAZ4zYYzZBJtnZshDqu/x
	 FYVLFo7fdIgEGlL8b/SxEvWGKW+HFnSbenPQhJXryaviKCLW9Xh+EdyHs/hHxMvTWk
	 /pMiUO+4TmdVIN/0Qt7TtehHI0vwNOEtli1+zfTiHW5f/IDcKLoalZuJWNVOikUg94
	 YcyHJKLTt2a+pKjgKOYbH68caZ4qFT8AoGSuZxi3jbdrvK9nX+81KCmN/Pl2aU1yEx
	 4UAaGn6e0c9vwsjWCbmLw2gbSMjyzpijBR0RIrpxwk0da/mWnUbH8ZKIUP0bpW2bFE
	 KamNaZBtG5lcQ==
Date: Wed, 22 Nov 2023 10:15:54 +0200
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
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <20231122081554.GG5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-4-tony@atomide.com>
 <20231122070353.GF5169@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122070353.GF5169@atomide.com>

* Tony Lindgren <tony@atomide.com> [231122 09:04]:
> * Tony Lindgren <tony@atomide.com> [700101 02:00]:
> > -	__add_preferred_console(buf, idx, options, brl_options, true);
> >  	return 1;
> 
> Looks like this can't be dropped yet. We need to keep it for the
> brl_options. I'll change it to return early if brl_options is NULL.

Looks like we can drop the parsing from printk :) In console_setup()
we can call console_opt_save() after _braille_console_setup(), and
then save also the brl_options for the port.

Regards,

Tony
