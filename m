From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 00/10] drivers: PL011: add ARM SBSA Generic UART support
Date: Fri, 16 Jan 2015 17:22:56 +0000
Message-ID: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
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
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave Martin <dave.martin@arm.com>
List-Id: linux-serial@vger.kernel.org

The ARM Server Base System Architecture[1] document describes a
generic UART which is a subset of the PL011 UART.
It lacks DMA support, baud rate control and modem status line
control, among other things.
The idea is to move the UART initialization and setup into the
firmware (which does this job today already) and let the kernel just
use the UART for sending and receiving characters.

This patchset integrates support for this UART subset into the
existing PL011 driver - basically by refactoring some
functions and providing a new uart_ops structure for it. It also has
a separate probe function to be not dependent on AMBA/PrimeCell.
It provides a device tree binding, but can easily be adapted to other
device configuration systems.
Beside the obvious effect of code sharing reusing most of the PL011
code has the advantage of not introducing another serial device
prefix, so it can go with ttyAMA, which seems to be pretty common.

This series relies on Dave's recent PL011 fix[2], which gets rid of
the loopback trick to get the UART going. There is a repo at [3]
(branch sbsa-uart/v1), which has this patch already integrated.

Patch 1/10 contains a bug fix which applies to the PL011 part also,
it should be considered regardless of the rest of the series.
Patch 2-7 refactor some PL011 functions by splitting them up into
smaller pieces, so that most of the code can be reused later by the
SBSA part.
Patch 8 and 9 introduce two new properties for the vendor structure,
this is for SBSA functionality which cannot be controlled by
separate uart_ops members only.
Patch 10 then finally drops in the SBSA specific code, by providing
a new uart_ops, vendor struct and probe function for it. Also the new
device tree binding is documented.

For testing you should be able to take any hardware which has a PL011
and change the DT to use a "arm,sbsa-uart" compatible string.
Of course testing with a real SBSA Generic UART is welcomed!

Cheers,
Andre

[1] ARM-DEN-0029 Server Base System Architecture, available (click-
    thru...) from http://infocenter.arm.com
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315248.html
[3] http://www.linux-arm.org/git?p=linux-ap.git
    git://linux-arm.org/linux-ap.git

Andre Przywara (10):
  drivers: PL011: avoid potential unregister_driver call
  drivers: PL011: refactor pl011_startup()
  drivers: PL011: refactor pl011_shutdown()
  drivers: PL011: refactor pl011_set_termios()
  drivers: PL011: refactor pl011_probe()
  drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
  drivers: PL011: move cts_event workaround into separate function
  drivers: PL011: allow avoiding UART enabling/disabling
  drivers: PL011: allow to supply fixed option string
  drivers: PL011: add support for the ARM SBSA generic UART

 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    9 +
 drivers/tty/serial/amba-pl011.c                    |  510 ++++++++++++++------
 2 files changed, 381 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

-- 
1.7.9.5
