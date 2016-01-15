From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 16:05:45 +0100
Message-ID: <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
References: <20150511013540.5709.93626.stgit@notabene.brown> <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com> <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160115110106.GA3262@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi Mark,

Am 15.01.2016 um 12:01 schrieb Mark Rutland <mark.rutland@arm.com>:

> On Fri, Jan 15, 2016 at 10:34:51AM +0100, H. Nikolaus Schaller wrote:
>> Hi Mark,
>> 
>> Am 13.01.2016 um 20:15 schrieb Mark Rutland <mark.rutland@arm.com>:
>> 
>>> On Tue, Jan 12, 2016 at 02:28:00PM +0100, H. Nikolaus Schaller wrote:
>>>> Hi Tomeu,
>>>> 
>>>> Am 12.01.2016 um 14:06 schrieb Tomeu Vizoso <tomeu@tomeuvizoso.net>:
>>>> 
>>>>> On 11 May 2015 at 03:56, NeilBrown <neil@brown.name> wrote:
>>>>>> Hi all,
>>>>>> here is version 4 of my "UART slave device" patch set, previously
>>>>>> known as "tty slave devices".
>>>>> 
>>>>> Hi Neil,
>>>>> 
>>>>> do you (or someone else) have plans to continue this work in the short
>>>>> or medium term?
>>>> 
>>>> yes, there is something in our upstreaming pipeline. This one works for us on top of 4.4.0:
>>>> 
>>>> <http://git.goldelico.com/?p=gta04-kernel.git;a=shortlog;h=refs/heads/work/hns/misc/w2sg-tty-slave2-v4>
>>>> 
>>>> There is one point still to be solved: the exact style of the DT bindings.
>>>> 
>>>> We have an idea how a driver can implement two different styles (child node AND phandle)
>>>> so that it is up to the DTS developer to use the one that best fits into the existing DTS.
>>> 
>>> From my perspective as a binding maintainer, and as I stated before, the
>>> child node approach made the most sense and was most consistent with the
>> 
>>> way we handle other devices.
>> 
>> I simply don't see that this is the most common way other devices are handled.
>> 
>> I find many counter-examples which use phandles:
>> * gpios
>> * regulators
>> * iio channels used by other drivers (e.g. iio-hwmon)
>> * phy devices
>> * timers
>> * pwms
>> * interrupts
>> * dma
> 
> As was previously described to you, in these cases phandles are used
> when these are _resources_ used by another device, not for the main
> programmer-visible interface to the device.

Ah, I think I finally begin to understand the rule you are following:

	If a device's data interface can be seen in user space, this interface
	is sort of a "main interface" and must be modelled in DT by a
	parent-child relationship.

But then you obviously ignore the basic rule that DT describes hardware
in an OS agnostic way and mix it up with programmer-visible interfaces
and a not well defined concept of "main" and "other" interfaces.

So I doubt that this rule is really necessary. A different OS could use the
same DT but not provide a programmer's interface at all.

Or is this no longer a general goal of DT to be OS agnostic?

Now I also think I better understand what you meant by "main interface"
a while ago.

For me, when looking into a chip data sheet, the main interface is a sometimes
arbitrary. Or when viewing it through device driver implementors glasses
I may end up with a different main interface.

>From the hardware schematics, I can't read which interface is "main". I can
only read which components and signals are connected. So the information
what is "main" must come from somewhere else, but not the hardware.

You appear to have a definition based on Linux user space interfaces
which is distinct from mine and at least explains why the discussion takes
so long and we don't come to a common view.

> 
> Conceptually, A UART slave is far closer to SPI or I2C, where the slave
> is represented as a sub-node.

Only if you have the goal to describe the data/command path ("main interface")
in DT.

I mentioned it several times: USB-PHYs use the phandle approach to attach
a single PHY to the usb controller, although there is usually some ULPI-"bus"
interface (12 parallel wires) between. And the PHY is clearly more "slave" than
the usb controller, isn't it?

But with phandle, the usb controller is a _resource_ for the PHY. So would
you say this is wrong?

This is the design pattern (for DT and drivers) we have copied for our tty-slave
proposal.

> I wasn't aware of any instances of timers being referred to by phandle
> by other devices -- that seems distinctly odd. Where do you see that
> happening.

I found it in connection with dmtimer / pwm on OMAP3. May be a rare exception
and that may be a special type of OMAP timers.

