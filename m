From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Thu, 22 Nov 2018 18:34:32 +0100
Message-ID: <20181122173432.GA7659@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
 <20181120152907.GA28796@ulmo> <20181121142740.GA29704@ulmo>
 <CABb+yY0nH3Su6a11TZLJf=CCpD+gTpqUkLnRhpy4MUwNJk5prw@mail.gmail.com>
 <20181122084712.GA5741@ulmo>
 <CABb+yY1Ez=tSyPq=bX7oE3s3Eu97kdOS6+PkfDg1HKtkYyWTpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8178177796874904661=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABb+yY1Ez=tSyPq=bX7oE3s3Eu97kdOS6+PkfDg1HKtkYyWTpA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============8178177796874904661==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 10:07:09AM -0600, Jassi Brar wrote:
> Hi Thierry,
>=20
> On Thu, Nov 22, 2018 at 2:47 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Wed, Nov 21, 2018 at 08:18:22PM -0600, Jassi Brar wrote:
> > > On Wed, Nov 21, 2018 at 8:27 AM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > On Tue, Nov 20, 2018 at 04:29:07PM +0100, Thierry Reding wrote:
> > > > > On Sat, Nov 17, 2018 at 11:27:17AM -0600, Jassi Brar wrote:
> > > > > > On Mon, Nov 12, 2018 at 9:18 AM Thierry Reding <thierry.reding@=
gmail.com> wrote:
> > > > > > >
> > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > >
> > > > > > > The mailbox framework supports blocking transfers via complet=
ions for
> > > > > > > clients that can sleep. In order to support blocking transfer=
s in cases
> > > > > > > where the transmission is not permitted to sleep, add a new -=
>flush()
> > > > > > > callback that controller drivers can implement to busy loop u=
ntil the
> > > > > > > transmission has been completed. This will automatically be c=
alled when
> > > > > > > available and interrupts are disabled for clients that reques=
t blocking
> > > > > > > transfers.
> > > > > > >
> > > > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > > > > > >  include/linux/mailbox_controller.h | 4 ++++
> > > > > > >  2 files changed, 12 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mail=
box.c
> > > > > > > index 674b35f402f5..0eaf21259874 100644
> > > > > > > --- a/drivers/mailbox/mailbox.c
> > > > > > > +++ b/drivers/mailbox/mailbox.c
> > > > > > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *=
chan, void *mssg)
> > > > > > >                 unsigned long wait;
> > > > > > >                 int ret;
> > > > > > >
> > > > > > > +               if (irqs_disabled() && chan->mbox->ops->flush=
) {
> > > > > > > +                       ret =3D chan->mbox->ops->flush(chan, =
chan->cl->tx_tout);
> > > > > > > +                       if (ret < 0)
> > > > > > > +                               tx_tick(chan, ret);
> > > > > > > +
> > > > > > > +                       return ret;
> > > > > > > +               }
> > > > > > > +
> > > > > > This is hacky. I think we can do without busy waiting in atomic
> > > > > > context. You could queue locally while in atomic context and th=
en
> > > > > > transfer in blocking mode. I don't think we should worry about =
the
> > > > > > 'throughput' as there already is no h/w rate control even with
> > > > > > busy-waiting.
> > > > >
> > > > > I actually tried to do that before I added this flushing mechanis=
m. The
> > > > > problem is, like you said, one of rate control. As mentioned in t=
he
> > > > > cover letter, the shared mailboxes implemented in tegra-hsp are u=
sed as
> > > > > RX and TX channels for the TCU, which is like a virtual UART. The=
 TTY
> > > > > driver included as part of this series will use one of the mailbo=
xes to
> > > > > transmit data that is written to the console. The problem is that=
 if
> > > > > these transmissions are not rate-limited on the TTY driver side, =
the
> > > > > console will just keep writing data and eventually overflow the b=
uffer
> > > > > that we have in the mailbox subsystem.
> > > > >
> > > > > The problem is that data comes in at a much higher rate than what=
 we can
> > > > > output. This is especially true at boot when the TCU console take=
s over
> > > > > and the whole log buffer is dumped on it.
> > > > >
> > > > > So the only way to rate-limit is to either make mbox_send_message=
()
> > > > > block, but that can only be done in non-atomic context. The conso=
le,
> > > > > however, will always run in atomic context, so the only way to do=
 rate-
> > > > > limiting is by busy looping.
> > > >
> > > > What I also tried before was to implement busy looping within the
> > > > ->send_data() callback of the driver so that we didn't have to put =
this
> > > > into the core. Unfortunately, however, the ->send_data() callback is
> > > > called under chan->lock, which means that from mbox_send_message() =
we
> > > > don't have a way to mark the transfer as done. In order to do that =
we'd
> > > > have to call mbox_chan_txdone(), but that ends up calling tx_tick()=
 and
