From: Henrik =?ISO-8859-1?Q?Nordstr=F6m?= <henrik@henriknordstrom.net>
Subject: [PATCH] tty/8250_early: Don't truncate last character of options
Date: Thu, 04 Jul 2013 03:51:39 +0200
Message-ID: <1372902699.12955.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

>From 8b278828cb439b3b9b723a1de28ae10ce3e0cc44 Mon Sep 17 00:00:00 2001
From: Henrik Nordstrom <henrik@henriknordstrom.net>
Date: Thu, 4 Jul 2013 03:24:41 +0200
Subject: [PATCH] tty/8250_early: Don't truncate last character of options

the 3,9 change to use strlcpy to save options uncovered a bug in the
options argument length calculation causing last character of the
string to be truncated by strlcpy. This caused the actual console
to be configured with bad parameters when specifying the console
using console=uart,... syntax.

Example:

Kernel command line: console=uart,mmio,0x90000000,115200
Early serial console at MMIO 0x90000000 (options '11520')

Signed-off-by: Henrik Nordstrom <henrik@henriknordstrom.net>
---
 drivers/tty/serial/8250/8250_early.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 721904f..946ddd2 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -193,7 +193,8 @@ static int __init parse_options(struct early_serial8250_device *device,
 	if (options) {
 		options++;
 		device->baud = simple_strtoul(options, NULL, 0);
-		length = min(strcspn(options, " "), sizeof(device->options));
+		length = min(strcspn(options, " ") + 1,
+			     sizeof(device->options));
 		strlcpy(device->options, options, length);
 	} else {
 		device->baud = probe_baud(port);
-- 
1.8.3.1
