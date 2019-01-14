From: Guan Yung Tseng <guan.yung.tseng@ni.com>
Subject: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
Date: Mon, 14 Jan 2019 22:10:05 +0800
Message-ID: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Guan Yung Tseng <guan.yung.tseng@ni.com>
List-Id: linux-serial@vger.kernel.org

Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
The reason of doing this is because all NI multi port serial cards
use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
serial_pci_is_class_communication test added in the commit 7d8905d06405
("serial: 8250_pci: Enable device after we check black list").

Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
---
 drivers/tty/serial/8250/8250_pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4986b4a..0949db1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -663,6 +663,13 @@ static int pci_xircom_init(struct pci_dev *dev)
 	return 0;
 }
 
+static int pci_ni_probe(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
+			(dev->class & 0xff);
+	return 0;
+}
+
 static int pci_ni8420_init(struct pci_dev *dev)
 {
 	void __iomem *p;
@@ -1850,6 +1857,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI23216,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1859,6 +1867,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2328,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1868,6 +1877,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1877,6 +1887,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1886,6 +1897,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2324I,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1895,6 +1907,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2322I,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1904,6 +1917,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_23216,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1913,6 +1927,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2328,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1922,6 +1937,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1931,6 +1947,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1940,6 +1957,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8422_2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1949,6 +1967,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8422_2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1958,6 +1977,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8430_init,
 		.setup		= pci_ni8430_setup,
 		.exit		= pci_ni8430_exit,
-- 
2.7.4
