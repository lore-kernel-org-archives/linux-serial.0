From: Vijaymahantesh Kalakoti <vijayck@sasken.com>
Subject: Remote serial port configuration.
Date: Thu, 4 Mar 2004 20:33:58 +0530 (IST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0403042021001.5144-100000@pcz-vijayck.sasken.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [164.164.56.19] ([164.164.56.19]:972 "EHLO mail1.sasken.com")
	by vger.kernel.org with ESMTP id S261926AbUCDPED (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Mar 2004 10:04:03 -0500
Received: from sunops2.sasken.com (localhost [127.0.0.1])
	by mail1.sasken.com (8.12.10/8.12.10) with ESMTP id i24F49jx001566
	for <linux-serial@vger.kernel.org>; Thu, 4 Mar 2004 20:34:10 +0530 (IST)
Received: from pcz-conf107.sasken.com (pcz-conf107.sasken.com [10.1.100.107])
	by sunops2.sasken.com (8.12.10/) with ESMTP id i24F3wUV024813
	for <linux-serial@vger.kernel.org>; Thu, 4 Mar 2004 20:33:58 +0530 (IST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi all,

I have connected two pc's through serial port. And one of the pc is 
configured to run a terminal on the serial port( ttyS0 ) by configuring 
the getty to run on serial port. 

I have written a program to send the username & password from the other 
computer. The configuration of serial port on both the systems are same.

But I am not able to login to the system. But when I give a delay 1/100 th 
of a second or more between sending of username & password, then it is 
getting logging into the system.

Can I log in without introducing any delays?

Pls help me in this regard.

Thanks & regards
vijay kalkoti
-- 


--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

***********************************************************************

********************************************************************

SASKEN BUSINESS DISCLAIMER

This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.

***********************************************************************

--=_IS_MIME_Boundary--
