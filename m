From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 0/4] tty/serial: at91: fixes dealing with port shutdown
Date: Tue, 7 Jan 2014 11:48:24 +0100
Message-ID: <52CBDB78.3050306@atmel.com>
References: <cover.1389090437.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:27582 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaAGKs1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Jan 2014 05:48:27 -0500
In-Reply-To: <cover.1389090437.git.nicolas.ferre@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Leilei Zhao <leilei.zhao@atmel.com>, mark.roszko@gmail.com, mdeneen@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 07/01/2014 11:41, Nicolas Ferre :
> Hi,

Sorry for the noise: I messed up with git-send-email...

I re-sent the whole series.

Bye,


> These four fixes are pretty important for our atmel_serial driver as they
> deal with closing/re-opening of ports. They fix race condition and
> null pointers dereference.
> I added the "stable" tag to each of them (v3.12).
> 
> Even if we are late in the development cycle, can you please consider including
> these patches for 3.13?
> 
> Thanks, best regards,
>    Nicolas Ferre
> 
> Marek Roszko (3):
>   tty/serial: at91: Handle shutdown more safely
>   tty/serial: at91: fix race condition in atmel_serial_remove
>   tty/serial: at91: prevent null dereference in tasklet function
> 
> Mark Deneen (1):
>   tty/serial: at91: reset rx_ring when port is shutdown
> 
>  drivers/tty/serial/atmel_serial.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 


-- 
Nicolas Ferre
