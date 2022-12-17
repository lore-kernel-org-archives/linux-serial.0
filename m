Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C8C10F1B
	for <linux-serial@archiver.kernel.org>; Sat, 17 Dec 2022 02:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLQC27 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Dec 2022 21:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLQC26 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Dec 2022 21:28:58 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C62D2F6
        for <linux-serial@vger.kernel.org>; Fri, 16 Dec 2022 18:28:56 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 83CA384E8F;
        Sat, 17 Dec 2022 03:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671244134;
        bh=Vx8cqL+nZJ2mCHK55sgVTq9WnS2+/3Lbg32HIFjo55A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q0tf4VqSMJZYG+bJv0j/WjHQduXefOJoD+fb1CkqPWtDtzBelW0bD236j7zL28InQ
         hrEEoIfSV08NAl/wtBgyjcl7M55aQ5Y1cQ+jdwucb1e4GEhiiQiOW+d7gihibSMW1r
         mrcZXvK9rek5aLIAi/tLatRYOmZSX617ioUowLkrL1wjCvf+w5l0n2+UdVtwUVrdIq
         FjoA0O+DL2FCwLy7zpkZrs8HGLX1d/EM2cu6ooc8SFtvHX13Zjbglg5anzpPWHDWBG
         lIgaIB5D6PKGrweGOsSARbhJgE7lg+6wFGnV/TA5mJ21uchC9K4IF7NdlvIgzORX51
         QBv7pkJB0HmRA==
Message-ID: <a8a3caa2-4be6-c672-8607-7c8795e5f583@denx.de>
Date:   Sat, 17 Dec 2022 03:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221216021504.457699-1-marex@denx.de>
 <Y5wljLfx4bj1R9kl@linutronix.de>
 <7eba06d4-4ea1-0a15-2bb0-a1837f342a34@denx.de>
 <Y5yfhkO4NAdxrxf6@linutronix.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y5yfhkO4NAdxrxf6@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/16/22 17:40, Sebastian Andrzej Siewior wrote:
> On 2022-12-16 12:52:43 [+0100], Marek Vasut wrote:
>>> Also it might be worth checking if the DMA mode makes any sense if the
>>> FIFO is so small.
>>
>> If you want to push a lot of data through the UART without refilling the
>> small FIFO all the time and getting a lot of IRQs, that's where the DMA
>> comes in. Maybe I misunderstood this comment ?
> 
> I have no idea how this works in detail. However: if you FIFO which is
> 16 bytes deep then filling it means 16 writes and so one interrupt every
> 16 bytes. If the DMA engine is the "average slave dma support" then it
> gets programmed to fill 16 bytes and then issues an interrupt again. The
> "lucky" case if you can program say 512 bytes (or so) and the DMA
> engines itself is able to fill the FIFO 32 times without involving the
> CPU. The last case is clear win.

Ah, no, on the STM32 the DMA should be capable of streaming arbitrary 
amount of data from DRAM to the UART FIFO if needed I think.

> If you have the 16 bytes-DMA case then you would have to check what is
> cheaper: programming the DMA engine for 16 bytes or stuffing it directly
> into the FIFO.
> If the DMA engine supports the larger case say 512 and refills the FIFO
> on its own, then using it makes sense. However this makes usually sense
> for larger transfers. Having a console on it usually leads to more
> overhead because you receive usually say two bytes a second (unless you
> are a fast typer). Sending depends on the usecase and the peak is
> usually during boot. People doing BT via UART usually want to use DMA
> because of the insane amount of data, that is pumped.

Yes, I think we are in agreement here. The terse version was just a bit 
too terse. Thanks
