Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D033F4;
	Tue, 21 Nov 2023 23:35:52 -0800 (PST)
Received: from hq-00595.holoplot.net (unknown [62.214.9.170])
	by mail.bugwerft.de (Postfix) with ESMTPSA id 66FBE281506;
	Wed, 22 Nov 2023 07:35:50 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lech.perczak@camlingroup.com,
	u.kleine-koenig@pengutronix.de
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Maxim Popov <maxim.snafu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] serial: sc16is7xx: address RX timeout interrupt errata
Date: Wed, 22 Nov 2023 08:35:41 +0100
Message-ID: <20231122073541.1200457-1-daniel@zonque.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device has a silicon bug that makes it report a timeout interrupt
but no data in the FIFO.

The datasheet states the following in the errata section 18.1.4:

  "If the host reads the receive FIFO at the same time as a
  time-out interrupt condition happens, the host might read 0xCC
  (time-out) in the Interrupt Indication Register (IIR), but bit 0
  of the Line Status Register (LSR) is not set (means there is no
  data in the receive FIFO)."

The errata doesn't explicitly mention that, but tests have shown
and the vendor has confirmed that the RXLVL register is equally
affected.

This bug has hit us on production units and when it does, sc16is7xx_irq()
would spin forever because sc16is7xx_port_irq() keeps seeing an
interrupt in the IIR register that is not cleared because the driver
does not call into sc16is7xx_handle_rx() unless the RXLVL register
reports at least one byte in the FIFO.

Fix this by always reading one byte when this condition is detected
in order to clear the interrupt. This approach was confirmed to be
correct by NXP through their support channels.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Co-Developed-by: Maxim Popov <maxim.snafu@gmail.com>
Cc: stable@vger.kernel.org
---
Meanwhile, NXP has confirmed this fix to be correct.

v4: NXP has confirmed the fix; update the commit log accordingly
v3: re-added the additional Co-Developed-by and stable@ tags
v2: reworded the commit log a bit for more context.

 drivers/tty/serial/sc16is7xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 289ca7d4e566..76f76e510ed1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -765,6 +765,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		case SC16IS7XX_IIR_RTOI_SRC:
 		case SC16IS7XX_IIR_XOFFI_SRC:
 			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+
+			/*
+			 * There is a silicon bug that makes the chip report a
+			 * time-out interrupt but no data in the FIFO. This is
+			 * described in errata section 18.1.4.
+			 *
+			 * When this happens, read one byte from the FIFO to
+			 * clear the interrupt.
+			 */
+			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+				rxlen = 1;
+
 			if (rxlen)
 				sc16is7xx_handle_rx(port, rxlen, iir);
 			break;
-- 
2.41.0

