From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
Date: Thu,  9 Jul 2015 11:57:12 +0100
Message-ID: <1436439433-10258-1-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Jakub=20Kici=C5=84ski?= <moorray3@wp.pl>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Andre Przywara <Andre.Przywara@arm.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, popcorn mix <popcornmix@gmail.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
sufficient to inhibit pl011_int() from being triggered by a local
IRQ and trying to re-take the same lock.  This can lead to
deadlocks.

This patch uses the _irq() locking variants instead to ensure that
pl011_int() handling for a given port is deferred until any
pl011_tx_softirq() work for that port is complete.

Fixes: 734745caeb9f serial/amba-pl011: Activate TX IRQ passively
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: stable <stable@vger.kernel.org> # 4.1
---
 drivers/tty/serial/amba-pl011.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl01=
1.c
index 763eb20..0cc622a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1360,9 +1360,9 @@ static void pl011_tx_softirq(struct work_struct *work=
)
 =09struct uart_amba_port *uap =3D
 =09=09container_of(dwork, struct uart_amba_port, tx_softirq_work);
=20
-=09spin_lock(&uap->port.lock);
+=09spin_lock_irq(&uap->port.lock);
 =09while (pl011_tx_chars(uap)) ;
-=09spin_unlock(&uap->port.lock);
+=09spin_unlock_irq(&uap->port.lock);
 }
=20
 static void pl011_tx_irq_seen(struct uart_amba_port *uap)
--=20
1.7.10.4
