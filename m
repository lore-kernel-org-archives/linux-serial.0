From: Jiri Slaby <jirislaby@gmail.com>
Subject: [UART] Why CAP_SYS_ADMIN can open non-started port?
Date: Wed, 17 Aug 2011 11:25:27 +0200
Message-ID: <4E4B8907.8030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50538 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab1HQJZb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Aug 2011 05:25:31 -0400
Received: by fxh19 with SMTP id 19so517544fxh.19
        for <linux-serial@vger.kernel.org>; Wed, 17 Aug 2011 02:25:30 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>, linux@arm.linux.org.uk

Hi,

while I was in the process of uart cleanup, I found this:
static int uart_startup(...) {
  ...
  retval = port->ops->startup(port);
  ...
  if (retval && capable(CAP_SYS_ADMIN))
    retval = 0;

  return retval;
}

Why CAP_SYS_ADMIN should not see the failing port startup? Does anybody
from you remember if it is for some kind of possibility to later
re-autoconfigure the port or something like that?

thanks,
-- 
js
