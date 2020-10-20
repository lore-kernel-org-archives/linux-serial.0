Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C17C4363D
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383BC223BF
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 23:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nostar-net.20150623.gappssmtp.com header.i=@nostar-net.20150623.gappssmtp.com header.b="pEr971VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439346AbgJTXkb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 19:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439345AbgJTXkb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 19:40:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F3C0613CE
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2020 16:40:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v200so628440qka.0
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2020 16:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nostar-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LHWkUkMjBfUAEKVtWpFK9Z8I2T5aCcDdnyeEbvx8u84=;
        b=pEr971VOcpP4ctQULFqsv22NT2h9xECYVqbynRBZTFzSvz4QMvfQu65Qrhm0ynhrIz
         LeFxORrU4UV9AheL63z6M2DdGbRVRlQIHL/DDnAjuNvWieOyv4XZrwnU1N3K58UXuGnj
         RN9u8Gvj0MBvpyllgvGXfM6KARfspF29oUZhVPdfi5Cfy6soAKwaj17qZcTycYEyKof+
         jhQP8bUNn6DxKmOJlLB2vYtW+XkoppCV/3+MftRgQ6emyyZNu7S5VNm89hpPXOm26ME+
         +aTBChM1xqZV5tQpG/4bNAx6D1iqk5Is3huKns6V+uo5ppFh7A32Ziz5tShUU4CvrKiY
         0xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LHWkUkMjBfUAEKVtWpFK9Z8I2T5aCcDdnyeEbvx8u84=;
        b=U1D9+2LqVbQqUDp+jKhMhdMi615Lsm9UgNMyOa3APys0+MGOVjRrXRD94gRKM9/gBd
         3Ym6fYz2lIjJy//ulcrnVt7LjODVxxHN//ZpNDGjtj4DSbdU8ypjlZEJcCj4rYZl1rls
         Dg+XHL6tOeSOdeJLmJMeh6pFcly8XsDLnpxmot+8xoaKhauyC7709BJyKLbvwBH4nkLs
         o8geRS2DgwBc2kXxAlx51T0pbddeZljWIlxQkYPYba96Idp2uGlNcIVWAKku4Ww6Ba1G
         Zr2r6tNYhulXaR4I1LQgSOEt+VS673foFO3HouLSL3bLhRR/LfpvXyHa6f2FXgNsKA3G
         VjgQ==
X-Gm-Message-State: AOAM532fX1VaNe/9+kS8txPPcRub/Ke6kQ9kDP367z+E46rRgHN+PF6Z
        3sgYmTmyDH58u6SWi9ACfTY9pvE9HT59ISCN
X-Google-Smtp-Source: ABdhPJxh32XYTP1H2ElInJgNcPCPBWtzDm6+G14+h3kzBxKRHa1agdBZ6jh4k2QODxYom2jxK0zL2A==
X-Received: by 2002:a37:51c2:: with SMTP id f185mr702876qkb.171.1603237229993;
        Tue, 20 Oct 2020 16:40:29 -0700 (PDT)
Received: from iggy.local (c-68-37-44-22.hsd1.mi.comcast.net. [68.37.44.22])
        by smtp.gmail.com with ESMTPSA id m25sm260970qki.105.2020.10.20.16.40.29
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 16:40:29 -0700 (PDT)
To:     linux-serial@vger.kernel.org
From:   Doug McLain <doug@nostar.net>
Subject: WCH382 PCIe 2 port serial card problem
Message-ID: <9ae84256-b8e8-efaa-4d0d-0bf14e0418e9@nostar.net>
Date:   Tue, 20 Oct 2020 19:40:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

I have this card 'PCIE 2 Port Serial Expansion Card PCI Express' with 
the WCH382 chip and everything seems to be loading ok by default on 
Fedora 32 but I simply get no communication from either port.  I came 
across this patch submission for this hardware 4 years ago, which is the 
same card as mine:

https://www.spinics.net/lists/linux-serial/msg21083.html

For a simple test I have a null modem cable connected between the 2 DB9 
ports on the card.  I run 2 instances of GtkTerm and set each instance 
to either 115200-8-N-1 or 9600-8-N-1 on /dev/ttyS4 and /dev/ttyS5 and 
just try to pass some bytes back n forth with no results.

dmesg output:
[    3.026478] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.026540] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    3.027743] 0000:03:00.0: ttyS4 at I/O 0xe0c0 (irq = 33, base_baud = 
115200) is a XR16850
[    3.027824] 0000:03:00.0: ttyS5 at I/O 0xe0c8 (irq = 33, base_baud = 
115200) is a XR16850


[nostar@iggy ~]$ sudo lspci -v -n -d 1c00:*
03:00.0 0700: 1c00:3253 (rev 10) (prog-if 05 [16850])
	Subsystem: 1c00:3253
	Flags: bus master, fast devsel, latency 0, IRQ 33
	I/O ports at e000 [size=256]
	Memory at e2100000 (32-bit, prefetchable) [size=32K]
	I/O ports at e100 [size=4]
	Expansion ROM at fc600000 [disabled] [size=32K]
	Capabilities: [60] Power Management version 3
	Capabilities: [68] MSI: Enable- Count=1/32 Maskable+ 64bit+
	Capabilities: [80] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Kernel driver in use: serial


[nostar@iggy ~]$ setserial -g /dev/ttyS4
/dev/ttyS4, UART: 16850, Port: 0xe0c0, IRQ: 33
[nostar@iggy ~]$ setserial -g /dev/ttyS5
/dev/ttyS5, UART: 16850, Port: 0xe0c8, IRQ: 33

I hope someone can help determine what is wrong here, all seems a-ok.



