From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 10/10] drivers: PL011: add support for the ARM SBSA generic
 UART
Date: Fri, 16 Jan 2015 18:07:42 +0000
Message-ID: <54B9536E.4040607@arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <1421428986-11300-11-git-send-email-andre.przywara@arm.com>
 <20150116173440.GI32155@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150116173440.GI32155@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "rob.herring@linaro.org" <rob.herring@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Mark,

On 16/01/15 17:34, Mark Rutland wrote:
> On Fri, Jan 16, 2015 at 05:23:06PM +0000, Andre Przywara wrote:
>> The ARM Server Base System Architecture[1] document describes a
>> generic UART which is a subset of the PL011 UART.
>> It lacks DMA support, baud rate control and modem status line
>> control, among other things.
>> The idea is to move the UART initialization and setup into the
>> firmware (which does this job today already) and let the kernel just
>> use the UART for sending and receiving characters.
>> We use the recent refactoring the build a new struct uart_ops
>> variable which points to some new functions avoiding access to the
>> missing registers. We reuse as much existing PL011 code as possible.
>>
>> In contrast to the PL011 the SBSA UART does not define any AMBA or
>> PrimeCell relations, so we go a pretty generic probe function
>> which only uses platform device functions.
>> A DT binding is provided, but other systems can easily attach to it,
>> too (hint, hint!).
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    9 ++
>>  drivers/tty/serial/amba-pl011.c                    |  154 ++++++++++++++++++++
>>  2 files changed, 163 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>> new file mode 100644
>> index 0000000..21d211f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>> @@ -0,0 +1,9 @@
>> +* ARM SBSA defined generic UART
>> +This UART uses a subset of the PL011 registers and consequently lives
>> +in the PL011 driver. It's baudrate and other communication parameters
>> +cannot be adjusted at runtime, so it lacks a clock specifier here.
>> +
>> +Required properties:
>> +- compatible: must be "arm,sbsa-uart"
>> +- reg: exactly one register range
>> +- interrupts: exactly one interrupt specifier
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index a1c929f..596e641 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -101,6 +101,14 @@ static struct vendor_data vendor_arm = {
>>  	.get_fifosize		= get_fifosize_arm,
>>  };
>>  
>> +static struct vendor_data vendor_sbsa = {
>> +	.oversampling		= false,
>> +	.dma_threshold		= false,
>> +	.cts_event_workaround	= false,
>> +	.always_enabled		= true,
>> +	.fixed_options		= "115200n8",
>> +};
> 
> Is this configuration mandated by the SBSA? If so, please mandate it in
> the binding document.

No, actually it is just a placeholder. The driver needs some values to
avoid querying the device and to make the upper levels happy, so I went
with those. Actually 38400 would make more sense here, since that is
some kind of Linux serial default value.

> If the rate and so on are not mandated, they should probably be
> described by the binding so software has a chance of getting the real
> configuration details.

What the actual settings are is actually totally up to the firmware. By
definition software cannot learn these settings and it shouldn't care,
as the SBSA UART is just "meant to work(TM)". Though from userland it
looks like one can change the baudrate and the other parameters, the
driver totally ignores those settings (though it reflects it back).

Cheers,
Andre.
