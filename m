From: Kevin Wilson <Kevin.Wilson@comtrol.com>
Subject: tty_flip.h needs mention of need for tty_flip_buffer_push call ..
	.
Date: Mon, 9 Oct 2006 12:16:13 -0500
Message-ID: <DD5056872F0E6A4EB8555318C3F8BCB00B65AB@exchange-2.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exchange-2.comtrol.com ([204.73.219.38]:29449 "EHLO
	Exchange-2.comtrol.com") by vger.kernel.org with ESMTP
	id S932987AbWJIRQR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Oct 2006 13:16:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

to free memory allocated. If the function is not called in place of 
ld->receive_buf(tty, chead, fhead, count). ld->receive_buf call doesn't 
deallocate the memory.

Also Note:

Our tests show the memory leak fix posted by Paul Fulghum at
http://lkml.org/lkml/2006/6/10/132 experiences data errors. They 
also show that if the first implementation is simply modified to have
tty_flip_buffer_push called instead of ld->receive_buf you will 
have a working driver.
