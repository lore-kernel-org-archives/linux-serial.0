From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Thu, 22 Nov 2018 09:47:12 +0100
Message-ID: <20181122084712.GA5741@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
 <20181120152907.GA28796@ulmo> <20181121142740.GA29704@ulmo>
 <CABb+yY0nH3Su6a11TZLJf=CCpD+gTpqUkLnRhpy4MUwNJk5prw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3860094840277817535=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABb+yY0nH3Su6a11TZLJf=CCpD+gTpqUkLnRhpy4MUwNJk5prw@mail.gmail.com>
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


--===============3860094840277817535==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2018 at 08:18:22PM -0600, Jassi Brar wrote:
> On Wed, Nov 21, 2018 at 8:27 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > On Tue, Nov 20, 2018 at 04:29:07PM +0100, Thierry Reding wrote:
> > > On Sat, Nov 17, 2018 at 11:27:17AM -0600, Jassi Brar wrote:
> > > > On Mon, Nov 12, 2018 at 9:18 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > >
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >
> > > > > The mailbox framework supports blocking transfers via completions for
> > > > > clients that can sleep. In order to support blocking transfers in cases
> > > > > where the transmission is not permitted to sleep, add a new ->flush()
> > > > > callback that controller drivers can implement to busy loop until the
> > > > > transmission has been completed. This will automatically be called when
> > > > > available and interrupts are disabled for clients that request blocking
> > > > > transfers.
> > > > >
> > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > > ---
> > > > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > > > >  include/linux/mailbox_controller.h | 4 ++++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > > > index 674b35f402f5..0eaf21259874 100644
> > > > > --- a/drivers/mailbox/mailbox.c
> > > > > +++ b/drivers/mailbox/mailbox.c
> > > > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> > > > >                 unsigned long wait;
> > > > >                 int ret;
> > > > >
> > > > > +               if (irqs_disabled() && chan->mbox->ops->flush) {
> > > > > +                       ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > > > > +                       if (ret < 0)
> > > > > +                               tx_tick(chan, ret);
> > > > > +
> > > > > +                       return ret;
> > > > > +               }
> > > > > +
> > > > This is hacky. I think we can do without busy waiting in atomic
> > > > context. You could queue locally while in atomic context and then
> > > > transfer in blocking mode. I don't think we should worry about the
> > > > 'throughput' as there already is no h/w rate control even with
> > > > busy-waiting.
> > >
> > > I actually tried to do that before I added this flushing mechanism. The
> > > problem is, like you said, one of rate control. As mentioned in the
> > > cover letter, the shared mailboxes implemented in tegra-hsp are used as
> > > RX and TX channels for the TCU, which is like a virtual UART. The TTY
> > > driver included as part of this series will use one of the mailboxes to
> > > transmit data that is written to the console. The problem is that if
> > > these transmissions are not rate-limited on the TTY driver side, the
> > > console will just keep writing data and eventually overflow the buffer
> > > that we have in the mailbox subsystem.
> > >
> > > The problem is that data comes in at a much higher rate than what we can
> > > output. This is especially true at boot when the TCU console takes over
> > > and the whole log buffer is dumped on it.
> > >
> > > So the only way to rate-limit is to either make mbox_send_message()
> > > block, but that can only be done in non-atomic context. The console,
> > > however, will always run in atomic context, so the only way to do rate-
> > > limiting is by busy looping.
> >
> > What I also tried before was to implement busy looping within the
> > ->send_data() callback of the driver so that we didn't have to put this
> > into the core. Unfortunately, however, the ->send_data() callback is
> > called under chan->lock, which means that from mbox_send_message() we
> > don't have a way to mark the transfer as done. In order to do that we'd
> > have to call mbox_chan_txdone(), but that ends up calling tx_tick() and
> > that in turn also attempts to take the chan->lock, which would cause a
> > deadlock.
> >
> > The explicit flushing is the best alternative that I could come up with.
> > I think it's not all that hacky, because it's very explicit about what's
> > going on and it has the nice side-effect that it will allow the mailbox
> > to work in interrupt driven mode if possible and only resorting to the
> > busy loop in atomic context.
> >
> > At this point I think I have explored all other options and I frankly
> > can't find a more proper way to achieve what we need here. Perhaps you
> > can think of additional ways to accomplish this?
> >
> Well, I would have a local ring buffer (array) of enough size to hold
> the characters and then have a task consuming data from that ring
> buffer by transmitting over mailbox.

There's already such a ringbuffer in the printk code. To implement what
you suggest would effectively be creating a copy of that buffer because
we'd be allocating the buffer and the console code would just dump each
and every character in the logbuf into that ring buffer without rate-
limitation.

To make matters worse, the ringbuffer would be empty most of the time
after the initial dump of the logbuf, so we'd be wasting all that buffer
space.

It just seems to me like we should be keeping the TCU driver as close as
possible to other UART drivers which also busy loop in order to rate-
limit what the console can write. Given the current mailbox framework it
is not possible to do that (in interrupt context), so an extension seems
like the most sensible option.

Perhaps you'd be less concerned about such a change if it was perhaps
more explicit? Just throwing ideas around, I think something that could
also work is if we explicitly add a mbox_flush() function that would
basically be calling ->flush(). That way users of the mailbox can make
their requirement very explicit. I haven't actually tested that, but I
think it would work. Does that sound more acceptable to you?

Thierry

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv2bQ0ACgkQ3SOs138+
s6EOHA//dYCq8J1T46Xy4btKn1RkTRcfMdeYRrVbOZ9M41IeBLEReON2DcWxCxlB
9SkxoH0SIfnS5r7TdmyZd0KuRDm9bIRRUh7lrjoeIBrd3xrWi0ox4D52nbkY22Nx
bMzz0LPQABx7/ze7oJr/t3zFc1An/JskULYW//v8aVbESn1P4GLmK/AkgN6OtpLg
fknivMC5W84F8tAFay8EDZ8ekEV5cEZerGmKj0zQtrBaUhUFl62CCbFZe7/Q8F69
Q4pGaM+scTdE0W7BPaldeczrK5VD36IPeOI295QMk69TyMe6AMYljInvknjfIJ5u
RV1YUaNaaOrSY1XZRgfsR2qKrI3wJyD9PTsDLqq6Xx8QZqWf+ep4KDWlvMymvJ9N
bRY4OAKbZqCzwSSyW36IidvEYv7/b8WH/lt1Nudor7mV1BYzWpGXP5AXNQB6UM1P
zebtTyBjE4utGT6zAfGfXOZ5Akp7QAaDTxWhLfhLGpVwaUP4jbEsb9rbTaJsJ649
jOukB7BCrBWm+v8IJ7bPMU+Pfj/bZBxrI19qxpGsqGfTwwLCUlOBgPxMXyqOImVU
G6gnAH98jrt5Dqy8e+B2kAFK4gjCaFpm1fzMTUEOrS6QJHulPJfwEtQlHeBlUekx
oEl3YK3a++w8s8Q+BTv86Sb9xGWH4I9CCFSZGCq5Pq2HW5bpziE=
=ZsGS
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--


--===============3860094840277817535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3860094840277817535==--
