From: Martin Qiu <martin_sjtu@yahoo.com.cn>
Subject: Question about IO/MMIO check in uart_configure_port() in serial_core.c
Date: Sun, 22 Mar 2009 11:01:41 +0800 (CST)
Message-ID: <158785.33395.qm@web15804.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web15804.mail.cnb.yahoo.com ([202.165.102.84]:42651 "HELO
	web15804.mail.cnb.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751280AbZCVDI1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Mar 2009 23:08:27 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


In uart_configure_port(), there is code:
        /*
         * If there isn't a port here, don't do anything further.
         */
        if (!port->iobase && !port->mapbase && !port->membase)
                return;

Actually, there is some UART devices over SPI interface, which don't ha=
ve IO spcae or MMIO registers which could be directly accessed, like Ma=
xim's 3100/3110/3111E. Further on, there may be UART devices over I2C.

These check may block those device from been correctly configured in li=
nux, or they have to fake out a iobase or mapbase.. to pass this check,=
 so my question is can these check re removed?

Thanks,
Martin


      ___________________________________________________________=20
  =BA=C3=CD=E6=BA=D8=BF=A8=B5=C8=C4=E3=B7=A2=A3=AC=D3=CA=CF=E4=BA=D8=BF=
=A8=C8=AB=D0=C2=C9=CF=CF=DF=A3=A1=20
http://card.mail.cn.yahoo.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
