From: Christopher Curtis <ccurtis0@gmail.com>
Subject: Re: [PATCH 1/5] tty: Add a function to insert a string of characters
	with the same flag
Date: Sat, 27 Feb 2010 09:45:57 -0500
Message-ID: <969d87001002270645v4b958f91vee0c0868d665c06b@mail.gmail.com>
References: <20100217130604.16008.86393.stgit@localhost.localdomain>
	 <20100226221100.GA22352@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:52245 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968433Ab0B0Op7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Feb 2010 09:45:59 -0500
In-Reply-To: <20100226221100.GA22352@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, Feb 26, 2010 at 5:11 PM, Greg KH <greg@kroah.com> wrote:
>
> On Wed, Feb 17, 2010 at 01:06:30PM +0000, Alan Cox wrote:
> > The USB drivers often want to insert a series of bytes all with the=
 same
> > flag set - provide a helper for this case.
> >
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > ---
> >
> > =A0drivers/char/tty_buffer.c | =A0 12 +++++++-----
> > =A0include/linux/tty_flip.h =A0| =A0 =A07 ++++++-
> > =A02 files changed, 13 insertions(+), 6 deletions(-)
> >
> >
> > diff --git a/drivers/char/tty_buffer.c b/drivers/char/tty_buffer.c
> > index 8402eda..af8d977 100644
> > --- a/drivers/char/tty_buffer.c
> > +++ b/drivers/char/tty_buffer.c
> > @@ -231,9 +231,10 @@ int tty_buffer_request_room(struct tty_struct =
*tty, size_t size)
> > =A0EXPORT_SYMBOL_GPL(tty_buffer_request_room);
> >
> > =A0/**
> > - * =A0 tty_insert_flip_string =A0- =A0 =A0 =A0 Add characters to t=
he tty buffer
> > + * =A0 tty_insert_flip_string_fixed_flag - Add characters to the t=
ty buffer
> > =A0 * =A0 @tty: tty structure
> > =A0 * =A0 @chars: characters
> > + * =A0 @flag: flag value for each character
> > =A0 * =A0 @size: size
> > =A0 *
> > =A0 * =A0 Queue a series of bytes to the tty buffering. All the cha=
racters
> > @@ -242,18 +243,19 @@ EXPORT_SYMBOL_GPL(tty_buffer_request_room);
> > =A0 * =A0 Locking: Called functions may take tty->buf.lock
> > =A0 */
> >
> > -int tty_insert_flip_string(struct tty_struct *tty, const unsigned =
char *chars,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t si=
ze)
> > +int tty_insert_flip_string_fixed_flag(struct tty_struct *tty,
> > + =A0 =A0 =A0 =A0 =A0 =A0 const unsigned char *chars, char flag, si=
ze_t size)
> > =A0{
> > =A0 =A0 =A0 int copied =3D 0;
> > =A0 =A0 =A0 do {
> > + =A0 =A0 =A0 =A0 =A0 =A0 int goal =3D min(size - copied, TTY_BUFFE=
R_PAGE);
>
> This variable isn't used in this function.
>
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 int space =3D tty_buffer_request_room(t=
ty, goal);

It is used on the next line; it would appear to be a local scope alias
for some other 'goal'...?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
