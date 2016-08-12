From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: debug tip after earlycon is closed?
Date: Fri, 12 Aug 2016 12:44:22 +0900
Message-ID: <CAK7LNARYUCGxK1Z0JSCY9SLtacVqn21VammGC=WAOz3ou-+c2g@mail.gmail.com>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
 <3860396.RT1mlU0LAT@wuerfel>
 <CAK7LNARtm_2uT3nbga4X0dMYs9jhKa8a2FTGJrYbVRg8P3vHQw@mail.gmail.com>
 <7034241.kLArk8ex69@wuerfel> <20160728122022.GZ1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160728122022.GZ1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi.




2016-07-28 16:44 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>
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


Looks like this comes from:

#elif defined(CONFIG_DUMMY_CONSOLE)
        conswitchp = &dummy_con;
#endif


console= in the kernel-parameter is no problem,
but stdout-path in the chose node goes wrong with it.






2016-07-28 21:20 GMT+09:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> I think this is down to how the linux,stdout property is handled.
>
> Normally, with command line specified consoles, if you don't specify
> anything, you get the framebuffer console (actually, it's the first
> registered console, but practically this is the framebuffer if enabled)
> by default.
>
> If you specify a console (or consoles) on the command line, you get
> all of those you specified, (iirc) with /dev/console's input connected
> to the first specified console.
>
> This happens because the command line is parsed for consoles, and
> add_preferred_console() is called for each that are found, whether or
> not drivers are discovered for them.  __add_preferred_console()
> prevents the first registered console being automatically initialised
> by setting selected_console to a non-negative number.
>
> However, the parsing of DT specified consoles occurs at driver
> initialisation time - in uart_add_one_port() via of_console_check().
> Only at this time is add_preferred_console() called, which means that
> the first console registered prior to _any_ selected UART console
> driver mentioned in DT will become active.
>
> When the first console becomes active, the earlycon is disabled, which
> means that in the DT case, if we have a framebuffer enabled which
> registers prior to any selected UART console, the framebuffer will
> stop the earlycon output immediately.
>
> To me, what this means is that the DT parsing of linux,stdout is
> broken - while it may look nice from a design point of view, the
> design is wrong and fails to take account of non-UART consoles in
> the system.


Thanks for clarification.
I agree that stdout-path is something wrong.



Since I switched
from

chosen {

         bootargs = "console=ttyS0,115200";
};

to

chosen {
        stdout-path = "serial0:115200n8";
};


I have had bad experiences.



The combination of stdout-path and earlycon gives doubled log.
I reported this in  https://lkml.org/lkml/2015/11/27/170
but not fixed yet.



I could fix the problem by changing


chosen {
         stdout-path = "serial0:115200n8";
         bootargs = "earlycon";
};

to

chosen {
         bootargs = "console=ttyS0,115200
earlycon=uniphier,mmio32,0x54006800,115200";
};






-- 
Best Regards
Masahiro Yamada
