From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: debug tip after earlycon is closed?
Date: Thu, 28 Jul 2016 13:20:22 +0100
Message-ID: <20160728122022.GZ1041@n2100.armlinux.org.uk>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
 <3860396.RT1mlU0LAT@wuerfel>
 <CAK7LNARtm_2uT3nbga4X0dMYs9jhKa8a2FTGJrYbVRg8P3vHQw@mail.gmail.com>
 <7034241.kLArk8ex69@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7034241.kLArk8ex69@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 28, 2016 at 09:44:53AM +0200, Arnd Bergmann wrote:
> I think the problem is that you have three consoles:
> 
> - the boot console that stays active until a real console comes up
> - the framebuffer console that is initialized early and goes on to
>   disable the bootconsole
> - the serial console that you are looking at but which doesn't get
>   initialized until much later
> 
> Clearly something is wrong in this setup and we don't want to
> disable the boot console before the serial console is up.
> 
> I guess you could work around it by disabling the framebuffer console
> at compile time, or by having the serial console initialized earlier
> than the framebuffer, but I wonder if this is something that could
> use a more general solution.

I think this is down to how the linux,stdout property is handled.

Normally, with command line specified consoles, if you don't specify
anything, you get the framebuffer console (actually, it's the first
registered console, but practically this is the framebuffer if enabled)
by default.

If you specify a console (or consoles) on the command line, you get
all of those you specified, (iirc) with /dev/console's input connected
to the first specified console.

This happens because the command line is parsed for consoles, and
add_preferred_console() is called for each that are found, whether or
not drivers are discovered for them.  __add_preferred_console()
prevents the first registered console being automatically initialised
by setting selected_console to a non-negative number.

However, the parsing of DT specified consoles occurs at driver
initialisation time - in uart_add_one_port() via of_console_check().
Only at this time is add_preferred_console() called, which means that
the first console registered prior to _any_ selected UART console
driver mentioned in DT will become active.

When the first console becomes active, the earlycon is disabled, which
means that in the DT case, if we have a framebuffer enabled which
registers prior to any selected UART console, the framebuffer will
stop the earlycon output immediately.

To me, what this means is that the DT parsing of linux,stdout is
broken - while it may look nice from a design point of view, the
design is wrong and fails to take account of non-UART consoles in
the system.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
