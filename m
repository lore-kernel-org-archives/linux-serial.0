From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH 5/5 v3] tty: serial: altera_jtaguart: Add device tree support
Date: Fri, 18 Feb 2011 09:10:01 +0100
Message-ID: <1298016601-19111-1-git-send-email-tklauser@distanz.ch>
References: <c28550ba11ed228f4137ced1ab34761c08ad38ad.1297974227.git.tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <c28550ba11ed228f4137ced1ab34761c08ad38ad.1297974227.git.tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Advertise the possibility to use this driver with device tree if
CONFIG_OF is set.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
v3:
 - put device tree binding documentation in the correct place (thanks Grant
   Likely)
v2:
 - add missing semicolon after definition of altera_jtaguart_match

 .../devicetree/bindings/serial/altera_jtaguart.txt |    4 ++++
 drivers/tty/serial/altera_jtaguart.c               |   15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/altera_jtaguart.txt

diff --git a/Documentation/devicetree/bindings/serial/altera_jtaguart.txt b/Documentation/devicetree/bindings/serial/altera_jtaguart.txt
new file mode 100644
index 0000000..c152f65
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/altera_jtaguart.txt
@@ -0,0 +1,4 @@
+Altera JTAG UART
+
+Required properties:
+- compatible : should be "ALTR,juart-1.0"
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 8f014bb..60e049b 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -466,12 +466,23 @@ static int __devexit altera_jtaguart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id altera_jtaguart_match[] = {
+	{ .compatible = "ALTR,juart-1.0", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
+#else
+#define altera_jtaguart_match NULL
+#endif /* CONFIG_OF */
+
 static struct platform_driver altera_jtaguart_platform_driver = {
 	.probe	= altera_jtaguart_probe,
 	.remove	= __devexit_p(altera_jtaguart_remove),
 	.driver	= {
-		.name	= DRV_NAME,
-		.owner	= THIS_MODULE,
+		.name		= DRV_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= altera_jtaguart_match,
 	},
 };
 
-- 
1.7.0.4
