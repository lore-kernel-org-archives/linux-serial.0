From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 11:01:07 +0000
Message-ID: <20160115110106.GA3262@leverpostej>
References: <20150511013540.5709.93626.stgit@notabene.brown>
 <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com>
 <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
 <20160113191542.GA12086@leverpostej>
 <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 15, 2016 at 10:34:51AM +0100, H. Nikolaus Schaller wrote:
> Hi Mark,
> 
> Am 13.01.2016 um 20:15 schrieb Mark Rutland <mark.rutland@arm.com>:
> 
> > On Tue, Jan 12, 2016 at 02:28:00PM +0100, H. Nikolaus Schaller wrote:
> >> Hi Tomeu,
> >> 
> >> Am 12.01.2016 um 14:06 schrieb Tomeu Vizoso <tomeu@tomeuvizoso.net>:
> >> 
> >>> On 11 May 2015 at 03:56, NeilBrown <neil@brown.name> wrote:
> >>>> Hi all,
> >>>> here is version 4 of my "UART slave device" patch set, previously
> >>>> known as "tty slave devices".
> >>> 
> >>> Hi Neil,
> >>> 
> >>> do you (or someone else) have plans to continue this work in the short
> >>> or medium term?
> >> 
> >> yes, there is something in our upstreaming pipeline. This one works for us on top of 4.4.0:
> >> 
> >> <http://git.goldelico.com/?p=gta04-kernel.git;a=shortlog;h=refs/heads/work/hns/misc/w2sg-tty-slave2-v4>
> >> 
> >> There is one point still to be solved: the exact style of the DT bindings.
> >> 
> >> We have an idea how a driver can implement two different styles (child node AND phandle)
> >> so that it is up to the DTS developer to use the one that best fits into the existing DTS.
> > 
> > From my perspective as a binding maintainer, and as I stated before, the
> > child node approach made the most sense and was most consistent with the
> 
> > way we handle other devices.
> 
> I simply don't see that this is the most common way other devices are handled.
> 
> I find many counter-examples which use phandles:
> * gpios
> * regulators
> * iio channels used by other drivers (e.g. iio-hwmon)
> * phy devices
> * timers
> * pwms
> * interrupts
> * dma

As was previously described to you, in these cases phandles are used
when these are _resources_ used by another device, not for the main
programmer-visible interface to the device.

Conceptually, A UART slave is far closer to SPI or I2C, where the slave
is represented as a sub-node.

I wasn't aware of any instances of timers being referred to by phandle
by other devices -- that seems distinctly odd. Where do you see that
happening.

> * mcbsp (see e.g. http://lxr.free-electrons.com/source/arch/arm/boot/dts/omap3-n900.dts#L127)

Subsystem type bindings are more of a special case, and regardless the
components have nodes in the relevant portions of the DT.

> * mmc-pwr-seq-simple (which does not even describe a physical piece of hardware)

If this is so different, how is it relevant?

> All of them define the provider in one node. And refer to it by a phandle in another node
> where they are used.
> 
> So I see a lot of provider-consumer relationships modeled by phandles but not by child nodes.

I agree that provider-consumer type relationships are typically
described in this manner.

However, master-slave relationships are not.

> Next, if I look up real world DT sources, child nodes have in a majority of cases a
> reg = <...> or ranges = <...> entry to define specific addresses of each child node and
> to distinguish between them.
> 
> This is not always the case (e.g. children of the root node) but often. Therefore I assume
> the child-node pattern is mainly intended for distinguishing between multiple *addressable*
> subdevices connected to a single provider, i.e. some sort of "shared bus".

We can have MMC controllers that only have a single sub-device, yet this
may have a node for this, rather than using phandles. The addressability
has no bearing.

> In the specific problem I (and Neil) want to solve (GTA04 devices and
> more to come), the UART is simply a provider of serial data lines and
> power control events (or whatever the driver implementations want to
> do with the knowledge about this connection).
> 
> Although we have multiple such uart-device connections, they are all
> individual point-to-point.
> 
> Not a bus structure with multiple clients. So there are several simple
> provider-consumer relations.  Hence there is no urgent need for
> addresses of multiple child nodes of a single UART and no reg/ranges
> property.

As above, the addressability doesn't matter.

> Of course, with the child node approach it would give the flexibility
> to introduce such
> a feature easily in the future - but I don't see a use case. Not even at the horizon.
> 
> And I wonder how I should implement a driver if a child node provides a reg property.
> Should I invent and implement a protocol layer to make the UART an addressable bus?

Why would it have a reg property if it were a UART slave?

If a device has multiple slave interfaces, it requires separate nodes
for these. In that case, you'd need to group those together with phandle
references.

> But the chip I connect to an UART does not understand that and I can't change it.

I don't follow what you mean by this. In what way does the binding
description affect the physical device? Are you talking about a driver?

> So it is probably not expected by the uart-slaves story - and I have no need for addressability
> of multiple subnodes.
> 
> So I conclude: the single chip is the consumer of a simple UART provider and should therefore
> be described as a connection through a phandle. Like in all the other DT examples listed
> above. The best description is IMHO:
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/iio-bindings.txt
> 
> At least this is how I see the DT world when going through some device tree files
> and trying to deduce what the common style is.
> 
> This appears to be opposite to what you say: "most consistent with the way we
> handle other devices". I only find that other devices which understand some addressing
> scheme are handled that way.

It's consistent with the way we handle *slave* devices (i.e. we describe
the programming interface on a sub-node to the device that provides
access to that programming interface).

