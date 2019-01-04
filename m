From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] sc16is7xx: Use struct_size() in devm_kzalloc()
Date: Fri, 4 Jan 2019 11:48:19 -0600
Message-ID: <20190104174819.GA32645@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-serial@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 268098681856..635178cf3eed 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1187,9 +1187,7 @@ static int sc16is7xx_probe(struct device *dev,
 		return PTR_ERR(regmap);
 
 	/* Alloc port structure */
-	s = devm_kzalloc(dev, sizeof(*s) +
-			 sizeof(struct sc16is7xx_one) * devtype->nr_uart,
-			 GFP_KERNEL);
+	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
 	if (!s) {
 		dev_err(dev, "Error allocating port structure\n");
 		return -ENOMEM;
-- 
2.20.1
