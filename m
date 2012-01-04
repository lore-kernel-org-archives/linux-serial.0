From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB disconnect -> kernel panic
Date: Wed, 4 Jan 2012 15:01:49 -0800
Message-ID: <20120104230149.GA16655@kroah.com>
References: <87mxahk3d1.fsf@gag.com>
 <20120102182255.GC8562@xanatos>
 <20120103235847.GF21311@kroah.com>
 <87fwfwmaeo.fsf@gag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87fwfwmaeo.fsf-wvU4uTqWWAI@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bdale Garbee <bdale-wvU4uTqWWAI@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Oliver Neukum <oliver-Q6YOFhsQ4GZ7tPAFqOLdPg@public.gmane.org>, keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 03, 2012 at 08:09:03PM -0700, Bdale Garbee wrote:
> On Tue, 3 Jan 2012 15:58:47 -0800, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > On Mon, Jan 02, 2012 at 10:22:55AM -0800, Sarah Sharp wrote:
> > > On Sat, Dec 24, 2011 at 03:32:26PM -0700, Bdale Garbee wrote:
> > > > Hi Sarah!  Merry Christmas!
> > > > 
> > > > I've been working on another production run of Altus Metrum products
> > > > today, and in the process of flashing and calibrating a pile of our
> > > > TeleDongle units, I've been seeing sporadic kernel panics when
> > > > unplugging them from my notebook USB.  Has now happened three times this
> > > > morning. 
> > > > 
> > > > I'm running 3.1.6 now, but I saw this under 3.1.5 too, at least once.
> > > > The notebook is an HP 2540p.
> > > > 
> > > > Keith suggested I send you the attached photo of my screen showing the
> > > > panic info. 
> > > 
> > > It's somewhere in the tty layer, and doesn't look USB related.  I think
> > > Greg KH is the tty maintainer right now, so you might want to ask him.
> > 
> > We've had some cdc_acm driver problems in the past, but I thought they
> > were all resolved.  3.1.3 should have fixed those problems.  We have
> > some more cleanups queued up for 3.3, but nothing that should be fixing
> > something like this.
> > 
> > Oliver, any thoughts about this (see the original post on linux-usb for
> > the crash dump.)
> 
> For what it's worth, it happened to me again today running 3.2.0-rc7.  I
> didn't bother photographing the screen again, though I'm happy to do
> that if it'll help.

Ok, can you try the patch below and let me know if it solves the problem
or not?

thanks,

greg k-h

-------------------
From: Thilo-Alexander Ginkel <thilo-6Cr7QIIRUuHQT0dZR+AlfA@public.gmane.org>
Subject: usb: cdc-acm: Fix acm_tty_hangup() vs.  acm_tty_close() race

There is a race condition involving acm_tty_hangup() and acm_tty_close() where
hangup() would attempt to access tty->driver_data without proper locking and
NULL checking after close() has potentially already set it to NULL.
One possibility to (sporadically) trigger this behavior is to perform a
suspend/resume cycle with a running WWAN data connection.

This patch addresses the issue by introducing a NULL check for
tty->driver_data in acm_tty_hangup() protected by open_mutex and exiting
gracefully when hangup() is invoked on a device that has already been closed.

Signed-off-by: Thilo-Alexander Ginkel <thilo-6Cr7QIIRUuHQT0dZR+AlfA@public.gmane.org>
---
 drivers/usb/class/cdc-acm.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index a8078d0..97f2e58 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -554,10 +554,18 @@ static void acm_port_down(struct acm *acm)
 
 static void acm_tty_hangup(struct tty_struct *tty)
 {
-	struct acm *acm = tty->driver_data;
-	tty_port_hangup(&acm->port);
+	struct acm *acm;
+
 	mutex_lock(&open_mutex);
+	acm = tty->driver_data;
+
+	if (!acm)
+		goto out;
+
+	tty_port_hangup(&acm->port);
 	acm_port_down(acm);
+
+out:
 	mutex_unlock(&open_mutex);
 }
 
-- 
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
