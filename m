From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Deterministic behavior for TTY serial
Date: Tue, 17 Apr 2012 16:38:30 +0200
Message-ID: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-rt-users-owner@vger.kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, RT <linux-rt-users@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello,

We are currently using the TTY framework for serial communication.

We are wondering if it is possible to give the TTY device in more
deterministic behavior (as in "less locks & no sleeping")
So in case of non blocking read/write behavior:
- We want directly write data to the serial_core transmit buffer and
return immediately.
- Incoming data should be buffered, on a read data is read directly
from that buffer and when no data available return immediately

We have the idea that the default N_TTY line discipline introduces too
much overhead & locking behavior what makes it less suitable for
deterministic serial communication on a PREEMT_RT platform.
Our first thought was that we need to use some kind of "raw" line
discipline, that directly writes data to the serial_core transmit
buffer, and buffers incoming data.

But isn't such a line discipline already available?
Or are we missing a option/flag for the N_TTY line discipline, that
will achieve the same behavior?

Regards,
Ivo Sieben