> 
>> * mcbsp (see e.g. http://lxr.free-electrons.com/source/arch/arm/boot/dts/omap3-n900.dts#L127)
> 
> Subsystem type bindings are more of a special case, and regardless the
> components have nodes in the relevant portions of the DT.

> 
>> * mmc-pwr-seq-simple (which does not even describe a physical piece of hardware)
> 
> If this is so different, how is it relevant?

It could as well be subnode of the affected mmc interface or mmc-slave, but obviously it
isn't grouped there, and uses a phandle to refer to its &mmc "master".

Its function is quite similar what we need for our GPS chip: control power sequences
of a remote device.

> 
>> All of them define the provider in one node. And refer to it by a phandle in another node
>> where they are used.
>> 
>> So I see a lot of provider-consumer relationships modeled by phandles but not by child nodes.
> 
> I agree that provider-consumer type relationships are typically
> described in this manner.

Ok.

> 
> However, master-slave relationships are not.

It looks as if you see a significant difference between provider-consumer and master-slave
relationship which I was not sure of which applies to what and where you make the distinction.

By the way: what exactly makes the UART on the SoC side "master" and the UART on the connected
device a "slave" (except the user-space view)?

UARTs per se have no master-slave roles and are symmetrical (contrary to SPI and I2C where it
is well defined). Rather, both are formally DTE connected by a null-modem.

This is another substantial difference between UART and I2C/SPI besides addressability.

> 
>> Next, if I look up real world DT sources, child nodes have in a majority of cases a
>> reg = <...> or ranges = <...> entry to define specific addresses of each child node and
>> to distinguish between them.
>> 
>> This is not always the case (e.g. children of the root node) but often. Therefore I assume
>> the child-node pattern is mainly intended for distinguishing between multiple *addressable*
>> subdevices connected to a single provider, i.e. some sort of "shared bus".
> 
> We can have MMC controllers that only have a single sub-device, yet this
> may have a node for this, rather than using phandles. The addressability
> has no bearing.

I admit that there are exceptions and MMC slaves (e.g. a single WiFi chip) is one
of them, but there are many cases where subnodes are addressable. e.g. I2C, SPI.
and e.g. the whole internal structure of SoCs.

A source of wisdom is

http://devicetree.org/Device_Tree_Usage#How_Addressing_Works

Although not explicitly said it gives me the impression that the parent-child
pattern is always tightly related with addresses and address translation
(including the degenerate case of reg = <0> which could be thought to apply
to the MMC example).

And it mentions for "Non Memory Mapped Devices" nodes "Instead the
parent device's driver would perform indirect access on behalf of the CPU".

So this document could be interpreted as that a parent driver *must* translate
addresses of children which would be exactly contrary to the view you describe
to me that there is no bearing.

Is this document wrong or irrelevant to our device trees (please give me a link
to a better document)?

> 
>> In the specific problem I (and Neil) want to solve (GTA04 devices and
>> more to come), the UART is simply a provider of serial data lines and
>> power control events (or whatever the driver implementations want to
>> do with the knowledge about this connection).
>> 
>> Although we have multiple such uart-device connections, they are all
>> individual point-to-point.
>> 
>> Not a bus structure with multiple clients. So there are several simple
>> provider-consumer relations.  Hence there is no urgent need for
>> addresses of multiple child nodes of a single UART and no reg/ranges
>> property.
> 
> As above, the addressability doesn't matter.
> 
>> Of course, with the child node approach it would give the flexibility
>> to introduce such
>> a feature easily in the future - but I don't see a use case. Not even at the horizon.
>> 
>> And I wonder how I should implement a driver if a child node provides a reg property.
>> Should I invent and implement a protocol layer to make the UART an addressable bus?
> 
> Why would it have a reg property if it were a UART slave?

Under the assumption that addressability matters and multiple parent-child
nodes are usually used for addressable slaves. To group all of them under
a single master. Then we would need reg = <1> etc. handled by the uart master
driver.

> 
> If a device has multiple slave interfaces, it requires separate nodes
> for these. In that case, you'd need to group those together with phandle
> references.

Yes.

> 
>> But the chip I connect to an UART does not understand that and I can't change it.
> 
> I don't follow what you mean by this. In what way does the binding
> description affect the physical device? Are you talking about a driver?

It is meant to comment about addressability discussion and protocol layer. If there is a
protocol layer, the chip must be able to understand the protocol for addresses. And since
I can't change the chip I can't introduce addresses. Hence can't make the uart-slave an
addressable chip. This limits the subnode approach to a single subnode and always
makes it a degenerate "bus".

> 
>> So it is probably not expected by the uart-slaves story - and I have no need for addressability
>> of multiple subnodes.
>> 
>> So I conclude: the single chip is the consumer of a simple UART provider and should therefore
>> be described as a connection through a phandle. Like in all the other DT examples listed
>> above. The best description is IMHO:
>> 
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/iio-bindings.txt
>> 
>> At least this is how I see the DT world when going through some device tree files
>> and trying to deduce what the common style is.
>> 
>> This appears to be opposite to what you say: "most consistent with the way we
>> handle other devices". I only find that other devices which understand some addressing
>> scheme are handled that way.
> 
> It's consistent with the way we handle *slave* devices (i.e. we describe
> the programming interface on a sub-node to the device that provides
> access to that programming interface).

