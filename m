From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Wed, 28 Nov 2018 11:08:19 +0100
Message-ID: <20181128100819.GA20723@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9205694295242488681=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jassi Brar <jassisinghbrar@gmail.com>, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============9205694295242488681==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 09:43:29AM +0000, Jon Hunter wrote:
>=20
> On 12/11/2018 15:18, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The mailbox framework supports blocking transfers via completions for
> > clients that can sleep. In order to support blocking transfers in cases
> > where the transmission is not permitted to sleep, add a new ->flush()
> > callback that controller drivers can implement to busy loop until the
> > transmission has been completed. This will automatically be called when
> > available and interrupts are disabled for clients that request blocking
> > transfers.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/mailbox/mailbox.c          | 8 ++++++++
> >  include/linux/mailbox_controller.h | 4 ++++
> >  2 files changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index 674b35f402f5..0eaf21259874 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void=
 *mssg)
> >  		unsigned long wait;
> >  		int ret;
> > =20
> > +		if (irqs_disabled() && chan->mbox->ops->flush) {
> > +			ret =3D chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > +			if (ret < 0)
> > +				tx_tick(chan, ret);
> > +
> > +			return ret;
> > +		}
>=20
> It seems to me that if mbox_send_message() is called from an atomic
> context AND tx_block is true, then if 'flush' is not populated this
> should be an error condition as we do not wish to call
> wait_for_completion from an atomic context.
>=20
> I understand that there is some debate about adding such flush support,
> but irrespective of the above change, it seems to me that if the
> mbox_send_message() can be called from an atomic context (which it
> appears to), then it should be detecting if someone is trying to do so
> with 'tx_block' set as this should be an error.
>=20
> Furthermore, if the underlying mailbox driver can support sending a
> message from an atomic context and busy wait until it is done, surely
> the mailbox framework should provide a means to support this?
>=20
> Now it could be possible for the underlying mailbox driver to detect we
> are in an atomic context and if the 'tx_block' is set do the right thing
> by busy waiting until the message is sent. However, the problem with
> that is, that for the mbox_send_message() to ensure the right thing is
> done, it needs to check that 'tx_done' is set in the case of a blocking
> transfer in an atomic context. At that point you may as well add the
> flush operator as I think it is more implicit/clear.

Heh, interesting timing, I just sent out v3 of this series with a
slightly different solution. Basically what v3 implements is explicit
flushing of the mailbox via a new function called mbox_flush().

I originally liked the idea of "hiding" the flush operation in the
mbox_send_message() function, but the more I look at the new explicit
flush solution, the more I prefer it. One reason why I prefer it is
because it no longer has the slightly odd "irqs_disabled()" check that
always made me a bit uneasy. The other advantage of the explicit flush
is that it becomes completely opt-in for both mailbox providers and
consumers. Furthermore the consumer should always know if it can be
called in atomic context or not, so none of these code paths should
have to be "clever" and check at runtime whether or not interrupts are
enabled. If the consumer knows that it will be called in atomic context
it can just unconditionally flush the mailbox.

Also, it nicely addresses the concern about erroring out if the provider
doesn't support flushing. The new mbox_flush() API returns -ENOTSUPP if
called on a mailbox channel provided by a driver that doesn't implement
->flush().

Thierry

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+aREACgkQ3SOs138+
s6FKGA/+JnGDszEAHnvCgJHje4SnuIB+cjPqszAruiIvjzVfLGCtwsOw9zR8gM/G
tYdRwLDYLdympxaXjiGuru1pDIgaAp+s1RqUNTdr3gq4JaKKqPidjEqxgqLa4LPi
oH2RZyaSNEGCYmvAiebupZp/PyQn/iJuckkMAcBVpakkknJPBHNoA/GZWxRjS1vl
+nzX5SsUBr6wuzWohGeg9xtQjdOX1YiL5+0kh++3prmsadm+Uk+HcJF4I+Xkx5PR
TNNuF7rVuQ11DvQ5iWpDHbxA0fgCA+4tEfY0/7lLV/eTqKDhMXjhhTix3IHjiFaL
8jEBzLrcUtNif2/dIxZEQzzR1/LOqcA/7lqUAQzTpfFAs6caK5mK4ZGF0UQGYxYi
htyR/oXBr0qVN6mc/BU7CUL28D0jIfjiyMIgvLeNw+cBFxMH8OzP9LeQ6p9D2qqT
ICM43RJCN/z11ZPESq2kpyiBBo/9cpD+ivTMIJju31vCgbgwiU4Icb0HP+/jMrsB
XDjQ0qGz0YjURhCf/vHDjhyuPzCiQC5bnq1wqpTQA2m2KytQydniOI8fq5/io8ZW
p9p2jLaMhz5a3JAi/5HGlPCkdkga4hwyuOr3+PuLiUhye8gGtV0nOce81Y6Y7Y0X
it0n9MY1TuRe80vhuWcmr22H6pkpV+Z9Cd6vosc6ErqFx5Vq3yQ=
=WfgI
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--


--===============9205694295242488681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9205694295242488681==--
