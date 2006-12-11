From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Date: Mon, 11 Dec 2006 15:19:43 +0000
Message-ID: <20061211151943.2bbc720e@localhost.localdomain>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
	<20061211102016.43e76da2@localhost.localdomain>
	<457D70A4.1000000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936499AbWLKPMF@vger.kernel.org>
In-Reply-To: <457D70A4.1000000@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corey Minyard <cminyard@mvista.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 11 Dec 2006 08:52:20 -0600
Corey Minyard <cminyard@mvista.com> wrote:
> So here's the start of discussion:
> 
> 1) The IPMI driver needs to run at panic time to modify watchdog
> timers and store panic information in the event log.  So no work
> queues, no delayed work, and the need for some type of poll
> operation on the device.

That would be the existing serial console interface. For things like USB
serial you are probably out of luck. At the moment we have a single
"console" attached to a specific serial console interface. The code is
almost all there for allowing other parties to create new synchronous
serial logging devices by opening open as the console driver does.

> 2) The IPMI driver needs to get messages through even when
> the system is very busy.  Since a watchdog runs over the driver,
> it needs to be able to get messages through to avoid a system
> reset as long as something is pinging the watchdog from userland.

You have a high priority character output function which jumps existing
data. Not all hardware implements this, and some of the modern hardware
in particular simply doesn't physically support such behaviour. Also if
you are the sole user of the port you *know* nobody else will be queuing
data to it anyway.

> Currently there are mutexes, lock_kernel() calls, and work queues
> that cause trouble for these.
> 
> There is also a comment that you can't set low_latency and call
> tty_flip_buffer_push from IRQ context.  This seems to be due to a
> lack of anything in flush_to_ldisc to handle reentrancy, and perhaps
> because disc->receive_buf can block, but I couldn't tell easily.

The entire tty side locking, scheduling and design is based upon the idea
that input processing is deferred. Otherwise you get long chains of
recursion from the worst cases.

Alan
