From: Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH v3 1/3] serial: xuartps: fix typo in cdns_uart_startup
Date: Mon, 4 Jun 2018 12:22:05 +0200
Message-ID: <5fbc35e1a4285e149cc0db3b1d989932260a8386.1528106392.git.h.grohne@intenta.de>
References: <cover.1528106392.git.h.grohne@intenta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1528106392.git.h.grohne@intenta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
List-Id: linux-serial@vger.kernel.org

The bit mask changes in commit 6e14f7c1f2c2 ("tty: xuartps: Improve
startup function") doesn't do what the commit message advertises. The
original behaviour was clearing the RX_DIS bit, but due to missing ~,
that bit is now the only bit kept.

Currently, the regression is harmless, because the previous write to the
control register sets it to TXRST | RXRST. Thus the RX_DIS bit is
previously cleared. The *RST bits are cleared by the hardware, so this
commit does not currently change behaviour, but makes future changes
less risky.

Link: https://www.spinics.net/lists/linux-serial/msg23157.html
Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
Fixes: 6e14f7c1f2c2 ("tty: xuartps: Improve startup function")
Reviewed-by: S=F6ren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index bd72dd843338..e4b2d8102a04 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -829,7 +829,7 @@ static int cdns_uart_startup(struct uart_port *port)
 	 * the receiver.
 	 */
 	status =3D readl(port->membase + CDNS_UART_CR);
-	status &=3D CDNS_UART_CR_RX_DIS;
+	status &=3D ~CDNS_UART_CR_RX_DIS;
 	status |=3D CDNS_UART_CR_RX_EN;
 	writel(status, port->membase + CDNS_UART_CR);
 =

-- =

2.11.0
