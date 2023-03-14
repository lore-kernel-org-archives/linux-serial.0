Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1467C6FD1C
	for <linux-serial@archiver.kernel.org>; Tue, 14 Mar 2023 16:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCNQFa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Mar 2023 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCNQFS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Mar 2023 12:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793BC49ED
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678809854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzhvSJRegQ05cQTbLX/ulW/gRiFVC1V7BJQvKFcfYec=;
        b=CzOrVCk/EOhaUAud7pm14UPP8XPvtg4CLBoQ5p3aeAI+Sdd1VCY0wA2LUarMKB3JkwoIp+
        LUgBq7vfcbv8fu3r+ONzuSEdWjm6SlpCpg6ASHzhn3eHOwgbAjEnx/kdBxbvoIXr+1lOuW
        3Z+CQUEEKO8wG5r/n3LXkAQDnLLXSSY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-qL5XdwijObCSBQM9lNJ7BQ-1; Tue, 14 Mar 2023 12:04:08 -0400
X-MC-Unique: qL5XdwijObCSBQM9lNJ7BQ-1
Received: by mail-ed1-f71.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so3815734edj.3
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 09:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678809845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzhvSJRegQ05cQTbLX/ulW/gRiFVC1V7BJQvKFcfYec=;
        b=bZ7PBHt4zJASzZtejd1b8fKmm0EXICIvjOMBacxJfIyOuiHuWwg6qzfRun+OUXiQP6
         Xq1SExYM+UweJMjJ7FFDX/hzZblwjFL0QWJ48J74StFwAEHAdhm3KSJPKxG2O54srY0i
         p8RJ4sVHRJycOkDz5owYfkK+q5PU9DIIov54T4R6gk+cE40m+kL1Me3gZ1UuKgF2aCqX
         Bx4WxbBIxPOxBtRSGtRCfpEzhk9YJYzdVPRfpRWhbT6HSkU8u2VPEtkP7KXvksh92IId
         qQlzD46edGCgomj2gBzsDh3KzO6+vEF6gaDcIKocBPs+w89pGa8uZz+WCSbrfMeMXcj3
         p51A==
X-Gm-Message-State: AO0yUKXmpZr4BD6WPixvtIBMd3IYuaTZ7FzaITObkVkZKqvY+uflq8wO
        vNh0DpCzF341ZuWLEs5oRmBhba4I0eabthByIbRS1wOx0bxggLQFx4N3k4yuhAIUYRMTmIJw4Ri
        N7e1Qs5FUOVPUcfsGH1gOI1lW
X-Received: by 2002:aa7:c1c4:0:b0:4af:62af:460a with SMTP id d4-20020aa7c1c4000000b004af62af460amr40759557edp.8.1678809845305;
        Tue, 14 Mar 2023 09:04:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set+rsZRW7ngfyVs1NjQdwwpLtAriJ4EtFBBn3WM8n97D7YdRpbBS/yzimkmwIVfaOhbl7Kqu/Q==
X-Received: by 2002:aa7:c1c4:0:b0:4af:62af:460a with SMTP id d4-20020aa7c1c4000000b004af62af460amr40759527edp.8.1678809844953;
        Tue, 14 Mar 2023 09:04:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id u19-20020a50c053000000b004fc537aec3csm1255162edd.74.2023.03.14.09.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:04:04 -0700 (PDT)
Message-ID: <9e1e207f-a74f-cedb-6811-993d6b0a26cf@redhat.com>
Date:   Tue, 14 Mar 2023 17:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com>
 <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com>
 <316ab583-d217-a332-d161-8225b0cee227@redhat.com>
 <1d7c80cf-cf79-ef1-58ba-e3b99294bb6@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1d7c80cf-cf79-ef1-58ba-e3b99294bb6@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 3/14/23 12:48, Ilpo Järvinen wrote:
