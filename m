From: =?koi8-r?Q?=22?=Grigorii Rubtsov=?koi8-r?Q?=22=20?=
	<grigoriir@mail.ru>
Subject: (unknown)
Date: Sun, 21 Dec 2003 16:39:09 +0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <E1AY3nZ-000PIZ-00.grigoriir-mail-ru@f9.mail.ru>
Reply-To: =?koi8-r?Q?=22?=Grigorii Rubtsov=?koi8-r?Q?=22=20?=
	  <grigoriir@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from f9.mail.ru ([194.67.57.39]:15117 "EHLO f9.mail.ru")
	by vger.kernel.org with ESMTP id S262965AbTLUNjK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Dec 2003 08:39:10 -0500
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org



  Dear Developers.

There is a misprint in linux-2.6.0/drivers/serial/Kconfig file concerning 8250 driver

/drivers/serial/Kconfig states

   config SERIAL_8250
             ........................
   	     To compile this driver as a module, choose M here: the
 	     module will be called serial.

But in real world the module is called 8250 (but not serial). This misprint can lead to confusion. (user will not find desired module)

Best regards,
Grigory Rubtsov.

