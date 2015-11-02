From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH DRAFT 0/2] Sketch for ZTE ZX296702 UART integration
Date: Mon,  2 Nov 2015 12:24:00 +0000
Message-ID: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
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
To: Jun Nie <jun.nie@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Timur Tabi <timur@tabi.org>
Cc: Andrew.Jackson@arm.com, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

there has been some discussion on how to integrate support for the
ZTE ZX296702 UART, which is very similar to the PL011, but (among
other deviations) has its registers at different offsets from the base
address.
Previous patches on the list [1] were reworking the whole of the PL011
driver, creating extra churn for all architecture compliant
implementations.
This sketch introduces register accessor wrappers in patch 1, which
are useful for other things as well later. Ideally the generated
code should look identical after this one, given the compiler properly
inlines the accessor functions.
Based on that patch 2 then introduces a mapping table just for the
ZTE UART, which redirects the original PL011 register offsets to the
shifted positions on the ZTE UART.
The impact on all other implementations are kept minimal, actually if
the CONFIG_ symbol for that SoC is not defined, there should be no
code difference compared to the state before.

I don't have access to the ZTE UART hardware, so could not test this
(this patch set is not complete anyway), but I quickly tested for
regressions on a Juno, which seems to work fine for me.

I provide these patches as a base for discussion and for future,
proper support patches.
Do these make sense to anyone? Is this the way to go for the ZTE UART
implementation?

Any comments are appreciated.

Cheers,
Andre.

[1] http://marc.info/?l=linux-serial&m=143832897928885&w=2

Andre Przywara (2):
  drivers: serial: PL011: refactor register access
  drivers: serial: PL011: [DRAFT] implement register diverson for ZTE
    UART

 drivers/tty/serial/amba-pl011.c | 246 +++++++++++++++++++++++-----------------
 include/linux/amba/serial.h     |  10 ++
 2 files changed, 155 insertions(+), 101 deletions(-)

-- 
2.5.1
