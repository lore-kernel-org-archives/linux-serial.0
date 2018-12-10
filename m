From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Mon, 10 Dec 2018 10:52:29 +0100
Message-ID: <20181210095229.GA15154@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
 <CABb+yY2jVmzxFR7iqSyMMyE+XZtyHrAPAxM_KMEa7c2zzpSwCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2923097026040702380=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABb+yY2jVmzxFR7iqSyMMyE+XZtyHrAPAxM_KMEa7c2zzpSwCA@mail.gmail.com>
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


--===============2923097026040702380==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 08, 2018 at 11:39:05AM +0530, Jassi Brar wrote:
> On Fri, Dec 7, 2018 at 5:02 PM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > On Thu, Dec 06, 2018 at 11:56:25PM -0600, Jassi Brar wrote:
> > > On Thu, Nov 29, 2018 at 9:23 AM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > On Wed, Nov 28, 2018 at 11:23:36PM -0600, Jassi Brar wrote:
> > > > > On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com>=
 wrote:
> > > > > >
> > > > > >
> > > > > > On 12/11/2018 15:18, Thierry Reding wrote:
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
> > > > > > >               unsigned long wait;
> > > > > > >               int ret;
> > > > > > >
> > > > > > > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > > > > > > +                     ret =3D chan->mbox->ops->flush(chan, ch=
an->cl->tx_tout);
> > > > > > > +                     if (ret < 0)
> > > > > > > +                             tx_tick(chan, ret);
> > > > > > > +
> > > > > > > +                     return ret;
> > > > > > > +             }
> > > > > >
> > > > > > It seems to me that if mbox_send_message() is called from an at=
omic
> > > > > > context AND tx_block is true, then if 'flush' is not populated =
this
> > > > > > should be an error condition as we do not wish to call
> > > > > > wait_for_completion from an atomic context.
> > > > > >
> > > > > > I understand that there is some debate about adding such flush =
support,
> > > > > > but irrespective of the above change, it seems to me that if the
> > > > > > mbox_send_message() can be called from an atomic context (which=
 it
> > > > > > appears to), then it should be detecting if someone is trying t=
o do so
> > > > > > with 'tx_block' set as this should be an error.
> > > > > >
> > > > > Layers within kernel space have to trust each other. A badly writ=
ten
> > > > > client can break the consumer in so many ways, we can not catch e=
very
> > > > > possibility.
> > > > >
> > > > > > Furthermore, if the underlying mailbox driver can support sendi=
ng a
> > > > > > message from an atomic context and busy wait until it is done, =
surely
> > > > > > the mailbox framework should provide a means to support this?
> > > > > >
> > > > > Being able to put the message on bus in atomic context is a featu=
re -
> > > > > which we do support. But busy-waiting in a loop is not a feature,=
 and
> > > > > we don't want to encourage that.
> > > >
> > > > I agree that in generally busy-waiting is a bad idea and shouldn't =
be
> > > > encouraged. However, I also think that an exception proves the rule=
=2E If
> > > > you look at the console drivers in drivers/tty/serial, all of them =
will
> > > > busy loop prior to or after sending a character. This is pretty much
> > > > part of the API and as such busy-looping is very much a feature.
> > > >
> > > > The reason why this is done is because on one hand we have an atomic
> > > > context and on the other hand we want to make sure that all charact=
ers
> > > > actually make it to the console when we print them.
> > > >
> > > > As an example how this can break, I've taken your suggestion to
> > > > implement a producer/consumer mode in the TCU driver where the cons=
ole
> > > > write function will just stash characters into a circular buffer an=
d a
> > > > work queue will then use mbox_send_message() to drain the circular
> > > > buffer. While this does work on the surface, I was able to concern =
both
> > > > of the issues that I was concerned about: 1) it is easy to overflow=
 the
> > > > circular buffer by just dumping enough data at once to the console =
and
> > > > 2) when a crash happens, everything in the kernel stops, including =
the
> > > > consumer workqueue that is supposed to drain the circular buffer and
> > > > flush messages to the TCU. The result is that, in my particular cas=
e,
> > > > the boot log will just stop at a random place in the middle of mess=
ages
> > > > from much earlier in the boot because the TCU hasn't caught up yet =
and
> > > > there's a lot of characters still in the circular buffer.
> > > >
> > > > Now, 1) can be mitigated by increasing the circular buffer size. A =
value
> > > > that seems to give reliably good results in 2 << CONFIG_LOG_BUF_SHI=
FT.
> > > >
> > > Yes please.
> >
> > As I explained elsewhere, I actually went and implemented this. But
> > given the nature of buffering, this ends up making the TCU completely
> > useless as a console because in case of a crash, the system will stop
> > working with a large number of characters still stuck in the buffer.
> > And that's especially bad in case of a crash because those last
> > characters that get stuck in the buffer are the most relevant ones
> > because they contain the stack dump.
> >
> I don't question the utility of TCU. I just wonder if mailbox api
> should provide a backdoor for atomic busy-wait in order to support a
> sub-optimal hw+fw design.
>=20
> > > > I thought that I could also mitigate 2) by busy looping in the TCU =
driver,
> > > > but it turns out that that doesn't work. The reason is that since w=
e are
> > > > in atomic context with all interrupts disabled, the mailbox won't e=
ver
> > > > consume any new characters, so the read pointer in the circular buf=
fer
> > > > won't increment, leaving me with no condition upon which to loop th=
at
> > > > would work.
> > > >
> > > So you want to be able to rely on an emulated console (running on a
> > > totally different subsystem) to dump development-phase early-boot
> > > logs? At the cost of legitimizing busy looping in atomic context - one
> > > random driver messing up the api for ever. Maybe you could have the
> > > ring buffer in some shmem and only pass the number of valid characters
> > > in it, to the remote?
> >
> > First of all, this is not about development-phase early-boot messages.
> > We're talking about the system console here. This is what everyone will
> > want to be using when developing on this device. Sure at some point you
> > may end up with a system that works and you can have the console on the
> > network or an attached display or whatever, but even then you may still
> > want to attach to the console if you ever run into issues where the
> > system doesn't come up.
> >
> > Secondly, I don't understand why you think this is an emulated console.
> >
> It is emulated/virtual because Linux doesn't put characters on a
> physical bus. The data is simply handed forward to a remote entity.

