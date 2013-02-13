From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: What to set uart_port->irq to for polled driver?
Date: Wed, 13 Feb 2013 15:24:26 +0000 (UTC)
Message-ID: <kfgb7a$gl2$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47535 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934098Ab3BMPYn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 10:24:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1U5eCh-0001xm-Je
	for linux-serial@vger.kernel.org; Wed, 13 Feb 2013 16:24:59 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 13 Feb 2013 16:24:59 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 13 Feb 2013 16:24:59 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

For a polled serial driver that doesn't use interrupts, to what should
the "irq" field in the uart_port structure be set?  Should it be 0?
Should it be the unused IRQ associated with the PCI card slot in which
the board is found?

-- 
Grant Edwards               grant.b.edwards        Yow! MERYL STREEP is my
                                  at               obstetrician!
                              gmail.com            