> > > > that in turn also attempts to take the chan->lock, which would caus=
e a
> > > > deadlock.
> > > >
> > > > The explicit flushing is the best alternative that I could come up =
with.
> > > > I think it's not all that hacky, because it's very explicit about w=
hat's
> > > > going on and it has the nice side-effect that it will allow the mai=
lbox
> > > > to work in interrupt driven mode if possible and only resorting to =
the
> > > > busy loop in atomic context.
> > > >
> > > > At this point I think I have explored all other options and I frank=
ly
> > > > can't find a more proper way to achieve what we need here. Perhaps =
you
> > > > can think of additional ways to accomplish this?
> > > >
> > > Well, I would have a local ring buffer (array) of enough size to hold
> > > the characters and then have a task consuming data from that ring
> > > buffer by transmitting over mailbox.
> >
> > There's already such a ringbuffer in the printk code. To implement what
> > you suggest would effectively be creating a copy of that buffer because
> > we'd be allocating the buffer and the console code would just dump each
> > and every character in the logbuf into that ring buffer without rate-
> > limitation.
> >
> Well, the console assumes there exists an atomic path to put character
> on the bus, But because there isn't in case of tcu, we have to emulate
> that. Frankly I prefer the one-off driver jump some hoops, rather than
> implement exceptions in the api.

I wouldn't have any objections to that if the hoops were reasonable
ones. What you're asking me to do is basically implement a second copy
of the logbuf. I don't call that a reasonable hoop to jump through. It
is also not guaranteed to work properly because we can always end up
with a situation where we produce more data than we can consume. Also,
by providing this additional buffer we make things worse because the
standard mechanisms of the logbuf are side-stepped. Typically the logbuf
code will warn if it overflows. In our case we provide a buffer that the
console can dump into, so instead of the logbuf overflowing and warning
about it, we'd now overflow the mailbox buffer and we'd have to add
extra code to warn about overflows.

The console really only works because it assumes that the output driver
will stall and thereby rate-limit.

> BTW, there is already no rate-limitation because its all virtual -
> data is consumed as fast as possible.

No, that's not true. On the receiving end of the TX mailbox is a micro-
processor that reads out the mailbox data. Once it has read the data it
needs to clear the FULL bit so that the TCU driver can write more data.
Even if the microprocessor on the receiving end did buffering (there is
no indication that it does) it would eventually run out of buffer space
and have to stall until it's clocked all the characters out of the
physical UART. At that point no amount of buffering is going to save us
and the only option is to stall, which, again, can currently only be
done from the mailbox, because it is the only one that knows when it is
busy. But it's also the one place where we can't because the framework
doesn't allow it.

> > To make matters worse, the ringbuffer would be empty most of the time
> > after the initial dump of the logbuf, so we'd be wasting all that buffer
> > space.
> >
> The idea is console and uart-ops both feed into this buffer and the
> only consumer thread runs the mailbox.
>=20
> > It just seems to me like we should be keeping the TCU driver as close as
> > possible to other UART drivers which also busy loop in order to rate-
> > limit what the console can write. Given the current mailbox framework it
> > is not possible to do that (in interrupt context), so an extension seems
> > like the most sensible option.
> >
> > Perhaps you'd be less concerned about such a change if it was perhaps
> > more explicit? Just throwing ideas around, I think something that could
> > also work is if we explicitly add a mbox_flush() function that would
> > basically be calling ->flush(). That way users of the mailbox can make
> > their requirement very explicit. I haven't actually tested that, but I
> > think it would work. Does that sound more acceptable to you?
> >
> I am happy to see features and bugfixes added to the api. What I am
> not eager about is supporting less than 100% legit and very platform
> specific usecases, especially when there is a work around.

Look, I'd be willing to push this all into the driver, but the framework
doesn't allow me to do that. If it was possible to run the state machine
outside of mbox_send_message() then I'd be able to just move the busy
loop or flush into the driver. But the locking is such that I can't do
that because it will cause a deadlock.

The ringbuffer workaround would be very brittle and if at all only work
by accident, not to mention that it would require duplicating much of
the logbuf logic.

Also I don't consider usage in atomic context a very platform specific
use-case, and I don't understand why I should be required to resort to
some unreliable workaround rather than find a proper fix that guarantees
proper operation.

Thierry

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv26KUACgkQ3SOs138+
s6EYXhAAsxBQG5vhVmJVTpgKOXwY5FCRYaYDLxYadi87xbGkQQjroAfPSmnYxU3E
YCXftObnL5BaLNd6UsIyUDIX7ZOCAlv1a58Yyjq/F0ABnz4aQPa4Lac4qXlru8d4
Hrdth957Yv4jGJnaPiHVKQvZCGJ8hgplOn1k2+P1Eiaq/EymNlu8vXa5G05aK5f5
PbM5ok5ViHDNcrsenhxMzMuvF5PTC7vzQVTRY7CTyuF5cWtkOZR2UuQ1qzWbC1Z4
O5TVoWLIQ0UjeJ68JkAWdkGS6RcGcP3O+7PTzW0HRKzJ7P8jIr31VovUjy6L1ohF
/jN4gyWEJOIV6WGVVy2MUp/7x44eJFHXROUf37PBbsHa1QqTMtwf+EMG6qehU6V7
xg+hjwK1c3aY4lHI6OuYt/ZLnSbtcjAGDWLTYLDfRttH1GltwMoL8f8DnJeNxvfR
GrSmbKxXubIDJldSlBtKlN1ZwWq8X6nk4uXKSQY8MF77m77sXnQJQDtLvhqX4NKz
ar9FyXIkIYSHCFdUfQpPWRr+OXQNNoDpcJKj4qm8fDDwTvIVPYHsEy0Bu07d+jK9
a9diL5rSTWsnYFlfHMvVpWO+YzcddFROXIminrxaPaotMtWTy14G5LEEHoVQx1nA
ZTC8sMJtImhoMTA5EkzMfRk0osQ9yQDMDG5dzmszEQWkHvQNaHI=
=l8ou
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--


--===============8178177796874904661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8178177796874904661==--
