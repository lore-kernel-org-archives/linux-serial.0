From: Vijaymahantesh Kalakoti <vijayck@sasken.com>
Subject: remote serial console problem
Date: Tue, 27 Apr 2004 13:18:48 +0530 (IST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.30.0404271306500.13975-100000@sunops2.sasken.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [164.164.56.19] ([164.164.56.19]:57396 "EHLO mail1.sasken.com")
	by vger.kernel.org with ESMTP id S263884AbUD0Hsw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Apr 2004 03:48:52 -0400
Received: from sunops2.sasken.com (localhost [127.0.0.1])
	by mail1.sasken.com (8.12.10/8.12.10) with ESMTP id i3R7nHf0006935
	for <linux-serial@vger.kernel.org>; Tue, 27 Apr 2004 13:19:17 +0530 (IST)
Received: from sunops2.sasken.com (sunops2.sasken.com [10.1.16.2])
	by sunops2.sasken.com (8.12.10/) with ESMTP id i3R7mmss023158
	for <linux-serial@vger.kernel.org>; Tue, 27 Apr 2004 13:18:48 +0530 (IST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi all,

I have configured the /etc/inittab file on PC1 to run agetty on one of the
serial port( ttyS0 ).

PC1( /etc/inittab configured ) <---------> PC2( Running my program )

Now PC1 getty is not in logged in state.  I send logout command
from PC2 to PC1.

The PROBLEM is :
	1. I see that sometimes it echoes back logout command what i had
sent & sometimes it doesn't echo back ( echoes only "lo" ).

	Please explain me why this is happening.

-----------------------------------
Thanks & Regards
vijay kalkoti
-----------------------------------


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
