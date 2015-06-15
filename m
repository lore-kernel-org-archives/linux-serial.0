From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 0/5]  serial/8250_fintek Support any configuration
Date: Mon, 15 Jun 2015 17:14:33 +0200
Message-ID: <1434381278-15852-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-serial@vger.kernel.org

The original driver only supported the default configuration of the chip.

This patchset add supports for all the possible configurations:
-Different io address
-Multiple chips
-Different chip_ids

Patchset can be viewed online at
https://github.com/ribalda/linux/tree/8250_fintek_try2

v2: Fix comments by Alan Cox <alan@linux.intel.com>

Replace blah foo[] = { 1,2,3,4 }; with
static const blah foo[] = { 1,2,3,4 };

Reported-by: Peter Hong <peter_hong@fintek.com.tw>

Ricardo Ribalda Delgado (5):
  serial/8250_fintek: Use private data structure
  serial/8250_fintek: Support for multiple base_ports
  serial/8250_fintek: Support for chip_ip 0x0501
  serial/8250_fintek: Support keys different than default
  serial/8250_fintek: Support for any io address.

 drivers/tty/serial/8250/8250_fintek.c | 170 +++++++++++++++++++++-------------
 1 file changed, 106 insertions(+), 64 deletions(-)

-- 
2.1.4
