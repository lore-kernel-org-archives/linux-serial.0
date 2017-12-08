From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] serial: max3100: Improve a size determination in
 max3100_probe()
Date: Fri, 8 Dec 2017 21:12:50 +0100
Message-ID: <8eca9ac5-96c3-8825-5c2b-a74b3dafcf9c@users.sourceforge.net>
References: <82c37f92-b4ee-8bea-bd10-de3b6691151d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <82c37f92-b4ee-8bea-bd10-de3b6691151d@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 20:32:09 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/max3100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index b7b7e6582f3f..00c0e650537d 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -761,7 +761,7 @@ static int max3100_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
-	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
+	max3100s[i] = kzalloc(sizeof(*max3100s[i]), GFP_KERNEL);
 	if (!max3100s[i]) {
 		mutex_unlock(&max3100s_lock);
 		return -ENOMEM;
-- 
2.15.1

