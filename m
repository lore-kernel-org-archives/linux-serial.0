From: Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH] tty: serial: vt8500: Fix clock code in probe
Date: Sat,  9 Mar 2013 18:44:36 +1300
Message-ID: <1362807877-23263-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:60738 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3CIFoe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Mar 2013 00:44:34 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: vt8500-wm8505-linux-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>

Hi Greg,

Looks like there was some kind of copy-paste messup in the probe function
which has resulted in some incorrect code being left after the conversion from
a fixed 24Mhz reference to a clock based driver.

This patch tidies up the initialization in probe() of the clock related bits.

Regards
Tony Prisk

Tony Prisk (1):
  tty: serial: vt8500: Unneccessary duplicated clock code removed

 drivers/tty/serial/vt8500_serial.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
1.7.9.5

