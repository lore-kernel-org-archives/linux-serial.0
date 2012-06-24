From: Stefan Wahren <info@lategoodbye.de>
Subject: Re: serial/mxs-auart: Unable to get interrupt counter from user space
Date: Sun, 24 Jun 2012 11:14:49 +0200
Message-ID: <4FE6DA89.50503@lategoodbye.de>
References: <4FE616CC.9000709@lategoodbye.de> <20120624022547.GA7307@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.augenpunkt.de ([213.239.207.9]:36015 "EHLO
	www.augenpunkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab2FXJL1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 24 Jun 2012 05:11:27 -0400
In-Reply-To: <20120624022547.GA7307@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

Hi,

Am 24.06.2012 04:25, schrieb Greg KH:
> On Sat, Jun 23, 2012 at 09:19:40PM +0200, Stefan Wahren wrote:
>> Hello,
>>
>> i'm using Linux 2.6.35 at ARM and i experience the following issue
>> with the mxs-auart (App UART). If i transmit and receive data over
>> the serial port (using mxs-auart), all the interrupt counter (RX,
>> TX, frame, parity, break) accessed from user space (ioctl with
>> TIOCGICOUNT or /proc/tty/driver/auart) are zero.
>>
>> Here is the scenario to reproduce the problem:
>>
>> 1. echoing some characters to the uart device
>> 2. fetch the statistics from proc-Filesystem
>>
>> Expected results: transmit counter greater than zero
>>
>> Observed results: transmit counter is always zero
>>
>> The same szenario on the mxs-duart (Debug UART) doesn't show this problem.
>>
>> Is this a bug in mxs-auart or just not implemented?
>
> We disabled the transmit counter from being displayed a while ago for
> security reasons, perhaps that is what you are seeing?

Does this security fix affect serial_core or only mxs-auart?

Prevent this security fix from reading all counter (TX, RX, frame erros, 
parity errors, breaks)?

Do you mean this security issue ( 
https://bugzilla.redhat.com/show_bug.cgi?id=648660 ) ?

>
> Also, you do realize just how old 2.6.35 really is, right?

Unfortunaley yes, Freescale the vendor delivers the Board Support 
Package only with 2.6.35.

>
> thanks,
>
> greg k-h
>

Thanks

Stefan
