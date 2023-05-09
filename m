Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C46C77B7F
	for <linux-serial@archiver.kernel.org>; Tue,  9 May 2023 00:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEIA6R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 May 2023 20:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIA6Q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 May 2023 20:58:16 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C77F26B3
        for <linux-serial@vger.kernel.org>; Mon,  8 May 2023 17:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=2DZuEJWnt1Se514A6rxACfH5qzgzuqCADCkgzoVzs2w=;
        b=nBjNadq2VWo8wcmVAoyppnhk2cxFX6gHDwBW7HRK4RTKFjwLNyfQ5PcTrbguHt
        rD4TcyzVLyjDg3/I6FWtVTKhsBBLFbwQAouvZv06FYRuRj3HHuUdI/0N0t6qJ15r
        TLWmN06jcsLHba+VdsOYdLLLhpnnWiFuDB0GJQ7pE+628=
Received: from [172.21.25.67] (unknown [218.201.129.19])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wDHi7WSmllkzwBpBQ--.27386S2;
        Tue, 09 May 2023 08:57:55 +0800 (CST)
Message-ID: <eb286124-20b5-df7b-ac23-b54c07dc9a25@163.com>
Date:   Tue, 9 May 2023 08:57:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: serial8250: can not change baudrate while the controller is busy
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com>
 <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com>
 <d8693191-be31-b471-7ddc-b491daa48650@163.com>
 <20e0285b-47c8-2695-1be9-e5da981eef7c@linux.intel.com>
 <c66120b5-370a-778c-048d-a10ba04fe057@163.com>
 <e87414db-3482-c9f1-8212-3be1afb2c750@linux.intel.com>
Content-Language: en-US
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <e87414db-3482-c9f1-8212-3be1afb2c750@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHi7WSmllkzwBpBQ--.27386S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWftw4rZF4fuw1DCr4rXwb_yoWfZF4kpF
        WUKanxKr4Dtr15twnFv3Z2qFy5trsxJrnrXrn8Jryjyrn0vryfKr4xKrWYkas2kr93Kw1U
        Zr42yasrCF1jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut3kNUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbBzhRq7WI0ZHkAwQAAsX
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



