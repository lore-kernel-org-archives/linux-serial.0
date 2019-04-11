From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v4 0/2] tty: serial: add DT bindings and serial driver for the
 SiFive FU540 UART
Date: Thu, 11 Apr 2019 02:00:26 -0700
Message-ID: <20190411090027.8670-1-paul.walmsley@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-serial@vger.kernel.org

This series adds a serial driver, with console support, for the
UART IP block present on the SiFive FU540 SoC.  The programming
model is straightforward, but unique.

Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
open-source FSBL (with appropriate patches to the DT data).

This fourth version incorporates a few more comments from the lists.

The patches in this series can also be found, with the PRCI patches,
DT patches, and DT prerequisite patch, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4


- Paul


Paul Walmsley (2):
  dt-bindings: serial: add documentation for the SiFive UART driver
  tty: serial: add driver for the SiFive UART

 .../bindings/serial/sifive-serial.txt         |   33 +
 drivers/tty/serial/Kconfig                    |   24 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/sifive.c                   | 1067 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 5 files changed, 1128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 create mode 100644 drivers/tty/serial/sifive.c

-- 
2.20.1
