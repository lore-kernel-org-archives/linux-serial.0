From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 0/2] serial: 8250_dw: Add ACPI support for uart on Hisilicon Hip05 SoC
Date: Wed, 31 Aug 2016 11:29:10 +0800
Message-ID: <1472614152-43136-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, guohanjun@huawei.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org, z.liuxinliang@hisilicon.com, linux-acpi@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Handle all cases of dw8250_data->clk properly in dw8250_set_termios(), then
make it as the default set_termios callback for 8250 dw uart.

After that, add ACPI support for uart on Hisilicon Hip05 SoC, be careful that
it is not 16500 compatible, and with Heikki's patchset[1], we safely only add
ACPI identifier, due to the ACPI quirks in dw8250_quirks() only for "APMC0D08".

Change since v3:
- The new dev var patch is sent separately.
- Address the comment from Andy, and repost patches based on Heikki Krogerus's patchset[1]
  "[PATCHv2 0/3] serial: dw8250: ACPI tuning"  

Change since v2:
- Add a new patch to use new var dev in probe
- Use built-in device properties to set device parameters for existing device probed by acpi,
  suggested by Andy Shevchenko


Change since v1:
- Use acpi_match_device() instead of acpi_dev_found(), limit the check to the device
  being probed and not a global search for whole DSDT (pointed by graeme.gregory@linaro.org)

[1] http://www.spinics.net/lists/linux-acpi/msg68519.html

Kefeng Wang (2):
  serial: 8250_dw: make dw8250_set_termios as default set_termios
    callback
  serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 SoC

 drivers/tty/serial/8250/8250_dw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.12.4

