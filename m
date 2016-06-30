From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/2] serial: 8250_dw: Add ACPI support for uart on Hisilicon Hip05 soc
Date: Thu, 30 Jun 2016 09:27:40 +0800
Message-ID: <1467250062-61583-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, z.liuxinliang@hisilicon.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org, xuwei5@hisilicon.com, graeme.gregory@linaro.org, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Make dw8250_set_termios() as the default set_termios callback for 8250 dw uart, correct me
if I am wrong.

Then add ACPI support for uart on Hisilicon Hip05 soc, be careful that it is not 16500
compatible. Meanwhile, set dw8250_serial_out32 to keep consistent between serial_out
and serial_in in ACPI.

Change since v1:
- Use acpi_match_device() instead of acpi_dev_found(), limit the check to the device
  being probed and not a global search for whole DSDT (pointed by graeme.gregory@linaro.org)

Kefeng Wang (2):
  serial: 8250_dw: make dw8250_set_termios as default set_termios
    callback
  serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 soc

 drivers/tty/serial/8250/8250_dw.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
1.7.12.4
