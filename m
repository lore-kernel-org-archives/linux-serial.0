From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Regression: ftdi_sio is slow (since Wed Oct 10 15:05:06 2012)
Date: Fri, 3 May 2013 10:16:18 -0700
Message-ID: <20130503171618.GA16686@kroah.com>
References: <5183D196.2080305@list.ru>
 <20130503163008.GA30699@kroah.com>
 <5183F62A.1020801@list.ru>
 <20130503165231.GA1966@kroah.com>
 <5183FC83.8090602@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5183FC83.8090602@list.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Stas Sergeev <stsp@list.ru>
Cc: Jarkko Huijts <jarkko.huijts@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-serial@vger.kernel.org

On Fri, May 03, 2013 at 10:05:55PM +0400, Stas Sergeev wrote:
> 03.05.2013 20:52, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >On Fri, May 03, 2013 at 09:38:50PM +0400, Stas Sergeev wrote:
> >>03.05.2013 20:30, Greg KH =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>We need some way to check the chars in the buffer, is the device y=
ou are
> >>>using just very slow to respond to this request?  How slow?  Do yo=
u have
> >>>a test case that we can see how it is affected?
> >>Greg, unfortunately, I do have nothing.
> >>The customer is in CC list, so maybe he will
> >>provide the test-case, but I doubt.
> >>
> >>Please, what are your concerns here?
> >>The patch in question does this:
> >>---
> >>+ ret =3D usb_control_msg(port->serial->dev,
> >>+ usb_rcvctrlpipe(port->serial->dev, 0),
> >>+ FTDI_SIO_GET_MODEM_STATUS_REQUEST,
> >>+ FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
> >>+ 0, priv->interface,
> >>+ buf, 2, WDR_TIMEOUT);
> >>---
> >>Obviously, this is too expensive to call too frequently,
> >>or am I missing something?
> >Why do you think that is too expensive to call?  Does it somehow sto=
p
> >the data being sent to the device through the serial endpoints?  Is
> >userspace calling this function too much slowing something else down=
?
> No, it doesn't slow down the data transfer.
> But it makes a select() call to take much longer to complete,

Please define "much longer".

> and the same goes to TIOCOUTQ ioctl. Yes, the app calls select()
> quite too much, and it is single-threaded, too. :)

Sounds like an application is doing a foolish thing and should stop it.
There's no guarantee as to how long select or an ioctl will take, and
now that we have fixed another bug, this device is slower.

If you change hardware types to use a different usb to serial chip, tha=
t
select call might take 4 times as long.  Are we somehow supposed to
change the kernel to "fix" that?

> >>I asked the customer to comment out
> >>tty_chars_in_buffer(tty) < WAKEUP_CHARS
> >>line in n_tty.c, and he said that cured his problems,
> >>so I think my guess was right.
> >What exactly is the "problem" being seen?
> No idea.
> Well, I can make a test-case that does 1000000 select() calls
> in a loop and time it. This is probably the best I can do.

That's really not a valid test case, as it's nothing that we ever
optimize a serial driver for.  Throughput is the proper thing to care
about, right?

And if select takes longer, nothing really "slows down" as now you get
data more often between select calls, right?

> >>The patch claims it only affects tcdrain() and close().
> >>Its trivial to see it also affects poll(), select() and TIOCOUTQ
> >>ioctl, so even from that it is already broken.
> >>Why do you need a test-case for this?
> >Because I don't know what the problem really is :)
> Slow select() call (and other calls).
> Can we just use usb_serial_generic_chars_in_buffer()
> in ftdi_sio? What was the reason behind the patch at all,
> why it is so importand to query TEMT?

To actually determine how many characters the device has in its buffer.

thanks,

greg k-h
