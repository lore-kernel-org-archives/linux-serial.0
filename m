From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: 9-bit mode
Date: Wed, 18 Jun 2014 12:51:35 +0400
Message-ID: <lnrjun$dps$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34152 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934104AbaFRIvu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Jun 2014 04:51:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WxBat-0001wo-3r
	for linux-serial@vger.kernel.org; Wed, 18 Jun 2014 10:51:47 +0200
Received: from 158.250.29.172 ([158.250.29.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 18 Jun 2014 10:51:47 +0200
Received: from matwey.kornilov by 158.250.29.172 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 18 Jun 2014 10:51:47 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

Not sure, that it is a right place to ask. I would like to ask about 
status of 9-bit mode in the kernel.

Some uart-devices support 9-bit mode. AFAIU the most challenging part is 
user-space termios api.

I've found two patches in this list:

http://marc.info/?l=linux-serial&m=125856076927911&w=2
http://marc.info/?l=linux-serial&m=125856099128385&w=2

However, they are neither accepted nor commented. Is it because of wrong 
submission format?

