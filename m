Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF37C2BABC
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AA92415B
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 14:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Hd3902wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgDFOsd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:48:33 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35993 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgDFOsd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 10:48:33 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 90FB322ED5;
        Mon,  6 Apr 2020 16:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1586184511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZsGeQd5LtxyyegUv3kXe2CTCf6ymiwjb/Rg6AcLBqYg=;
        b=Hd3902wuRwba3PtE6yErTa/Px4FQ+6x67tZncT1VdNJkjR/PZKaNlP2Ak3xZqoG6JjqBJN
        aCAxqd/a0xdTzigC1vfJQGrLu3CZAMF9WLqNleb1hGZ+ukKr0AcIFrzlSI5iiOsoqjwFoi
        GZXGMZcl+J3ry4q3QEP2UzzBTa340PI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Apr 2020 16:48:31 +0200
From:   Michael Walle <michael@walle.cc>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [bug report] tty: serial: fsl_lpuart: fix DMA mapping
In-Reply-To: <20200406144243.GB68494@mwanda>
References: <20200406144243.GB68494@mwanda>
Message-ID: <6a2d4108095bafbd1a1f5580ddf97a4b@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 90FB322ED5
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         NEURAL_HAM(-0.00)[-0.788];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 2020-04-06 16:42, schrieb Dan Carpenter:
> Hello Michael Walle,
> 
> This is a semi-automatic email about new static checker warnings.

Thanks, fix is pending, see here:
   
https://lore.kernel.org/linux-serial/20200403174942.9594-1-michael@walle.cc/

-michael

> 
> The patch a092ab25fdaa: "tty: serial: fsl_lpuart: fix DMA mapping"
> from Mar 6, 2020, leads to the following Smatch complaint:
> 
>     drivers/tty/serial/fsl_lpuart.c:1237 lpuart_dma_rx_free()
>     error: we previously assumed 'chan' could be null (see line 1234)
> 
> drivers/tty/serial/fsl_lpuart.c
>   1228  static void lpuart_dma_rx_free(struct uart_port *port)
>   1229  {
>   1230          struct lpuart_port *sport = container_of(port,
>   1231                                          struct lpuart_port, 
> port);
>   1232          struct dma_chan *chan = sport->dma_rx_chan;
>   1233
>   1234		if (chan)
>                     ^^^^
> The patch adds a check
> 
>   1235			dmaengine_terminate_all(chan);
>   1236
>   1237		dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, 
> DMA_FROM_DEVICE);
>                              ^^^^^^
> and an unchecked dereference.
> 
>   1238		kfree(sport->rx_ring.buf);
>   1239		sport->rx_ring.tail = 0;
> 
> regards,
> dan carpenter
