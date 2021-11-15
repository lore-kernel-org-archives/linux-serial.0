Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF7DC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 09:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372DF61B95
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 09:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhKOJ2t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbhKOJ0X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 04:26:23 -0500
Received: from mailg110.ethz.ch (mailg110.ethz.ch [IPv6:2001:67c:10ec:5605::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7B2C0613B9
        for <linux-serial@vger.kernel.org>; Mon, 15 Nov 2021 01:21:52 -0800 (PST)
Received: from mailm113.d.ethz.ch (2001:67c:10ec:5602::25) by mailg110.ethz.ch
 (2001:67c:10ec:5605::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 10:21:46 +0100
Received: from dtkw (213.55.225.240) by mailm113.d.ethz.ch
 (2001:67c:10ec:5602::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 10:21:49 +0100
Date:   Mon, 15 Nov 2021 10:21:48 +0100
From:   Ilia Sergachev <silia@ethz.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: liteuart: fix missing drvdata
Message-ID: <20211115102148.6c30dbf6@dtkw>
In-Reply-To: <YZIF48DPkfgBf5H9@kroah.com>
References: <20211115031808.7ab632ef@dtkw>
        <YZIF48DPkfgBf5H9@kroah.com>
Organization: ETH Zurich
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.55.225.240]
X-ClientProxiedBy: mailm215.d.ethz.ch (2001:67c:10ec:5603::29) To
 mailm113.d.ethz.ch (2001:67c:10ec:5602::25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I'd say 1da81e5562fac8286567422cc56a7fbd0dc646d4 - where 
liteuart_probe() and liteuart_remove() were initially implemented.

Ilia

On Mon, 15 Nov 2021 08:01:55 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> What commit does this fix?
> 
> thanks,
> 
> greg k-h
