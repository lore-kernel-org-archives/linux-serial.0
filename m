From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Date: Fri, 31 Mar 2017 15:33:53 +0200
Message-ID: <20170331133353.GA32267@kroah.com>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 29, 2017 at 11:33:26PM +0200, Marcel Holtmann wrote:
> Hi Rob,
> 
> >> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all comments from
> >> Rob and Pavel regarding the serdev patches and dropped the *.dts patches, since
> >> they were queued by Tony. I also changed the patch order, so that the serdev
> >> patches come first. All of them have Acked-by from Rob, so I think it makes
> >> sense to merge them to serdev subsystem (now) and provide an immutable branch
> >> for the bluetooth subsystem.
> > 
> > Greg doesn't read cover letters generally and since the serdev patches
> > are Cc rather than To him, he's probably not planning to pick them up.
> 
> I wonder actually if we should merge all of these via bluetooth-next
> tree with proper Ack from Greg. However it would be good to also get
> buy in from Dave for merging this ultimately through net-next.

I don't really care where it goes.  I can take the whole thing in my
tty/serial tree now if no one objects and I get an ack from the relevant
maintainers {hint...}

thanks,

greg k-h
