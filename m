From: Jerzy Tryjarski <jurekt@pkp.com.pl>
Subject: IP over X.25 via asynchrous RS232
Date: Tue, 19 Aug 2003 13:45:56 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3F420DF4.20000@pkp.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from antybiotyk.tktelekom.pl ([213.199.225.22]:61444 "EHLO
	smtp.tktelekom.pl") by vger.kernel.org with ESMTP id S269509AbTHSJpu
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2003 05:45:50 -0400
Received: (from root@localhost)
	by smtp.tktelekom.pl (8.12.9/8.12.5) id h7J9jn8p027055
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2003 11:45:49 +0200
Received: from pkp.com.pl ([172.23.11.118])
	by smtp.tktelekom.pl (8.12.9/8.12.5) with ESMTP id h7J9jlJJ026801
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2003 11:45:48 +0200
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
  I want to connect my PC under linux RH 9 with e-mail server  via X.25 
packet network using standard asynchrous rs232 interface in my PC ( 
without aditional hardware ).
 
IP datagrams are encapsulated inside packets on an X.25 virtual circuit.

Mail server is connected to X.25 network via Cisco router. So I use the 
IETF standard encapsulation, as specified by RFC 1356, set X.121 
address, set IP address and I map between X.121 address and IP address.

Finaly in my PC It must be additional software for rs232 and user 
application to be abble to configure the interface with such as 
functions as assigning IP address, assigning X.121 address, mapping, pad 
and other specific for X.25 network functions.

Can anybody recommend the best solution ?

Jurek


