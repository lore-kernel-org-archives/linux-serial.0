From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [BUG] tiocsti() NULL dereference if ld->ops->receive_buf==NULL
Date: Mon, 21 Jan 2019 17:14:21 +0100
Message-ID: <20190121161421.GB29858@kroah.com>
References: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
 <20190119091108.GF10836@kroah.com>
 <20190120095205.GB28267@kroah.com>
 <CAG48ez0=Mcgk15EWBfVw-X7gB2hMJFULRA_w429-uyPZotdqNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG48ez0=Mcgk15EWBfVw-X7gB2hMJFULRA_w429-uyPZotdqNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: Jiri Slaby <jslaby@suse.com>, kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 21, 2019 at 04:38:33PM +0100, Jann Horn wrote:
> On Sun, Jan 20, 2019 at 10:52 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jan 19, 2019 at 10:11:08AM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Jan 18, 2019 at 08:09:07PM +0100, Jann Horn wrote:
> > > > Hi!
> > > >
> > > > When a line discipline doesn't have a ->receive_buf handler, tiocsti()
> > > > attempts to call a NULL pointer. Both tty_n_tracesink and
> > > > spk_ttyio_ldisc_ops don't have such a handler.
> > > >
> > > > To reproduce, build a kernel with CONFIG_SPEAKUP=y and
> > > > CONFIG_SPEAKUP_SYNTH_SOFT=y, set speakup.synth=soft in the kernel
> > > > command line, and run the following code as root:
> > >
> > > <snip>
> > >
> > > Ugh, thanks for finding this.  I'll look at it later this afternoon...
> >
> > It looks to be a simple change.  We can't really "fail" this ioctl if
> > there's nothing wrong with the structure of the call, so we can just
> > quietly "eat" the character, given that the line discipline doesn't care
> > about it.
> >
> > So, any objections to the patch below?
> 
> No objection from me.
> 
> (spk_ttyio_ldisc_ops has a receive_buf2 handler, but I don't know
> whether that should be invoked here or not.)

No, receive_buf2 can fail, or do a short "receive", which receive_buf()
can't do, and tiocsti can't fail (it's only used to fake input data).

Yeah, the tty layer is strange :(

thanks,

greg k-h