The phandle case describes side-band interfaces.

> > I don't understand what the benefit of supporting two styles of
> > description would be, relative to the maintenance cost.
> 
> Supporting both styles is a proposal to make both of us happy.
> 
> And there isn't much to be maintained. It is just a notice in the bindings document
> of uart-slaves that the phandle is optional, if the node is the single child node of an
> UART. If it isn't a subnode of an UART, or not at index 0, the phandle is needed
> to describe the cross-reference. So it can be seen as a simple extension to move
> the node outside but keep the link.
> 
> A rough estimate is that it requires just ~20 lines to implement in our driver (unless
> we need locks, error handling etc.).
> 
> Then, the DT developers (like me) can decide which style better fits into the DTS
> structure that already exists, when adding a salve device to some UART.

Which then leads to confusion as DTs are arbitrarily different for no
real reason. That makes things harder to maintain, even if only ~20
lines of code were necessary.

> My experience from almost daily work with device trees is that phandles give
> more flexibility in expressing the hardware structure in DT language. And they
> allow to better group properties. In this case: "I am connected to interface ...".
> 
> And the allow to easily modify it by includes and overlays to describe small hardware
> variants ("I am now connected to a different interface ..."). Moving a subnode between
> parents is difficult without multiple well designed include files, while for phandle
> there is a simple idiom:
> 
> 	#include <existing.dts(i)>
> 	&child { link = <&new-parent>; };
> 
> IMHO this is easy to read and understand. And I have used that pattern several
> times, e.g. for "adding" hardware to some evaluation board without touching the
> original DTS. So I don't want to miss it in this case.
> 
> > Nor do I
> > understand your fixation with the phandle approach,
> 
> Well, because I don't understand your fixation on the child node approach for this
> non-addressable point-to-point connection. Why prepare for a feature that nobody
> really needs and has asked for?

Addressability was not my main concern. Consistency with other "bus"
types is a major concern. See below for what I mean by "bus", as we are
clearly using the term differently.

> To be more specific:
> 
> * I find that the phandle approach better (more flexible) suits the problem I want to have solved.
> * there is no need for multiple child nodes for a point-to-point connection, because UART is rarely used as a bus.

In Linux terminology a "bus" is effectively anything that provides us
with a programming interface to some number of devices. That number may
be 1 (i.e. a point-to-point connection is just a particular case of a
"bus").

That is what I mean when I talk about a "bus", and that is why I believe
that UARTs should be treated as with other busses if we are going to
handle slave devices.

I appreciate that this is not quite its usual meaning

> * I see a lot of examples where phandles are intensively used and there it appears to be right to do so.
> 
> I just know that you conclude "child nodes made the most sense and was most consistent".
> 
> But I still wonder why. It does not appear to match what I observe in arch/arm/boot/dts
> and the problem I want to solve.
> 
> > given it has been
> > repeatedly disagreed with by binding maintainers.
> 
> Binding maintainers may sometimes be as wrong as I may be here. This needs a discussion
> but not a circular argument, that it already has been disagreed repeatedly.

We all make mistakes, certainly.

However, you have ignored the distinction that has been described
repeatedly w.r.t. slaves vs random side-band relationships.

> I may have missed it, but I am also not aware that there was a technical analysis of both
> approaches, comparing the pro's and con's. I had received requests to show code for the
> phandle approach and we provided it.
> 
> Coming to different conclusions can happen, if requirements are weighted differently. Or
> the problem to be solved is not completely understood. But then, the requirements and
> assumptions should be discussed (which is difficult on a patch-review-based discussion list).
> 
> On a more general level, the key problem is that *I* have to write and maintain a
> multitude of board specific DTS files (not all of them in mainline) using the style
> *you* decide.

While myself and others will be having to maintain bindings and
infrastructure for whatever is used. I appreciate one style might be
more painful in some cases, but that pain isn't necessarily only
constrained to dts authors.

> A style which I don't feel to be the "right" one, because it is less flexible (e.g. swapping
> child nodes between parents in board variants).
> 
> Summary: your decision gives flexibility for future expansion that I do not need (and
> probably nobody else) and does not provide the flexibility I need today (and others
> might appreciate).
> 
> So what should I do? Except being fixed on the phandle approach, repeating my arguments
> and describe requirements. And submitting our code and bindings document proposal
> every now and then?

Follow the advice from myself and others, and describe the device as a
slave, under the UART providing access to the programmers' interface. By
your own admission that works, it's simply that you don't like the style
of the dts.

Thanks,
Mark.
