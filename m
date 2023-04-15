Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04DC77B71
	for <linux-serial@archiver.kernel.org>; Sat, 15 Apr 2023 01:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDOBJd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Apr 2023 21:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDOBJc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Apr 2023 21:09:32 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3374E5BB8
        for <linux-serial@vger.kernel.org>; Fri, 14 Apr 2023 18:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=Fcbde4RW80PEClfVwtHjpulsLwY8A/r19zVjDoFsr78=;
        b=Ig4EtdWdb92Bn20sZSfNEsSjXI+zQykS1mfV42RRip0Aj52RNBY/tT4bjlYnPJ
        bo7Dh4ds96j6TruCvJbzhZRY29ITXIYbugNXDN/BtaeLSDFxnTdVAO48f7cf079D
        Je8f1ZkZ2xBvz+UclzUHroQRO979DZcPL7Nlzx26URCCc=
Received: from [172.21.25.67] (unknown [218.201.129.19])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wD3_386+TlkiE73BQ--.8838S2;
        Sat, 15 Apr 2023 09:09:15 +0800 (CST)
Message-ID: <14a56867-8dad-bec5-36f7-78b769b83ceb@163.com>
Date:   Sat, 15 Apr 2023 09:09:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: serial8250: can not change baudrate while the controller is busy
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com>
 <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com>
Content-Language: en-US
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_386+TlkiE73BQ--.8838S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy8Ar18ur15tw4DXF4fKrg_yoW8urWUpF
        W0kay7KryDGr4YvanF9rWIyFWYgFsrGwnrGa1DGry2vws0qa4vvr4xK3yF9a40grsxtr1q
        vryakFW8uF90vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1c_fUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGh1S7VaEE52O2QAAsz
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



在 2023/4/14 20:10, Ilpo Järvinen 写道:
> On Fri, 14 Apr 2023, qianfan wrote:
>
>> Hi:
>>
>> My custom board is based on allwinner R40, the uart is compatibled with
>> serial8250. Based on it's datasheet:
>>
>>> When TX transmit data, or RX receives data, or TX FIFO is not empty, then
>> the
>>> BUSY flag bit can be set to 1 by hardware, which indicates the UART
>>> controller is busy.
>> We cannot write LCR and DLL to update UART params such as baudrate and partity
>> while the UART is busy, however `serial8250_do_set_termios` is a void
>> function,
>> the upper level always assume the uart params is updated.
>>
>> The upper level `uart_set_termios` do noting if ktermios params is not
>> changed,
>> it will not update when the user space program running tcsetattr set a same
>> baudrate again.
>>
>> So we can not fix the baudrate when
>> `serial8250_do_set_termios`
>> failed.
>>
>> Allwinner R40's datasheet provided a way for this case.
>>
>>> CHCFG_AT_BUSY(configure at busy): Enable the bit, software can also set UART
>>> controller when UART is busy, such as the LCR, DLH, DLL register.
>>> CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and CHANGE_UPDATE
>>> is written to 1, the configuration of UART controller can be updated.
>>> After completed update, the bit is cleared to 0 automatically.
>> I can't know this feature is expanded by allwinner, or it is a common
>> functiton
>> of serial8250. Perhaps the serial8250 driver need this.
> tcsetattr() can be given a flag which enforces TX empty condition before
> core calls into the lower layer HW set_termios function. Would that be
> enough to solve the case you're interested in?
>
> Obviously, nothing can prevent Rx from occuring as it's not under local
> UART's control (e.g. a busy flag check would still be racy). But does
> writing those registers actually break something or just corrupts the
> character under Tx/Rx (which can be handled by flushing)?
I think flushing can't resolv this problem. We can control the time to 
sending
but can not control when we are recving.

The RX busy is always exists.
>

