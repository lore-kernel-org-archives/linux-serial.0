From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCHv2 0/3] serial: dw8250: ACPI tuning
Date: Tue, 23 Aug 2016 11:33:25 +0300
Message-ID: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Since we now have the build-in properties available, using those when
ever possible to get the details the driver expects and when they are
not being provided by the fw. Right now there is only one exception
ACPI enumerated board where we have no means to provide the properties
with build-in ones, so simply handling that as an exception in
dw8250_quirks().

Changes since v1:
- Fix a compiler error in acpi_apd.c found by kbuild test robot
- ACK from Mika


Heikki Krogerus (3):
  ACPI / APD: Provide build-in properties of the UART
  ACPI / LPSS: Provide build-in properties of the UART
  serial: 8250_dw: Add quirk for APM X-Gene SoC

 drivers/acpi/acpi_apd.c           | 15 +++++++++++++++
 drivers/acpi/acpi_lpss.c          | 17 +++++++++++++++++
 drivers/tty/serial/8250/8250_dw.c | 15 ++++++++++-----
 3 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.8.1

