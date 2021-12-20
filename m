Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D9C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 06:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbhLTG2D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 01:28:03 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42734 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhLTG2D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 01:28:03 -0500
Received: by mail-wr1-f42.google.com with SMTP id c4so17844962wrd.9
        for <linux-serial@vger.kernel.org>; Sun, 19 Dec 2021 22:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=deP9faJPj/al0XQNj75dcMaVL4Kt2Zx7xWdaxeZkuSU=;
        b=F/1o0dVNi+G6qJ92/ipZg9qbDTam8Nruk0UAvHVKSqFcw7OCMGm9ODWWkt64oRaG/L
         /yVx2CuyV4ONsTNW4B4LRBwMQvd+60Ti35pWAZiXOcnlM98gJlWK9bDUVvpgH1BKN63w
         6+RMLSKMEVffMzbl2ZKpGQmrJ0xpXyapABdEQG0dff8AI3i6zKa6NtnIszl10shQz5ml
         Ja9z5bRmoq67uCALucSf1OND+vxKunPliPWcXDBopPc8RFCPQmhPbBCpznML3/Qn/C/w
         Tb+hHOb4LyLtmHqvzkIRnPpDU7jDhuaf06Clij2bmQBtXEDDVCahSLbNK43rECPXSUvr
         SzDw==
X-Gm-Message-State: AOAM532czFu7xFR15kLtNhEcJJv7b4jxPbjXF5nigSOyzrMeYrmnA4U3
        SSlSUuzvWnzxn/m22XnEcGk=
X-Google-Smtp-Source: ABdhPJyNlPnuzSSqBs52K2oYhhbOxSKo8lWFfb8Mx8Ujp8XVMrQYh7+5HaHFk5EUsvb/Td2B6o2Cdw==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr7127281wrr.99.1639981682079;
        Sun, 19 Dec 2021 22:28:02 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id w6sm4937097wrs.52.2021.12.19.22.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 22:28:01 -0800 (PST)
Message-ID: <8a10bea0-fb8a-c25a-6828-ab907b336d0b@kernel.org>
Date:   Mon, 20 Dec 2021 07:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] serial: Fix incorrect rs485 polarity on uart open
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Su Bao Cheng <baocheng.su@siemens.com>, baocheng_su@163.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Rafael Gago Castano <rgc@hms.se>
References: <9395767847833f2f3193c49cde38501eeb3b5669.1639821059.git.lukas@wunner.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <9395767847833f2f3193c49cde38501eeb3b5669.1639821059.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18. 12. 21, 10:58, Lukas Wunner wrote:
> Commit a6845e1e1b78 ("serial: core: Consider rs485 settings to drive
> RTS") sought to deassert RTS when opening an rs485-enabled uart port.
> That way, the transceiver does not occupy the bus until it transmits
> data.
> 
> Unfortunately, the commit mixed up the logic and *asserted* RTS instead
> of *deasserting* it:
> 
> The commit amended uart_port_dtr_rts(), which raises DTR and RTS when
> opening an rs232 port.  "Raising" actually means lowering the signal
> that's coming out of the uart, because an rs232 transceiver not only
> changes a signal's voltage level, it also *inverts* the signal.  See
> the simplified schematic in the MAX232 datasheet for an example:
> https://www.ti.com/lit/ds/symlink/max232.pdf
> 
> So, to raise RTS on an rs232 port, TIOCM_RTS is *set* in port->mctrl
> and that results in the signal being driven low.
> 
> In contrast to rs232, the signal level for rs485 Transmit Enable is the
> identity, not the inversion:  If the transceiver expects a "high" RTS
> signal for Transmit Enable, the signal coming out of the uart must also
> be high, so TIOCM_RTS must be *cleared* in port->mctrl.
> 
> The commit did the exact opposite, but it's easy to see why given the
> confusing semantics of rs232 and rs485.  Fix it.
> 
> Fixes: a6845e1e1b78 ("serial: core: Consider rs485 settings to drive RTS")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.14+
> Cc: Rafael Gago Castano <rgc@hms.se>

Rafael, can you ack/test this, please?

> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Su Bao Cheng <baocheng.su@siemens.com>
> ---
>   drivers/tty/serial/serial_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 29f4781..259f28e 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -162,7 +162,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
>   	int RTS_after_send = !!(uport->rs485.flags & SER_RS485_RTS_AFTER_SEND);
>   
>   	if (raise) {
> -		if (rs485_on && !RTS_after_send) {
> +		if (rs485_on && RTS_after_send) {
>   			uart_set_mctrl(uport, TIOCM_DTR);
>   			uart_clear_mctrl(uport, TIOCM_RTS);
>   		} else {
> @@ -171,7 +171,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
>   	} else {
>   		unsigned int clear = TIOCM_DTR;
>   
> -		clear |= (!rs485_on || !RTS_after_send) ? TIOCM_RTS : 0;
> +		clear |= (!rs485_on || RTS_after_send) ? TIOCM_RTS : 0;
>   		uart_clear_mctrl(uport, clear);
>   	}
>   }


-- 
js
suse labs
