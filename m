From: =?UTF-8?q?Ky=C3=B6sti=20M=C3=A4lkki?= <kyosti.malkki@gmail.com>
Subject: usb: gadget: Fixes to receive from USB EHCI Debug
Date: Mon,  3 Nov 2014 17:18:03 +0200
Message-ID: <1415027885-2181-1-git-send-email-kyosti.malkki@gmail.com>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:51099 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbaKCPSl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Nov 2014 10:18:41 -0500
In-Reply-To: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-serial@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org

USB gadget driver dbgp can be used as an EHCI debug dongle in replaceme=
nt
for product like Net20DC. With it one can receive early kernel messages
from remote targets over USB. See parameter earlyprintk=3Ddbgp for targ=
et
kernel requirements and configuration.
=20
The two patches are required for dbgp gadget driver to work. Longterm
plan: I think G_DBGP_PRINTK is an odd hack and could be removed.
Exposing the debug descriptor can be implemented in cdc_acm so that we
could seemlessly reconfigure endpoint from the 8 byte payload limitatio=
n
EHCI Debug Port has, to 512 bytes, once ehci-hcd with DMA is available.


Handling of the termios CLOCAL flag calls for some discussion and I am
not that familiar with the tty infra u_serial uses. See the previous
change around gserial_disconnect():
  http://permalink.gmane.org/gmane.linux.usb.general/4260

Regards,
  Ky=C3=B6sti
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
