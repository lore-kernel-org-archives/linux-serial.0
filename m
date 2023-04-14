Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE21C77B6E
	for <linux-serial@archiver.kernel.org>; Fri, 14 Apr 2023 09:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDNJci (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Apr 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNJci (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Apr 2023 05:32:38 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 332191FD2
        for <linux-serial@vger.kernel.org>; Fri, 14 Apr 2023 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
        Content-Type; bh=ztDTdKmMl1HdlikSbNuo7EDjXQF2lhFn2rfgOH9/5mo=;
        b=UIlFzRAUF3TJ9uFg8cAI8w10nUXCt/a26knzbbvbCh2qFYwXZsD1NRyhR++xhO
        7dcnUcPknDckBefTDtyDlw8Eha1e+pd091wl412ZteAh2b1YVobhnGMB8DD9x6Q9
        uiJimdTxqGH2k0Vt1mFfl2UoVil9Kxy9R8I7fAFdHm+wQ=
Received: from [172.21.25.67] (unknown [218.201.129.19])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3oJiOHTlkTz6YBQ--.1874S2;
        Fri, 14 Apr 2023 17:32:00 +0800 (CST)
Message-ID: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com>
Date:   Fri, 14 Apr 2023 17:31:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
From:   qianfan <qianfanguijin@163.com>
Subject: serial8250: can not change baudrate while the controller is busy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD3oJiOHTlkTz6YBQ--.1874S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW7ZFWxGr1fGr43XFWxXrb_yoW8Jw1DpF
        WYkFWxKFyDKw4jvanrurWxtFW5WrsxGr47KFWqkry3Jw1Yqas29r1xK3yFka10qF9Iqrn8
        ZryayrWrCF4v9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USoGdUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXQdR7VWBpPLi0gABsV
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi:

My custom board is based on allwinner R40, the uart is compatibled with
serial8250. Based on it's datasheet:

 > When TX transmit data, or RX receives data, or TX FIFO is not empty, 
then the
 > BUSY flag bit can be set to 1 by hardware, which indicates the UART
 > controller is busy.

We cannot write LCR and DLL to update UART params such as baudrate and 
partity
while the UART is busy, however `serial8250_do_set_termios` is a void 
function,
the upper level always assume the uart params is updated.

The upper level `uart_set_termios` do noting if ktermios params is not 
changed,
it will not update when the user space program running tcsetattr set a same
baudrate again. So we can not fix the baudrate when 
`serial8250_do_set_termios`
failed.

Allwinner R40's datasheet provided a way for this case.

 > CHCFG_AT_BUSY(configure at busy): Enable the bit, software can also 
set UART
 > controller when UART is busy, such as the LCR, DLH, DLL register.
 > CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and 
CHANGE_UPDATE
 > is written to 1, the configuration of UART controller can be updated.
 > After completed update, the bit is cleared to 0 automatically.

I can't know this feature is expanded by allwinner, or it is a common 
functiton
of serial8250. Perhaps the serial8250 driver need this.

Thanks

