From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 3/8] tty: serial: 8250_pxa: Implement mmp earlycon
Date: Wed, 22 Feb 2017 03:29:23 +0100
Message-ID: <20170222022929.10540-4-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, info@andromedabox.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

There is an early_pxa earlycon available for "mrvl,pxa-uart", but
mmp2.dtsi and soon iap140.dtsi have only "mrvl,mmp-uart". The binding
does not mandate to have the fallback, so add a second earlycon for this
alternative compatible string.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Note: early_pxa is not documented in kernel-parameters.txt, so not adding
       mmp either for now.
 
 Should early_pxa be renamed to / accompanied by pxa before it gets documented?
 An early_ prefix seems uncommon and redundant, thus not adopting here for mmp.
 
 v2: new
 
 drivers/tty/serial/8250/8250_pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 4d68731..26ffa04 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -183,6 +183,7 @@ static int __init early_serial_pxa_setup(struct earlycon_device *device,
 	return early_serial8250_setup(device, NULL);
 }
 OF_EARLYCON_DECLARE(early_pxa, "mrvl,pxa-uart", early_serial_pxa_setup);
+OF_EARLYCON_DECLARE(mmp, "mrvl,mmp-uart", early_serial_pxa_setup);
 #endif
 
 MODULE_AUTHOR("Sergei Ianovich");
-- 
2.10.2
