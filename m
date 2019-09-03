From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
Date: Tue, 3 Sep 2019 15:24:12 +0100
Message-ID: <CAL_Jsq+Y3=xXuaqO=UoAShw5OxJA4wDBZVUE3=OT_DL9kw9t-Q@mail.gmail.com>
References: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
 <5d6d1b81.1c69fb81.7eabb.cabd@mx.google.com> <CAN8ut8KMjo4KVcgLp6AhZOpuLwWMJ8HeiecH70RgYnLQQ05M9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN8ut8KMjo4KVcgLp6AhZOpuLwWMJ8HeiecH70RgYnLQQ05M9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pragnesh Patel <pragnesh.patel@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Albert Ou <aou@eecs.berkeley.edu>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 3, 2019 at 7:52 AM Pragnesh Patel <pragnesh.patel@sifive.com> wrote:
>
> On Mon, Sep 2, 2019 at 7:09 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Sep 01, 2019 at 12:39:21PM +0530, Pragnesh Patel wrote:
> > > Convert the riscv,sifive-serial binding to DT schema using json-schema.
> > >
> > > Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> > > ---
> > >  .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
> > >  .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
> > >  2 files changed, 62 insertions(+), 33 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> > >  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > deleted file mode 100644
> > > index c86b1e5..0000000
> > > --- a/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > +++ /dev/null
> > > @@ -1,33 +0,0 @@
> > > -SiFive asynchronous serial interface (UART)
> > > -
> > > -Required properties:
> > > -
> > > -- compatible: should be something similar to
> > > -           "sifive,<chip>-uart" for the UART as integrated
> > > -           on a particular chip, and "sifive,uart<version>" for the
> > > -           general UART IP block programming model.  Supported
> > > -           compatible strings as of the date of this writing are:
> > > -           "sifive,fu540-c000-uart" for the SiFive UART v0 as
> > > -           integrated onto the SiFive FU540 chip, or "sifive,uart0"
> > > -           for the SiFive UART v0 IP block with no chip integration
> > > -           tweaks (if any)
> > > -- reg: address and length of the register space
> > > -- interrupts: Should contain the UART interrupt identifier
> > > -- clocks: Should contain a clock identifier for the UART's parent clock
> > > -
> > > -
> > > -UART HDL that corresponds to the IP block version numbers can be found
> > > -here:
> > > -
> > > -https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> > > -
> > > -
> > > -Example:
> > > -
> > > -uart0: serial@10010000 {
> > > -     compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > > -     interrupt-parent = <&plic0>;
> > > -     interrupts = <80>;
> > > -     reg = <0x0 0x10010000 0x0 0x1000>;
> > > -     clocks = <&prci PRCI_CLK_TLCLK>;
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > > new file mode 100644
> > > index 0000000..56fa935
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > > @@ -0,0 +1,62 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/serial/sifive-serial.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SiFive asynchronous serial interface (UART)
> > > +
> > > +maintainers:
> > > +  - Pragnesh Patel <pragnesh.patel@sifive.com>
> > > +  - Paul Walmsley  <paul.walmsley@sifive.com>
> > > +  - Palmer Dabbelt <palmer@sifive.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/serial.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sifive,fu540-c000-uart
> > > +      - sifive,uart0
> >
> > This is wrong and should have warned if you tested this on 5.3.
> >
> > items:
> >   - const: sifive,fu540-c000-uart
> >   - const: sifive,uart0
> >
>
> Thanks for the correction, i will update this in v2 patch.
>
> I haven't got any warnings due to my patch.
> For your reference, following is the list of warnings when i did "make
> dtbs_check" (kernel version - 5.3.0-rc7)

Thanks for the confirmation. I've now fixed it to correctly catch
that. Update your dtschema to the latest.

Rob
