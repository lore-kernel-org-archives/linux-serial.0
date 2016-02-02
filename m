From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Dual Serial PCIe WCH382 Support
Date: Tue,  2 Feb 2016 13:00:44 -0800
Message-ID: <1454446845-18739-1-git-send-email-jmcnicol@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: devel@linuxdriverproject.org
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


This change adds support for the IOCrest WCH382 dual serial PCIe card.

LSPCI:
-----

03:00.0 Serial controller: Device 1c00:3253 (rev 10) (prog-if 05 [16850])
	Subsystem: Device 1c00:3253
	Flags: fast devsel, IRQ 16
	I/O ports at 2000 [size=256]
	Memory at c0000000 (32-bit, prefetchable) [size=32K]
	I/O ports at 2100 [size=4]
	Expansion ROM at aa000000 [disabled] [size=32K]
	Capabilities: [60] Power Management version 3
	Capabilities: [68] MSI: Enable- Count=1/32 Maskable+ 64bit+
	Capabilities: [80] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting


Unfortunately I couldn't find the vendor's refrence manuals.  All
I could find where pointers to this:
   http://www.wch-ic.com/download/list.asp?id=126
but that link is dead.  If someone has a copy of the reference sheet /
programmers guide for this I would greatly appreciate it sent my way.

Testing:
  -verified minicom can communicate a various speeds using each RS-232 port
     through a NULL modem cable.
  -grub serial doesn't seem to work, but I didn't really dig into it.
  -kernel boot console works, which is the only thing I was after.
  -Link to the one I used: http://www.iocrest.com/en/product_details276.html


Jeremy McNicoll (1):
  tty: Add support for PCIe WCH382 2S multi-IO card

 drivers/tty/serial/8250/8250_pci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.6.1
