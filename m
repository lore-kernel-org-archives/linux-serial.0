From: Michael Anderson <mjanders@us.ibm.com>
Subject: Re: [PATCH] linux-2.6.2-rc3 Add icom serial device driver
Date: Fri, 6 Feb 2004 17:03:46 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <OFC1CDAB5E.ED6A985E-ON86256E32.007CF24F-86256E32.007EBF7F@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13529 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265788AbUBFXEJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Feb 2004 18:04:09 -0500
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org


>diff -Nur orig/Documentation/icom.txt devel/Documentation/icom.txt
>--- orig/Documentation/icom.txt           1969-12-31 18:00:00.000000000
-0600
>+++ devel/Documentation/icom.txt          2004-02-03 17:35:31.000000000
-0600
>
>Why not place this in the Documentation/serial subdirectory?

Yes, I will move icom.txt to the serial subdirectory.

>+#define ASYNC_CLOSING    0x08000000            /* Serial port is closing
*/
>+#define ASYNC_HUP_NOTIFY 0x0001          /* Notify getty on hangups and
closes
>+                                                  on the callout port */
>
>These are unused, please remove them.

They will be removed.

>+                 vendor:PCI_VENDOR_ID_IBM,
>+                 device:ICOM_DEV_ID_1,
>+                 subvendor:PCI_ANY_ID,
>+                 subdevice:PCI_ANY_ID,
>+                 driver_data:ADAPTER_V1,
>
>This should use C99 initialisers. IOW:
>                        .vendor = PCI_VENDOR_ID_IBM,
>etc

I will update as suggested.

>+LIST_HEAD(icom_adapter_head);
>
>Shouldn't this be prefixed by "static" ?

yes.

>+static int startup(struct icom_port *icom_port)
>...
>+           spin_lock_irqsave(&icom_lock, flags);
>...
>+                       icom_port->load_in_progress = 1;
>+                       spin_unlock_irq(&icom_lock);
>+
>+                       load_code(icom_port);
>+
>+                       spin_lock_irq(&icom_lock);
>+                       icom_port->load_in_progress = 0;
>...
>+           spin_unlock_irqrestore(&icom_lock, flags);
>
>spin_unlock_irq() after spin_lock_irqsave() is potentially unsafe.
>Also, the locking there is not necessary - opens and closes are
>already serialised with each other and themselves by the serial_core
>layer.

The spin locks will be removed.

>+           status = readb(&ICOM_PORT->dram->isr);
>+           control = readb(&ICOM_PORT->dram->osr);
>+
>+           result = ((status & ICOM_DCD) ? TIOCM_CAR : 0)
>+               | ((status & ICOM_RI) ? TIOCM_RNG : 0)
>+               | ((status & ICOM_DSR) ? TIOCM_DSR : 0)
>+               | ((status & ICOM_CTS) ? TIOCM_CTS : 0);
>+           return result;
>+}
>
>Hmm, you never seem to use "control".

Line of code and variable definition will be removed.

>+static struct uart_driver icom_uart_driver = {
>+           .owner = THIS_MODULE,
>+           .driver_name = ICOM_DRIVER_NAME,
>+           .dev_name = "ttyS",
>+           .major = ICOM_MAJOR,
>+           .minor = ICOM_MINOR_START,
>+           .nr = NR_PORTS,
>+           .cons = ICOM_CONSOLE,
>+};
>
>+#define ICOM_MAJOR       TTY_MAJOR
>+#define ICOM_MINOR_START 64
>
>I take it you'll never ever have one of these adapters in a machine
>which also has standard PC serial ports as well?  Since you're using
>the same major/minor numbers as the standard PC serial driver, it
>only allows one or the other driver to be loaded at any one time.

The icom driver is intended for iSeries platform linux which does
not have a standard serial port.  Ideally, I believe it would be
best if icom had its own MAJOR number.

>+static int __init icom_init(void)
>+{
>+           int ret;
>+
>+           spin_lock_init(&icom_lock);
>+
>+           ret = uart_register_driver(&icom_uart_driver);
>+           if (ret)
>+                       return ret;
>+
>+           pci_register_driver(&icom_pci_driver);
>+
>+           return 0;
>+}
>
>What if pci_register_driver() fails?

I will update to return failure code of pci_register_driver when
failure occurs.

>+static void __exit icom_exit(void)
>+{
>+           struct icom_adapter *icom_adapter;
>+           struct list_head *tmp;
>+
>+           pci_unregister_driver(&icom_pci_driver);
>+
>+           while (1) {
>+                       list_for_each(tmp, &icom_adapter_head) {
>+                                   icom_adapter = list_entry(tmp, struct
icom_adapter,
>+
icom_adapter_entry);
>+                                   icom_remove_adapter(icom_adapter);
>+                                   break;
>+                       }
>+                       break;
>+           }
>+
>+           uart_unregister_driver(&icom_uart_driver);
>+}
>
>Is it really necessary to loop over the list of adapters?
>pci_unregister_driver() will call the remove method for each PCI device
>which was assigned to this driver, so your icom_remove function should
>have already removed all instances.

Correct, this should be unreachable code, I will remove it.

