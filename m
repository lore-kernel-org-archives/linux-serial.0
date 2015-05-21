From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v4 10/11] drivers: PL011: add support for the ARM SBSA
 generic UART
Date: Thu, 21 May 2015 12:13:30 +0100
Message-ID: <555DBDDA.6070908@arm.com>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
 <1431440095-5146-11-git-send-email-andre.przywara@arm.com>
 <55536096.4020008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55536096.4020008@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Langsdorf <mlangsdo@redhat.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Graeme Gregory <graeme.gregory@linaro.org>, =?UTF-8?B?SmFrdWIgS2ljacWEc2tp?= <moorray3@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Mark,

(please keep the people on CC:, I almost missed that mail)

On 05/13/2015 03:32 PM, Mark Langsdorf wrote:
> On 05/12/2015 09:14 AM, Andre Przywara wrote:
>> The ARM Server Base System Architecture[1] document describes a
>> generic UART which is a subset of the PL011 UART.
>> It lacks DMA support, baud rate control and modem status line
>> control, among other things.
>> The idea is to move the UART initialization and setup into the
>> firmware (which does this job today already) and let the kernel just
>> use the UART for sending and receiving characters.
>>
>> We use the recent refactoring to build a new struct uart_ops
>> variable which points to some new functions avoiding access to the
>> missing registers. We reuse as much existing PL011 code as possible.
>>
>> In contrast to the PL011 the SBSA UART does not define any AMBA or
>> PrimeCell relations, so we go with a pretty generic probe function
>> which only uses platform device functions.
>> A DT binding is provided with this patch, ACPI support is added in a
>> separate one.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   .../devicetree/bindings/serial/arm_sbsa_uart.txt   |  10 ++
>>   drivers/tty/serial/amba-pl011.c                    | 168
>> +++++++++++++++++++++
>>   2 files changed, 178 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>> b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>> new file mode 100644
>> index 0000000..4163e7e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>> @@ -0,0 +1,10 @@
>> +* ARM SBSA defined generic UART
>> +This UART uses a subset of the PL011 registers and consequently lives
>> +in the PL011 driver. It's baudrate and other communication parameters
>> +cannot be adjusted at runtime, so it lacks a clock specifier here.
>> +
>> +Required properties:
>> +- compatible: must be "arm,sbsa-uart"
>> +- reg: exactly one register range
>> +- interrupts: exactly one interrupt specifier
>> +- current-speed: the (fixed) baud rate set by the firmware
>> diff --git a/drivers/tty/serial/amba-pl011.c
>> b/drivers/tty/serial/amba-pl011.c
>> index 70e2958..cca93d9 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c

....

>> @@ -1872,6 +1915,24 @@ pl011_set_termios(struct uart_port *port,
>> struct ktermios *termios,
>>       spin_unlock_irqrestore(&port->lock, flags);
>>   }
>>
>> +static void
>> +sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
>> +              struct ktermios *old)
>> +{
>> +    struct uart_amba_port *uap =
>> +        container_of(port, struct uart_amba_port, port);
>> +    unsigned long flags;
>> +
>> +    if (old)
>> +        tty_termios_copy_hw(termios, old);
> 
> This code prevented login via the serial console on our test hardware.
> 
> Mark Salter suggested the following patch:
> 
> -       if (old)
> +       /*
> +        * The first call to set_termios() comes when the console is
> +        * registered via uart_add_one_port(). The serial core will
> +        * pass in a dummy old termios rather than NULL. Check to make
> +        * sure the old termios has reasonable info before copying from
> +        * it.
> +        */
> +       if (old && old->c_cflag)
>                 tty_termios_copy_hw(termios, old);

That seems like a kludge to me.
Regardless of the reason why uart_send_options() is passing a
dummy variable instead of a NULL pointer (which documentation explicitly
declares as legal) I saw that this unconditional copying of the old
value being common practise in various drivers, actually the default for
drivers not implementing set_termios at all.

Can you describe a setup where this issue shows up? I haven't observed
this issue in my testing.

But in fact I think we actually shouldn't care about the old value at
all. Instead we should filter the new termios settings to avoid userland
configuring for instance flow control or an differing byte format which
the SBSA UART does not support.
I will cook up a patch and send out a v5 ASAP.

Cheers,
Andre.

> 
> which fixed the issue.
> 
>> +    tty_termios_encode_baud_rate(termios, uap->fixed_baud,
>> uap->fixed_baud);
>> +
>> +    spin_lock_irqsave(&port->lock, flags);
>> +    uart_update_timeout(port, CS8, uap->fixed_baud);
>> +    pl011_setup_status_masks(port, termios);
>> +    spin_unlock_irqrestore(&port->lock, flags);
>> +}
>> +
>>   static const char *pl011_type(struct uart_port *port)
>>   {
>>       struct uart_amba_port *uap =
