From: Ed Vance <EdV@macrolink.com>
Subject: RE: port speeds >115k
Date: Mon, 24 Feb 2003 11:01:11 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DAE@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Tim' <delt@gate-way.net>
Cc: linux-serial@vger.kernel.org

On Mon, Feb 24, 2003 at 9:58 AM, Tim wrote:
> 
> stty -F /dev/ttyS3 230400
> stty: /dev/ttyS3: unable to perform all requested operations
> 
> > > If the doco says it can run faster than 115200, it should 
> > > also tell what you have to do to make it do so.
> > 
> > Yes.  It will likely say (or imply) to use a driver 
> > they supply for Windows only.                                 
> > ^^^^^^^^^^^
> 
> Ha! ~"All our 56k modems are capable of supporting 230k ... go find
> a driver from someone else", actually.  Or try to ID the chipset &
> find the datasheet.
> 
> > > > If my modem was detected as a modem by Linux,
> > > > would setserial -a show something more?
> > > 
> > > It was detected as a serial port.  Linux does not detect modems at
> > > startup.
> 
> I guess all that modem stuff in serial.c is just for PnP 
> addr/irq init.
> 
> > > There seems to be a "quickie test to see how big the FIFO is".
> > > How can I cause the results of that test to be logged?
> > Is this test done by some Linux utility?
> 
> grep quickie drivers/char/serial.c
> 
> > > Internal modems usually just have a simulated uart for software
> > > compatibility and baud rate is irrelevant (same for 
> parity, stop bits,
> > > FIFO, etc). Set to 5 baud and see if you get same performance.
> 
> Well I noticed stty <anyspeed> makes no dif in an xterm, or the 
> getty on a vc, but with 
> http://members.gate-way.net/delt/test/500k.html
> my hardware ISA modem behaves like:
> 
> CARRIER	PORT	AVG.RATE
> =======	====	========
> 46k	115k	10.5kB/s
> 26k	115k	10.5kB/s
> 14k	115k	10.5kB/s
> 46k	 57k	 5.3kB/s
> 
> For viewing large html text tables with a fast browser like Dillo,
> 230k could ~double the speed of the whole process.
> 
> > I set to 300 baud and couldn't connect.  Then at 1200 baud 
> > it connected but download speeds were around 60 bytes/sec. 
> > I estimated the received rate from the /proc dir and it was 
> > close to 1200 baud.  So mine must have a real UART.
> > 
> > Some modems brag that they can do 230.4k baud.  This is a 
> > serial port speed.  So it seems like a real UART.  So what 
> > percent of internal modems will operate at a high baud rate 
> > when one specifies low baud rate?
> 
> [snip]

Hi Tim,

For a real 16550A UART, you cannot exceed the "baud_base" frequency, 
by calculating a new divisor, because the divisor would have to be 
less than one - and the 16550A can't do that. (16950 can) If the 
modem really supports a 230kb/sec UART rate, then there must either 
be a way to tell the card to either generate a higher speed base 
clock or change the UART's prescaler value. A real 16550A UART has 
a fixed prescaler that always divides the base clock by 16.

If you find a way to get a higher speed base clock, then use 
setserial to set the new baud_base value (must be 230kb or higher) 
and the warp flag that tells the serial driver to actually calculate 
a divisor for 230kb (spd_shi) when the user sets 38.4Kb (highest 
standard speed encoded in ye olde 4-bit termio baud rate field).

Ed
