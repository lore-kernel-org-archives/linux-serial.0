From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 0/4] tty: serial: Fix module autoload for OF platform drivers
Date: Fri, 18 Sep 2015 20:02:15 +0200
Message-ID: <20150918180215.GA30639@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabian Frederick <fabf@skynet.be>, Wolfram Sang <wsa@the-dreams.de>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (4):
  tty: serial: apbuart: Fix module autoload for OF platform driver
  tty: serial: cpm_uart: Fix module autoload for OF platform driver
  tty: serial: of_serial: Fix module autoload for OF platform driver
  tty: serial: sprd: Fix module autoload for OF platform driver

 drivers/tty/serial/apbuart.c                | 1 +
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 1 +
 drivers/tty/serial/of_serial.c              | 1 +
 drivers/tty/serial/sprd_serial.c            | 1 +
 4 files changed, 4 insertions(+)

-- 
2.4.6
