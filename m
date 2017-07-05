From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
Date: Wed, 5 Jul 2017 09:12:22 -0500
Message-ID: <20170705141222.t6yskhdeqaqf2h4b@rob-hp-laptop>
References: <20170627005520.23731-1-afaerber@suse.de>
 <20170627005520.23731-5-afaerber@suse.de>
 <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
 <e8b8eb0c-0362-0cfb-4d18-3e1ab2b77412@suse.de>
 <CAL_JsqLatRUwdA6GeWCHXFTHMUYY27pdmUpPEoHwCCFMg2F21Q@mail.gmail.com>
 <d9b00fd8-2e9e-fb01-9056-db0d32b3e80b@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d9b00fd8-2e9e-fb01-9056-db0d32b3e80b@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, service@rdamicro.com, zhao_steven@263.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jul 02, 2017 at 03:52:39AM +0200, Andreas Färber wrote:
> Am 30.06.2017 um 16:27 schrieb Rob Herring:
> > On Fri, Jun 30, 2017 at 6:12 AM, Andreas Färber <afaerber@suse.de> wrote:
> >> Am 29.06.2017 um 22:10 schrieb Rob Herring:
> >>> On Tue, Jun 27, 2017 at 02:55:18AM +0200, Andreas Färber wrote:
> >>>> Add an initial binding for the RDA8810PL UART.
> >>>>
> >>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/serial/rda-uart.txt | 13 +++++++++++++
> >>>>  1 file changed, 13 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/serial/rda-uart.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/serial/rda-uart.txt b/Documentation/devicetree/bindings/serial/rda-uart.txt
> >>>> new file mode 100644
> >>>> index 000000000000..6840a8aee035
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/serial/rda-uart.txt
> >>>> @@ -0,0 +1,13 @@
> >>>> +RDA Micro UART
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible :  "rda,8810pl-uart" for RDA8810PL
> >>>> +- reg        :  Offset and length of the register set for the device.
> >>>
> >>> No clocks or interrupts?
> >>
> >> Not yet. I've only pieced together an earlycon driver so far, no full
> >> serial driver. The .dtsi doesn't even have an interrupt-controller node
> >> yet - wasn't clear to me whether this SoC even has a GIC and, if so,
> >> where, from the downstream pre-DT code.
> > 
> > How far can you boot with no interrupts?
> 
> That was described in the cover letter, as usual.
> 
> > DT bindings shouldn't unnecessarily evolve. Really, anything added
> > should be optional to maintain compatibility. Sometimes that's
> > unavoidable, but this isn't one of those cases.
> 
> Makes sense. Maybe this series should've been marked RFC. It's too late
> for 4.13 anyway, so there's lots of time left to extend the bindings.
> 
> BTW I saw that Kevin was adding a disclaimer to the Amlogic bindings
> that they are not stable. Is that required here, too?

I'm not really a fan of that. I've yet to see anyone remove an unstable 
tag. I'd rather see it for specific bindings, rather than platforms as a 
whole. It shouldn't be that hard to get most bindings complete enough 
and to a point that can be extended in a compatible way. In the end, 
decisions about breaking compatibility are up to the platform maintainer 
regardless of any text in some document.


> > So submit this when
> > you have something more complete.
> 
> Negative. I worked weeks and months towards perfect STM32 drivers, and
> despite showing it to ST and at a LinuxCon Japan, someone else sent less
> sophisticated patches (e.g., fixed-clocks) and took all the credit. Same
> with Turris Omnia. Therefore I am now submitting my new patches early,
> not just when everything is complete.

Fair enough. I should have said, we'll apply/ack when more complete. 
Submit it as often as you want.

Rob
