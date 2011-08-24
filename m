From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty: 8250_dw: fix build error for CONFIG_SERIAL_8250=m
Date: Wed, 24 Aug 2011 16:45:16 +0200
Message-ID: <201108241645.16377.arnd@arndb.de>
References: <1314169906-12958-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57670 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1HXOpW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Aug 2011 10:45:22 -0400
In-Reply-To: <1314169906-12958-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>

On Wednesday 24 August 2011, Jamie Iles wrote:
> Allow 8250_dw to be built as a module and export serial8250_handle_irq
> so that 8250 can still be built as a module.  This prevents the
> following build failure:
> 
> drivers/built-in.o: In function `dw8250_handle_irq':
> 8250_dw.c:(.text+0xcad9c): undefined reference to `serial8250_handle_irq'

I think this won't fix the bug that Stephen was reporting, it will only
make the error message go away but it won't work in the end: When
CONFIG_SERIAL_8250_DW is set to 'm', the declaration of
serial8250_use_designware_io now gets stubbed out from of_serial.ko,
meaning that the 8250_dw module becomes useless.

At the very least you also need to export the serial8250_use_designware_io
symbol and check for CONFIG_SERIAL_8250_DW_MODULE in the header.

When go go to such length, I think the approach I initially advocated
(making 8250_dw a standalone platform_driver like of_serial) will be
nicer.

Another alternative would be to link 8250_dw.o into 8250.ko, but that
requires renaming the module and will conflict with some of the other
changes I'm still planning to do with the 8250 driver.

	Arnd
