From: Guenter Roeck <linux@roeck-us.net>
Subject: Commit f7d2c0bb (serial: i.MX: evaluate linux,stdout-path property)
 and resulting build errors
Date: Wed, 2 Oct 2013 21:56:11 -0700
Message-ID: <20131003045611.GA17921@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64979 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727Ab3JCE4R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Oct 2013 00:56:17 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so2038567pab.22
        for <linux-serial@vger.kernel.org>; Wed, 02 Oct 2013 21:56:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Jiri Slaby <jslaby@suse.cz>

Hi all,

Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
built as module, yet add_preferred_console() is not exported on any platform.
This is one reason why arm:allmodconfig fails to build on the upstream kernel.

What is the best solution ? Should imx.c not be buildable as module anymore ?

Guenter
