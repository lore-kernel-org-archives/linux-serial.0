From: Ed Vance <EdV@macrolink.com>
Subject: RE: A new serial baud rate
Date: Fri, 26 Jul 2002 09:00:05 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7908@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: "'henrique@cyclades.com'" <henrique@cyclades.com>
Cc: linux-serial@vger.kernel.org, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>

> > On Thu, July 25, 2002 at 12:14 PM, henrique wrote:
> > > I just wanna know what is the procedure to insert this new baud 
> > > rate (14400) in the linux kernel.
> > > 

> On Thu, July 25, 2002 at 2:36 PM, Ed Vance wrote:
> > If you have a 2.4.x kernel, and your serial ports have "simple" 
> > UARTs like a 16550A, then use the setserial command to directly 
> > set the UART's divisor. See the man page on setserial, which also 
> > has words about how to put the setserial commands into a script 
> > that runs automatically when you boot the system.
> > 
> > You will have to know the "baud base" rate of your UARTs. This is 
> > the baud rate that you get if you set the divisor to 1 (probably 
> > 115200 bps).
> > 
> > The new divisor is baud_base / 14400 (which is probably 8).
> > 

On Fri, July 26, 2002 at 6:15 AM, henrique wrote:
> 
> Ed, unfortunately my equipment uses the 2.2.14 kernel. 
> Does your suggestion work in such kernel ? It would be 
> the easiest way to solve this.
> 

Hi Henrique,

I know of no specific reason why it would not work under 2.2. I just 
have no direct experience with the 2.2 kernel and the corresponding 
version of the serial driver. If the setserial functionality that I 
described is in your setserial man page from 2.2, then I think the 
method should work well. 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
