From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] serial: handle pci_enable_device() failure upon resume
Date: Wed, 11 Oct 2006 21:47:20 -0400
Message-ID: <20061012014720.GA12935@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422687AbWJLBrV@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/serial/8250_pci.c    |    8 ++++++--

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 4d0ff8f..aa96e94 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -1810,16 +1810,20 @@ static int pciserial_resume_one(struct p
 	pci_restore_state(dev);
 
 	if (priv) {
+		int rc;
+
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
-		pci_enable_device(dev);
+		rc = pci_enable_device(dev);
+		if (rc)
+			return rc;
 
 		pciserial_resume_ports(priv);
 	}
 	return 0;
 }
-#endif
+#endif /* CONFIG_PM */
 
 static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
