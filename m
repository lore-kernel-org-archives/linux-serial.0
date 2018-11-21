From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Wed, 21 Nov 2018 15:27:40 +0100
Message-ID: <20181121142740.GA29704@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
 <20181120152907.GA28796@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5090347075083841764=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181120152907.GA28796@ulmo>
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


--===============5090347075083841764==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 04:29:07PM +0100, Thierry Reding wrote:
> On Sat, Nov 17, 2018 at 11:27:17AM -0600, Jassi Brar wrote:
> > On Mon, Nov 12, 2018 at 9:18 AM Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > The mailbox framework supports blocking transfers via completions for
> > > clients that can sleep. In order to support blocking transfers in cas=
es
> > > where the transmission is not permitted to sleep, add a new ->flush()
> > > callback that controller drivers can implement to busy loop until the
> > > transmission has been completed. This will automatically be called wh=
en
> > > available and interrupts are disabled for clients that request blocki=
ng
> > > transfers.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > >  include/linux/mailbox_controller.h | 4 ++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > index 674b35f402f5..0eaf21259874 100644
> > > --- a/drivers/mailbox/mailbox.c
> > > +++ b/drivers/mailbox/mailbox.c
> > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, vo=
id *mssg)
> > >                 unsigned long wait;
> > >                 int ret;
> > >
> > > +               if (irqs_disabled() && chan->mbox->ops->flush) {
> > > +                       ret =3D chan->mbox->ops->flush(chan, chan->cl=
->tx_tout);
> > > +                       if (ret < 0)
> > > +                               tx_tick(chan, ret);
> > > +
> > > +                       return ret;
> > > +               }
> > > +
> > This is hacky. I think we can do without busy waiting in atomic
> > context. You could queue locally while in atomic context and then
> > transfer in blocking mode. I don't think we should worry about the
> > 'throughput' as there already is no h/w rate control even with
> > busy-waiting.
>=20
> I actually tried to do that before I added this flushing mechanism. The
> problem is, like you said, one of rate control. As mentioned in the
> cover letter, the shared mailboxes implemented in tegra-hsp are used as
> RX and TX channels for the TCU, which is like a virtual UART. The TTY
> driver included as part of this series will use one of the mailboxes to
> transmit data that is written to the console. The problem is that if
> these transmissions are not rate-limited on the TTY driver side, the
> console will just keep writing data and eventually overflow the buffer
> that we have in the mailbox subsystem.
>=20
> The problem is that data comes in at a much higher rate than what we can
> output. This is especially true at boot when the TCU console takes over
> and the whole log buffer is dumped on it.
>=20
> So the only way to rate-limit is to either make mbox_send_message()
> block, but that can only be done in non-atomic context. The console,
> however, will always run in atomic context, so the only way to do rate-
> limiting is by busy looping.

What I also tried before was to implement busy looping within the
->send_data() callback of the driver so that we didn't have to put this
into the core. Unfortunately, however, the ->send_data() callback is
called under chan->lock, which means that from mbox_send_message() we
don't have a way to mark the transfer as done. In order to do that we'd
have to call mbox_chan_txdone(), but that ends up calling tx_tick() and
that in turn also attempts to take the chan->lock, which would cause a
deadlock.

The explicit flushing is the best alternative that I could come up with.
I think it's not all that hacky, because it's very explicit about what's
going on and it has the nice side-effect that it will allow the mailbox
to work in interrupt driven mode if possible and only resorting to the
busy loop in atomic context.

At this point I think I have explored all other options and I frankly
can't find a more proper way to achieve what we need here. Perhaps you
can think of additional ways to accomplish this?

Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv1a1kACgkQ3SOs138+
s6GExg/9FnPibOvLkQ2iF2HFskxFcFmtsZqvSkH6MW/O6X1GxXJT3y3hQIAHHRH8
hrZv29c44ZowWaSkNAsElKDYs8i1hh6FT7gknLIAAYjdXHwNW/1S6W9Rjgd+uR9F
PjtKX/4LNkyldTSszw7Nn42dVhK4EnCi4rMYhT8UUgG80kegiUYVn7dnm56C0W3A
sRFOSEKhStXuMFCo0h5G4qamZa2hzTJUl/CMaVAOmWLhM2qjoOaUmUjWQSqooWlq
569DPijvBTk9wS4tIT8ZpOkjejgQ8n5SspWaGu1hdkZZemniBjuMtc1gdTEAkbcj
x86iiHS6/KwM3or9MqFsxsETRwjpz7wKP55tSMJ90v2x0JcaKXpnarbbhIfgwpaQ
GhaUldu2TfjvsQyf1JQQgzHgaS4+iw3sp6y2DfP9rkkpqr1sZhBaKtklO6oen3s7
rDWu4hg2Cw3hyXZi09200keIVOdmaVFNCO/AVz75vSUJ8yi7zYovdIr4LxX5pXi0
iqcTXAThEXqTe+2/KqTsxRS29WGTG+L/aoeZewzfZ4bkDB3uD55sRnvs6tySlVFv
M63pew9SOKDJRT0CvTDkek5sANTkv2b44Sl9AGtJcSPFokt8SH+Q7dpNbJHuUTzN
m7ehmW9YZnqXb9PLQcDwjDfxTctakVL7l1MKnhu9JnP/ApaOvRs=
=aN9X
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--


--===============5090347075083841764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5090347075083841764==--
