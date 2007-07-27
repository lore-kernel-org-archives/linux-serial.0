From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 10:11:36 -0700
Message-ID: <46AA2748.80703@howardsilvan.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no> <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com> <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:48016 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936061AbXG0RMu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 13:12:50 -0400
In-Reply-To: <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Thu, 26 Jul 2007, Lee Howard wrote:
>
>  
>
>>If the application were to use TIOCM_RTS how would it know when to apply it or
>>not?  Is there some approach that the application could take to manage flow
>>control on the serial port?  What about software flow control?  Does the
>>    
>>
>
> Well, an application could negate RTS when it receives a character and 
>is running out of resources for further processing of incoming data.
>
> Smarter UARTs may be able to negate RTS themselves based on the amount of 
>data in their receive FIFO.  The threshold may be configurable.
>

Okay, so let's say we've got a loop around a blocking read on the modem 
file descriptor...

  for (;;) {
      read some data from modem
      process data from modem
      if (end-of-data detected) break;
  }

Are you suggesting that the application should be using deasserting RTS 
after the read and asserting it before?

I had previously thought that the control of RTS was something that the 
serial/tty driver was supposed to do independently based on the buffer 
fill.  Was I wrong?

Thanks,

Lee.
