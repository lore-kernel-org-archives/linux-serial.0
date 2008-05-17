From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: CONFIG_CONSOLE_POLL
Date: Sat, 17 May 2008 19:07:45 -0400
Message-ID: <482F6541.8080702@dlasys.net>
Reply-To: dhlii@dlasys.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outbound-mail-17.bluehost.com ([69.89.20.232]:59748 "HELO
	outbound-mail-17.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754836AbYEQXOV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 May 2008 19:14:21 -0400
Received: from [72.25.59.47] (helo=hp-dhlii.dlasys.lcl)
	by host200.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dhlii@dlasys.net>)
	id 1JxVV7-0001Zm-6Z
	for linux-serial@vger.kernel.org; Sat, 17 May 2008 17:07:41 -0600
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

    One more try.

    Is CONFIG_CONSOLE_POLL intended to be used to implement general
irqless serial functionality,
     such as for serial ports that have no irq,
    or is it more narrowly intended just for serial IO inside of an IRQ
or dduring debugging ?




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