> On Tue, 14 Mar 2023, Hans de Goede wrote:
>> On 3/14/23 11:55, Ilpo Järvinen wrote:
>>> On Tue, 14 Mar 2023, Hans de Goede wrote:
>>>
>>>> I have spend the last couple of days debugging a problem with Bluetooth
>>>> adapters (HCIs) connected over an UART connection on Intel Bay Trail
>>>> and Cherry Trail devices.
>>>>
>>>> After much debugging I found out that sometimes the first byte of
>>>> a received packet (data[0]) would be overwritten with a 0 byte.
>>>>
>>>> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
>>>>
>>>> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
>>>>
>>>> would sometimes turn into:
>>>>
>>>> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
>>>>
>>>> Further investigation revealed that this goes away if I stop
>>>> the dw_dmac module from loading, leading to:
>>>> "dw-apb-uart 80860F0A:00: failed to request DMA"
>>>> and the UART working without DMA support.
>>>>
>>>> Testing various kernels showed that this problem was introduced
>>>> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
>>>>
>>>> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
>>>>
>>>> And reverting that on top of v6.3-rc2 indeed solves the problem.
>>>
>>> You did something else too than just that because you cannot cleanly 
>>> revert just e8ffbb71f783. Please indicate what happened to:
>>>   f8d6e9d3ca5c ("serial: 8250: Fix __stop_tx() & DMA Tx restart races")
>>>
>>> I guess you reverted that too and forgot to mention about it but I just 
>>> want to be sure we're on the same page?
>>
>> I manually fixed up the revert, effectively
>> dropping the drivers/tty/serial/8250/8250_port.c part of f8d6e9d3ca5c
>> I did not revert f8d6e9d3ca5c in its entirety.
>>
>> I've attached my manual fixed up revert as a patch here.
>>
>>>> So it seems that that commit somehow interferes with DMA based
>>>> data receiving, causing the first byte of a received data transfer
>>>> to get replaced by 0.
>>>
>>> Okay, and you're sure the problem/corruption occurs on the receiving side? 
>>
>> What I am sure is that the first byte of a packet has been replaced by 0
>> by the time drivers/tty/tty_buffer.c: receive_buf() gets called.
>>
>> I did not dive into the serial-port code side of this problem since
>> I'm unfamiliar with that.
>>
>>> Maybe the the extra interrupt that the tx side change will trigger somehow 
>>> causes the confusion on the rx side. So that would be an extra call into 
>>> handle_rx_dma() that could either do an extra flush or start DMA Rx that 
>>> would not occur w/o that tx side change.
>>
>> That sounds like a likely candidate for causing this yes, as said
>> I'm unfamiliar with the serial-port code, but I did already suspect
>> that the change was causing some extra interrupt which somehow
>> interfered with the rx side.
>>
>>>> The issue has been seen on and the revert has been tested on
>>>> the following HW:
>>>>
>>>> Asus T100TA
>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
>>>>
>>>> Lenovo Yoga Tablet 2 1051L
>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
>>>>
>>>> Lenovo Yoga Book X91F
>>>> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
>>>>
>>>> I have more hw which I believe is affected but these are the models
>>>> where I have done detailed testing.
>>>>
>>>> I would be happy to test any patches, or run a kernel with some extra
>>>> debugging added, just let me know what you need to help fixing this.
>>>
>>> How easy this is to trigger in general? (Mainly trying to gauge how 
>>> easy it will be to find the read and/or the irq that related to the 
>>> corrupted payload).
>>
>> For the git bisect I did 10 consecutive "rmmod hci_uart; modprobe hci_uart"
>> calls, re-initializing and re-uploading the BT firmware 10 times and
>> then looked for "Frame reassembly failed" errors (+ more error caused
>> by this error) from the drivers/bluetooth/hci_bcm.c code.
>>
>> This would usually trigger at least twice with the 10 rmmod + modprobe
>> calls and typically more often then twice.
>>
>> With the revert (and with 5.18.y) I never see a single error even
>> with more rmmod + modprobe calls. Note it is not just the driver's
>> probe() which fails, sometimes there are also later errors, this
>> is just a somewhat convenient way to reproduce.
>>
>> So this is somewhat easy to trigger, not trivial to trigger,
>> but it also does not take waiting many hours before hitting it
>> once.
> 
> Okay, maybe the patch below will manage to filter the interesting part of 
> it (not tested beyond compiling). It should capture a few irq events after 
> the THRI is set when DMA Tx completes.
> 
> What I'd expect is to have iir value variation between the working and not 
> working case. Especially, if it's UART_IIR_THRI that shows up that might 
> be usable as a condition to return from handle_rx_dma() without touching
> DMA Rx.

