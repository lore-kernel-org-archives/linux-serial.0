From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: DCD interrupt for i.MX25 UART
Date: Mon, 4 Apr 2016 22:49:11 +0200
Message-ID: <20160404204911.GA5384@pengutronix.de>
References: <20160323153638.GO6191@pengutronix.de>
 <20160329131443.09e46ad6@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160329131443.09e46ad6@ipc1.ka-ro>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hallo Lothar,

On Tue, Mar 29, 2016 at 01:14:43PM +0200, Lothar Wa=DFmann wrote:
> On Wed, 23 Mar 2016 16:36:38 +0100 Uwe Kleine-K=F6nig wrote:
> > Hello,
> > =

> > I have a problem with an UART on an i.MX25 based machine. I implemented
> > DCD (and other handshake lines) irq handling[1].
> > =

> > Now a user of this patch noticed that DCD handling (at least) is broken.
> > The problem is that the USR2_DCDDELT bit doesn't clear:
> > =

> > 	root@hostname:~ memtool md 0x43f90080+0x34  =

> > 	43f90080: 00000000 00004021 0000078c 00004002                ....!@...=
....@..
> > 	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..h=
R..+...
> > 	43f900a0: 00000000 000000bf 00002e62 00000008                ........b=
.......
> > 	43f900b0: 0000251c                                           .%..
> > =

> > 	root@hostname:~ memtool mw 0x43f90098 0x0x40
>                                               ^^^^^^
> This looks rather fishy.

Probably a cut-and-paste problem. I tried this several times with
various values, the bit doesn't clear.

> > 	root@hostname:~ memtool md 0x43f90080+0x34  =

> > 	43f90080: 00000000 00004021 0000078c 00004002                ....!@...=
....@..
> > 	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..h=
R..+...
> > 	43f900a0: 00000000 000000bf 00002e62 00000008                ........b=
.......
> > 	43f900b0: 0000251c                                           .%..
> > =

> > In fact even writing 0xffff doesn't change the register, where I would =
expect
> > that the DCDDELT bit (0x40) disappears. I'm sure there is nothing toggl=
ing this
> > line.
> > =

> Are you sure the clock is enabled when doing your manual tests?

I guess they are. For sure the same thing happens with the driver active
and the device open. And the symptoms are the same: If the DCDDELTA irq
is enabled and active the machine is stuck until the irq upper layers
disable the respective irq.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
