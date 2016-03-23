From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: DCD interrupt for i.MX25 UART
Date: Wed, 23 Mar 2016 16:36:38 +0100
Message-ID: <20160323153638.GO6191@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

I have a problem with an UART on an i.MX25 based machine. I implemented
DCD (and other handshake lines) irq handling[1].

Now a user of this patch noticed that DCD handling (at least) is broken.
The problem is that the USR2_DCDDELT bit doesn't clear:

	root@hostname:~ memtool md 0x43f90080+0x34  =

	43f90080: 00000000 00004021 0000078c 00004002                ....!@.......=
@..
	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..hR..+=
...
	43f900a0: 00000000 000000bf 00002e62 00000008                ........b....=
...
	43f900b0: 0000251c                                           .%..

	root@hostname:~ memtool mw 0x43f90098 0x0x40

	root@hostname:~ memtool md 0x43f90080+0x34  =

	43f90080: 00000000 00004021 0000078c 00004002                ....!@.......=
@..
	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..hR..+=
...
	43f900a0: 00000000 000000bf 00002e62 00000008                ........b....=
...
	43f900b0: 0000251c                                           .%..

In fact even writing 0xffff doesn't change the register, where I would expe=
ct
that the DCDDELT bit (0x40) disappears. I'm sure there is nothing toggling =
this
line.

The net effect is that the irq blocks the machine until it is disabled with

	[   51.885987] irq 61: nobody cared (try booting with the "irqpoll" option)

.

This is on an i.MX25 and I checked the erratas also of the newer i.MX
cpus, but I didn't find anything.

Did I miss something? Is this a known bug? Do you have a recommendation
other than not to set UCR3_DCD? I cannot test the same problem for RI
because my hardware doesn't use it, but I wouldn't be surprised if that
had the same problem.

It would be great to get a statement from you on this topic.

Best regards
Uwe

[1] Message-Id: 1457605569-7828-3-git-send-email-u.kleine-koenig@pengutroni=
x.de

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
