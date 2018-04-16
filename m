From: Stefan Agner <stefan@agner.ch>
Subject: serial: imx: half-duplex RS485 operation with RTS active low
Date: Mon, 16 Apr 2018 11:14:32 +0200
Message-ID: <0e88706a05a302201be396d2f03c3e9e@agner.ch>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, baruch@tkos.co.il
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Using upstream I noticed that RS-485 does not work in the default
configuration for our platforms (Toradex Apalis/Colibri). Closer
debugging shows that it is related to "serial: imx: default to half
duplex rs485".

We use the i.MX UART in DTE mode and control the RS-485 transceiver
using the RTS signal in low-active mode.

	uart-has-rtscts;
	fsl,dte-mode;
	linux,rs485-enabled-at-boot-time;
	rs485-rts-active-low;

Using this setting leads to the RTS signal not getting asserted (the
oscilloscope only shows a very short fluke before the start bit is
sent).

However, using

	uart-has-rtscts;
	fsl,dte-mode;
	linux,rs485-enabled-at-boot-time;
	rs485-rts-active-low;
	rs485-rx-during-tx;

Asserts the RTS signal low active just fine...

Is this a known problem? Any idea where that could come from? It looks
as if the receiver part is actually enabling RTS...?

Also, isn't enabling RX even in half-duplex mode quite common in order
to detect collisions?

--
Stefan
