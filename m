From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 00/12] Prepare amba-pl011 for ZTE UART support
Date: Mon, 16 Nov 2015 17:39:35 +0000
Message-ID: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

This series is a re-posting of the updates to the AMBA PL011 primecell
serial port.

ZTE UARTs differ from the ARM version in two ways: the address layout
of the register set is substantially different, and the register access
size needs to be 32-bit.

This series converts the driver to use a lookup table to address the
first point, and switches to use a flag to indicate the access size.
We also switch the driver to use relaxed accessors, which is safe as
none of these are responsible for DMA configuration.

 drivers/tty/serial/amba-pl011.c | 335 ++++++++++++++++++++++++++--------------
 drivers/tty/serial/amba-pl011.h |  34 ++++
 include/linux/amba/serial.h     |  18 +++
 3 files changed, 269 insertions(+), 118 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
