From: Jerzy Tryjarski <jurekt@pkp.com.pl>
Subject: IP over X.25, Cisco
Date: Mon, 18 Aug 2003 15:13:03 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3F40D0DF.9060802@pkp.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from antybiotyk.tktelekom.pl ([213.199.225.22]:27656 "EHLO
	smtp.tktelekom.pl") by vger.kernel.org with ESMTP id S271384AbTHRLM6
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2003 07:12:58 -0400
Received: (from root@localhost)
	by smtp.tktelekom.pl (8.12.9/8.12.5) id h7IBCv6F001886
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2003 13:12:57 +0200
Received: from pkp.com.pl ([172.23.11.118])
	by smtp.tktelekom.pl (8.12.9/8.12.5) with ESMTP id h7IBCtJJ001767
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2003 13:12:56 +0200
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
  I want to connect my PC under linux RH 9 with e-mail server  via X.25 
packet network.
                                                                                                                        
 
IP datagrams are encapsulated inside packets on an X.25 virtual circuit.
                                                                                                                        
 
Mail server is connected to X.25 network via Cisco router. So I use the 
IETF standard encapsulation, as specified by RFC
1356, set X.121 address, set IP address and I map between X.121 address 
and IP address.
                                                                                                                        
 
Finaly in my pc It must be additional software for rs232 and user 
application to be abble to configure the interface with such as 
functions as assigning IP address, assigning X.121 address, mapping, pad 
and other specific for X.25 network functions.
                                                                                                                        
 
Are there products just for Linux ?
                                                                                                                        
 
Can anybody recommend the best solution ?
                                                                                                                        
 
Jurek


