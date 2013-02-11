From: claudio@evidence.eu.com
Subject: [PATCH] atmel_serial: general fixes for RS485 and TTGR
Date: Mon, 11 Feb 2013 16:54:23 +0100
Message-ID: <1360598067-3577-1-git-send-email-claudio@evidence.eu.com>
References: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mr001msb.fastweb.it ([85.18.95.85]:54632 "EHLO
	mr001msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757086Ab3BKQAw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 11:00:52 -0500
In-Reply-To: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: nicolas.ferre@atmel.com, clagix@gmail.com

Dear Guido.

I agree about splitting the patch. Therefore, I've created the following patchset which

 - Adds the unit of measure (i.e., milliseconds) in the documentation
   serial-rs485.txt (it is already available in the header file).

 - Sets RS485 delays using msleep (as in the cris driver) rather than using
   TTGR.

 - Adds an entry in sys/ to get/set the TTGR register for this specific driver.

Have you tested the msleep part ?

Best regards,

	Claudio
