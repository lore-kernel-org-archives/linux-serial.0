From: Johan Hovold <johan@kernel.org>
Subject: Re: [RFC lora-next 5/5] HACK: net: lora: sx130x: Add PicoCell
 gateway shim for cdc-acm
Date: Mon, 7 Jan 2019 16:28:34 +0100
Message-ID: <20190107152834.GC14782@localhost>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-6-afaerber@suse.de>
 <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
 <9d97fec5-31b0-8717-cd10-de4f36d1cf05@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9d97fec5-31b0-8717-cd10-de4f36d1cf05@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Rob Herring <robh@kernel.org>, linux-lpwan@lists.infradead.org, linux-serial <linux-serial@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>, "David S. Miller" <davem@davemloft.net>, Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev <netdev@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 05, 2019 at 12:43:48AM +0100, Andreas Färber wrote:
> Hi Rob,
> 
> Am 04.01.19 um 18:07 schrieb Rob Herring:
> > On Fri, Jan 4, 2019 at 5:21 AM Andreas Färber <afaerber@suse.de> wrote:
> >>
> >> Ignore our device in cdc-acm probing and add a new driver for it,
> >> dispatching to cdc-acm for the actual implementation.
> >>
> >> WARNING: It is likely that this VID/PID is in use for unrelated devices.
> >> Only the Product string hints what this really is in current v0.2.1.
> >> Previous code v0.2.0 was using a Semtech VID/PID, but no card shipping
> >> with such firmware is known to me.
> >>
> >> While this may seem unorthodox, no internals of the driver are accessed,
> >> just the set of driver callbacks is duplicated as shim.
> >>
> >> Use this shim construct to fake DT nodes for serdev on probe.
> >> For testing purposes these nodes do not have a parent yet.
> >> This results in two "Error -2 creating of_node link" warnings on probe.
> > 
> > It looks like the DT is pretty static. Rather than creating the nodes
> > at run-time, can't you create a dts file and build that into your
> > module.
> 
> Heh, if that were the only issue with this patch... ;)

My thoughts exactly. ;)

This clearly is too much of a hack, but maintaining serdev compatible
information in the corresponding tty drivers is probably what we'll want
to do.

When the tty driver binds and registers its ports with tty core, we can
could match again on the USB descriptors, but since the device has
already been matched, we can just pass the equivalent of a compatible
string, or more generally dt-fragment, instead.

Without having had time to look into it myself yet, this sounds like
something we should be using the new software nodes for (software
generated fw nodes). That way, we don't depend on CONFIG_OF either.

Johan