在 2023/5/8 21:34, Ilpo Järvinen 写道:
> On Mon, 8 May 2023, qianfan wrote:
>> 在 2023/5/8 18:17, Ilpo Järvinen 写道:
>>> On Fri, 5 May 2023, qianfan wrote:
>>>> 在 2023/4/14 20:10, Ilpo Järvinen 写道:
>>>>> On Fri, 14 Apr 2023, qianfan wrote:
>>>>>> My custom board is based on allwinner R40, the uart is compatibled
>>>>>> with
>>>>>> serial8250. Based on it's datasheet:
>>>>>>
>>>>>>> When TX transmit data, or RX receives data, or TX FIFO is not empty,
>>>>>>> then
>>>>>> the
>>>>>>> BUSY flag bit can be set to 1 by hardware, which indicates the UART
>>>>>>> controller is busy.
>>>>>> We cannot write LCR and DLL to update UART params such as baudrate and
>>>>>> partity
>>>>>> while the UART is busy, however `serial8250_do_set_termios` is a void
>>>>>> function,
>>>>>> the upper level always assume the uart params is updated.
>>>>>>
>>>>>> The upper level `uart_set_termios` do noting if ktermios params is not
>>>>>> changed,
>>>>>> it will not update when the user space program running tcsetattr set a
>>>>>> same
>>>>>> baudrate again.
>>>>>>
>>>>>> So we can not fix the baudrate when
>>>>>> `serial8250_do_set_termios`
>>>>>> failed.
>>>>>>
>>>>>> Allwinner R40's datasheet provided a way for this case.
>>>>>>
>>>>>>> CHCFG_AT_BUSY(configure at busy): Enable the bit, software can also
>>>>>>> set
>>>>>>> UART
>>>>>>> controller when UART is busy, such as the LCR, DLH, DLL register.
>>>>>>> CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and
>>>>>>> CHANGE_UPDATE
>>>>>>> is written to 1, the configuration of UART controller can be
>>>>>>> updated.
>>>>>>> After completed update, the bit is cleared to 0 automatically.
>>>>>> I can't know this feature is expanded by allwinner, or it is a common
>>>>>> functiton
>>>>>> of serial8250. Perhaps the serial8250 driver need this.
>>>>> tcsetattr() can be given a flag which enforces TX empty condition before
>>>>> core calls into the lower layer HW set_termios function. Would that be
>>>>> enough to solve the case you're interested in?
>>>>>
>>>>> Obviously, nothing can prevent Rx from occuring as it's not under local
>>>>> UART's control (e.g. a busy flag check would still be racy). But does
>>>>> writing those registers actually break something or just corrupts the
>>>>> character under Tx/Rx (which can be handled by flushing)?
>>>> Hi:
>>>>
>>>> I speed long times to create a common solution for this problem.
>>>>
>>>> (I had create two commit, the first one add some sysfs debug interface
>>>> and the second one try solve this problem. So the next following patch
>>>> has only patch-2. Let's we discuess this solution and I will send all
>>>> patches if it is good.)
>>> Thanks a lot, it's much easier to discuss now with something concrete at
>>> hand.
>>>
>>>> Allwinner introduce some bits in HALT_TX register which can change
>>>> baudrate while the serial is busy. But that is not a common feature
>>>> of dw-uart. Rockchip's uart is also based on dw-uart and they doesn't
>>>> has such feature.
>>>>
>>>> The loopback is a common feature of 16450/16550 serial, so we can set
>>>> loopback mode to cut down the external serial line to force the serial
>>>> to idle.
>>>>
>>>> Next is the second patch:
>>>>
>>>>   From 171e981c3695e3efcc76a2c4f0d0937d366d6e2a Mon Sep 17 00:00:00 2001
>>>> From: qianfan Zhao <qianfanguijin@163.com>
>>>> Date: Fri, 5 May 2023 08:46:50 +0800
>>>> Subject: [PATCH] drivers: serial: 8250_dw: Make uart idle before set
>>>> baudrate
>>>>
>>>> Some registers which control the baudrate such as DLL, DLM can not
>>>> write while the uart is busy. So set the controller to loopback mode
>>>> and clear fifos to force idle before change baudrate.
>>>>
>>>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>>>> ---
>>>> @@ -360,6 +367,46 @@ static void dw8250_set_termios(struct uart_port *p,
>>>> struct ktermios *termios,
>>>>        serial8250_do_set_termios(p, termios, old);
>>>>    }
>>>>
>>>> +static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
>>>> +                   unsigned int quot, unsigned int quot_frac)
>>>> +{
>>>> +    struct uart_8250_port *up = up_to_u8250p(p);
>>>> +    struct dw8250_data *d = to_dw8250_data(p->private_data);
>>>> +    unsigned int usr;
>>>> +    int retries;
>>>> +
>>>> +    /*
>>>> +     * LCR, DLL, DLM registers can not write while the uart is busy,
>>> According to DW databook, this is not entirely true. The databook
>>> explicitly states that if BUSY is not configured
>>> (UART_16550_COMPATIBLE=YES), those are always writable. And I know for
>>> sure that there are devices on the field do not come with BUSY.
>>> Thus, it looks something that should be decided based on BUSY
>>> availability.
>>>
>>> I had one time a patch which generalized uart_16550_compatible to
>>> struct dw8250_port_data but in the end I didn't need it.
>> Or we should register dw8250_set_divisor callback only when
>> !d->uart_16550_compatible
>> in probe function, that is a easy way to handle this.
> Yes, registering it based on the compatible might makes sense, but please
> see my comment below wrt. dw8250_check_lcr().
>
>>>> +     * set uart to loopback mode, clear fifos to force idle.
>>>> +     * The loopback mode doesn't take effect immediately, it will waiting
>>>> +     * current byte received done, the lower baudrate the longer waiting
>>>> +     * time.
>>>> +     */
>>>> +    p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
>>>> +    for (retries = 0; retries < 10000; retries++) {
>>>> +        dw8250_force_idle(p);
>>>> +
>>>> +        usr = p->serial_in(p, d->usr_reg);
>>>> +        if (!(usr & DW_UART_USR_BUSY))
>>>> +            break;
>>>> +        udelay(1);
>>>> +    }
>>> This loop is overkill, ndelay(p->frame_time) is all you need to wait for
>>> the maximum time a single frame needs.
>> Sorry but I can not find the p->frame_time variable.
> Then you're probably using some old kernel... Please base your work on
> tty repo's tty-next branch when working with serial upstream.
Thanks and I found it now.
>
>> And the total waiting time is not a const value so we need polling.
> It's not constant, agreed. But your comment states that it's at most one
> frame worth of time so that should be the worst-case waiting time. Once
> the UART starts to do things like temporary switch to loopback and/or
> reinit/clearing FIFO, it doesn't seem that harmful to wait slightly
> longer for the worst-case frame time, so essentially you'd only need this
> (+ comment):
>
> 	p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> 	dw8250_force_idle(p);
> 	ndelay(p->frame_time);
> 	p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
>
> If you insist, ndelay() could be replaced by:
> 	ret = read_poll_timeout_atomic(p->serial_in, usr, !(usr & DW_UART_USR_BUSY),
> 				       1, DIV_ROUND_UP(p->frame_time, NSEC_PER_USEC), false,
> 				       p, d->usr_reg);
>
> You also don't explain why force_idle() is needed inside to loop, why
> doing it once before the loop is not enough? I can see the need for that
> in loop for dw8250_check_lcr() because it doesn't enable loopback, but
> here, so why?
Under my test, this code will not work:

p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
dw8250_force_idle(p);
/* waiting until not busy... */

Current byte maybe not finished when we set UART_MCR_LOOP and reset fifo,
dw-uart will continue receive even if LOOP bit is set. After this byte
is finished it will push data to rx fifo and remark BUSY flag again.
That's why I leave dw8250_force_idle inside to loop.

Or maybe we should make dw8250_force_idle after ndelay such as:

p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
ndelay(p->frame_time);
dw8250_force_idle(p);

But that requires a test to see if it works.
>
> I started to wonder whether dw8250_check_lcr() should also temporarily
> switch to loopback mode to ensure the UART becomes idle. Some common macro
> could be created which wraps the idle forcing for both use cases +
> restoring LCR & MCR. That is, dw8250_force_idle() + little bit extra ->
> __dw8250_idle_enter() and __dw8250_idle_exit() that are called by the
> macro.
>
> I also recall there was something with RS485 mode that it didn't do
> something with loopback but the wording in the databook seems rather
> vague.
>
>>>> +    d->last_loopback_waiting_time = retries;
>>>> +
>>>> +    p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
>>>> +    if (p->serial_in(p, UART_LCR) & UART_LCR_DLAB) {
>>> Can this still fail? Why?
>> If the waiting time is enough this should not fail.
>>
>> But under my test before this patch, set UART_LCR register maybe failed
>> due to busy,
> So your patch doesn't work or what are you saying? I see you're using
> "before this patch" but how is that relevant to the case with the patch
> my question was about, I don't understand?
I means set LCR maybe failed without this patch.
>
>> if we write DLM without check DLAB bit, that will write data to UART_IER
>> register,
>> different baudrate will write different value, that will cause some interrupt
>> disabled
>> and cause strange problem.
> Ah, I see. You should comment it then it's there just for safety purposes.
OK.
>
>
> It might also make sense to add delayed error reporting for the failures.
> The error printing can safely happen only after releasing port's lock.
Yes, this is really useful.
>
>

