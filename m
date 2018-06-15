From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART
 controller
Date: Fri, 15 Jun 2018 22:47:53 +0530
Message-ID: <8c553dcc-e352-6e69-e08c-4e6237555ea7@ti.com>
References: <20180605060125.9518-1-nm@ti.com>
 <20180605060125.9518-4-nm@ti.com> <20180612210640.GA20728@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180612210640.GA20728@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Wednesday 13 June 2018 02:36 AM, Rob Herring wrote:
> On Tue, Jun 05, 2018 at 01:01:22AM -0500, Nishanth Menon wrote:
>> AM654 uses a UART controller that is compatible (partially) with
>> existing 8250 UART, however, has a few differences with respect to DMA
>> support and control paths. Introduce a base definition that allows us
>> to build up the differences in follow on patches.
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>>  drivers/tty/serial/8250/8250_omap.c                      | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> index 4b0f05adb228..c35d5ece1156 100644
>> --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
>> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> @@ -1,6 +1,7 @@
>>  OMAP UART controller
>>  
>>  Required properties:
>> +- compatible : should be "ti,am654-uart" for AM654 controllers
> 
> Not compatible with any existing TI 8250 UARTs?

Curious on why you asked about this. Are you suggesting why not:

"ti,<new-soc>-uart", "ti,<old-soc>-uart"

or you are asking why introduce "ti,<new-soc>-uart" unless there is
clear demonstrable need for using it in driver code.

In general, I think "ti,<new-soc>-uart", "ti,<old-soc>-uart" in
device-tree (and by extension in binding document) is better even in
there are no _known_ incompatibilities at the time of initial driver
submission. The reason is silicon integration and process differences
many times spill over into driver.

Of course, the idea is not to go postal and create a new compatible for
every pin-compatible part number that gets created, but probably a new
compatible should be created for a new silicon die.

We have just started introducing support for this SoC, and since it
reuses many IPs, this question is likely to come up again.

In this particular case though, Nishanth is perfectly right in not saying

compatible : should be "ti,am654-uart", "ti,omap4-uart"

Because we *know* UART DMA integration is different and a match against
omap4 would result in non-working UART once DMA is enabled by default.

Thanks,
Sekhar
