From: christian pellegrin <chripell@gmail.com>
Subject: [PATCH -mm 0/1] max3100: Fixes for the MAX31x0 console
Date: Thu, 8 Apr 2010 19:02:13 +0200
Message-ID: <g2qcabda6421004081002o97fec27fx1cc4640164930608@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:51754 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932576Ab0DHRCc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Apr 2010 13:02:32 -0400
Received: by bwz1 with SMTP id 1so1953017bwz.21
        for <linux-serial@vger.kernel.org>; Thu, 08 Apr 2010 10:02:30 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Feng Tang <feng.tang@intel.com>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.or

This patch fixes the problems reported by Feng Tang in the console
code. After this I intend to do a complete rework to apply the ideas
outlined by Grant Likely to avoid the use of delayed work and, if I
find a way, the batching of TX requests proposed by Feng Tang and Alan
Cox (I guess I will have at least to add a new function to the SPI
core to know the real bit/rate the system is using to make this work).
The relevant patches from the -mm kernel were tested on a 2.6.34-rc2
kernel on a S3C ARM machine. This patch ris based on them.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
