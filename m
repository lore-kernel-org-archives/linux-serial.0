From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: Serial console UART confusion after machine S3 suspend and resume
Date: Thu, 03 Feb 2005 18:16:10 +0100
Message-ID: <42025C5A.7070709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from pop.gmx.de ([213.165.64.20]:55447 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263205AbVBCRPn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Feb 2005 12:15:43 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

on resume from S3, my serial console prints garbage and stops working.
If I disconnect the console while my machine is sleeping and reconnect
immediately after, the serial console still prints garbage on resume
but the follwowing command on my machine fixes the output for all
subsequent kernel messages sent to the serial console.

echo foo >/dev/ttyS0

Nothing besides outputting something to ttyS0 helps. Disconnecting
and reconnecting, both logically and physically, doesn't have any
positive effect.

Could it be that the UART state is out-of-sync or something like that
after resume and the serial console code doesn't notice, but the
"normal" serial code notices and fixes things up?

Are there any debugging options/patches/tips to find out what happens
exactly? The machine works just fine after resume, so I could read
dmesg for debugging output.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
