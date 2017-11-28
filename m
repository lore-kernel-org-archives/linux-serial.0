From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 8/8] serdev: ttyport: do not used keyed wakeup in
 write_wakeup
Date: Tue, 28 Nov 2017 16:16:29 +0100
Message-ID: <20171128151629.GA8177@localhost>
References: <20171103143059.20749-1-johan@kernel.org>
 <20171103143059.20749-9-johan@kernel.org>
 <20171128150418.GA3341@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171128150418.GA3341@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 28, 2017 at 04:04:18PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 03, 2017 at 03:30:59PM +0100, Johan Hovold wrote:
> > Serdev does not use the file abstraction and specifically there will
> > never be anyone polling a file descriptor for POLLOUT events.
> > 
> > Just use plain wake_up_interruptible() in the write_wakeup callback and
> > document why it's there.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/tty/serdev/serdev-ttyport.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> This patch didn't apply, perhaps because I split this series across my
> "for-next" and "for-linus" branches?

That's right, this one depends on patch 4/8.

Perhaps you can take also this one through tty-linus? Or even better,
just take the whole series through tty-linus?

Johan
