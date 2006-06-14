From: Adrian Cox <adrian@humboldt.co.uk>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Wed, 14 Jun 2006 15:25:28 +0100
Message-ID: <1150295128.6552.35.camel@localhost.localdomain>
References: <9FCDBA58F226D911B202000BDBAD4673069C3C3D@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.humboldt.co.uk ([80.68.93.146]:60938 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S964997AbWFNPLo
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Jun 2006 11:11:44 -0400
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673069C3C3D@zch01exm40.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Alexandre.Bounine@tundra.com, linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>

On Tue, 2006-06-13 at 13:39 +0800, Zang Roy-r61911 wrote:

> The reason is that the serial port on tsi108/9 is a bit difference with the 
> standard 8250 serial port. the patch deal with the difference.
> The prefixed ">" is caused by "Fw" the email. Sorry for that. The following 
> is the original patch.

The problem I see is that the code uses a CONFIG option, to change the
behaviour of the generic 8250 driver. What happens if somebody adds a
PCI serial card to a tsi108 based machine?

Perhaps you should define a new value for uart_8250_port.port.iotype,
and add code to serial_in and serial_out to handle the IIR register.

-- 
Adrian Cox <adrian@humboldt.co.uk>

