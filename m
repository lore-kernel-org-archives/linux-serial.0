From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] tty/serial_core: Introduce lock mechanism for RS485
Date: Mon, 13 Oct 2014 23:48:05 +0200
Message-ID: <543C4895.4000902@atmel.com>
References: <1412948280-30993-1-git-send-email-ricardo.ribalda@gmail.com> <543A1055.9080801@atmel.com> <CAPybu_1kwSRfe33H9cFO_DgstP8VW=z_AcqZhhs0iQX89Mmbag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:47672 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbaJMVsL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2014 17:48:11 -0400
In-Reply-To: <CAPybu_1kwSRfe33H9cFO_DgstP8VW=z_AcqZhhs0iQX89Mmbag@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On 13/10/2014 21:03, Ricardo Ribalda Delgado :
> Hello Nicolas
> 
>>
>> I have the feeling that moving the code chunk that uses this new
>> variable (rs485_enabled) here ...
>>
>>>       ret = uart_add_one_port(&atmel_uart, &port->uart);
>>>       if (ret)
>>>               goto err_add_port;
>>> @@ -2574,7 +2572,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
>>>       device_init_wakeup(&pdev->dev, 1);
>>>       platform_set_drvdata(pdev, port);
>>>
>>> -     if (port->uart.rs485.flags & SER_RS485_ENABLED) {
>>> +     if (rs485_enabled) {
>>>               UART_PUT_MR(&port->uart, ATMEL_US_USMODE_NORMAL);
>>>               UART_PUT_CR(&port->uart, ATMEL_US_RTSEN);
>>>       }
>>
>> ... (this one ^^^) up where you can test the SER_RS485_ENABLED, can be
>> even simpler.
>>
>> otherwise, it seems good so you can add my:
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Thanks.
> 
> I supposed that the code needs to be initialized with rs485 disabled
> and then enable it. Also I did not want to change the behaviour a
> driver in a patch that involves 3 other drivers. If you don't mind I
> prefer that this is added to a separated patch.

Fair enough, I can do it later on.

Thanks, bye,
-- 
Nicolas Ferre
