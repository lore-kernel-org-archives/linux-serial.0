From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
Date: Wed, 24 Oct 2018 11:53:49 -0500
Message-ID: <20181024165349.GA5652@bogus>
References: <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
 <mhng-44b7601c-c2f4-4de8-a12e-7730e03d691e@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mhng-44b7601c-c2f4-4de8-a12e-7730e03d691e@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, mark.rutland@arm.com, paul@pwsan.com
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 22, 2018 at 09:41:51AM -0700, Palmer Dabbelt wrote:
> On Fri, 19 Oct 2018 13:45:57 PDT (-0700), robh+dt@kernel.org wrote:
> > On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > > 
> > > Add DT binding documentation for the Linux driver for the SiFive
> > > asynchronous serial IP block.  Nothing too exotic.
> > > 
> > > Cc: linux-serial@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-riscv@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Palmer Dabbelt <palmer@sifive.com>
> > > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > ---
> > >  .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > new file mode 100644
> > > index 000000000000..8982338512f5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > @@ -0,0 +1,21 @@
> > > +SiFive asynchronous serial interface (UART)
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
> > 
> > I assume once again, the last '0' is a version? As I mentioned for the
> > intc and now the pwm block bindings, if you are going to do version
> > numbers please document the versioning scheme. Palmer mentioned the
> > compatible string is part of the IP block repository? Where does the
> > number come from? What's the next version? Major vs. minor versions?
> > ECO fixes? Is the version s/w readable? How do you ensure it gets
> > updated? All that should be addressed.
> 
> The RISC-V ecosystem is a bit different than that of ARM, MIPS, or Intel in
> that the ISA is an royalty-free open standard that anyone can implement (ie,
> without even signing a license agreement), with only the "RISC-V" trademark
> being held behind a pay+conformance wall.  As a result, we don't actually
> have any control over who builds a RISC-V chip so all we at SiFive can
> really to is try to demonstrate good practices in software land and go from
> there.

Rights to the ISA and cores may be different, but how chips are built 
is not really all that different (or doesn't have to be).

> As far as SiFive's codebase is concerned, the version number is embedded in
> the RTL generator, and a device tree is generated along with the RTL.  This
> device tree is then embedded into a mask ROM on the chip, which allows the
> earliest stage of boot to proceed.  As I'm sure you know, boot is a very
> complicated process and as a result the device tree passed to Linux doesn't
> necessarily look like what's in the ROM, but the intent is to keep iterating
> until we can get these as similar as possible -- that's why we're submitting
> every devicetree binding to the standard.

So all this discussion is purely SiFive specific and really has nothing 
to do with RISC-V ecosystem.

Putting the DT into the ROM isn't something I'd do. It's simply not 
going to work timeline wise IMO.

> Specifically as far as the UART is concerned, the compat string that's not
> chip-specific lives here (the "sifive,fu540-c000-uart" string lives in an
> internal chip repo that I can't point to):
> 
>    https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> 
> The version numbering scheme right now is pretty simple: I try to pay as
> much attention as possible to how the hardware changes (both by looking and
> with some automation), and I go yell at anyone who does something stupid.  I
> know it's not the most scalable of schemes, but it's the best we have.  The
> UART is actually an interesting case right now because we have an
> outstanding pull request that adds a bit to the UART and then adds
> "sifive,uart1" to the compat string
> 
>    https://github.com/sifive/sifive-blocks/pull/90

Relying on people to catch whether changes are important or not is bound 
to fail. It's really got to be built into the design flow.

Even just updating a version register I've experienced the h/w designers 
forgetting to update it.

> My intent is to ensure that the device tree's compat string uniquely
> identifies the software interface to a block.  Thus, whenever a device's
> implementation changes in a software-visible way (bug fix or feature
> addition) we change the compat string -- either adding one (as is the case
> of the UART, where the compat string will be both "sifive,uart1" and
> "sifive,uart0" since the new feature is backwards compatible with the old
> software) or changing one (if the interface change is not compatible with
> old software).

What about config options? Say the UART has a configurable FIFO size.

What about major vs. minor version changes? Respins of chips would need 
to make minor changes if picking up major changes are deemed too risky.

> Like I said above, this is all a manual process right now and this only
> applies to SiFive's implementations.  I'm confident that I can at least
> ensure that, for any given SiFive implementation, a block's compat string
> will uniquely identify the software interface to it.  For the rest of the
> RISC-V world all we can do is set a good example and review the software.

This is all good information and is essentially what I'm looking for. I 
just don't want it lost in a reply to an email, but something you can 
reference. Look at bindings/arm/primecell.txt for example. That 
describes a family of IP blocks and not any specific device.

Whether the versioning is sufficient or not, I don't really care as long 
as you docuemnt what it is so it is consistent. Since you have a common 
schema across IP blocks, that means you should have a common document.

Rob
