From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] linux-2.6.2-rc3 Add icom serial device driver
Date: Sat, 21 Feb 2004 23:02:33 +0000
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040221230233.C18248@flint.arm.linux.org.uk>
References: <OF44D236E7.513A2596-ON86256E38.00773808-86256E38.00777F7E@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50181 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261625AbUBUXCj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Feb 2004 18:02:39 -0500
Content-Disposition: inline
In-Reply-To: <OF44D236E7.513A2596-ON86256E38.00773808-86256E38.00777F7E@us.ibm.com>; from mjanders@us.ibm.com on Thu, Feb 12, 2004 at 03:44:35PM -0600
List-Id: linux-serial@vger.kernel.org
To: Michael Anderson <mjanders@us.ibm.com>
Cc: linux-serial@vger.kernel.org

On Thu, Feb 12, 2004 at 03:44:35PM -0600, Michael Anderson wrote:
> Updated icom patch can be found at:
> 
> http://www-124.ibm.com/linux/patches/misc/icom-2.6.3-rc2.patch

I was just giving this it's final going over, and I noticed the following
in icom_init():

+	if (ret < 0) {
+		pci_unregister_driver(&icom_pci_driver);
+		uart_unregister_driver(&icom_uart_driver);
+	}

If pci_register_driver() fails in 2.6, you must not call
pci_unregister_driver.

I think there may be issues concerning the firmware in the .h file.
Can you give any information about the licensing policy on it please?
It may need to use the kernels firmware loader (for more info on that
see drivers/base/firmware_class.c)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
