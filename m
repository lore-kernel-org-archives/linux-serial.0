From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers/tty: Don't hangup shared ttys
Date: Tue, 11 Jun 2013 17:05:01 -0700
Message-ID: <20130612000501.GA2733@kroah.com>
References: <1370991787-24141-1-git-send-email-marcheu@chromium.org>
 <20130611231518.GA28106@kroah.com>
 <CADMs+9ZWnz4zFqa69QoHfbOLc7Yxn2Cvo-NTNdAhw8-uPm9M6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44104 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3FLAE0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jun 2013 20:04:26 -0400
Content-Disposition: inline
In-Reply-To: <CADMs+9ZWnz4zFqa69QoHfbOLc7Yxn2Cvo-NTNdAhw8-uPm9M6A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Cc: linux-kernel@vger.kernel.org, jslaby@suse.cz, olof@lixom.net, linux-serial@vger.kernel.org

On Tue, Jun 11, 2013 at 04:19:47PM -0700, St=E9phane Marchesin wrote:
> On Tue, Jun 11, 2013 at 4:15 PM, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> > On Tue, Jun 11, 2013 at 04:03:07PM -0700, St=E9phane Marchesin wrot=
e:
> >> When quickly restarting X servers, we can run into a situation whe=
re
> >> one X server quits while another one starts on the same tty. For a
> >> while, two X servers share the tty, and when the old X server
> >> eventually quits, the tty layer hangs up the tty, which among othe=
r
> >> things stubs out the tty's ioctl functions. Later on, the new X
> >> server (which shares the tty functions) tries to call some ioctls
> >> on the tty and fails because they have been replaced with the hung=
up
> >> versions. This in turn causes the new X server to abort.
> >>
> >> This patch checks the tty->count to make sure we're the last
> >> consumer before hanging up a tty.
> >>
> >> Signed-off-by: St=E9phane Marchesin <marcheu@chromium.org>
> >> ---
> >>  drivers/tty/tty_io.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> >> index 6464029..62a0f02 100644
> >> --- a/drivers/tty/tty_io.c
> >> +++ b/drivers/tty/tty_io.c
> >> @@ -619,6 +619,9 @@ static void __tty_hangup(struct tty_struct *tt=
y, int exit_session)
> >>       if (!tty)
> >>               return;
> >>
> >> +     /* Don't hangup if there are other users */
> >> +     if (tty->count > 1)
> >> +             return;
> >
> > What happens when you have a "real" tty that was hungup because it =
was
> > disconnected physically from the system yet userspace had a tty ope=
n?
> > You want those ttys to be hungup properly, right?  Doesn't this cha=
nge
> > break that?
>=20
> My understanding was that they'd have a different tty_struct. Is that
> not the case?

No, it's the same case as you are seeing, the tty_struct is still the
same, but we really need to hang it up as it's no longer there, no
matter if there are users of it or not.

Try it with your change and any cheap usb-serial device (open a port,
unplug it, try to write to the device node you still had open.)

> If so how would you recommend fixing the problem I described?

=46ix your system to:
  - shut down X faster
  - only start the new X when the first one is shutdown
  - create the second version of X before the first one is shutdown, bu=
t
    handle it properly by giving userspace the full second instance
    (i.e. handle it if 2 x servers are running at once.)

Have you tried any of these?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
