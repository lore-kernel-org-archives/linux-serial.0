From: "Dominik Wilczynski" <dominik.wilczynski@s3group.com>
Subject: PROBLEM: linux serial rs-232 bug when open()
Date: Wed, 28 Sep 2005 13:27:52 +0200
Message-ID: <200509281127.NAA14222@s3group.com.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ormo.s3group.com.pl ([212.160.116.194]:2482 "EHLO
	ormo.s3group.com.pl") by vger.kernel.org with ESMTP
	id S1751219AbVI1L2A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Sep 2005 07:28:00 -0400
Received: from s3group.com.pl ([192.168.88.1])
        by ormo.s3group.com.pl  with ESMTP id j8SBQYuU022930
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2005 13:26:35 +0200 (CEST)
Received: from TURNAL (turnal.wroclaw.ad.s3group.com [192.168.88.63])
        by s3group.com.pl  with ESMTP id NAA14222
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2005 13:27:52 +0200 (MET DST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
 
I'm doing embedded development with rs-232 interface and I noticed a bug in
serial driver. When I open ttySx device, open() function returns 0 instead
of proper file descriptor. I have to perform open() twice before I get exact
file descriptor. 
 
Some guys were discussing similar bug:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0104.2/0830.html
 
I use kernel 2.6.11.4-20a-default on SUSE 9.3 disctribution. If you would
like to have more details on this, please let me know and I 'll send you
description of my configuration.
 
Best Regards,
 
 
Dominik Wilczynski
-----------------------------------------
Software Design Engeneer
 
dominik.wilczynski@s3group.com
 
Silicon & Software Systems
www.s3group.com


The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
