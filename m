From: Ed Vance <EdV@macrolink.com>
Subject: RE: Saving data from the serial port
Date: Thu, 17 Apr 2003 12:10:39 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33E47@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:56586
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S261886AbTDQS6o (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2003 14:58:44 -0400
List-Id: linux-serial@vger.kernel.org
To: "'alexm@ndtel.com'" <alexm@ndtel.com>
Cc: linux-serial@vger.kernel.org

On Thu, Apr 17, 2003 at 11:44 AM, Alex Moen wrote:
> 
> I want to take the data from a serial port from our PBX and 
> log it to a file.  Sounds simple, right?  I can (Winblows) 
> hyperterm to the port and gather the data.  I can connect 
> the port to a serial printer and get the data.  But, when I 
> connect my linux box to the serial port, I am only getting 
> PART of the data.  For instance, I am only getting the 
> first 14-16 characters of each line, with really no line 
> breaks.  I also notice with statserial that I am getting an 
> overrun (wth is that???).  I have the port settings in the 
> software set at what Windows and the printer are set at
> (9600-8-N-1).
> 
> I have read through the serial howto, tried a few programs 
> that are suggested (two that look promising but are giving 
> the above results are linbar and logserial), and am stumped.
> 
> I'd hate to have to set up a Win98 box running hyperterm 
> logging to a file, and then manually rotate that each day....
> 
Overruns happen when the UART receiver FIFO buffer is completely
full when the next date character is received. The byte that did
not fit is discarded and the overrun status is posted. 

the root cause is either that the data is not being read fast 
enough by the program, or system interrupt latency is too long
to let the driver service the UART before an overrun occurs. 

If the data source supports XON/XOFF or hardware flow control, 
you could set that to hold off the data source when the system 
is not ready to receive more data. 

Does your UART have a FIFO buffer? 
What UART type is your port?
How fast is your system?
 
Cheers,
Ed
