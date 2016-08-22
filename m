From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 18:38:49 +0100
Message-ID: <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <12886761.WF058qtZp8@wuerfel>
        <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
        <2775954.hrE2UdODgU@wuerfel>
        <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
        <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
        <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> I'm talking about serio, not my design which I already said the
> receive side at least needs work.
> 
> The serio API for rx and tx is a single character at a time. I thought
> we agreed that's not sufficient for things like BT.

Yes.

> 
> >> - a child of the uart node
> >> - a reg property containing the line number if the parent has multiple
> >> uarts (I'd expect this to rarely be used).  
> >
> > That surprises me as for current x86 platforms it would be the norm,
> > except that we use ACPI.  
> 
> Exactly, we're talking DT bindings here. Each port will be a separate
> node otherwise things like serial aliases and stdout-path won't work
> correctly. Compatible strings for 8250 uarts are for a single port.
> But if you had h/w such that it has common and per port registers then
> it may be a single node. I'm not aware of any example offhand (maybe
> PPC CPM). But it doesn't matter as reg can handle this case just fine
> if we need to.

For the tty side by the way here's a first RFC of one approach we could
take. This should (unless I missed anything) allow the core tty framework
to be used directly from a kernel created tty object rather than one
backed by a file.

commit fcd072e755594f9c9c0533d45223f56f76e3d104
Author: Alan <alan@linux.intel.com>
Date:   Mon Aug 22 18:05:56 2016 +0100

    [RFC] tty_port: allow a port to be opened with a tty that has no file handle
    
    Let us create tty objects entirely in kernel space. Untested proposal to
    show why all the ideas around rewriting half the uart stack are not needed.
    
    With this a kernel created non file backed tty object could be used to handle
    data, and set terminal modes. Not all ldiscs can cope with this as N_TTY in
    particular has to work back to the fs/tty layer.
    
    The tty_port code is however otherwise clean of file handles as far as I can
    tell as is the low level tty port write path used by the ldisc, the
    configuration low level interfaces and most of the ldiscs.
    
    Currently you don't have any exposure to see tty hangups because those are
    built around the file layer. However a) it's a fixed port so you probably
    don't care about that b) if you do we can add a callback and c) you almost
    certainly don't want the userspace tear down/rebuild behaviour anyway.
    
    This should however be sufficient if we wanted for example to enumerate all
    the bluetooth bound fixed ports via ACPI and make them directly available.
    
    It doesn't deal with the case of a user opening a port that's also kernel
    opened and that would need some locking out (so it returned EBUSY if bound
    to a kernel device of some kind). That needs resolving along with how you
    "up" or "down" your new bluetooth device, or enumerate it while providing
    the existing tty API to avoid regressions (and to debug).
    
    Alan

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 734a635..6210cff 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -855,7 +855,7 @@ static void tty_vhangup_session(struct tty_struct *tty)
 
 int tty_hung_up_p(struct file *filp)
 {
-	return (filp->f_op == &hung_up_tty_fops);
+	return (filp && filp->f_op == &hung_up_tty_fops);
 }
 
 EXPORT_SYMBOL(tty_hung_up_p);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index c3f9d93..606d9e5 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -335,7 +335,7 @@ EXPORT_SYMBOL(tty_port_lower_dtr_rts);
  *	tty_port_block_til_ready	-	Waiting logic for tty open
  *	@port: the tty port being opened
  *	@tty: the tty device being bound
- *	@filp: the file pointer of the opener
+ *	@filp: the file pointer of the opener or NULL
  *
  *	Implement the core POSIX/SuS tty behaviour when opening a tty device.
  *	Handles:
@@ -369,7 +369,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 		tty_port_set_active(port, 1);
 		return 0;
 	}
-	if (filp->f_flags & O_NONBLOCK) {
+	if (filp == NULL || (filp->f_flags & O_NONBLOCK)) {
 		/* Indicate we are open */
 		if (C_BAUD(tty))
 			tty_port_raise_dtr_rts(port);
