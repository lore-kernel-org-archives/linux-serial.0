From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Date: Fri, 18 Jan 2019 12:59:58 +0100
Message-ID: <20190118115958.GA5532@kroah.com>
References: <20190114012528.2367-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190114012528.2367-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 13, 2019 at 05:25:25PM -0800, Tony Lindgren wrote:
> Hi all,
> 
> Here's a series of patches to add initial serdev support to n_gsm
> TS 27.010 line discipline.
> 
> This allows handling vendor specific protocols on top of TS 27.010 and
> allows creating simple serdev drivers where it makes sense. So far I've
> tested it with droid 4 for it's modem to provide char devices for AT
> ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.
> 
> I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
> For reference, the MFD driver is at [0], the GNSS driver at [1], and
> the Alsa ASoC driver at [2] below.

I have applied the first two patches to my tree, as those are nice
cleanups.

The last one I want some feedback from the serdev developers to verify
all is set up properly, and Johan, to see if this ends up conflicting
with the gnss code, as that would not be good.

thanks,

greg k-h