Here are 2 dmesg snippets both are with a 6.3-rc2 kernel *without*
the revert and with your dmesg patch.

This is (part of) the HCI init without issues:

[  733.682492] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
[  733.682628] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
[  733.927142] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  733.928311] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  733.932892] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  733.933818] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  733.970404] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  733.975558] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  734.080290] 8250irq: iir=cc lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  734.081300] 8250irq: iir=cc lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  734.081492] Bluetooth: hci0: BCM: chip id 101

Here is another *successful* log with slightly different timing.

[  737.660532] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
[  737.660681] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
[  737.905238] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  737.906429] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  737.907782] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  737.908978] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  737.935929] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  737.940976] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  738.048476] 8250irq: iir=cc lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  738.049530] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  738.049678] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  738.050142] Bluetooth: hci0: BCM: chip id 101

And here is the same part of the init sequence with an error:

[  771.247538] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
[  771.247656] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
[  771.493259] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  771.494378] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  771.495637] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  771.496833] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  771.523597] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  771.528708] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
[  771.632340] 8250irq: iir=c2 lsr+saved=61 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
[  771.632462] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/1/0 skiprx=0 cnt=-4
[  771.632568] Bluetooth: hci0: Frame reassembly failed (-84)

Here is a full dmesg from several rmmod + modprobes, for the errors look for
"Frame reassembly failed".

Note this is from a different boot, I had to add log_buf_len=50M to be able
to grab a full dmesg:

https://fedorapeople.org/~jwrdegoede/dmesg-8250-dma-issue

Regards,

Hans




> 
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Subject: [PATCH] DEBUG: DMA Rx problem
> 
> A DEBUG PATCH, not intended for upstream inclusing.
> 
> ---
>  drivers/tty/serial/8250/8250_dma.c  |  4 +++-
>  drivers/tty/serial/8250/8250_port.c | 13 +++++++++++++
>  include/linux/serial_8250.h         |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 7fa66501792d..20d54abdded2 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -32,8 +32,10 @@ static void __dma_tx_complete(void *param)
>  		uart_write_wakeup(&p->port);
>  
>  	ret = serial8250_tx_dma(p);
> -	if (ret || !dma->tx_running)
> +	if (ret || !dma->tx_running) {
> +		p->irq_debug = -5;
>  		serial8250_set_THRI(p);
> +	}
>  
>  	spin_unlock_irqrestore(&p->port.lock, flags);
>  }
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index fa43df05342b..193c08b1888a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1923,6 +1923,9 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	bool skip_rx = false;
>  	unsigned long flags;
> +	long irq_debug;
> +	unsigned int tx_running = 0, rx_running = 0, tx_err = 0;
> +	unsigned int ier;
>  	u16 status;
>  
>  	if (iir & UART_IIR_NO_INT)
> @@ -1931,6 +1934,12 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  	spin_lock_irqsave(&port->lock, flags);
>  
>  	status = serial_lsr_in(up);
> +	if (up->dma) {
> +		rx_running = up->dma->rx_running;
> +		tx_running = up->dma->tx_running;
> +		tx_err = up->dma->tx_err;
> +	}
> +	ier = up->ier;
>  
>  	/*
>  	 * If port is stopped and there are no error conditions in the
> @@ -1957,7 +1966,11 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  			__stop_tx(up);
>  	}
>  
> +	irq_debug = up->irq_debug++;
>  	uart_unlock_and_check_sysrq_irqrestore(port, flags);
> +	if (irq_debug < 0)
> +		pr_err("8250irq: iir=%02x lsr+saved=%02x ier=%02x dma_t/rx/err=%u/%u/%u skiprx=%d cnt=%ld\n",
> +		       iir, status, ier, tx_running, rx_running, tx_err, skip_rx, irq_debug);
>  
>  	return 1;
>  }
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 741ed4807a9c..8d9d7de6728d 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -107,6 +107,7 @@ struct uart_8250_port {
>  	unsigned char		mcr;
>  	unsigned char		cur_iotype;	/* Running I/O type */
>  	unsigned int		rpm_tx_active;
> +	long			irq_debug;
>  	unsigned char		canary;		/* non-zero during system sleep
>  						 *   if no_console_suspend
>  						 */
> 

