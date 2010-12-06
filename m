From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
Subject: RE: [PATCH] pl011: added clock management feature
Date: Mon, 6 Dec 2010 13:23:50 +0100
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA33483F160F@EXDCVYMBSTM005.EQ1STM.local>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
	<20101109224012.GA21992@kroah.com>
	<AANLkTikUmq7qeFb+0XPpmzcvp5q_Z4SMjBaAgNZaCRqV@mail.gmail.com>
	<20101203151547.GA30898@n2100.arm.linux.org.uk>
	<AANLkTimxU-YL_wy9ZTjKXX+68u_KcPzhSn9mOU_MnzQS@mail.gmail.com>
	<20101206101427.GC29563@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101206101427.GC29563@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Vitaly Wool <vitalywool@gmail.com>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@suse.de>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Russell,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: den 6 december 2010 11:14
> To: Vitaly Wool
> Cc: Greg KH; Linus WALLEIJ; Par-Gunnar HJALMDAHL; Greg Kroah-Hartman;
> Lukasz Rymanowski; Grzegorz Sygieda; linux-serial@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] pl011: added clock management feature
> =

> On Mon, Dec 06, 2010 at 10:53:20AM +0100, Vitaly Wool wrote:
> > Hi Russell,
> >
> > On Fri, Dec 3, 2010 at 4:15 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >> Why don't you stop
> > >> the clocks if RTS is cleared? This would have allowed the line
> > >> discipline driver to implicitly control the UART clock and there
> will
> > >> be no risk of losing data, as well as no non-standard behavior
> > >> involved. In fact, you'll be transparent to the upper layers in
> this
> > >> case.
> > >
> > > I've no idea what you're thinking, but you can't stop the UART
> clock
> > > because RTS is deasserted - or DTR for that matter. =A0Neither of
> those
> > > two define whether characters will be transmitted or received.
> >
> > What I'm mostly up to (and I guess Par also is) is how to conserve
> > power for the Bluetooth UARTs. For a Bluetooth UART, there usually is
> > a kind of signalling protocol, either inband or out-of-band, that
> > allows the host and the chip to negotiate about power conservation
> > during inactivity periods. These protocols do not belong to UART
> > implementation and are usually implemented as line discipline
> drivers.
> > While BT chip is sleeping, we don't need the UART clock running but
> we
> > need to have a decent way of telling the UART driver it can shut
> those
> > off. Using RTS for that, even though not being applicable in all the
> > cases, seems to work pretty well for Bluetooth UARTs. So if we just
> > add a flag if an UART is used for BT or not and then use RTS for this
> > kind of communication, will it be okay with you?
> =

> So you want to teach each UART driver a protocol-specific method of
> handling power management rather than implementing a sane API to do
> this?
> =

> Please, come up with a sane API for power management of UARTs rather
> than trying to hack protocol specific stuff into UART drivers.

So I guess the best solution would then be to add function(s) to struct tty=
_operations in tty_driver.h? Something like
void (*clk_enable)(struct tty_struct *tty);
void (*clk_disable)(struct tty_struct *tty);
and then it is up to each UART driver to implement them? Would such a solut=
ion be OK?

/P-G
