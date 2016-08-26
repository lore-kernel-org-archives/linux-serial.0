From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 4/6] serio: serport: add support for buffered write
 and receive
Date: Sat, 27 Aug 2016 00:24:25 +0200
Message-ID: <20160826222425.GA1140@amd>
References: <20160824232437.9446-1-robh@kernel.org>
 <20160824232437.9446-6-robh@kernel.org>
 <20160826201202.GA27227@amd>
 <CAL_JsqLNeV9BDvRtRbDCKbrq-gO9jv8-kmGJNS9AKXUSmEvYOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLNeV9BDvRtRbDCKbrq-gO9jv8-kmGJNS9AKXUSmEvYOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri 2016-08-26 16:27:35, Rob Herring wrote:
> On Fri, Aug 26, 2016 at 3:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> @@ -133,26 +133,29 @@ static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *c
> >>       if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> >>               goto out;
> >>
> >> -     for (i = 0; i < count; i++) {
> >> -             if (fp) {
> >> -                     switch (fp[i]) {
> >> -                     case TTY_FRAME:
> >> -                             ch_flags = SERIO_FRAME;
> >> -                             break;
> >> -
> >> -                     case TTY_PARITY:
> >> -                             ch_flags = SERIO_PARITY;
> >> -                             break;
> >> -
> >> -                     default:
> >> -                             ch_flags = 0;
> >> -                             break;
> >> +     if (serio_buffered_mode_enabled(serport->serio)) {
> >> +             serio_receive_buf(serport->serio, cp, count);
> >
> > Elsewhere:
> > +       /* Use buffer receive if the driver provides a callback */
> > +       if (drv->receive_buf)
> > +               set_bit(SERIO_MODE_BUFFERED, &drv->flags);
> >
> > Could we use if (drv->receive_buf) above directly, and not require the
> > bitfield?
> 
> I'm allowing for allowing drivers to provide both functions and be
> able to switch between them. However, I didn't provide any mechanism
> to do so yet.

Dunno -- does switching make sense? IMO we'd want to migrate all the
drivers to the "blocks" interface... no need to switch between the
two.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
