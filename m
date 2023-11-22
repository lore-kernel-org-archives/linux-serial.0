Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="JSEVesTc"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4550419D;
	Tue, 21 Nov 2023 23:04:26 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A6E7860513;
	Wed, 22 Nov 2023 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1700636665;
	bh=VXGR8xQGZzWXW6baSZHRlpOMY386TuOcB9XLnlAtLsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSEVesTcdCirCXWm9j2QFnmIl2byVFl2VpYF4FPb9Y9egs/H5xk3uYM4wnZCSBURQ
	 X+0wi12ozQewEC3JjKlo2I8Zig5kcBp/evrX4j5QmjNwSk7S5wpIprE97JareGLhSZ
	 anqVwDs6jeDH+ilFU0gOiV+ROWA0MmBclmF6tp1Owlf73zK06mVLWAqb4TlqDVDshX
	 rLbP4IrOyUcBhpAs0hVt4nJuNEkwfhZx3IUaLyMtLEeyHgtdWc88Eu+iXV/xMlE9KI
	 tzmy9KDsrlcDjFj6bBPEA3Zo/5s9/+XXnE50Q4oqOHW1UKYj5Br/ovHIT3O8SyNRIN
	 1v8q0jRwbHZ6A==
Date: Wed, 22 Nov 2023 09:03:53 +0200
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
Message-ID: <20231122070353.GF5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-4-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121113203.61341-4-tony@atomide.com>

* Tony Lindgren <tony@atomide.com> [700101 02:00]:
> -	__add_preferred_console(buf, idx, options, brl_options, true);
>  	return 1;

Looks like this can't be dropped yet. We need to keep it for the
brl_options. I'll change it to return early if brl_options is NULL.

Regards,

Tony
