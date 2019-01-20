From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [BUG] tiocsti() NULL dereference if ld->ops->receive_buf==NULL
Date: Sun, 20 Jan 2019 10:52:05 +0100
Message-ID: <20190120095205.GB28267@kroah.com>
References: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
 <20190119091108.GF10836@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190119091108.GF10836@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: Jiri Slaby <jslaby@suse.com>, kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 19, 2019 at 10:11:08AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 18, 2019 at 08:09:07PM +0100, Jann Horn wrote:
> > Hi!
> > 
> > When a line discipline doesn't have a ->receive_buf handler, tiocsti()
> > attempts to call a NULL pointer. Both tty_n_tracesink and
> > spk_ttyio_ldisc_ops don't have such a handler.
> > 
> > To reproduce, build a kernel with CONFIG_SPEAKUP=y and
> > CONFIG_SPEAKUP_SYNTH_SOFT=y, set speakup.synth=soft in the kernel
> > command line, and run the following code as root:
> 
> <snip>
> 
> Ugh, thanks for finding this.  I'll look at it later this afternoon...

It looks to be a simple change.  We can't really "fail" this ioctl if
there's nothing wrong with the structure of the call, so we can just
quietly "eat" the character, given that the line discipline doesn't care
about it.

So, any objections to the patch below?

thanks,

greg k-h

-----------------

Subject: [PATCH] tty: Handle problem if line discipline does not have receive_buf

Some tty line disciplines do not have a receive buf callback, so
properly check for that before calling it.  If they do not have this
callback, just eat the character quietly, as we can't fail this call.

Reported-by: Jann Horn <jannh@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 23c6fd238422..21ffcce16927 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2189,7 +2189,8 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return -EIO;
-	ld->ops->receive_buf(tty, &ch, &mbz, 1);
+	if (ld->ops->receive_buf)
+		ld->ops->receive_buf(tty, &ch, &mbz, 1);
 	tty_ldisc_deref(ld);
 	return 0;
 }
-- 
2.20.1
