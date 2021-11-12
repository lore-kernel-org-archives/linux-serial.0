Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA49C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 12 Nov 2021 06:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F53160FE3
	for <linux-serial@archiver.kernel.org>; Fri, 12 Nov 2021 06:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhKLGc7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:32:59 -0500
Received: from m12-15.163.com ([220.181.12.15]:60153 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhKLGc7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Nov 2021 01:32:59 -0500
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 01:32:58 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=RpLI0
        QHkr2X3vli+7cq3X2AH5v4ZV8VRS0o1IpAL2eo=; b=nTooyCyUy+wVmJCA2Sbon
        imEHndMjNPIFeKL85n58ttI5bP+E+f8zI4ToAKYtst0aENEp/fR3DzWgQRhCHa7I
        pSxdClqxKg/+R5PumafV97hOd56hyAQr8hSUbXxenX0bQqg9SHumZ6QXMlFzwFj7
        y3LFXtc4uM7BDcZhxD0qh4=
Received: from [192.168.100.154] (unknown [117.61.10.5])
        by smtp11 (Coremail) with SMTP id D8CowACXfrAzBo5h0Y5YBg--.2227S2;
        Fri, 12 Nov 2021 14:14:13 +0800 (CST)
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control while
 in rs485 mode"
To:     Lukas Wunner <lukas@wunner.de>,
        Su Bao Cheng <baocheng.su@siemens.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, chao.zeng@siemens.com
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
From:   Su Bao Cheng <baocheng_su@163.com>
Message-ID: <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
Date:   Fri, 12 Nov 2021 14:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027113938.GA9373@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowACXfrAzBo5h0Y5YBg--.2227S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyDXw4xuFWxtr4fXw4fKrg_yoW5Aw1rpF
        s3KFZayFZ0qayUGa1DZr4jvFWY9F48Jr1fCF9rKwn0yw4YgFyIyF4fKw4Yk34UW3yktFyS
        vFyYvry7A3WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjMKtUUUUU=
X-Originating-IP: [117.61.10.5]
X-CM-SenderInfo: pedrux5hqjs2rx6rljoofrz/xtbBFBVJJ1aECB-G4wAAsP
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021/10/27 下午7:39, Lukas Wunner wrote:
> On Wed, Oct 27, 2021 at 07:16:44PM +0800, Su Bao Cheng wrote:
>> This reverts commit f45709df7731ad36306a28a3e1af7309d55c35f5.
>>
>> The `serial8250_do_set_mctrl` not only used by userspace ioctl but
>> also the kernel itself.
>>
>> During tty_open, the uart_port_startup sets the MCR to 0, and then use
>> set_mctrl to restore the MCR, so at this time, the MCR read does not
>> reflect the desired value.
> 
> I don't quite follow.  Where is uart_port_startup() setting the MCR to 0?
> Are you referring to the call to uart_port_dtr_rts()?  That function should
> set RTS correctly according to RS485 state, so I don't see where any
> breakage may occur.
>
> What is the user-visible issue that you seek to fix with the revert?
> 

Sorry for the late response, the company exchange server does not work
for me at this moment, so I have to use the private email instead.

The issue is observed on omap8250 hardware (CPU: AM6548). the use case
is RS485 half-duplex (2 wire mode), in this mode the RTS pin is used to
control the direction and is software controller via the MCR[1]
register. The problem is that the RS485 transmitting is OK, but the
receiving is not working. Similar issue also exists for the RS422, i.e.
the 4-wire full-duplex mode of RS485, but this time the TX does not
work, RX is fine.

The MCR is set to 0 at this line within uart_port_startup():
	retval = uport->ops->startup(uport);

On omap8250, the startup() points to omap_8250_startup(), within it:
	up->mcr = 0;

For software controlled RTS pin of RS485 half-duplex, when not in the
transmitting, the MCR[1] should be constant to indicate the current
direction is receiving. This is set in serial8250_em485_stop_tx().

So after this point of setting the MCR to 0, this up->mcr register
mirror does not reflect the actual desired value anymore. Further
checking against it leads to false result.

Another possible fix could be, instead of setting the mcr to 0 blindly,
one could check if the current operating mode is RS485 half-duplex, and
if so, mask the MCR[1], so that this bit is not changed. Because the
MCR[1] will be changed to the correct value before TX in
serial8250_em485_start_tx(), this change would not impact the transmitting.

> Thanks,
> 
> Lukas
> 
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 66374704747e..40736e460956 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2024,13 +2024,6 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>  	struct uart_8250_port *up = up_to_u8250p(port);
>>  	unsigned char mcr;
>>  
>> -	if (port->rs485.flags & SER_RS485_ENABLED) {
>> -		if (serial8250_in_MCR(up) & UART_MCR_RTS)
>> -			mctrl |= TIOCM_RTS;
>> -		else
>> -			mctrl &= ~TIOCM_RTS;
>> -	}
>> -
>>  	mcr = serial8250_TIOCM_to_MCR(mctrl);
>>  
>>  	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
>> -- 
>> 2.25.1