Ok, I understand, based on your programming interface view.

This means:

user-space -> /dev/tty* -> UART -> chip

> 
> The phandle case describes side-band interfaces.

Probably this is the key.

In my PoV the data interface (programmer's API) already works (through /dev/tty*)
without need to change DT. E.g. if the GPS chip is powered on by U-Boot.

What is missing in kernel.org is just that the driver of a slave can know when to
power up/down.

Therefore the driver just needs to know the UART and ask for state information.
Exactly the same as e.g. some driver might need to access the iio interface
of some other device.

Now the question is: is this a side-band interface or not?

IMHO yes.

There is also another use case to consider that was mentioned long ago: someone
wanted to hide an UART from the tty layer so that it is not visible to the user
space at all and the "slave" driver wraps it effectively inside the kernel.

In that case a "slave" device driver uses the whole UART as a _resource_ to
get access to the AT commands or whatever the chip understands and
can present the data to user space with a different API (e.g. iio).

Then, it would be obvious that the device driver has its own node and
uses some phandle to know about the SoC UART it is connected to.

This would be

user-space ->/sys/bus/iio -> chip -> UART

It appears to be impossible to correctly model both UART slave relations
in a single DT...

> 
>>> I don't understand what the benefit of supporting two styles of
>>> description would be, relative to the maintenance cost.
>> 
>> Supporting both styles is a proposal to make both of us happy.
>> 
>> And there isn't much to be maintained. It is just a notice in the bindings document
>> of uart-slaves that the phandle is optional, if the node is the single child node of an
>> UART. If it isn't a subnode of an UART, or not at index 0, the phandle is needed
>> to describe the cross-reference. So it can be seen as a simple extension to move
>> the node outside but keep the link.
>> 
>> A rough estimate is that it requires just ~20 lines to implement in our driver (unless
>> we need locks, error handling etc.).
>> 
>> Then, the DT developers (like me) can decide which style better fits into the DTS
>> structure that already exists, when adding a salve device to some UART.
> 
> Which then leads to confusion as DTs are arbitrarily different for no
> real reason. That makes things harder to maintain, even if only ~20
> lines of code were necessary.

1 line in DT + location
~20 lines in tty-driver code

> 
>> My experience from almost daily work with device trees is that phandles give
>> more flexibility in expressing the hardware structure in DT language. And they
>> allow to better group properties. In this case: "I am connected to interface ...".
>> 
>> And the allow to easily modify it by includes and overlays to describe small hardware
>> variants ("I am now connected to a different interface ..."). Moving a subnode between
>> parents is difficult without multiple well designed include files, while for phandle
>> there is a simple idiom:
>> 
>> 	#include <existing.dts(i)>
>> 	&child { link = <&new-parent>; };
>> 
>> IMHO this is easy to read and understand. And I have used that pattern several
>> times, e.g. for "adding" hardware to some evaluation board without touching the
>> original DTS. So I don't want to miss it in this case.
>> 
>>> Nor do I
>>> understand your fixation with the phandle approach,
>> 
>> Well, because I don't understand your fixation on the child node approach for this
>> non-addressable point-to-point connection. Why prepare for a feature that nobody
>> really needs and has asked for?
> 
> Addressability was not my main concern. Consistency with other "bus"
> types is a major concern. See below for what I mean by "bus", as we are
> clearly using the term differently.

> 
>> To be more specific:
>> 
>> * I find that the phandle approach better (more flexible) suits the problem I want to have solved.
>> * there is no need for multiple child nodes for a point-to-point connection, because UART is rarely used as a bus.
> 
> In Linux terminology a "bus" is effectively anything that provides us
> with a programming interface to some number of devices.

This "number of devices" is why I think addressability is a natural consequence of "bus".

> That number may
> be 1 (i.e. a point-to-point connection is just a particular case of a
> "bus").

Yes, of course there are degenerate cases where addressability can be ignored 
(0 or 1 bus client).

> 
> That is what I mean when I talk about a "bus", and that is why I believe
> that UARTs should be treated as with other busses if we are going to
> handle slave devices.

> 
> I appreciate that this is not quite its usual meaning

It is not far from my definition, except that you deny that multiple devices always need
some addressing mechanism. Which you can only ignore if there is a degenerate
case of a point-to-point connection.

What your definition does not describe is the distinction between "payload" and
side-band information.

And again you argue with Linux terminology and programming interface when
trying to describe hardware.

> 
>> * I see a lot of examples where phandles are intensively used and there it appears to be right to do so.
>> 
>> I just know that you conclude "child nodes made the most sense and was most consistent".
>> 
>> But I still wonder why. It does not appear to match what I observe in arch/arm/boot/dts
>> and the problem I want to solve.
>> 
>>> given it has been
>>> repeatedly disagreed with by binding maintainers.
>> 
>> Binding maintainers may sometimes be as wrong as I may be here. This needs a discussion
>> but not a circular argument, that it already has been disagreed repeatedly.
> 
> We all make mistakes, certainly.
> 
> However, you have ignored the distinction that has been described
> repeatedly w.r.t. slaves vs random side-band relationships.

No, not at all.

I just insist (and have also repeated several times) that for our device problem is just a side-band
relationship that needs to be modeled.

And IMHO nobody has described that he/she needs a solution to model the *data* relationship
for devices connected behind a tty port.

> 
>> I may have missed it, but I am also not aware that there was a technical analysis of both
>> approaches, comparing the pro's and con's. I had received requests to show code for the
>> phandle approach and we provided it.
>> 
>> Coming to different conclusions can happen, if requirements are weighted differently. Or
>> the problem to be solved is not completely understood. But then, the requirements and
>> assumptions should be discussed (which is difficult on a patch-review-based discussion list).
>> 
>> On a more general level, the key problem is that *I* have to write and maintain a
>> multitude of board specific DTS files (not all of them in mainline) using the style
>> *you* decide.
> 
> While myself and others will be having to maintain bindings and
> infrastructure for whatever is used. I appreciate one style might be
> more painful in some cases, but that pain isn't necessarily only
> constrained to dts authors.

Please explain your pain by the phandle (only) approach or the pain
for the non-dts authors you mention.

We will provide a bindings document, examples and 2-3 drivers and board,dts using it.

What do you expect to have to maintain?

IMHO your work is exactly the same for both variants.

> 
>> A style which I don't feel to be the "right" one, because it is less flexible (e.g. swapping
>> child nodes between parents in board variants).
>> 
>> Summary: your decision gives flexibility for future expansion that I do not need (and
>> probably nobody else) and does not provide the flexibility I need today (and others
>> might appreciate).
>> 
>> So what should I do? Except being fixed on the phandle approach, repeating my arguments
>> and describe requirements. And submitting our code and bindings document proposal
>> every now and then?
> 
> Follow the advice from myself and others, and describe the device as a
> slave, under the UART providing access to the programmers' interface.

