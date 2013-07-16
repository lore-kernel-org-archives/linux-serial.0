From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 0/4] pci_ids, 8250_pci: remove PCI_VENDOR_ID_ADDIDATA_OLD
Date: Tue, 16 Jul 2013 16:14:37 +0100
Message-ID: <1373987681-18245-1-git-send-email-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Abbott <abbotti@mev.co.uk>
List-Id: linux-serial@vger.kernel.org

The 8250_pci driver uses PCI_VENDOR_ID_ADDIDATA_OLD (0x10e8),
PCI_DEVICE_ID_ADDIDATA_APCI7800 (0x818e) to recognize the original
ADDI-DATA APCI-7800 PCI serial card.  However vendor ID 0x10e8 was
assigned by PCI-SIG to Applied Micro Circuits Corporation (AMCC) and the
associated device ID 0x818e was assigned by AMCC to ADDI-DATA.

Comedi already defines PCI_VENDOR_ID_AMCC as 0x10e8 in one of its header
files, so that definition can be moved into pci_ids.h and the 8250_pci
driver changed to use it.  The PCI_DEVICE_ID_ADDIDATA_APCI7800 define
seems out of place in pci_ids.h since it isn't associated with
ADDI-DATA's vendor ID but with AMCC's vendor ID.  It's only used in
8250_pci.c so it can be moved there and renamed to something more
sensible.

1) pci_ids.h: move PCI_VENDOR_ID_AMCC here
2) serial: 8250_pci: replace PCI_VENDOR_ID_ADDIDATA_OLD
3) serial: 8250_pci: use local device ID for ADDI-DATA APCI-7800
4) pci_ids.h: remove PCI_VENDOR_ID_ADDIDATA_OLD and
   PCI_DEVICE_ID_ADDIDATA_APCI7800

 drivers/staging/comedi/comedidev.h | 1 -
 drivers/tty/serial/8250/8250_pci.c | 9 +++++----
 include/linux/pci_ids.h            | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)
