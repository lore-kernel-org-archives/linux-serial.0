From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: Re: [PATCH  00/12] Serial : sc26xx - generalize and support SC2892
Date: Sat, 20 Feb 2010 18:55:19 +0100
Message-ID: <4B802207.4080309@gmail.com>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net> <20100215170958.GA13994@alpha.franken.de>
Reply-To: mfuzzey@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:21324 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756763Ab0BTRzW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Feb 2010 12:55:22 -0500
Received: by ey-out-2122.google.com with SMTP id 9so394162eyd.5
        for <linux-serial@vger.kernel.org>; Sat, 20 Feb 2010 09:55:21 -0800 (PST)
In-Reply-To: <20100215170958.GA13994@alpha.franken.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-serial@vger.kernel.org

Thomas Bogendoerfer wrote:
> there shouldn't be many users of this driver, it's probably just me...
> So changing names is ok for me.
>
>   
> I'm fine with pushing your changes, if there are regression for
> RM system I'll take care later.
>
> Just add my Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> to your patches.
>
> Thomas.
>
>   
Great thank you,

Can I also have an Ack for this additional patch:


Author: Martin Fuzzey <mfuzzey@gmail.com>
Date:   Sat Feb 20 18:47:06 2010 +0100

    Serial: sc26xx - Use ttySC0 instead of ttySC205
   
    Use device name ttySC0 as per Documentation/devices.txt

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 2e17bbc..9b0ede0 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -918,8 +918,6 @@ static int __devinit sc26xx_probe(struct
platform_device *dev)
        if (err)
                goto out_free_port;
 
-       sc26xx_reg.tty_driver->name_base = sc26xx_reg.minor;
-
        err = uart_add_one_port(&sc26xx_reg, &up->port[0]);
        if (err)
                goto out_unregister_driver;



If this is OK with you I'll repost the whole series with your acks and a
rename patch to sc2xxx

Cheers,

Martin


