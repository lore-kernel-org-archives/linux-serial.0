From: Benjamin Krill <ben@codiert.org>
Subject: Re: [PATCH] Add support for the nwp serial device
Date: Sun, 23 Nov 2008 22:46:11 +0100
Message-ID: <20081123214611.GS24487@codiert.org>
References: <200811201501.24000.arnd@arndb.de> <20081121132244.e9e9fd74.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cursor.subgra.de ([78.46.252.50]:47753 "EHLO cursor.subgra.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbYKWVqQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 23 Nov 2008 16:46:16 -0500
Content-Disposition: inline
In-Reply-To: <20081121132244.e9e9fd74.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org

* Andrew Morton | 2008-11-21 13:22:44 [-0800]:

>(does a powerpc allmodconfig)
>
>drivers/serial/nwpserial.c:443: warning: data definition has no type or storage class
>drivers/serial/nwpserial.c:443: warning: type defaults to 'int' in declaration of 'console_initcall'
>drivers/serial/nwpserial.c:443: warning: parameter names (without types) in function declaration
>drivers/serial/nwpserial.c:400: warning: 'nwpserial_console_init' defined but not used
>
>The file fails to include linux/init.h.  It should do so, but that
>doesn't fix the above.
>
>Apparently it hasn't been tested as a kernel module...

Console support doesn't work when the driver is build as module, all
other serial drivers did this with a further configuration option. Will
send an updated patch which fixes this and the other issues.
