From: Stanislav Meduna <stano@meduna.org>
Subject: mxs-auart gives data from previous run after close and reopen
Date: Fri, 14 Mar 2014 21:11:07 +0100
Message-ID: <5323625B.4010203@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi,

following scenario:

- a Freescale i.MX28 machine
- RS232 AUART looped back Rx - Tx or two different ports cross-connected
- a test program sending data in one thread and receiving in the other:
  thread A periodically sends "Quick brown fox jumps over the lazy dog",
  thread B receives
- stop the program using ctrl-C
- restart

=> sometimes the receiving thread gets "dogQuick", receiving
   characters from the previous transmission

The extra characters definitely come from the receiver - the transmission
is OK. This was verified by a scope.

My theory is that this behaviour is caused by mxs_auart_shutdown
function gating and mxs_auart_startup reenabling the clock instead
of doing a soft reset. If the clock is gated while the AUART already
has something in the FIFO, but did not generate the interrupt yet,
the internal state machine is frozen in this state. As soon as it
is reenabled, the characters are delivered to a new user.

I am using a 3.4.77 kernel, but the relevant code looks the same in
the recent kernels (when not using DMA). I also backported patches
waiting for the transmission FIFO to clear at mxs_auart_shutdown.

I did not find any possibility to fully clear the receiver - even
if one disables the AUART and reads everything from the FIFO,
the character currently in transmit might be still somewhere (the
reference manual states that disabling is effective after the
current character is received). Which might be 1 ms at 9600 and one
has no clue whether it is the case.

Also note that the function mxs_auart_reset is in fact not doing
a reset - it just makes sure that the AUART comes out of one after
the initialization. Maybe a full reset at startup is the solution...

Pleas Cc: me when answering.

Regards
-- 
                                Stano
