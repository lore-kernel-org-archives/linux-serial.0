From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] Drop owner assignment from i2c_driver (and platform left-overs)
Date: Fri, 10 Jul 2015 15:36:18 +0900
Message-ID: <1436510180-5567-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Paul Burton <paul.burton@imgtec.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,


The i2c drivers also do not have to set 'owner' field because
i2c_register_driver() will do it instead.

'owner' is removed from i2c drivers, which I was able to compile
with allyesconfig (arm, arm64, i386, x86_64, ppc64).
Only compile-tested.

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  tty: serial: Drop owner assignment from platform_driver
  tty: serial: Drop owner assignment from i2c_driver

 drivers/tty/serial/8250/8250_ingenic.c | 1 -
 drivers/tty/serial/sc16is7xx.c         | 1 -
 2 files changed, 2 deletions(-)

-- 
1.9.1
