From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/4] serdev: make serdev_device_write() more usable
Date: Tue, 20 Nov 2018 18:11:07 +0100
Message-ID: <20181120171107.GI19900@localhost>
References: <20181114150904.19653-1-johan@kernel.org>
 <CAL_JsqJyTVsN1=YpeHNtTr+Tpw9Qmqd=mWfhg-d3WgzUX7DqKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJyTVsN1=YpeHNtTr+Tpw9Qmqd=mWfhg-d3WgzUX7DqKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 19, 2018 at 09:16:35AM -0600, Rob Herring wrote:
> On Wed, Nov 14, 2018 at 9:10 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > This series make the synchronous serdev_device_write() helper more
> > usable by
> >
> >         1) allowing drivers to pass a zero timeout to indicate that they
> >            want to wait forever;
> >
> >         2) returning the number of bytes actually written (buffered)
> >            if the helper is interrupted;
> >
> >         3) make the helper use interruptible wait so that the helper can
> >            be used on behalf of user space.
> >
> > Finally, the two write functions are documented using kernel-doc.
> >
> > Turns out I was using the wrong timeout for two gnss drivers that
> > expected the helper to wait indefinitely. I've fixed up those separately
> > (by using MAX_SCHEDULE_TIMEOUT for now), but for the helper to be usable
> > when using flow control we really want it to be interruptible.
> >
> > Besides the two gnss drivers, there's currently only one other in-kernel
> > user of this helper and that driver (rave-sp) uses a non-zero timeout
> > and doesn't check the return value and therefore does not need to be
> > updated.
> >
> > Note that this series depends on the two above mentioned GNSS fixes
> > (submitted for v4.20-rc3).
> >
> > Johan
> >
> >
> > Johan Hovold (4):
> >   serdev: use zero to indicate infinite write timeout
> >   serdev: make synchronous write return bytes written
> >   serdev: make synchronous write helper interruptible
> >   serdev: document the write functions using kernel-doc
> 
> Other than the one nit, for the series:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for reviewing.

Greg, note that these still depend on the two gnss fixes currently in
your char-misc-linus branch.

Johan
