From: Chris Budd <budorola@gmail.com>
Subject: 2.4.21: Sharing interrupts with serial console
Date: Wed, 3 Aug 2005 18:36:51 -0700
Message-ID: <92fc8b8105080318367f77fed1@mail.gmail.com>
Reply-To: Chris Budd <budorola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:24868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261738AbVHDBgy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Aug 2005 21:36:54 -0400
Received: by zproxy.gmail.com with SMTP id r28so168148nza
        for <linux-serial@vger.kernel.org>; Wed, 03 Aug 2005 18:36:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

I have read http://www.tldp.org/HOWTO/Remote-Serial-Console-HOWTO/preparation-setport.html
and http://www.linux-mips.org/archives/linux-mips/2004-04/msg00134.html
and other items, but I still have not found the answers to the
following questions:

1.  The rs_init function in ./linux-2.4.21/drivers/char/serial.c
explicitly states "The interrupt of the serial console port can't be
shared."  Does this include *ALL* interrupts?  The code checks for
sharing only with other serial devices, not *ALL* types of devices
like I2C, RTC, etc.

2.  While the presence of the comment about not sharing was nice, it
does not explain "why?"  Why can't we share the serial console
interrupt?  The serial console seems to work when I alter serial.c to
skip this check for the sharing of interrupts with the serial console.

3.  Does the hardware platform matter?  We are running Linux 2.4.21 on
an embedded XScale(ARM)-based board.

Thanks,
Chris.
