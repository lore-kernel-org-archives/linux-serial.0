From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v3 3/3] serial: core: Allow skipping old serial port initialization
Date: Thu, 15 Mar 2018 16:24:56 +0000
Message-ID: <CAGS+omBiUJ=0LouOkP_C9GvHNZCTeH5Vr8=Yqoe9EO6YGgZFvQ@mail.gmail.com>
References: <20180315020445.150604-1-djkurtz@chromium.org> <20180315020445.150604-4-djkurtz@chromium.org>
 <1521119068.10722.661.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521119068.10722.661.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, adurbin@chromium.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, jslaby@suse.com, Kees Cook <keescook@chromium.org>, mbrugger@suse.com, dhowells@redhat.com, allen.lkml@gmail.com, sean@mess.org, Doug Anderson <dianders@chromium.org>, matt.redfearn@mips.com, Jeffy <jeffy.chen@rock-chips.com>, marc_gonzalez@sigmadesigns.com, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 15, 2018 at 7:04 AM Andy Shevchenko <
andriy.shevchenko@linux.intel.com> wrote:

> On Wed, 2018-03-14 at 20:04 -0600, Daniel Kurtz wrote:
> > The old_serial_port global array in 8250_core is supposed to hold an
> > entry
> > for each serial port on the system that cannot be discovered via a
> > standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is
> > populated
> > at compile-time from the value specified in the SERIAL_PORT_DFNS
> > macro.
> > This macro is defined in arch/serial.h.
> >
> > For x86, this macro is currently unconditionally initialized to supply
> > four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).
> >
> > However, not all x86 CPUs have these four ioport UARTs.  For example,
> > the
> > UARTs on AMD Carrizo and later are separate memory mapped Designware
> > IP
> > blocks.
> >
> > Fairly early in boot the console_initcall univ8250_console_init
> > iterates
> > over this array and installs these old UARTs into the global array
> > serial8250_ports.  Further, it attempts to register them for use as
> > the console.  In other words, if, for example, the kernel commandline
> > has
> > console=ttyS0, the console will be switched over to one of these
> > non-existent UARTs.  Only later, when the real UART drivers are probed
> > and their devices are instantiated will the console switch back over
> > to
> > the proper UART.
> >
> > This is noticeable when using earlycon, since part of the serial
> > console
> > log will appear to disappear (when the bogus old takes over) and then
> > re-appear (when the real UART finally gets registered for the
> > console).
> >
> > The problem is even more noticable when *not* using earlycon, since in
> > this case the entire console output is missing, having been
> > incorrectly
> > played back to the non-existing serial port.
> >
> > Create a global variable to allow skipping old serial port
> > initialization
> > and wire it up to the AMDCZ ACPI SPCR quirk and the special amdcz
> > earlycon
> > setup handler.

> I don't like this approach at all.
> But unfortunately I have nothing to propose.
> Just felt like I have to share my opinion on this.

I'm not very proud of this either, but I don't know how else to set this
flag.
I proposed a Kconfig option earlier, but that also met resistance.
Perhaps another kernel command line option?


> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
