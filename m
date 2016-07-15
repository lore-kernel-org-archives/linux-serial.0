From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/3]
Date: Fri, 15 Jul 2016 19:01:22 +0800
Message-ID: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc: linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Make dw8250_set_termios() as the default set_termios callback for 8250 dw uart, correct me
if I am wrong.

Then add ACPI support for uart on Hisilicon Hip05 soc, be careful that it is not 16500
compatible. Meanwhile, set dw8250_serial_out32 to keep consistent between serial_out
and serial_in in ACPI.

Change since v2:
- Add a new patch to use new var dev in probe
- Use built-in device properties to set device parameters for existing device probed by acpi,
  suggested by Andy Shevchenko 


Change since v1:
- Use acpi_match_device() instead of acpi_dev_found(), limit the check to the device
  being probed and not a global search for whole DSDT (pointed by graeme.gregory@linaro.org)

Kefeng Wang (3):
  serial: 8250_dw: make dw8250_set_termios as default set_termios
    callback
  serial: 8250_dw: Use new dev variable in probe
  serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 soc

 drivers/tty/serial/8250/8250_dw.c | 71 ++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 30 deletions(-)

-- 
1.7.12.4

