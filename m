Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C27C43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF1E2073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 13:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="PDlmSGmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgDCNFw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:05:52 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:50969 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCNFw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 09:05:52 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C890822FF5;
        Fri,  3 Apr 2020 15:05:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585919149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pj9jzC0ZfoChJdTLCxZ7NORdmRiG/WL06eyNPkHoe60=;
        b=PDlmSGmmU+JvBKWwNSQBAwz5PyHCzj7StKS/39socavTZ5CzTPzlcG1Z927kbC4jRoX9pN
        +F7o3RWk2J/1+wrId8Kzpsz8zE6lK+F2VeLpNrraEcD198eOTcpYosVrYEddE2u/9LUsPG
        Ht6ALMCqTck8q4dOiEqpvqlO9P1t0zc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Apr 2020 15:05:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: tty: serial: fsl_lpuart: fix DMA mapping - static analysis bug
 report
In-Reply-To: <9722c1bb-f09e-7332-6381-0b423168afc7@canonical.com>
References: <9722c1bb-f09e-7332-6381-0b423168afc7@canonical.com>
Message-ID: <ba294a2b336b3cde9f5fd2ddbf1fe490@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: C890822FF5
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-1.067];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 2020-04-03 14:44, schrieb Colin Ian King:
> Hi,
> 
> Static analysis with Coverity has found an issue with the following 
> commit:
> 
> From a092ab25fdaa445b821f5959e458350696fce44c Mon Sep 17 00:00:00 2001
> From: Michael Walle <michael@walle.cc>
> Date: Fri, 6 Mar 2020 22:44:31 +0100
> Subject: [PATCH] tty: serial: fsl_lpuart: fix DMA mapping
> 
> The analysis report is as follows for function lpuart_dma_rx_free in
> source drivers/tty/serial/fsl_lpuart.c :
> 
> var_compare_op: Comparing chan to null implies that chan might be null.
> 
> 1234        if (chan)
> 1235                dmaengine_terminate_all(chan);
> 1236
> 
> Dereference after null check (FORWARD_NULL)
> var_deref_op: Dereferencing null pointer chan.
> 
> 1237        dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1,
> DMA_FROM_DEVICE);
> 
> The check for chan being null implies it is may be null, however, the
> call to dma_unmap_sg dereferences chan which leads to a null pointer
> dereference issue.

Technically, this is correct. But lpuart_dma_rx_free() is guarded by
lpuart_dma_rx_use which is only true if there is a dma channel, see
lpuart_rx_dma_startup(). In any way, this looks bogus.

So actually, the "if (chan)" is superfluous. Could you double check 
that?
Then I'd make a patch which removes the if (chan) to make coverity 
happy.

-michael
