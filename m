From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: serial flow control appears broken
Date: Sat, 28 Jul 2007 10:18:52 +0100
Message-ID: <20070728091851.GB26443@flint.arm.linux.org.uk>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no> <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com> <20070726173121.70088a92@the-village.bc.nu> <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc> <46D33636.7070200@microgate.com> <46AA5A0E.1050600@howardsilvan.com> <1185578908.2989.15.camel@x2> <46AACB4D.7080004@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762319AbXG1Jb6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46AACB4D.7080004@howardsilvan.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Paul Fulghum <paulkf@microgate.com>, Tilman Schmidt <tilman@imap.cc>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 27, 2007 at 09:51:25PM -0700, Lee Howard wrote:
> Curiously, the session at 38400 bps that skipped 858 bytes... coincided, 
> not just in sequence but also in precice timing within the session, with 
> a small but noticeable disk load that I caused by grepping through a 
> hundred session logs.  (I can't reproduce it easily, though, because of 
> disk caching.)

If you have other parts of the system which run with IRQs disabled for
a significant time period, then you will get serial corruption.  That's
not the serial driver's fault - that's a problem with the other device
drivers/rest of the system.

You may be table to track down where IRQs are being held off for too long
by hooking into the 8250 interrupt handler, and when an overrun error is
reported, printk a _minimal_ message reporting the instruction pointer
obtained via get_irq_regs().

Note, however, that I don't actively maintain serial anymore.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
