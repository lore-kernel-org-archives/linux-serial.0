From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Date: Mon, 22 Jul 2019 11:17:57 +0100
Message-ID: <20190722101757.GC1330@shell.armlinux.org.uk>
References: <1563526074-20399-2-git-send-email-sorganov@gmail.com>
 <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
 <87h87idxq2.fsf@osv.gnss.ru>
 <20190719143151.gx43ndn2oy35h247@pengutronix.de>
 <87woge9hvz.fsf@osv.gnss.ru>
 <20190719201949.ldqlcwjhcmt7wwhg@pengutronix.de>
 <87ftmy8qgu.fsf@osv.gnss.ru>
 <20190722075107.cc3tvf6gmxhaeh5m@pengutronix.de>
 <20190722095721.GB1330@shell.armlinux.org.uk>
 <20190722100414.k5wp4osx3gtuhmnc@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190722100414.k5wp4osx3gtuhmnc@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 12:04:14PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Russell,
> =

> On Mon, Jul 22, 2019 at 10:57:21AM +0100, Russell King - ARM Linux admin =
wrote:
> > However, RTS is not guaranteed to stop the remote end sending characters
> > as soon as it is deasserted - 16550 relies on software noticing that
> > CTS has changed, and even then it may have a FIFO full of characters
> > already queued to be sent that will still be sent.
> > =

> > So, disabling RTS just before changing the baud doesn't give any
> > guarantees that a character won't be in the process of being received
> > while we're changing the baud rate, which means disabling it doesn't
> > actually gain us anything.
> =

> <sarcasm>With that reasoning we can drop RTS driving completely. Let's
> just assert it unconditionally.</sarcam>

Please, I'm being serious.

> Right, deasserting RTS doesn't help against long receive FIFOs or
> senders that react slowly (or not at all), but still it's better than
> nothing, isn't it?

Not really.

In the normal use case of RTS, RTS doesn't get deasserted when there is
no buffer space available, but when the available buffer space reaches
a low-threshold.  Buffer space remains to allow the sender to react to
the change of RTS state.

In the case you are promoting, which is to deassert RTS and then
immediately start changing the port settings, you are not giving any
chance for the sender to react to that state change.  You could even
be mid-way through receiving a character from the remote end - and
at 75 baud, a single character lasts around 133ms.

Even if you wait 133ms, that doesn't mean that the remote end has
finished sending.  If the remote end has a 16 byte FIFO, you'd need
to wait about 2.2 seconds.  At faster baud rates, of course the
delay gets shorter.

Just deasserting RTS just before changing the port settings gains
very little protection.  You need a character-period based delay as
well.

If we do start adding delays, it means that changing the baud rate
for a port set to 75 baud starts taking ages to complete if CRTSCTS
is enabled, irrespective of the settings change mode that was
requested by userspace.

However, adding delays is likely to screw up various userspace
applications, such as those that do need to change baud rate at
specific points in their protocol.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up
