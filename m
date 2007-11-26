From: Javier Herrero <jherrero@hvsistemas.es>
Subject: 8250 driver patch for Blackfin platforms
Date: Mon, 26 Nov 2007 03:00:43 +0100
Message-ID: <474A28CB.5070902@hvsistemas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zm1.veloxia.com ([213.149.227.2]:42384 "HELO zm1.veloxia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753640AbXKZCH0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Nov 2007 21:07:26 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I had modified the 8250.c driver as follows for Blackfin uClinux. Robin 
Getz had suggested me that this patch should be sumitted upstream. I 
hope that this is is the right way.

Regards,

Javier

--- trunk/drivers/serial/8250.c	2007-11-25 22:05:33 UTC (rev 3932)
 +++ trunk/drivers/serial/8250.c	2007-11-25 22:08:02 UTC (rev 3933)
 @@ -92,7 +92,9 @@
   */
  #define CONFIG_HUB6 1
  
 +#ifndef CONFIG_BLACKFIN
  #include <asm/serial.h>
 +#endif
  
  /*
   * SERIAL_PORT_DFNS tells us about built-in ports that have no
 @@ -1544,6 +1546,10 @@
  		i->head = &up->list;
  		spin_unlock_irq(&i->lock);
  
 +#ifdef CONFIG_BLACKFIN
 +		irq_flags |= IRQF_TRIGGER_HIGH;
 +#endif
 +
  		ret = request_irq(up->port.irq, serial8250_interrupt,
  				  irq_flags, "serial", i);
  		if (ret < 0)




-- 
------------------------------------------------------------------------
Javier Herrero                            EMAIL: jherrero@hvsistemas.com
HV Sistemas S.L.                          PHONE:         +34 949 336 806
Los Charcones, 17A                        FAX:           +34 949 336 792
19170 El Casar - Guadalajara - Spain      WEB: http://www.hvsistemas.com 

