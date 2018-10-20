From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
Date: Sat, 20 Oct 2018 09:21:42 -0500
Message-ID: <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
References: <20181019184827.12351-1-paul.walmsley@sifive.com>
 <20181019184827.12351-2-paul.walmsley@sifive.com> <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
 <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 19, 2018 at 5:06 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> On 10/19/18 1:45 PM, Rob Herring wrote:
> > On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >> Add DT binding documentation for the Linux driver for the SiFive
> >> asynchronous serial IP block.  Nothing too exotic.
> >>
> >> Cc: linux-serial@vger.kernel.org
> >> Cc: devicetree@vger.kernel.org
> >> Cc: linux-riscv@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Palmer Dabbelt <palmer@sifive.com>
> >> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> >> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> >> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> >> ---
> >>   .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
> >>   1 file changed, 21 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> >> new file mode 100644
> >> index 000000000000..8982338512f5
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> >> @@ -0,0 +1,21 @@
> >> +SiFive asynchronous serial interface (UART)
> >> +
> >> +Required properties:
> >> +
> >> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
> > I assume once again, the last '0' is a version?
>
>
> Yes.
>
>
> > Palmer mentioned the
> > compatible string is part of the IP block repository?
>
>
> It is, but there's no guarantee that the compatible string from the RTL
> will make it into a ROM for any given chip.  For example, a customer may
> want the UART, but not want to take the DT ROM to keep area down.

Optional? Well, that's pointless to have then.

> This is one of the reasons why we'll likely switch to the usual
> software-maintained DTS files for Linux, just like the rest of arch/arm,
> arch/powerpc, etc.

Then you should probably just follow normal conventions.

I don't think DT in the h/w is the best strategy anyways. Ideally,
what the h/w should have are version and capabilities (assuming there
are configuration options) registers which aren't optional and can't
be forgotten to be updated. The version should probably have a vendor
too.

> > As I mentioned for the
> > intc and now the pwm block bindings, if you are going to do version
> > numbers please document the versioning scheme.
>
>
> Will add that to the binding document.

I don't seem to be making my point clear. I don't want any of this
added to a binding doc for particular IP blocks. Write a common doc
that explains the scheme and addresses the questions I asked. Then
just reference that doc here.

Maybe this is documented somewhere already? Otherwise, if one is
creating a new IP block, how do they know what the versioning scheme
is or what goes in the DT ROM?

>
>
> >   Where does the
> > number come from?
>
>
> It comes from the RTL, which is public:
>
> https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43

I'm not going to go read your RTL, sorry.

Rob
