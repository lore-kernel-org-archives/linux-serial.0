From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/9] serial: Fix out-of-bounds accesses through DT aliases
Date: Fri, 23 Feb 2018 14:38:28 +0100
Message-ID: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
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

Changes compared to v1:
  - Fix Fixes references,
  - Use ARRAY_SIZE(),
  - Fix off-by-one error in patch [5/9],
  - Document where the non-DT case is also fixed by a patch.

Tested on r8a7791/koelsch (sh-sci), all other drivers were
compile-tested only.

Thanks for your comments!

Geert Uytterhoeven (9):
  serial: arc_uart: Fix out-of-bounds access through DT alias
  serial: fsl_lpuart: Fix out-of-bounds access through DT alias
  serial: imx: Fix out-of-bounds access through serial port index
  serial: mxs-auart: Fix out-of-bounds access through serial port index
  serial: pxa: Fix out-of-bounds access through serial port index
  serial: samsung: Fix out-of-bounds access through serial port index
  serial: sh-sci: Fix out-of-bounds access through DT alias
  serial: sirf: Fix out-of-bounds access through DT alias
  serial: xuartps: Fix out-of-bounds access through DT alias

 drivers/tty/serial/arc_uart.c      | 5 +++++
 drivers/tty/serial/fsl_lpuart.c    | 4 ++++
 drivers/tty/serial/imx.c           | 6 ++++++
 drivers/tty/serial/mxs-auart.c     | 4 ++++
 drivers/tty/serial/pxa.c           | 4 ++++
 drivers/tty/serial/samsung.c       | 4 ++++
 drivers/tty/serial/sh-sci.c        | 4 ++++
 drivers/tty/serial/sirfsoc_uart.c  | 5 +++++
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 9 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
