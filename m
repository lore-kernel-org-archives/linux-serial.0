From: Ed Blake <ed.blake@imgtec.com>
Subject: [PATCH v2 0/2] serial: Add IrDA support to 8250_dw driver
Date: Fri, 28 Oct 2016 18:04:32 +0100
Message-ID: <1477674274-16283-1-git-send-email-ed.blake@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com, heikki.krogerus@linux.intel.com, noamc@ezchip.com, annie.wang@amd.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, peter@hurleysoftware.com, alexander.sverdlin@nokia.com, yegorslists@googlemail.com, matwey@sai.msu.ru, yamada.masahiro@socionext.com, tthayer@opensource.altera.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, james.hartley@imgtec.com, Ed Blake <ed.blake@imgtec.com>
List-Id: linux-serial@vger.kernel.org

This patch set adds IrDA support to the 8250_dw driver. The first patch exposes
the set_ldisc() function in the 8250 driver so it can be overridden, and the
second patch adds a set_ldisc() function to the 8250_dw driver which enables /
disables IrDA SIR mode if supported.

v2:
  The 8250_dw set_ldisc() function no longer tries to enable/disable IrDA SIR
  mode if not supported by the hardware configuration.

Ed Blake (2):
  serial: 8250: Expose set_ldisc function
  serial: 8250_dw: Add support for IrDA SIR mode

 drivers/tty/serial/8250/8250_core.c |  3 +++
 drivers/tty/serial/8250/8250_dw.c   | 24 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 12 ++++++++++--
 include/linux/serial_8250.h         |  4 ++++
 include/linux/serial_core.h         |  2 ++
 5 files changed, 43 insertions(+), 2 deletions(-)

-- 
1.9.1
