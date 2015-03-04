From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 00/10] drivers: PL011: add ARM SBSA Generic UART support
Date: Wed,  4 Mar 2015 17:59:44 +0000
Message-ID: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
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
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave.Martin@arm.com
List-Id: linux-serial@vger.kernel.org

This is the second revision of the SBSA UART support series.
It is now based on 4.0-rc2 and Dave's PL011 fixes[2], which fixes
all problems seen on the fast models and on some hardware.
I also added support for reporting back the actual baudrate to
userland, which needs to be passed in via the device tree by the
firmware now. An attempt to change that value will be ignored by the
driver, sane userland software (like stty) also rightfully complains
about not being able to change it:

# stty < /dev/ttyAMA1 | head -n 1
speed 115200 baud; line = 0;
# stty 38400 < /dev/ttyAMA1
stty: standard input: cannot perform all requested operations
# stty < /dev/ttyAMA1 | head -n 1
speed 115200 baud; line = 0;


----


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
(branch sbsa-uart/v2), which has this patch already integrated.

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
and change the DT to use a "arm,sbsa-uart" compatible string and the
baud rate with the "current-speed" property.
Of course testing with a real SBSA Generic UART is welcomed - as well
as regression testing with any PL011 implementation.

Changelog v1..v2:
- rebased on top of 4.0-rc1 and Dave's newest PL011 fix [2]
- added mandatory current-speed property and report that to userland

Cheers,
Andre

[1] ARM-DEN-0029 Server Base System Architecture, available (click-
    thru...) from http://infocenter.arm.com
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/327631.html
[3] http://www.linux-arm.org/git?p=linux-ap.git
    git://linux-arm.org/linux-ap.git

===========================================
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

 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |   10 +
 drivers/tty/serial/amba-pl011.c                    |  536 ++++++++++++++------
 2 files changed, 402 insertions(+), 144 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

-- 
1.7.9.5
