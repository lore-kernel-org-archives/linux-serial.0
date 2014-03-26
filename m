From: Jon Ringle <jon@ringle.org>
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: Add bindings documentation for
 the SC16IS7XX UARTs
Date: Wed, 26 Mar 2014 08:49:59 -0400
Message-ID: <CAMwGMjxK2C_ciW6LwdMHE5wYkOHtkP00extF1-qcZ2xYoDr=7g@mail.gmail.com>
References: <1395771564-30534-1-git-send-email-jon@ringle.org>
	<1395771564-30534-2-git-send-email-jon@ringle.org>
	<20140326090855.GP10341@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140326090855.GP10341@e106331-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jon Ringle <jringle@gridpoint.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 26, 2014 at 5:08 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Mar 25, 2014 at 06:19:24PM +0000, jon@ringle.org wrote:
>> +- interrupt-parent: The phandle for the interrupt controller that
>> +  services interrupts for this IC.
>> +- interrupts: Specifies the interrupt source of the parent interrupt
>> +  controller. The format of the interrupt specifier depends on the
>> +  parent interrupt controller.
>
> Just describe what the device-specific interrupt logically is, not what
> the interrupts property means in general.
>

Something like this ok?:

-interrupts: Should contain the UART interrupt

>> +- clocks: phandle to the IC source clock.
>
> Nit: clocks aren't just referred to with phandles; there's a clock
> specifier too.
>
> Either correct the type here or don't mention the type at all, given
> this is a common property.
>

I'm not sure what to do here. Many of the other
devicetree/bindings/serial/*.txt use phandle verbage and also the
devicetree/bindings/clock-bindings.txt documentation for clocks refers
the type as phandle too:

==Clock consumers==

Required properties:
clocks:         List of phandle and clock specifier pairs, one pair
                for each clock input to the device.  Note: if the
                clock provider specifies '0' for #clock-cells, then
                only the phandle portion of the pair will appear.

Is something like this ok?:

clocks: reference to the source clock

Jon
