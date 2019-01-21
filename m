From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Date: Mon, 21 Jan 2019 11:57:35 +0100
Message-ID: <20190121105735.GI3691@localhost>
References: <20190114012528.2367-1-tony@atomide.com>
 <20190118115958.GA5532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118115958.GA5532@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>, Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-serial@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-serial@vger.kernel.org

Adding Marcel on CC.

On Fri, Jan 18, 2019 at 12:59:58PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Jan 13, 2019 at 05:25:25PM -0800, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here's a series of patches to add initial serdev support to n_gsm
> > TS 27.010 line discipline.
> > 
> > This allows handling vendor specific protocols on top of TS 27.010 and
> > allows creating simple serdev drivers where it makes sense. So far I've
> > tested it with droid 4 for it's modem to provide char devices for AT
> > ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.
> > 
> > I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
> > For reference, the MFD driver is at [0], the GNSS driver at [1], and
> > the Alsa ASoC driver at [2] below.
> 
> I have applied the first two patches to my tree, as those are nice
> cleanups.
> 
> The last one I want some feedback from the serdev developers to verify
> all is set up properly, and Johan, to see if this ends up conflicting
> with the gnss code, as that would not be good.

I think we need to have a discussion about how to model modems generally
before getting into implementation details.

Modems are currently managed by user space (e.g. through ofono) and
I'm not sure that moving only parts of its responsibilities into the
kernel is necessarily the right thing to do. You still need coordination
between the various components for things like power management.

TS 27.010 may make it seem like we can move everything into the kernel,
but Tony's to-be-posted Motorola MFD driver is still exposing character
devices for most of the muxed ports. If I understand things correctly,
there also still needs to be some coordination with USB over which some
channels are handled (e.g. IP over USB, gnss over muxed UART).

Instead of adding these extra layers, only to export most ports to user
space again, it may be better to hook into the various kernel subsystems
through dedicated user-space-implementation interfaces such as the
suggested ugnss interface, which means that user space feeds gnss data
into the kernel which in turn makes it available through a standard
interface.

This would also allow things to work for other transports such as USB
CDC for which the mux protocol isn't used.

Johan
