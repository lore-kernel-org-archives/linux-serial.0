From: "Linus Walleij" <linus.walleij@linaro.org>
Subject: [PATCH] serial: PL011: move interrupt clearing
Date: Wed, 21 Mar 2012 20:15:18 +0100
Message-ID: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, Linus Walleij <linus.walleij@linaro.org>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
List-Id: linux-serial@vger.kernel.org

Commit 360f748b204275229f8398cb2f9f53955db1503b
"serial: PL011: clear pending interrupts"
attempts to clear interrupts by writing to a
yet-unassigned memory address. This fixes the issue.

The breaking patch is marked for stable so should be
carried along with the other patch.

Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: stable <stable@vger.kernel.org>
Reported-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7e01399..4ed35c5 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1930,10 +1930,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto unmap;
 	}
 
-	/* Ensure interrupts from this UART are masked and cleared */
-	writew(0, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
-
 	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
@@ -1951,6 +1947,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.line = i;
 	pl011_dma_probe(uap);
 
+	/* Ensure interrupts from this UART are masked and cleared */
+	writew(0, uap->port.membase + UART011_IMSC);
+	writew(0xffff, uap->port.membase + UART011_ICR);
+
 	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
 
 	amba_ports[i] = uap;
-- 
1.7.7.6
