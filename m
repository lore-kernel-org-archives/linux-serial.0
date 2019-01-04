From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] serial: max310x: Use struct_size() in devm_kzalloc()
Date: Fri, 4 Jan 2019 15:39:13 -0600
Message-ID: <20190104213913.GA21248@embeddedor>
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
 drivers/tty/serial/max310x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4f479841769a..1d700a8ab517 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1197,8 +1197,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return PTR_ERR(regmap);
 
 	/* Alloc port structure */
-	s = devm_kzalloc(dev, sizeof(*s) +
-			 sizeof(struct max310x_one) * devtype->nr, GFP_KERNEL);
+	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
 	if (!s) {
 		dev_err(dev, "Error allocating port structure\n");
 		return -ENOMEM;
-- 
2.20.1
