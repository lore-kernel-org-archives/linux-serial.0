From: Pete Murray <pmurray@dawning.com>
Subject: SC16is752 I2c driver
Date: Tue, 22 Feb 2011 09:28:26 -0500
Message-ID: <4D63C80A.3070005@dawning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.dawning.com ([63.247.149.203]:2666 "EHLO mail.dawning.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab1BVOfP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Feb 2011 09:35:15 -0500
Received: from [10.10.100.168] by mail.dawning.com
	(MDaemon PRO v9.5.4)
	with ESMTP id 52-md50000007913.msg
	for <linux-serial@vger.kernel.org>; Tue, 22 Feb 2011 09:28:27 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I wrote an I2C  driver for the SC16is752 dual Uart chip, I see there is 
an SPI version now.  There was no SPI version when I was developing, if 
there was I would have tried to add I2C support to that driver instead.  
Is this something I should post for review, or should I work on adding 
support to the existing SPI version? 

Thanks
Pete

