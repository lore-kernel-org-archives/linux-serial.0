From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/2] serial: 8250: Allow to skip autoconfig_irq() for
 a console
Date: Wed, 08 Jul 2015 09:51:36 -0400
Message-ID: <559D2AE8.8080603@hurleysoftware.com>
References: <55717224.9060104@cp.jp.nec.com> <557173EC.5000307@cp.jp.nec.com> <559D0FCC.5040107@hurleysoftware.com> <559D1D39.9070405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <559D1D39.9070405@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Taichi Kageyama <t-kageyama@cp.jp.nec.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

Hi Prarit,

On 07/08/2015 08:53 AM, Prarit Bhargava wrote:
> 
> 
> On 07/08/2015 07:55 AM, Peter Hurley wrote:
>> Hi Taichi,
>>
>> On 06/05/2015 06:03 AM, Taichi Kageyama wrote:
>>> This patch provides a new parameter as a workaround of the following
>>> problem. It allows us to skip autoconfig_irq() and to use a well-known irq
>>> number for a console even if CONFIG_SERIAL_8250_DETECT_IRQ is defined.
>>>
>>> There're cases where autoconfig_irq() fails during boot.
>>> In these cases, the console doesn't work in interrupt mode,
>>> the mode cannot be changed anymore, and "input overrun"
>>> (which can make operation mistakes) happens easily.
>>> This problem happens with high rate every boot once it occurs
>>> because the boot sequence is always almost same.
>>>
>>> autoconfig_irq() assumes that a CPU can handle an interrupt from a serial
>>> during the waiting time, but there're some cases where the CPU cannot
>>> handle the interrupt for longer than the time. It completely depends on
>>> how other functions work on the CPU. Ideally, autoconfig_irq() should be
>>> fixed
>>
>> It completely depends on how long some other driver has interrupts disabled,
>> which is a problem that needs fixed _in that driver_. autoconfig_irq() does not
>> need fixing.
>>
>> A typical cause of this behavior is printk spew from overly-instrumented
>> debugging of some driver (trace_printk is better suited to heavy instrumentation).
>>
> 
> Peter, I understand what you're saying, however the problem is that this is the
> serial driver which is one of, if not _the_ main debug output mechanism in the
> kernel.
> 
> I'm not sure I agree with doing this patch, but perhaps an easier approach would
> be to add a debug kernel parameter like "serial.force_irq=4" to force the irq to
> a previously known good value?  That way the issue of the broken driver can be
> debugged.

For debugging purposes, can you use a kernel built with
CONFIG_SERIAL_8250_DETECT_IRQ=n?

What is the platform and device type?

Regards,
Peter Hurley


> P.
> 
>> Regards,
>> Peter Hurley
>>
>>
>>> to control these cases but as long as auto_irq algorithm is used,
>>> it's hard to know which CPU can handle an interrupt from a serial and
>>> to assure the interrupt of the CPU is enabled during auto_irq.
>>> Meanwhile for legacy consoles, they actually don't require auto_irq
>>> because they basically use well-known irq number.
>>> For non-console serials, this workaround is not required
>>> because setserial command can kick autoconfig_irq() again for them.
>>>
>>> Signed-off-by: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
>>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>> ---
>>>   drivers/tty/serial/8250/8250_core.c |   17 +++++++++++++++++
>>>   1 files changed, 17 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>>> index 6bf31f2..60fda28 100644
>>> --- a/drivers/tty/serial/8250/8250_core.c
>>> +++ b/drivers/tty/serial/8250/8250_core.c
>>> @@ -65,6 +65,8 @@ static int serial_index(struct uart_port *port)
>>>
>>>   static unsigned int skip_txen_test; /* force skip of txen test at init time */
>>>
>>> +static unsigned int skip_cons_autoirq; /* force skip autoirq for console */
>>> +
>>>   /*
>>>    * Debugging.
>>>    */
>>> @@ -3336,6 +3338,9 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
>>>   		if (skip_txen_test)
>>>   			up->port.flags |= UPF_NO_TXEN_TEST;
>>>
>>> +		if (uart_console(&up->port) && skip_cons_autoirq)
>>> +			up->port.flags &= ~UPF_AUTO_IRQ;
>>> +
>>>   		uart_add_one_port(drv, &up->port);
>>>   	}
>>>   }
>>> @@ -3875,6 +3880,9 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>>>   		if (skip_txen_test)
>>>   			uart->port.flags |= UPF_NO_TXEN_TEST;
>>>
>>> +		if (uart_console(&uart->port) && skip_cons_autoirq)
>>> +			uart->port.flags &= ~UPF_AUTO_IRQ;
>>> +
>>>   		if (up->port.flags & UPF_FIXED_TYPE)
>>>   			uart->port.type = up->port.type;
>>>
>>> @@ -3936,6 +3944,10 @@ void serial8250_unregister_port(int line)
>>>   		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
>>>   		if (skip_txen_test)
>>>   			uart->port.flags |= UPF_NO_TXEN_TEST;
>>> +
>>> +		if (uart_console(&uart->port) && skip_cons_autoirq)
>>> +			uart->port.flags &= ~UPF_AUTO_IRQ;
>>> +
>>>   		uart->port.type = PORT_UNKNOWN;
>>>   		uart->port.dev = &serial8250_isa_devs->dev;
>>>   		uart->capabilities = 0;
>>> @@ -4044,6 +4056,9 @@ MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STR
>>>   module_param(skip_txen_test, uint, 0644);
>>>   MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
>>>
>>> +module_param(skip_cons_autoirq, uint, 0644);
>>> +MODULE_PARM_DESC(skip_cons_autoirq, "Skip auto irq for console during boot");
>>> +
>>>   #ifdef CONFIG_SERIAL_8250_RSA
>>>   module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
>>>   MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
>>> @@ -4070,6 +4085,8 @@ static void __used s8250_options(void)
>>>   	module_param_cb(share_irqs, &param_ops_uint, &share_irqs, 0644);
>>>   	module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
>>>   	module_param_cb(skip_txen_test, &param_ops_uint, &skip_txen_test, 0644);
>>> +	module_param_cb(skip_cons_autoirq, &param_ops_uint,
>>> +		&skip_cons_autoirq, 0644);
>>>   #ifdef CONFIG_SERIAL_8250_RSA
>>>   	__module_param_call(MODULE_PARAM_PREFIX, probe_rsa,
>>>   		&param_array_ops, .arr = &__param_arr_probe_rsa,
>>>
>>
