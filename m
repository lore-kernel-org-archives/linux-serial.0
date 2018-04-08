From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Date: Sun, 8 Apr 2018 09:50:38 -0700
Message-ID: <20180408165038.GM5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408090259.GA8185@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Dan Williams <dcbw@redhat.com>, Jiri Prchal <jiri.prchal@aksignal.cz>, Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Michael Scott <michael.scott@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Russ Gorby <russ.gorby@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-serial@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180408 09:04]:
> I guess I'd like to test this on Droid4; there are fso-gsm0710muxd and
> gsm0710muxd packages in Debian, but I assume those do multiplexing in
> userspace and thus are not suitable?

I don't think those are needed, we now have kernel n_gsm driver do
most of the work for us :) Doing ldattach config is still needed,
but eventually we should have a serdev driver do that too for us.

So apps should only do the ldattach part if node yet already done,
and just attempt to use /dev/gsmtty* ports directly.

I did get serdev working with n_gsm several weeks ago with horrible
hacks, it needs quite a bit more work though before it's ready..

Then we need to add proxying of some /dev/gsmtty* ports to W3GLTE to
get that working (US only AFAIK for the band). It might make sense
to add the proxy features to ModemManager eventually.

> Do you have a tool to use and a script?

Yes I used the shell script I posted earlier, but forgot it also
needs the ldattach done.

Anyways, last night and today I wrote a quick test utility called
droid4-ngsm that initializes things and I can use to do some
experiments to get the ts27010 channel proxying to W3GLTE also
going:

http://github.com/tmlind/droid4-ngsm/

Sorry could not resist adding a test call feature too :)

Hmm it might be best to add the ts27010 support and proxying
eventually to ModemManager? I think ofono and others could still
use the /dev/gsmtty* ports for the modem as needed too?

Regards,

Tony
