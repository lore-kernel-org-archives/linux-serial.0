From: Peter Hurley <peter@hurleysoftware.com>
Subject: man termios
Date: Thu, 20 Mar 2014 14:42:25 -0400
Message-ID: <532B3691.1070602@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:54212 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757067AbaCTSm3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Mar 2014 14:42:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Ivan <athlon_@mail.ru>

Hi Michael,

Some issues have arisen [1] regarding a discrepancy between the Linux behavior of
read() on a tty and 'man termios' and 'Linux Programming Interface', Chapter 62.

Firstly, if MIN==0 and TIME==0 and no input is available, read() returns 0,
even if O_NONBLOCK is set. This is also true of the other non-canonical read()'s with
timeout (TIME > 0).

'man termios' is silent here, but 62.6.2 in LPI implies that O_NONBLOCK will return
-1 with errno==EAGAIN; it does not.

This is unspecified by POSIX (11.1.7).

Secondly, in all 4 of the non-canonical read() modes, the MIN value does not limit
the number of bytes which may be returned by the read(). Only the 'count' parameter
to read() has this effect.

LPI has this to say (man-pages reads similar):

"MIN > 0, TIME == 0 (blocking read)

The read() blocks (possibly indefinitely) until the lesser of the number of bytes
requested or MIN bytes are available, and returns the lesser of the two values."

However, read() may unblock when MIN bytes are available but return up to the
'count' parameter if more input arrives in between waking and copying into the
user buffer.

So, for example, if MIN == 5,

   n = read(tty, &buffer, 30 /*sizeof(buffer)*/)

n may be up to 30 on return.

Finally, if the 'count' parameter is less than MIN, read() may return before MIN
bytes have been received, if 'count' bytes have been received.

Regards,
Peter Hurley

[1] https://bugzilla.kernel.org/show_bug.cgi?id=71671
