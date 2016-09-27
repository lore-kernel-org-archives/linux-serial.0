From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: Problem with 761ed4a (tty: serial_core: convert uart_close to
 use tty_port_close)
Date: Tue, 27 Sep 2016 19:16:33 +0200
Message-ID: <20160927171633.GH16263@bigcity.dyn.berto.se>
References: <20160927110140.GG16263@bigcity.dyn.berto.se>
 <CAL_JsqKWjJ3Qo44=gjqLVJK6utUtrJF5nB=EVEE1wOmFpqw-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKWjJ3Qo44=gjqLVJK6utUtrJF5nB=EVEE1wOmFpqw-+A@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

Thanks for your reply.

On 2016-09-27 10:57:56 -0500, Rob Herring wrote:
> On Tue, Sep 27, 2016 at 6:01 AM, Niklas Söderlund
> <niklas.soderlund@ragnatech.se> wrote:
> > Hi Rob and Vinod,
> >
> > While testing on Renesas Koelsch board Vinods 'next' branch at
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git
> >
> > I ran into some problems with Robs patch 761ed4a (tty: serial_core:
> > convert uart_close to use tty_port_close) and my systemd based init
> > system. The kernel starts fine, mounts the NFS root and starts init but
> > then the serial console go silent and I'm not able to communicate with
> > the system.
> 
> There's a fix later in Greg's tree that's not in this tree. If that
> doesn't fix it, can you try reverting the hunk that sets the
> tty_port.console flag.

I tried Greg's branch tty-next from 

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

Which contains the commit I think you are referring to, a5a2b13 (serial: 
core: fix potential NULL pointer dereference). Unfortunately it dose not 
fix the problem I see.

I also tried your other suggestion by reverting the chunk that sets the 
tty_port.console flag (on top of tty-next branch), like this:

@@ -2746,8 +2746,6 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
        uport->cons = drv->cons;
        uport->minor = drv->tty_driver->minor_start + uport->line;
 
-       port->console = uart_console(uport);
-
        /*
         * If this port is a console, then the spinlock is already
         * initialised.

The problem still unfortunately persists :-(

I can still revert the commits a5a2b13 (serial: core: fix potential NULL 
pointer dereference) and 761ed4a (tty: serial_core: convert uart_close 
to use tty_port_close) from the top of the tty-next branch and the 
system boots fine.

The configuration I'm using for all tests are shmobile_defconfig + 
CONFIG_CGROUPS + CONFIG_SECCOMP. 

-- 
Regards,
Niklas Söderlund
