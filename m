From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
Date: Fri, 06 Dec 2013 14:34:17 +0400
Message-ID: <1386326057.7152.44.camel@host5.omatika.ru>
References: <20131205043544.GA28580@kroah.com>
	 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
	 <20131206000253.GC21358@kroah.com>
	 <20131206001728.GJ4360@n2100.arm.linux.org.uk>
	 <1386322131.7152.36.camel@host5.omatika.ru>
	 <20131206095345.GQ16425@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:60827 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab3LFKeW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Dec 2013 05:34:22 -0500
In-Reply-To: <20131206095345.GQ16425@us.netrek.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: James Cameron <quozl@laptop.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Crispin <blogic@openwrt.org>, Jiri Slaby <jslaby@suse.cz>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Zhou Zhu <zzhu3@marvell.com>

On Fri, 2013-12-06 at 20:53 +1100, James Cameron wrote:
> I don't understand why /dev/ttyS2 (4,66) changed to /dev/ttyS0 (4,64)
> after the patch was applied to olpc-kernel/arm-3.5 but, as you say it
> doesn't change, perhaps there is something between 3.5 and now for me
> to watch out for.  My problem.

The old pxa.c set device ids explicitly:
-static int serial_pxa_probe_dt(struct platform_device *pdev,
-                              struct uart_pxa_port *sport)
-{
-       struct device_node *np = pdev->dev.of_node;
-       int ret;
-
-       if (!np)
-               return 1;
-
-       ret = of_alias_get_id(np, "serial");
-       if (ret < 0) {
-               dev_err(&pdev->dev, "failed to get alias id, errno %d
\n", ret);
-               return ret;
-       }
-       sport->port.line = ret;
-       return 0;
-}

and

-       ret = serial_pxa_probe_dt(dev, sport);
-       if (ret > 0)
-               sport->port.line = dev->id;


However, this is not possible with 8250_core. The latter assigns device
ids strictly in the call order of serial8250_register_8250_port().

Hope it helps.

