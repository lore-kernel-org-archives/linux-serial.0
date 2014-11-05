From: Shreyas Bethur <shreyas.bethur@ni.com>
Subject: Re: [PATCH 1/1] tty: Do not set modem lines when reopening ports
Date: Wed, 5 Nov 2014 16:01:21 -0600
Message-ID: <OFC3DBEDDF.98889C80-ON86257D87.006F9538-86257D87.0078F95B@ni.com>
References: <OF6C85CA04.9FBB77C4-ON86257D82.007014C2-86257D82.0070E996@ni.com> <54580C09.7080901@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:34912 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751219AbaKEWB1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 17:01:27 -0500
In-Reply-To: <54580C09.7080901@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org

Hi Peter,

Thanks for your response. You can find my reply in-line below.

> From: Peter Hurley <peter@hurleysoftware.com>
> To: Shreyas Bethur <shreyas.bethur@ni.com>, linux-
> serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, 
> Date: 11/03/2014 05:13 PM
> Subject: Re: [PATCH 1/1] tty: Do not set modem lines when reopening 
ports
> 
> Hi Shreyas,
> 
> On 10/31/2014 04:33 PM, Shreyas Bethur wrote:
> > When tty port is opened, we will raise the DTR and RTS lines. But for
> > second and subsequent opens, we should not modify these lines because 
the
> > first session might be actively using these lines. We don't want a 
second
> > open to interfere with the first session.
> > 
> > Signed-off-by: Shreyas Bethur <shreyas.bethur@ni.com>
> > ---
> > To give some background for this patch, we have a product that uses 
the
> > DTR line on the serial port for synchronization with other devices. 
While
> > the synchronization application is using the DTR line, if another 
process
> > opens the same port, then DTR line is raised, and thus interferes with 
the
> > synchronization application. So, if a port is open, subsequent opens
> > should not modify any modem lines.
> 
> Would you please expand on your use-case?
> 
> Regards,
> Peter Hurley
> 

We have many devices in a real-time test & measurement system, and the 
clocks on
all these devices needs to be synchronized for our applications. So we 
connect
all the devices to a central hub via serial ports. We open a tty session 
(in
exclusive mode and non-admin user) and toggle the DTR lines from all the 
devices,
every time cycle. The hub measures the time difference between these 
signals and
correct the clock on the devices. We also have a service that the user can 
use to
enumerate all the serial ports and check whether they are in use. When 
this
service opens the port that is used for synchronization, it gets EBUSY 
error,
which is good; But the tty driver raises the DTR line before returning 
EBUSY.

I would expect that if a tty session is opened in exclusive mode, any 
subsequent
opens to not change anything on the port including DTR and RTS lines. 
Please let
me know if I'm missing something or if my understanding is incorrect.

Regards,
Shreyas Bethur


> > This patch is my attempt to fix this issue. Please review my fix, and 
let
> > me know what you folks think.
> > ---
> >  drivers/tty/tty_port.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > index 1b93357..8a6c80a 100644
> > --- a/drivers/tty/tty_port.c
> > +++ b/drivers/tty/tty_port.c
> > @@ -363,6 +363,7 @@ int tty_port_block_til_ready(struct tty_port 
*port,
> >         int do_clocal = 0, retval;
> >         unsigned long flags;
> >         DEFINE_WAIT(wait);
> > +       bool port_first_open = true;
> > 
> >         /* block if port is in the process of being closed */
> >         if (port->flags & ASYNC_CLOSING) {
> > @@ -381,8 +382,15 @@ int tty_port_block_til_ready(struct tty_port 
*port,
> >                 return 0;
> >         }
> >         if (filp->f_flags & O_NONBLOCK) {
> > -               /* Indicate we are open */
> > -               if (tty->termios.c_cflag & CBAUD)
> > +               /* The port lock protects the port counts */
> > +               spin_lock_irqsave(&port->lock, flags);
> > +               if (port->count > 1)
> > +                       port_first_open = false;
> > +               spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +               /* Indicate we are open. Raise DTR and RTS only if 
opening 
> > the
> > +                  port for the first time */
> > +               if ((tty->termios.c_cflag & CBAUD) && port_first_open)
> >                         tty_port_raise_dtr_rts(port);
> >                 port->flags |= ASYNC_NORMAL_ACTIVE;
> >                 return 0;
> > 
> 

