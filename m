Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EE2C7618A
	for <linux-serial@archiver.kernel.org>; Mon, 20 Mar 2023 09:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCTJx6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Mar 2023 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjCTJxx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Mar 2023 05:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF026A7
        for <linux-serial@vger.kernel.org>; Mon, 20 Mar 2023 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679305986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3Pj/3G+pw/sNJtACsoO/q2uAYR7s0D8aHjD/OdMQHg=;
        b=TPGkZx+9W5a/QR7WS0lBRAEjjllEIF2ZtWk5bPamtMRJ3sOpQ0HuQnbZ9ebPmpZcJpOv8V
        0L5qw5rBicpF+sU/CpJ7JxUxo43TMVmxuanCgvzbuEliLgrB+maEiF0GHRYWa5+7h2LxN9
        bmH4jJTBRBB/Nd2DBCciGI/fJwadCaA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-fnmxB0B8N_-mqyq0hSiVRA-1; Mon, 20 Mar 2023 05:52:58 -0400
X-MC-Unique: fnmxB0B8N_-mqyq0hSiVRA-1
Received: by mail-ed1-f69.google.com with SMTP id y24-20020aa7ccd8000000b004be3955a42eso16850296edt.22
        for <linux-serial@vger.kernel.org>; Mon, 20 Mar 2023 02:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679305977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3Pj/3G+pw/sNJtACsoO/q2uAYR7s0D8aHjD/OdMQHg=;
        b=Z8IzYvjGq1ub60REFaInYzTwJLCzl0CST8W4fkVdl3Zrz8NS0idt5XvlzmH1sboWdn
         RNEctXRxEHsTPKB6DdTBhNp8s24RC1rymscq5DZ9OjCpA+/S1WmOZXoZ9j7fGhyKO6JD
         PeTeLq7QgAfhG0TbZs1E7KMo1k5UY2HnL44WNBr1h2GBhkdg/nfxhb5tjQn0kVGzB564
         bOYNXLJGhCZnOki9FlE3gjrCKj2wvz2RLCaq6UyRpw267c4io6t02oIxVBRO4FF5woCv
         RWEkALv2kN0aUO76mi5FKXSPHAAYTlvfdMhKX49ZvxzD/3i9qbdrMs2b28LmuRZXvZ8F
         i/gg==
X-Gm-Message-State: AO0yUKUJTEN8wHkNLXzqu/+7gkP1qX1TtPJwItAbYRCqqUu8jh3giRUW
        0hg/zXzK/gD4yoOCMh6YOm6XjKr1fL0c5w6hnbND8KnSFZPWI/TShB6sVZFYzTVeCZrUL2gpZBp
        XzibkVQpR86lV9yTPEclNK/+C
X-Received: by 2002:a17:906:1e85:b0:931:1567:f84f with SMTP id e5-20020a1709061e8500b009311567f84fmr7658179ejj.4.1679305976966;
        Mon, 20 Mar 2023 02:52:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set83wgbpdegd2TlXJ3c04BQJtTwdCQY5d7UTH7A95NYc2dSM2iqratMQgySSel+pdRIr9S/3YQ==
X-Received: by 2002:a17:906:1e85:b0:931:1567:f84f with SMTP id e5-20020a1709061e8500b009311567f84fmr7658167ejj.4.1679305976719;
        Mon, 20 Mar 2023 02:52:56 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906310c00b00926d614b890sm4136143ejx.204.2023.03.20.02.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:52:56 -0700 (PDT)
Message-ID: <d8e8a1fd-eff9-6095-b69c-465f7d6de6aa@redhat.com>
Date:   Mon, 20 Mar 2023 10:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] serial: 8250: Prevent starting up DMA Rx on THRI
 interrupt
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20230317103034.12881-1-ilpo.jarvinen@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230317103034.12881-1-ilpo.jarvinen@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 3/17/23 11:30, Ilpo Järvinen wrote:
> Hans de Goede reported Bluetooth adapters (HCIs) connected over an UART
> connection failed due corrupted Rx payload. The problem was narrowed
> down to DMA Rx starting on UART_IIR_THRI interrupt. The problem occurs
> despite LSR having DR bit set, which is precondition for attempting to
> start DMA Rx in the first place.
> 
> From a debug patch:
> [x.807834] 8250irq: iir=cc lsr+saved=60 received=0/15 ier=0f dma_t/rx/err=0/0/0
> [x.808676] 8250irq: iir=c2 lsr+saved=61 received=0/0 ier=0f dma_t/rx/err=0/0/0
> [x.808776] 8250irq: iir=cc lsr+saved=60 received=1/12 ier=0d dma_t/rx/err=0/1/0
> [x.808870] Bluetooth: hci0: Frame reassembly failed (-84)
> 
> In the debug snippet, received field indicates 1 byte was transferred
> over DMA and 12 bytes after that with the non-DMA Rx. The sole byte DMA
> handled was corrupted (gets zeroed) which leads to the HCI failure.
> 
> This problem became apparent after commit e8ffbb71f783 ("serial: 8250:
> use THRE & __stop_tx also with DMA") changed Tx stop behavior. Tx stop
> is now triggered from a THRI interrupt.
> 
> Despite that this problem looks like a HW bug, this fix is not adding
> UART_BUG_xx flag to the driver beucase it seems useful in general to
> avoid starting DMA when there are only a few bytes to transfer.
> Skipping DMA for small transfers avoids the extra overhead DMA incurs.
> 
> Thus, don't setup DMA Rx on UART_IIR_THRI but leave it to a subsequent
> interrupt which has Rx a related IIR value.
> 
> By returning false from handle_rx_dma(), the DMA vs non-DMA decision is
> postponed until either UART_IIR_RDI (FIFO threshold worth of bytes
> awaiting) or UART_IIR_TIMEOUT (inter-character timeout) triggers at a
> later time which allows better to discern whether the number of bytes
> warrants starting DMA or not.
> 
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks, patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/tty/serial/8250/8250_port.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index fa43df05342b..3ba9c8b93ae6 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1903,6 +1903,17 @@ EXPORT_SYMBOL_GPL(serial8250_modem_status);
>  static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
>  {
>  	switch (iir & 0x3f) {
> +	case UART_IIR_THRI:
> +		/*
> +		 * Postpone DMA or not decision to IIR_RDI or IIR_RX_TIMEOUT
> +		 * because it's impossible to do an informed decision about
> +		 * that with IIR_THRI.
> +		 *
> +		 * This also fixes one known DMA Rx corruption issue where
> +		 * DR is asserted but DMA Rx only gets a corrupted zero byte
> +		 * (too early DR?).
> +		 */
> +		return false;
>  	case UART_IIR_RDI:
>  		if (!up->dma->rx_running)
>  			break;

