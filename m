From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 04/12] gpio-sch: Fix leak of resource
Date: Wed, 27 Jun 2012 12:21:42 +0100
Message-ID: <20120627112140.5678.79917.stgit@localhost.localdomain>
References: <20120627112102.5678.4141.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46078 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307Ab2F0LFl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 07:05:41 -0400
In-Reply-To: <20120627112102.5678.4141.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpio/gpio-sch.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 424dce8..8707d45 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -241,7 +241,8 @@ static int __devinit sch_gpio_probe(struct platform_device *pdev)
 			break;
 
 		default:
-			return -ENODEV;
+			err = -ENODEV;
+			goto err_sch_gpio_core;
 	}
 
 	sch_gpio_core.dev = &pdev->dev;

