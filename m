From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: serial flow control appears broken
Date: Sat, 04 Aug 2007 11:19:00 -0700
Message-ID: <46B4C314.7020600@howardsilvan.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no> <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com> <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl> <46AA2748.80703@howardsilvan.com> <Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway.howardsilvan.com ([64.146.212.27]:33026 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764989AbXHDSTI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 Aug 2007 14:19:08 -0400
In-Reply-To: <Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Fri, 27 Jul 2007, Lee Howard wrote:
>
>  
>
>>Okay, so let's say we've got a loop around a blocking read on the modem file
>>descriptor...
>>
>> for (;;) {
>>     read some data from modem
>>     process data from modem
>>     if (end-of-data detected) break;
>> }
>>
>>Are you suggesting that the application should be using deasserting RTS after
>>the read and asserting it before?
>>    
>>
>
> It certainly could -- you were asking how it would know. ;-)
>

So, to test... I put this in the application before every read:

    int flags;
    ioctl(modemFd, TIOCMGET, &flags);
    flags |= TIOCM_RTS;
    ioctl(modemFd, TIOCMSET, &flags);

and this after:

    int flags;
    ioctl(modemFd, TIOCMGET, &flags);
    flags &= ~TIOCM_RTS;
    ioctl(modemFd, TIOCMSET, &flags);

Now I can see the RTS light blink on the modem (and during heavy 
communication it merely "dims" depending on the amount of delay in the 
processing.

However, it does not help.  Data still goes missing.

Thanks,

Lee.

