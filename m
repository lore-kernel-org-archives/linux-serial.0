From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] 8250: Hypervisors always export working 16550A UARTs.
Date: Thu, 28 Apr 2016 17:04:52 -0700
Message-ID: <5722A524.8040507@hurleysoftware.com>
References: <1461881913-23967-1-git-send-email-rjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461881913-23967-1-git-send-email-rjones@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yamada.masahiro@socionext.com, matwey@sai.msu.ru, valentinrothberg@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
List-Id: linux-serial@vger.kernel.org

On 04/28/2016 03:18 PM, Richard W.M. Jones wrote:
> [This is an opinionated patch, mainly for discussion.]
> 
> I'm trying to reduce the time taken in the kernel in initcalls, with
> my aim being to reduce the current ~700ms spent in initcalls before
> userspace, down to something like 100ms.  All times on my Broadwell-U
> laptop, under virtualization.  The purpose of this is to be able to
> launch VMs around containers with minimal overhead, like Intel Clear
> Containers, but using standard distro kernels and qemu.
> 
> Currently the kernel spends 25ms inspecting the UART that we passed to
> it from qemu to find out whether it's an 8250/16550/16550A perhaps
> with a non-working FIFO or other quirks.  Well, it isn't -- it's a
> working emulated 16550A, with a FIFO and no quirks, and if it isn't,
> we should fix qemu.

I'm sure all of this delay is sizing the fifo:

static int size_fifo(struct uart_8250_port *up)
{
	...
	for (count = 0; count < 256; count++)
		serial_out(up, UART_TX, count);
===>	mdelay(20);/* FIXME - schedule_timeout */
	for (count = 0; (serial_in(up, UART_LSR) & UART_LSR_DR) &&
	     (count < 256); count++)
		serial_in(up, UART_RX);
	...

	return count;
}


> So the patch detects if we're running virtualized (perhaps it should
> only check for qemu/KVM?) and if so, shortcuts the tests.

Yeah, sorry, that's not going to fly.

I'm assuming x86, yes?

There's are multiple ways already supported by this driver to specify
the port based on the platform:

1. Register "serial8250" platform device.
   Set UPF_FIXED_TYPE in ::flags and PORT_16550A in ::type
2. early_serial_setup()
   Same as above, but must be before console_init()
3. Don't enumerate PNP0501 ACPI devices
   These are going to be probed dynamically
4. Add ACPI/PNP custom device
   Fixing the port type isn't supported now but could be
5. Modify the SERIAL_PORT_DFNS
   Fixing the port type isn't supported now either but could be

Regards,
Peter Hurley  
