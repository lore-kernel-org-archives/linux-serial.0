From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: My pledge as a maintainer to the developers sending me patches.
Date: Mon, 18 Jun 2012 14:15:10 -0700
Message-ID: <20120618211510.GA11479@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
List-Id: linux-serial@vger.kernel.org

As I recently posted here:
	http://www.kroah.com/log/linux/maintainer_pledge.html
there's been lots of discussion about maintainers, their general
grumpiness, and how to handle this.  I don't want to duplicate what was
said in that post, except for the following.

Here's what I, as a kernel subsystem maintainer, will strive to do for
all patches sent to me by developers:

 1) I will review your patch within 1-2 weeks (see details below).
 2) I will offer semi-constructive criticism of your patches.
 3) I will let you know the status of your patch if it is rejected, or if
    it is accepted, what tree it has gone into, where you can find it,
    and when you can expect to see it merged into Linus's tree.

Notes on the above:

1) Of course, if I'm sick, or traveling on insane Asia trips, my
response time will be delayed, but feel free to email me asking the
status of a patch you have sent me, I'm happy to respond back that I
just haven't gotten to it.  I would much rather field these kinds of
inquiries (after waiting a few weeks) then loose patches and make people
mad.

Also, consider the kernel merge window requirements, during the merge
window, I can't accept new patches into my tree that are not bugfixes
for this specific kernel release, so that means there is usually a 3
week window starting about 1 week before Linus's release,
lasting until after a -rc1 kernel is released, before I can get to your
patch.  During that time period hundreds of patches accrue, so please
give me some time to dig out from all of them.  Usually by -rc3 I'm
caught up, if not, email me and ask.

2) Sorry, it can't always be constructive, but I'll try my best.  I'll
also try to not cast aversions about your cat, but if you taunt me, all
bets are off.

3) I have scripts that automatically do this, that were based on Andrew
Morton's older scripts, that any maintainer is more than willing to have
a copy of.  Here's the most recent copy at the moment, if you want to
look at it:
	https://github.com/gregkh/gregkh-linux/blob/master/work/do.sh


So, that's it, comments?  Criticism?

Note, I don't expect anyone else to do this, it's just what I am willing
to do.  I know some subsystem maintainers do a much better job than I do
(some subsystem response times to patches is amazing!), but I figured
I'd put this out there if anyone else wanted to rift on it.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
