From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Tue, 20 Nov 2018 16:29:07 +0100
Message-ID: <20181120152907.GA28796@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3901182344694834560=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
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


--===============3901182344694834560==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 17, 2018 at 11:27:17AM -0600, Jassi Brar wrote:
> On Mon, Nov 12, 2018 at 9:18 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The mailbox framework supports blocking transfers via completions for
> > clients that can sleep. In order to support blocking transfers in cases
> > where the transmission is not permitted to sleep, add a new ->flush()
> > callback that controller drivers can implement to busy loop until the
> > transmission has been completed. This will automatically be called when
> > available and interrupts are disabled for clients that request blocking
> > transfers.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/mailbox/mailbox.c          | 8 ++++++++
> >  include/linux/mailbox_controller.h | 4 ++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index 674b35f402f5..0eaf21259874 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> >                 unsigned long wait;
> >                 int ret;
> >
> > +               if (irqs_disabled() && chan->mbox->ops->flush) {
> > +                       ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > +                       if (ret < 0)
> > +                               tx_tick(chan, ret);
> > +
> > +                       return ret;
> > +               }
> > +
> This is hacky. I think we can do without busy waiting in atomic
> context. You could queue locally while in atomic context and then
> transfer in blocking mode. I don't think we should worry about the
> 'throughput' as there already is no h/w rate control even with
> busy-waiting.

I actually tried to do that before I added this flushing mechanism. The
problem is, like you said, one of rate control. As mentioned in the
cover letter, the shared mailboxes implemented in tegra-hsp are used as
RX and TX channels for the TCU, which is like a virtual UART. The TTY
driver included as part of this series will use one of the mailboxes to
transmit data that is written to the console. The problem is that if
these transmissions are not rate-limited on the TTY driver side, the
console will just keep writing data and eventually overflow the buffer
that we have in the mailbox subsystem.

The problem is that data comes in at a much higher rate than what we can
output. This is especially true at boot when the TCU console takes over
and the whole log buffer is dumped on it.

So the only way to rate-limit is to either make mbox_send_message()
block, but that can only be done in non-atomic context. The console,
however, will always run in atomic context, so the only way to do rate-
limiting is by busy looping.

Thierry

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv0KEAACgkQ3SOs138+
s6E93w//XhzNtaPg4I6695pMUdnzMFUHZ6s0L2MkqsOBMZK1aEyNVe9Bx2HI8TUn
F7RjY9XKClvPc/+Jwd9nvXBdP2AuTLSKzWRs+Y5mIX27l7qbzCTBKeX/jn9Uq2YO
Cp0wf+IJ5IswPjuwh93VCiTPVTfaNiWCadCMThwjlVFd0oq2ktAhBR2X0ND9e3Bm
BPP78LhfR5g8E4SUaRM9z0vugPUuldeiOPJpw0QMHZBsnsTc7enbdhTRbSM4vD6W
mpsqHx93UjtMA3O4oMM3DWyg1Dz4jcZGXT62BjHJE+4Sqi95Ouf3529loX2L+k5/
kmXO7pf0iAkfIg6xtm0dEYOxSzX3Q7C0xqlRwjVR6l27hSn6GluQ/SIwXg5XW5tc
Lw7PKNWupHbitJadyux67EGPvrS7UyYdYgOXP/0xjVXDf1Y6+wVYKXok0469OnFD
DoSp9holxv3ETx7SXL0nb0/bItnljAFRB4+64EyiM6k/yusK++bwdSA3vPaZUHDV
yIewQRDQfnz6+9gOylbqF9dpRpdN+o635RpKpjcCdbBbt44oe1EqiMyTWhEEBG0w
zMJzSaqORdqNBW/2yK43h1nrqotiJZqnJI6puLQfYDMfBGY5SxjgqKCFR8XOMJzy
mSpuSODHPeIpBIALixRHnd4CVrUgRHsoVMRSxegHKpp58CZVEIA=
=fUQD
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--


--===============3901182344694834560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3901182344694834560==--