Yes, that would be obviously the easiest for you :)

I would have to work with a DT structure that I don't see necessary to solve my problem,
and have the additional pain with arranging the board.dts files in an easy to maintain
way (can't use simple phandle overwriting).

> By
> your own admission that works, it's simply that you don't like the style
> of the dts.

It is not a simple dislike. I think it is the wrong solution (harming future development if cast
into concrete) for the practical problems I (and maybe others) have to be solved.

After all (it is a very complex topic which is probably the reason why almost nobody jumps
in to argue), I think we have condensed it into that we simply have different goals/problems
to be solved and different starting points:

* you want to see that DT describes the data (=main) interface from the uart to the chip. This
   is based on looking which programmer-visible "main" interfaces are available to user space (a
   rule which I doubt is needed and helpful for an OS agnostic formal hardware description).
  You see the SoC UART as "master" and the chip as "slave" (even if there are no clear master-slave
   roles in UART serial interfaces).

* I want to describe the side-band interface from the chip to the uart to be able to know how to
   control power of the chip and can even ignore that there is any user space API. This makes
   the UART a status resource to be queried by the "slave".

>From each of both goals it is clear that we come to different conclusions about the right way.

And I wonder if the wording "uart-slave" is misleading? Is "uart-control" better? Or "uart-client"?

So we do not have to discuss solutions and which one is right but the problem to be solved.

Now what can I do to convince you and accept my view and the problem I want to
solve for Linux?

BR and thanks for clarifying your PoV,
Nikolaus
