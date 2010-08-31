From: Philippe Langlais <philippe.langlais@stericsson.com>
Subject: Re: serial.h v serial_core.h PORT_ defines?
Date: Tue, 31 Aug 2010 13:55:44 +0200
Message-ID: <4C7CEDC0.50600@stericsson.com>
References: <20100827193541.GA29541@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:34989 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751275Ab0HaL5C (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Aug 2010 07:57:02 -0400
In-Reply-To: <20100827193541.GA29541@gallifrey>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi,
You are right.
I'll add my define in serial_core.h (#19), and withdraw U6_16550A 
definition in serial.h.
I'll post a patch to fix it.
I have the same question about these double definitions.

Thanks

Philippe

On 08/27/10 21:35, Dr. David Alan Gilbert wrote:
> Hi,
>    I was playing with sparse and it flagged that in drivers/serial/8250.c
> there is a duplicate initialiser in the uart_config[] array
> (from Linus's git):
>
>         [PORT_NS16550A] = {
>                  .name           = "NS16550A",
>                  .fifo_size      = 16,
>                  .tx_loadsz      = 16,
>                  .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>                  .flags          = UART_CAP_FIFO | UART_NATSEMI,
>          },
>
> and
>         [PORT_U6_16550A] = {
>                  .name           = "U6_16550A",
>                  .fifo_size      = 64,
>                  .tx_loadsz      = 64,
>                  .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>                  .flags          = UART_CAP_FIFO | UART_CAP_AFE,
>          },
>
> now PORT_NS16550A is defined as 14 in serial_core.h:
>
> #define PORT_NS16550A   14
>
> and PORT_U6_16550A is defined as 14 in serial.h:
>
> 235dae5d (Philippe Langlais 2010-07-29 17:13:57 +0200  80) #define PORT_U6_16550A       14
>
> I guess that might subtly break NS16550A users?
>
> My assumption is that Philippe's addition should actually
> be to the serial_core.h list which currently goes upto 18.
>
> However, that leaves the question of why is there a set of nearly
> but not quite idential defines in serial.h and serial_core.h?
>
> (please leave me on cc for replies)
>
> Dave
>    
