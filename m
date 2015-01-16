From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] sh-sci: extend PM methods
Date: Fri, 16 Jan 2015 13:56:02 -0800 (PST)
Message-ID: <3390015.epzKE7eYAi@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In order to make it possible to restore from hibernation not only in Linux but
also in e.g. U-Boot, we have to use sci_{suspend|remove}() for the PM {freeze|
thaw|restore}() methods.  It's handy to achieve this by using SIMPLE_DEV_PM_OPS()
macro, however we have to annotate sci_{suspend|remove}() with '__maybe_unused'
in order to avoid compilation warnings when CONFIG_PM_SLEEP is undefined.

Based on orignal patch by Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.

 drivers/tty/serial/sh-sci.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: tty/drivers/tty/serial/sh-sci.c
===================================================================
--- tty.orig/drivers/tty/serial/sh-sci.c
+++ tty/drivers/tty/serial/sh-sci.c
@@ -2605,7 +2605,7 @@ static int sci_probe(struct platform_dev
 	return 0;
 }
 
-static int sci_suspend(struct device *dev)
+static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -2615,7 +2615,7 @@ static int sci_suspend(struct device *de
 	return 0;
 }
 
-static int sci_resume(struct device *dev)
+static __maybe_unused int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -2625,10 +2625,7 @@ static int sci_resume(struct device *dev
 	return 0;
 }
 
-static const struct dev_pm_ops sci_dev_pm_ops = {
-	.suspend	= sci_suspend,
-	.resume		= sci_resume,
-};
+static SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
 
 static struct platform_driver sci_driver = {
 	.probe		= sci_probe,

