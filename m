From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi
 serial
Date: Tue, 22 Jan 2019 13:55:08 +0200
Message-ID: <20190122115508.GB22960@kuha.fi.intel.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Yung Tseng <guan.yung.tseng@ni.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

+Andy

On Mon, Jan 14, 2019 at 10:10:05PM +0800, Guan Yung Tseng wrote:
> Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> The reason of doing this is because all NI multi port serial cards
> use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> serial_pci_is_class_communication test added in the commit 7d8905d06405
> ("serial: 8250_pci: Enable device after we check black list").

OK, so commit 7d8905d06405 ("serial: 8250_pci: Enable device after we
check black list") has created a regression. If the device does not
use PCI_CLASS_COMMUNICATION*SERIAL class, probe will fail, and I
don't think that is how the driver should function.

If the device id is listed in serial_pci_tbl, we need to probe the
device, regardless of the class id.

> Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 4986b4a..0949db1 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -663,6 +663,13 @@ static int pci_xircom_init(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +static int pci_ni_probe(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
> +			(dev->class & 0xff);
> +	return 0;
> +}

This is only working around the regression that 7d8905d064058 created,
and only with your UART. There may be others.

We need to fix the regression, not work around it. How about something
like the attached diff?


thanks,

-- 
heikki

--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="improved_7d8905d064058.diff"

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index f80a300b5d68..8b555c3a3670 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3375,10 +3375,22 @@ static const struct pci_device_id blacklist[] = {
 	/* Exar devices */
 	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), },
 	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), },
+	{ }
 };
 
-static int serial_pci_is_class_communication(struct pci_dev *dev)
+/*
+ * Given a complete unknown PCI device, try to use some heuristics to
+ * guess what the configuration might be, based on the pitiful PCI
+ * serial specs.  Returns 0 on success, -ENODEV on failure.
+ */
+static int
+serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
+	int first_port = -1;
+	int num_iomem;
+	int num_port;
+	int i;
+
 	/*
 	 * If it is not a communications device or the programming
 	 * interface is greater than 6, give up.
@@ -3389,38 +3401,6 @@ static int serial_pci_is_class_communication(struct pci_dev *dev)
 	    (dev->class & 0xff) > 6)
 		return -ENODEV;
 
-	return 0;
-}
-
-static int serial_pci_is_blacklisted(struct pci_dev *dev)
-{
-	const struct pci_device_id *bldev;
-
-	/*
-	 * Do not access blacklisted devices that are known not to
-	 * feature serial ports or are handled by other modules.
-	 */
-	for (bldev = blacklist;
-	     bldev < blacklist + ARRAY_SIZE(blacklist);
-	     bldev++) {
-		if (dev->vendor == bldev->vendor &&
-		    dev->device == bldev->device)
-			return -ENODEV;
-	}
-
-	return 0;
-}
-
-/*
- * Given a complete unknown PCI device, try to use some heuristics to
- * guess what the configuration might be, based on the pitiful PCI
- * serial specs.  Returns 0 on success, -ENODEV on failure.
- */
-static int
-serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
-{
-	int num_iomem, num_port, first_port = -1, i;
-
 	/*
 	 * Should we try to make guesses for multiport serial devices later?
 	 */
@@ -3647,13 +3627,8 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 
 	board = &pci_boards[ent->driver_data];
 
-	rc = serial_pci_is_class_communication(dev);
-	if (rc)
-		return rc;
-
-	rc = serial_pci_is_blacklisted(dev);
-	if (rc)
-		return rc;
+	if (pci_match_id(blacklist, dev))
+		return -ENODEV;
 
 	rc = pcim_enable_device(dev);
 	pci_save_state(dev);

--qlTNgmc+xy1dBmNv--
