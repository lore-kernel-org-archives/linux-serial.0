Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD50C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 05:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiCAFpR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 00:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiCAFpQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 00:45:16 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E822593BB;
        Mon, 28 Feb 2022 21:44:30 -0800 (PST)
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 1 Mar
 2022 13:44:28 +0800
Message-ID: <34a1fd07-cb83-25b9-a208-490ea01ed891@amlogic.com>
Date:   Tue, 1 Mar 2022 13:44:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V7 5/6] tty: serial: meson: The system stuck when you run
 the stty command on the console to change the baud rate
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <20220225073922.3947-6-yu.tu@amlogic.com>
 <1jczj7xnn0.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jczj7xnn0.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Jerome,
	Thank you for your reply.

On 2022/2/28 18:58, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Start the console and run the following commands in turn:
>> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600. The
>> system will stuck.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/tty/serial/meson_uart.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index ba8dc203b9cb..d19349ead738 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -365,8 +365,13 @@ static void meson_uart_set_termios(struct uart_port *port,
>>   	writel(val, port->membase + AML_UART_CONTROL);
>>   
>>   	baud = uart_get_baud_rate(port, termios, old, 50, 4000000);
>> +
>> +	spin_unlock_irqrestore(&port->lock, flags);
>> +
>>   	meson_uart_change_speed(port, baud);
>>   
>> +	spin_lock_irqsave(&port->lock, flags);
> 
> Already told you before, you can make meson_change_speed()
> clk_set_rate() uses mutex and may sleep.
Sorry, I may have only paid attention to how you asked me to change to 
using the clock before, instead of paying attention to this suggestion.
> 
>> +
>>   	port->read_status_mask = AML_UART_TX_FIFO_WERR;
>>   	if (iflags & INPCK)
>>   		port->read_status_mask |= AML_UART_PARITY_ERR |
> 
