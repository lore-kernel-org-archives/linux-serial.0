From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH] serial: bfin_uart: Don't switch baud rate untill the
 transfer buffer is empty.
Date: Mon, 19 Nov 2012 01:31:29 -0500
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D173F33FAE06@NWD2CMBX1.ad.analog.com>
References: <1352264142-30771-1-git-send-email-sonic.adi@gmail.com>
 <20121116005946.GA1727@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:42753
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252Ab2KSGbg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 01:31:36 -0500
In-Reply-To: <20121116005946.GA1727@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sonic Zhang <sonic.adi@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>



>-----Original Message-----
>From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
>Sent: Friday, November 16, 2012 9:00 AM
>To: Sonic Zhang
>Cc: linux-serial@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org; Zhang,
>Sonic
>Subject: Re: [PATCH] serial: bfin_uart: Don't switch baud rate untill the transfer
>buffer is empty.
>
>On Wed, Nov 07, 2012 at 12:55:42PM +0800, Sonic Zhang wrote:
>> From: Sonic Zhang <sonic.zhang@analog.com>
>>
>> set_termios may be invoked before the former data transfer is
>> completed. Block until the tranfer is done.
>>
>> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
>> ---
>>  drivers/tty/serial/bfin_uart.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/bfin_uart.c
>> b/drivers/tty/serial/bfin_uart.c index 9242d56..71c0c09 100644
>> --- a/drivers/tty/serial/bfin_uart.c
>> +++ b/drivers/tty/serial/bfin_uart.c
>> @@ -869,6 +869,10 @@ bfin_serial_set_termios(struct uart_port *port,
>> struct ktermios *termios,
>>
>>      UART_SET_ANOMALY_THRESHOLD(uart, USEC_PER_SEC / baud * 15);
>>
>> +    /* Wait till the transfer buffer is empty */
>> +    while (UART_GET_GCTL(uart) & UCEN && !(UART_GET_LSR(uart) &
>TEMT))
>> +            barrier();
>
>Where is the "the hardware is hung" break out of this loop?
>

Sorry, I will add time_after check soon.

Regards,

Sonic

>And why "barrier()"?
>
>thanks,
>
>greg k-h


