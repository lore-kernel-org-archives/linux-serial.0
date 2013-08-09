From: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Subject: Buffer overflow concerns when TTY_THRESHOLD_THROTTLE <= Uart FIFO
 size of the sending side
Date: Fri, 9 Aug 2013 16:08:31 -0500
Message-ID: <CAES2cWzqgKmCT7Uy-4dqrgNeq1W0LeBH5A=y7D+OX8cnBuM-rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:40901 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031125Ab3HIVIv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Aug 2013 17:08:51 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so2732711obp.36
        for <linux-serial@vger.kernel.org>; Fri, 09 Aug 2013 14:08:51 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

When using software-level RTS/CTS flow control (or Xon/Xoff), we could
leak at most the UART FIFO size of bytes after getting the flow
control signal. This is because the bytes might be loaded in the FIFO
when the flow control signal comes through and the UART will send them
out the wire.

Consider a case where I have a UART with a 128 byte FIFO. The
TTY_THRESHOLD_THROTTLE is set at 128 bytes in n_tty.c. So, isn't it
possible that potentially we lose bytes when moving data to the TTY
line discipline buffer? If the line discipline buffer is almost full
(say the receiving room is 120 bytes), it calls throttle and even if
the other end gets the throttle in time, it could potentially send 128
bytes (but there is only 120 bytes of space in the buffer). So when we
are flushing to ldisc, we will transfer only the receive_room amount
of data and discard the rest? Is there any way of avoiding this?

I know there is no way of knowing what the FIFO size of the other side
might be! I was wondering if this happens, could we potentially flag a
buffer overflow error? We know how many bytes are coming in from the
UART and when we are trying to flush to ldisc, if the count is more
than the throttle level, can we return an error?

Thanks,
Karthik
