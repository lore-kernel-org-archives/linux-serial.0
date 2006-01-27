From: Rub=?ISO-8859-1?B?6Q==?=n Navarro Huedo <eb5esx@eb5esx.ampr.org>
Subject: 2 Applications using data from one serial port
Date: Fri, 27 Jan 2006 17:53:35 +0100
Message-ID: <C0000E9F.1AAA%eb5esx@eb5esx.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ea5cee.ampr.org ([44.133.3.22]:49852 "EHLO cabodesantapola.org")
	by vger.kernel.org with ESMTP id S1751129AbWA0Qw4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jan 2006 11:52:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by cabodesantapola.org (Postfix) with ESMTP id 6A89417CC5F
	for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2006 17:52:55 +0100 (CET)
Received: from cabodesantapola.org ([44.133.3.22])
	by localhost (cabodesantapola.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14129-10 for <linux-serial@vger.kernel.org>;
	Fri, 27 Jan 2006 17:52:53 +0100 (CET)
Received: from [10.0.0.2] (84-120-168-239.onocable.ono.com [84.120.168.239])
	by cabodesantapola.org (Postfix) with ESMTP id B0BF217CC5A
	for <linux-serial@vger.kernel.org>; Fri, 27 Jan 2006 17:52:52 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello friends:
My name is Ruben and i am from Spain.
I am running a weather web site under Linux.
A weather station is connected to the server using a serial port.
At this moment i am using wx200 like weather software, but i am thinkin=
g to
migrate to another one.
What i need is to can test the new software some time.
But...if the new Software tries access serial port, the other one (wx20=
0d)
software stops receiving.
Applications only have to receive data from serial port, don't send
anything.
I have been thinking to do some pipe from the physical /dev/ttyS0 to 2
serial pipes (ptyt0 and ptyt1) but i don't know how.
Please...could you help me?
I have been some weeks trying solve the problem without good result.

A lot of thank's

--=20
Rub=E9n Navarro Huedo
http://www.palotes.com
http://www.cabodesantapola.org



-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
