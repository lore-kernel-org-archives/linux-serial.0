From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/2] serial: 8250_dw: Add ACPI support for uart on Hisilicon Hip05 soc
Date: Tue, 28 Jun 2016 11:17:13 +0800
Message-ID: <1467083835-37750-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, z.liuxinliang@hisilicon.com, guohanjun@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Make dw8250_set_termios() as the default set_termios callback for 8250 dw uart, correct me
if I am wrong.

Then add ACPI support for uart on Hisilicon Hip05 soc, be careful that it is not 16500
compatible. Note, the build(no ACPI) depends on https://patchwork.kernel.org/patch/9141207/,
which was already accepted in net-next.

Meanwhile, set dw8250_serial_out32 to keep consistent between serial_out
and serial_in in ACPI.

Kefeng Wang (2):
  serial: 8250_dw: make dw8250_set_termios as default set_termios
    callback
  serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 soc

 drivers/tty/serial/8250/8250_dw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
1.7.12.4
