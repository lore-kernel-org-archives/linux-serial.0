From: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Subject: How to move serial8250_init out of the critical path to decrease boot
 time?
Date: Sun, 1 Apr 2018 09:11:15 +0200
Message-ID: <e086c888-df77-1fde-e3b8-9246c9ab3377@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C55A42C5E8E528F2DC9C503D"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------C55A42C5E8E528F2DC9C503D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


The goal is to boot a *distribution* Linux kernel as fast as possible. 
(The goal is currently 500 ms.)

With Linux 4.16-rc7, `serial8250_init()` takes almost 34 ms according to 
`initcall_debug` on the laptop TUXEDO Book BU1406 with an Intel Kaby 
Lake processor.

```
[    2.657950] calling  serial8250_init+0x0/0x168 @ 1
[    2.657963] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.692598] initcall serial8250_init+0x0/0x168 returned 0 after 33820 
usecs
```

One problem is, that the distributions do not build this as a module, 
despite more and more devices do not actually have serial connectors, 
but the chipset still exposes them.

What options are there?

1.  Try to probe it asynchronously as in the attached patch, which is 
not tested yet.

2.  Where possible try to deactivate this in the firmware?

3.  Recommend to build this as a module? But this would only fix future 
systems?

4.  Avoid the probe, by have an interface to pass the infomr

5.  Add an option to disable the driver, which could be specified on the 
Linux kernel command line? `8250.disable`?


Kind regards,

Paul

--------------C55A42C5E8E528F2DC9C503D
Content-Type: text/x-patch;
 name="0001-tty-serial-8250-Request-driver-probe-from-an-async-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-tty-serial-8250-Request-driver-probe-from-an-async-t.pa";
 filename*1="tch"

>From 536100229e59d9ff7c910d0c26e1c54a56daba81 Mon Sep 17 00:00:00 2001
From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sun, 1 Apr 2018 08:57:53 +0200
Subject: [PATCH] tty/serial/8250: Request driver probe from an async task

Currently, according to `initcall_debug` running `serial8250_init` takes
around 33 ms on a Lenovo X60 and TUXEDO Book BU1406.

As this is in the critical path, and most distributions do *not* build
*8250* as a module, that means `CONFIG_SERIAL_8250=y`, probe the device
asynchronously, so other tasks are not hold up.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..996de9c78001 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -894,6 +894,7 @@ static struct platform_driver serial8250_isa_driver = {
 	.driver		= {
 		.name	= "serial8250",
 	},
+	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
 
 /*
-- 
2.14.1


--------------C55A42C5E8E528F2DC9C503D--
