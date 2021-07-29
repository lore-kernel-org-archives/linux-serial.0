Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CDC4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 06:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B3D61042
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 06:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhG2GEF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 02:04:05 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49309 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbhG2GEE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 02:04:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 51A46580B39;
        Thu, 29 Jul 2021 02:04:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Jul 2021 02:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oOA9yKbtZrclxkXt8oi2w9Qy4VI
        sBkPwwH4Zip+yF2Q=; b=jlS/9w7SQZpmcYyil/QHB10d4j+LqD1BBnEeV4VpVbv
        YZcHJh/Vq7gQ63HSRfNySSGszZLBGMRyX1HZCbzDmg98A2mDQDi9CL2eo/w+lBeZ
        9rpP82l3iy8NfhCPOD4RfvQs5zQGdY9wjNBUtjqYjF1AFeAJ3mEGZSxluDAgsqSX
        YcJUHUl1XVpqLVSIG+P7e52LxOPCsz3M/NPpapeIjUKNYZmhv/lebtp/qOd2meNd
        rEUU8cBd+lDKoxPGgYkpcbdhX3u974W8teP+KCvkJ4I1cT1OyQrtyR8pToEKAhuh
        i8/SQExgJwN6Q2vtcdzs1yf3lKlMoM4xPjQPYuouStg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oOA9yK
        btZrclxkXt8oi2w9Qy4VIsBkPwwH4Zip+yF2Q=; b=ErtoLAJ54DmhkFR0iJpgqm
        9ERknF9Qyd1Esscd3Cy/Jh109VV7+BA16zm23A4kNc+Q5nhpTd1Ncu19h+a8bOWD
        rss1BNt43SQWfUysU2ae1tPSYAAPOhpRkvnWjdcBx0BGuh2FKfDxgxCx3zdnnwTh
        aGWwKrbBr67B4XNUUAitjbo+WQAYZEHhyBjlCKWFvyHQNYoCqwoPi6adNPoTuDfK
        FIwj5ID3KnQ9Jh+cEuzw8s8bQZTusEXoKwn4PSHeNwV5LOZvcpQmTqRBkbNI73w9
        MCEaOoM/fdDer11hxBw/9Ow43j2/r671/LX7PS3SiGFeNBJkqyY6uN7EAlJj1Gpg
        ==
X-ME-Sender: <xms:0EQCYbyYxtkJu4glF-PyF7Vmo43tTOkmvx7vk1EntVZdLMEsHu3C3Q>
    <xme:0EQCYTQMDkRSNrRfWPG-hblj2PmnOTxNvFK7bUM5dB0oC_22euwHulzvy7WykXbDR
    hcIb45NDz3qsA>
X-ME-Received: <xmr:0EQCYVVCQuiiDMb-vlKynWBt1gusm3RY0N0qSpi8uTEjqcbSEDY8vYCjsGkVpQytv_Ajx3LMmq2fb0184BL90bN5-mEmdm76>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrhedtgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepfeefueduhe
    egtddvueejueeiveelhedthfejudehteejgfegudffgedttdetheeknecuffhomhgrihhn
    pegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:0EQCYVgIDo1Ew43r7hAFpqP8nmJpY5A5vd9QDYdocfnL7YV5_tY1qw>
    <xmx:0EQCYdBh3Od3AAwJM5CHD0pPk69bSsf7bG7F1_I1lMG6ty4Onw0P6g>
    <xmx:0EQCYeIhXcVY50E1ruC0Z8OVs-Gv2-qNTmHE6IJR-H-yWCCk6BNUhQ>
    <xmx:0UQCYdansu-BxNZUR8BiGYppnOc_z2YNFJumpJ6Ouh-OROzART6GgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jul 2021 02:04:00 -0400 (EDT)
Date:   Thu, 29 Jul 2021 08:03:58 +0200
From:   Greg KH <greg@kroah.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     timur@kernel.org, linux@armlinux.org.uk, alcooperx@gmail.com,
        tklauser@distanz.ch, sean.wang@kernel.org,
        srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        yuchen.huang@mediatek.com, huihui.wang@mediatek.com,
        eddie.huang@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/1] Mediatek uart patch
Message-ID: <YQJEzlb2NyxD1EpD@kroah.com>
References: <20210729014817.11879-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729014817.11879-1-zhiyong.tao@mediatek.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 29, 2021 at 09:48:16AM +0800, Zhiyong Tao wrote:
> This series includes 1 patches:
> 1.fix uart corruption issue when rx power off
> 
> when uart is used as a communication port with external device(GPS).
> when external device(GPS) power off, the power of rx pin is also from
> 1.8v to 0v. Even if there is not any data in rx. But uart rx pin can
> capture the data "0".
> If uart don't receive any data in specified cycle, uart will generates
> BI(Break interrupt) interrupt.
> If external device(GPS) power off, we found that BI interrupt appeared
> continuously and very frequently.
> When uart interrupt type is BI, uart IRQ handler(8250 framwork
> API:serial8250_handle_irq) will push data to tty buffer.
> The code path:
> https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_port.c#L1917
> mtk8250_dma_rx_complete is a task of mtk_uart_apdma_rx_handler.
> mtk8250_dma_rx_complete priority is lower than uart irq
> handler(serial8250_handle_irq).
> if we are in process of mtk8250_dma_rx_complete, uart appear BI
> interrupt:1)serial8250_handle_irq will priority execution.2)it may cause
> write tty buffer conflict in mtk8250_dma_rx_complete.
> So the spin lock protect the rx receive data process is not break.

All of this information should be in the changelog for the patch itself.
There is no need for a "cover letter" for a single patch like this.

Can you redo your 1/1 patch and add the above information to the
changelog text and resend it as a v2?

thanks,

greg k-h