Okay, I understand. However, from a kernel point of view there's no
difference between the TCU and any physical UART. Once the data is
handed to the TCU TX mailbox, it's out of control of the TCU driver.
Whether there's a real UART behind that or some remote processor that
reads the data isn't really relevant.

> > Lastly, I don't understand why you think we're messing up the API here.
> > The proposal in this series doesn't even change any of the API, but it
> > makes it aware of the state of interrupts internally so that it can do
> > the right thing depending on the call stack. The other proposal, in v3,
> > is more explicit in that it adds new API to flush the mailbox. The new
> > API is completely optional and I even offered to document it as being
> > discouraged because it involves busy looping. At the same time it does
> > solve a real problem and it doesn't impact any existing mailbox drivers
> > nor any of their users (because it is completely opt-in).
> >
> The 'flush' api is going to have no use other than implement
> busy-waits. I am afraid people are simply going to take it easy and
> copy the busy-waits from the test/verification codes.
> "discouraging" seldom works because the developer comes with the
> failproof excuse "the h/w doesn't provide any other way". Frankly I
> would like to push back on such designs.

I certainly approve of that stance.

However, I'd like to reiterate that the TCU design does in fact support
"another way". If you look at the mailbox driver implementation (in the
drivers/mailbox/tegra-hsp.c driver), you'll see that it does support an
interrupt driven mode. After you had reviewed Mikko's earliest proposal
that was indeed implementing busy looping exclusively we both set out
to properly implement interrupt support. This took quite a while to do
because of some gaps in the documentation, but we eventually got it to
work properly. And then it was discovered that it was all a waste of
effort because the console driver couldn't make use of it anyway. Well,
I should say "waste of effort" because I'm still happy that the proper
implementation exists and we can use it under the right circumstances.

So, at least in this particular case, it is not the hardware or firmware
design that's flawed or was taking any shortcuts. It's really just the
particular use-case of the console that doesn't allow us to make use of
the right implementation, which is why we have to resort to the inferior
method of busy-looping.

>  Anyways, let us add the new 'flush' api.

Great, thanks!

Thierry

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwON1kACgkQ3SOs138+
s6GOtxAAnS2OHTZMcpgfVOZJpbp0CQWtB4D/7DwbIQUg5WmCqAnzubVM8HdjtPM6
cN1tQTIwF9oZJAKAfaX91mkOzSkZrhkDW0x6ImtzYbsrLk8nV31hScUCus3W1Vf4
iwrlfzztdyz0FPgchbJZ/UpX0TOuVQ0ME4HDnLVW9+uYfc/2jPL+LfN370F644IJ
xNDaUktGPE08JeKQDta1z0LPTAftlvYzJvaN3XkYZfQLiAWtFpp71Zc0FMQzVDp0
BBq3/VP7TqLWJxZwt44tXDP1qfu/lFDlrAfPiszMGAtKrFJMLwUBgK1VWWVDkW+3
EOQ7t3p0bxhwoxgNlzZksIYNMJn7efDwpEBXYcUenIujX0JHTlePJ/P/aqb8LHcJ
3MTNNoOJawLszZIUak8u9lpHy0KAwcVPHNQ+843WKpVp7EGp0PceqyHHEfZnurDX
B2K1j7EAYCu7L8jRMiGejQUkVS/kNaVlMavlCKZGgGXiapRaTXtjfyjFv+m+IUQD
azr6fNGCP060mN6SDWbWj/LZWg/hmqToIS9STcsfo+7WB+jo3qZ7hJNrD2+TDYlB
BKsjIP1f0L/5AO3RmTIgIZzWGPFg2lRqcI7lQHohLAVBT++v83rgpl8fdEYI01QY
oJh79IvIJpzNiab0BUbzbfXQv7+ENg/MEwvCCFHnu1DsaNdAgPo=
=lut4
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


--===============2923097026040702380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2923097026040702380==--
