From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/16] dt-bindings: mvebu-uart: update documentation
 with extended UART
Date: Wed, 18 Oct 2017 08:29:07 -0500
Message-ID: <CAL_JsqJ3VkXHnh1H2NcBhgiFE+++WvXGA9Phdgj77X-4VGX3+w@mail.gmail.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
 <20171013090200.31034-2-miquel.raynal@free-electrons.com>
 <20171017220022.kr2qiodln3qfkbwe@rob-hp-laptop>
 <20171018082531.59a2e5d0@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171018082531.59a2e5d0@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Catalin Marinas <catalin.marinas@arm.com>, Jason Cooper <jason@lakedaemon.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Nadav Haklai <nadavh@marvell.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Gregory Clement <gregory.clement@free-electrons.com>, Wilson Ding <dingwei@marvell.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 18, 2017 at 1:25 AM, Miquel RAYNAL
<miquel.raynal@free-electrons.com> wrote:
> Hi Rob,
>
> On Tue, 17 Oct 2017 17:00:22 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> On Fri, Oct 13, 2017 at 11:01:45AM +0200, Miquel Raynal wrote:
>> > Update the Device Tree binding documentation for the Marvell EBU
>> > UART, in order to allow describing the extended UART IP block, in
>> > addition to the already supported standard UART IP. This requires
>> > adding a new compatible string, the introduction of a clocks
>> > property, and extensions to the interrupts property.
>> >
>> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
>> > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> > ---
>> >  .../devicetree/bindings/serial/mvebu-uart.txt      | 49
>> > +++++++++++++++++++--- 1 file changed, 44 insertions(+), 5
>> > deletions(-)
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
>> > b/Documentation/devicetree/bindings/serial/mvebu-uart.txt index
>> > d37fabe17bd1..3df3a3fab4bb 100644 ---
>> > a/Documentation/devicetree/bindings/serial/mvebu-uart.txt +++
>> > b/Documentation/devicetree/bindings/serial/mvebu-uart.txt @@ -1,13
>> > +1,52 @@ -* Marvell UART : Non standard UART used in some of
>> > Marvell EBU SoCs (e.g., Armada-3700) +* Marvell UART : Non standard
>> > UART used in some of Marvell EBU SoCs
>> > +                 e.g., Armada-3700.
>> >
>> >  Required properties:
>> > -- compatible: "marvell,armada-3700-uart"
>> > +- compatible:
>> > +    - "marvell,armada-3700-uart" for the standard variant of the
>> > UART
>> > +      (32 bytes FIFO, no DMA, level interrupts, 8-bit access to the
>> > +      FIFO, baudrate limited to 230400).
>> > +    - "marvell,armada-3700-uart-ext" for the extended variant of
>> > the
>> > +      UART (128 bytes FIFO, DMA, front interrupts, 8-bit or 32-bit
>> > +      accesses to the FIFO, baudrate unlimited by the dividers).
>>
>> What do you call the next extended version?
>> marvell,armada-3700-uart-ext-ext?
>
> I don't know what you mean by "next extended version"?

IP evolves on new chips with new features. Just trying to understand
how you are

>> This is different versions of UART on the same chip?
>
> Today in mainline there is support for the A3700 UART IP.
> This series add support for another IP, based on the A3700, but with
> extended features (explaining the -ext suffix).
>
> Can you precise what is bothering you?

Is this different versions of UART IP on 1 chip or a new version of
the UART IP on a new SoC? The latter should be a new compatible with
the new SoC. The former case does happen some, but is not common. I'm
just trying to understand which applies here.


>> >  - reg: offset and length of the register set for the device.
>> > -- interrupts: device interrupt
>> > +- clocks: UART reference clock used to derive the baudrate (only
>> > +      mandatory with "marvell,armada-3700-uart-ext" compatible).
>>
>> How is this optional? The freq is fixed if not present? If so, what
>> frequency?
>
> The "clocks" property should not be optional at all but that is how the
> bindings were handled before this series, so I can't tell now that
> this property is mandatory as it would break compatibility with older
> versions of the driver.

Okay. I think it should be mandatory with a note how missing property
is handled.

> When no clock is provided, the frequency is fixed by the bootloader
> and cannot be changed. There is no standard frequency for it but the
> one chosen by the bootloader often is 115200 as the UART is usually
> used as the serial console.
>
> Because the bootloader does only initialize the UART in use for the
> serial console, the clock is mandatory when using another port or it
> will not work at all.
