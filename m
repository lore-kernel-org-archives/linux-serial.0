From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 0/3] keep console alive even if missing the 'enable' clock
Date: Mon, 26 Aug 2019 15:29:26 +0800
Message-ID: <20190826072929.7696-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

After the commit 4007098f4ce4 (serial: sprd: Add power management for the Spreadtrum serial controller),
the 'enable' clock was forced to be configured in device tree, otherwise the uart devices couldn't be
probed successfully.

With this patch-set, the uart device which is used as console would be allowed to register even without
any clock configured in device tree, this will make debug easier.

Chunyan Zhang (3):
  serial: sprd: check the right port and membase
  serial: sprd: add console_initcall in sprd's uart driver
  serial: sprd: keep console alive even if missing the 'enable' clock

 drivers/tty/serial/sprd_serial.c | 42 ++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

-- 
2.20.1
