From: Tim <delt@gate-way.net>
Subject: serial port speeds >115k; PnP modem ID must contain modem substring
Date: Fri, 21 Feb 2003 15:09:39 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030221200939.GA1543@jats9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have a Diamond/Supra v90 ISA modem (model SUP2124) in my
Linux system running 2.4.20.  I've noticed that for the
type of file I commonly access (large html text table) 115k
port speed seems to be a significant bottleneck.  (These
files compress to <10% of raw size.  Transfer speed is
reported as ~10.5kByte/s, even if I reduce my modem speed
from the typical 45kbps to 28.8.)  The modem documentation
says it is capable of 230k port speed, so I tried specifying
230400 in my ppp config, which resulted in 9600 baud port
speed; stty returns an error.

At this point in my education, my guess is that the modem is
being treated like a 16550A without extended FIFOs or 230k
port speed.  If my modem was detected as a modem by Linux,
would setserial -a show something more?

# setserial -a /dev/ttyS3
/dev/ttyS3, Line 3, UART: 16550A, Port: 0x02e8, IRQ: 10
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_normal skip_test

I am not a programmer, but have been looking at the comments
in serial.c:

There seems to be an ISA PnP device device search, the success
of which depends on finding the string "modem" in PnP id:
  dev->name or dev->bus->name must contain "modem" substring;

However, the modem in this system was installed with PnP
disabled and does not have modem in its string:
# ANSI string -->SupraExpress 56i Voice<--

What are the consequences of failing this test?  If the
string were changed, could the test succeed with the modem
jumper not in PnP mode?

There seems to be a "quickie test to see how big the FIFO is".
How can I cause the results of that test to be logged?

I now have CONFIG_SERIAL=y.
If I compile serial as a module, are there parameters that
can be added to modules.conf to enable available features
beyond what a 16550A has, or perhaps someone has patches
that would enable these features?

TIA,
Tim.

