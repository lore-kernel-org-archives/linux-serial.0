From: "Thomas Meyer" <thomas.mey@web.de>
Subject: 2.6.12-rc1-mm3: module loop in serial_core and 8250
Date: Fri, 25 Mar 2005 23:13:35 +0100
Message-ID: <1619542239@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from fmmailgate05.web.de ([217.72.192.243]:19166 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP id S261836AbVCYWNk
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2005 17:13:40 -0500
Received: by fmmailgate05.web.de (8.12.10/8.12.10/webde Linux 0.7) with SMTP id j2PMDGO0028266
        for linux-serial@vger.kernel.org; Fri, 25 Mar 2005 23:13:36 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Is this a known problem?

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  2.6.12-rc1-mm3; fi
WARNING: Module /lib/modules/2.6.12-rc1-mm3/kernel/drivers/serial/serial_core.ko ignored, due to loop
WARNING: Module /lib/modules/2.6.12-rc1-mm3/kernel/drivers/serial/8250_pnp.ko ignored, due to loop
WARNING: Module /lib/modules/2.6.12-rc1-mm3/kernel/drivers/serial/8250_pci.ko ignored, due to loop
WARNING: Loop detected: /lib/modules/2.6.12-rc1-mm3/kernel/drivers/serial/8250.ko needs serial_core.ko which needs 8250.ko again!
WARNING: Module /lib/modules/2.6.12-rc1-mm3/kernel/drivers/serial/8250.ko ignored, due to loop


______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193

