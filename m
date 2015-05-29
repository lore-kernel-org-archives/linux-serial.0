From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH 0/3] Add RS-485 support and fix RTS/CTS implementation
Date: Fri, 29 May 2015 13:35:51 +0530
Message-ID: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
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
To: gregkh@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, bhuvanchandra.dv@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

- Add pinmux for UART_0 RTS/CTS pins.

- Since hardware can handle RTS/CTS flow control automatically,
  remove manual control of RTS/CTS from set/get mctrl.

- Add RS-485 support for Vybird platform.


Bhuvanchandra DV (3):
  ARM: dts: colibri-vf: Add pinmux for UART_0 aka UART_A RTS/CTS pins
  tty: serial: fsl_lpuart: remove RTS/CTS control from set/get_mctrl
  tty: serial: fsl_lpuart: Add support for RS-485

 arch/arm/boot/dts/vf-colibri.dtsi |   2 +
 drivers/tty/serial/fsl_lpuart.c   | 112 +++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 44 deletions(-)

-- 
2.1.0
