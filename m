From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Mon, 6 Dec 2010 10:14:27 +0000
Message-ID: <20101206101427.GC29563@n2100.arm.linux.org.uk>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com> <20101109224012.GA21992@kroah.com> <AANLkTikUmq7qeFb+0XPpmzcvp5q_Z4SMjBaAgNZaCRqV@mail.gmail.com> <20101203151547.GA30898@n2100.arm.linux.org.uk> <AANLkTimxU-YL_wy9ZTjKXX+68u_KcPzhSn9mOU_MnzQS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35667 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0LFKOy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Dec 2010 05:14:54 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimxU-YL_wy9ZTjKXX+68u_KcPzhSn9mOU_MnzQS@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Greg KH <greg@kroah.com>, Linus Walleij <linus.walleij@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Grzegorz Sygieda <grzegorz.sygieda@tieto.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Dec 06, 2010 at 10:53:20AM +0100, Vitaly Wool wrote:
> Hi Russell,
>=20
> On Fri, Dec 3, 2010 at 4:15 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> Why don't you stop
> >> the clocks if RTS is cleared? This would have allowed the line
> >> discipline driver to implicitly control the UART clock and there w=
ill
> >> be no risk of losing data, as well as no non-standard behavior
> >> involved. In fact, you'll be transparent to the upper layers in th=
is
> >> case.
> >
> > I've no idea what you're thinking, but you can't stop the UART cloc=
k
> > because RTS is deasserted - or DTR for that matter. =A0Neither of t=
hose
> > two define whether characters will be transmitted or received.
>=20
> What I'm mostly up to (and I guess Par also is) is how to conserve
> power for the Bluetooth UARTs. For a Bluetooth UART, there usually is
> a kind of signalling protocol, either inband or out-of-band, that
> allows the host and the chip to negotiate about power conservation
> during inactivity periods. These protocols do not belong to UART
> implementation and are usually implemented as line discipline drivers=
=2E
> While BT chip is sleeping, we don't need the UART clock running but w=
e
> need to have a decent way of telling the UART driver it can shut thos=
e
> off. Using RTS for that, even though not being applicable in all the
> cases, seems to work pretty well for Bluetooth UARTs. So if we just
> add a flag if an UART is used for BT or not and then use RTS for this
> kind of communication, will it be okay with you?

So you want to teach each UART driver a protocol-specific method of
handling power management rather than implementing a sane API to do
this?

Please, come up with a sane API for power management of UARTs rather
than trying to hack protocol specific stuff into UART drivers.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
