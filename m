From: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Date: Fri, 15 Apr 2005 20:10:54 +0400
Message-ID: <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
References: <20050415151053.GM5456@stusta.de>
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from f13.mail.ru ([194.67.57.43]:27917 "EHLO f13.mail.ru")
	by vger.kernel.org with ESMTP id S261846AbVDOQKw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Apr 2005 12:10:52 -0400
In-Reply-To: <20050415151053.GM5456@stusta.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005 17:10:53 +0200, Adrian Bunk wrote:

> This patch fixes the following warning:

>   CC      drivers/serial/8250_acpi.o
> drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> drivers/serial/8250_acpi.c:51: warning: implicit declaration of function `acpi_register_gsi'

> --- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old
> +++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c

> +#include <linux/config.h>

drivers/serial/8250_acpi.c doesn't use CONFIG_ symbols.
