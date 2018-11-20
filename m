From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/4] serdev: make synchronous write return bytes written
Date: Tue, 20 Nov 2018 18:09:18 +0100
Message-ID: <20181120170918.GH19900@localhost>
References: <20181114150904.19653-1-johan@kernel.org>
 <20181114150904.19653-3-johan@kernel.org>
 <CAL_JsqLuF-t_Rf5Hh400=aeiLT_ahTfE0a_czZ6XRG-mD9xmig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLuF-t_Rf5Hh400=aeiLT_ahTfE0a_czZ6XRG-mD9xmig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 19, 2018 at 09:15:37AM -0600, Rob Herring wrote:
> On Wed, Nov 14, 2018 at 9:10 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > Make the synchronous serdev_device_write() helper behave analogous to
> > the asynchronous serdev_device_write_buf() by returning the number of
> > bytes written (or rather buffered) also on timeout.
> >
> > This will allow drivers to distinguish the case where data was partially
> > written from the case where no data was written.
> >
> > Also update the only two users that checked the return value.
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gnss/serial.c     |  2 +-
> >  drivers/gnss/sirf.c       |  2 +-
> >  drivers/tty/serdev/core.c | 12 ++++++++++--
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> > index 31e891f00175..def64b36d994 100644
> > --- a/drivers/gnss/serial.c
> > +++ b/drivers/gnss/serial.c
> > @@ -65,7 +65,7 @@ static int gnss_serial_write_raw(struct gnss_device *gdev,
> >
> >         /* write is only buffered synchronously */
> >         ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
> > -       if (ret < 0)
> > +       if (ret < 0 || ret < count)
> 
> The 2nd condition covers the 1st condition.

Actually it does not; ret is signed and count is unsigned, so this is
needed to catch negative errnos which would otherwise become larger than
count due to integer promotion.

> Though I guess this will all change anyways when you address the FIXME
> below.

Not sure about that yet. If wait_until_sent is interrupted the data has
already been buffered and we need to return that count. So I think I'll
just drop the FIXME.

> >                 return ret;
> >
> >         /* FIXME: determine if interrupted? */

Thanks,
Johan
