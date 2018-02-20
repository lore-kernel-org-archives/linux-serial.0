From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/9] serial: Fix out-of-bounds accesses through DT aliases
Date: Tue, 20 Feb 2018 10:40:15 +0100
Message-ID: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Vineet Gupta <vgupta@synopsys.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

	Hi all,

Serial drivers used on DT platforms use the "serialN" alias in DT to
obtain the serial port index for a specific port.  Drivers typically use
a fixed-size array for keeping track of all available serial ports.
However, several drivers do not perform any validation on the index
obtained from DT, which may lead to out-of-bounds accesses of these
fixed-size arrays.

While the DTB passed to the kernel might be considered trusted, some of
these out-of-bounds accesses can be triggered by a legitimate DTB:
  - In some drivers the size of the array is defined by a Kconfig
    symbol, so a user who doesn't need all serial ports may lower this
    value rightfully,
  - Tomorrow's new SoC may have more serial ports than the fixed-size
    array in today's driver can accommodate, which the user may forget
    to enlarge.

Hence this series fixes that by adding checks for out-of-range aliases,
logging an error message when triggered.

Tested on r8a7791/koelsch (sh-sci), all other drivers were
compile-tested only.

Thanks for your comments!

Geert Uytterhoeven (9):
  serial: arc_uart: Fix out-of-bounds access through DT alias
  serial: fsl_lpuart: Fix out-of-bounds access through DT alias
  serial: imx: Fix out-of-bounds access through DT alias
  serial: mxs-auart: Fix out-of-bounds access through DT alias
  serial: pxa: Fix out-of-bounds access through DT alias
  serial: samsung: Fix out-of-bounds access through DT alias
  serial: sh-sci: Fix out-of-bounds access through DT alias
  serial: sirf: Fix out-of-bounds access through DT alias
  serial: xuartps: Fix out-of-bounds access through DT alias

 drivers/tty/serial/arc_uart.c      | 5 +++++
 drivers/tty/serial/fsl_lpuart.c    | 4 ++++
 drivers/tty/serial/imx.c           | 5 +++++
 drivers/tty/serial/mxs-auart.c     | 4 ++++
 drivers/tty/serial/pxa.c           | 4 ++++
 drivers/tty/serial/samsung.c       | 4 ++++
 drivers/tty/serial/sh-sci.c        | 4 ++++
 drivers/tty/serial/sirfsoc_uart.c  | 5 +++++
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 9 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
