From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Mon, 16 Apr 2018 07:47:09 -0700
Message-ID: <20180416144709.GC5669@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
 <20180412212412.GA29243@amd>
 <20180413002415.GC5700@atomide.com>
 <20180416084439.GA5489@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180416084439.GA5489@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180416 08:46]:
> Ahha, so first I missed two of the patches, and second, I was not
> patient enough. I was stopping my test after first or second
> error. Now I get... so I guess it works for me.

OK good to hear.

> For the series:
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks for testing.

> Testing ngsm..
> 1> U0000AT+CFUN?
> 1<

Hmm droid4-ngsm should show the response or error out as you
already probably figured out :)

Regards,

Tony
