Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B223AC433ED
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C1161381
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 09:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbhDEJ5n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Apr 2021 05:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbhDEJ5m (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Apr 2021 05:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4E9561380;
        Mon,  5 Apr 2021 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617616656;
        bh=d9HlR0nLkG6xK/HNnzIIxLY3lGXnWcpcZ5rsNapVVi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oz3S9KS983nuTHFfnD8hpO2M5cho78FXaOZcitl41YVx4X+TlU3zWXrCdkAO7d1ac
         MoNsUY+tPGSOTuIKdgLMARCmYbQ/2cgn2hFIqNmeZ6yTQsHqxthoUmvtvhjl2QTrS3
         iUH/qyu/qtxMzGdnWmVTv6foeyBEiyMi/vjSEDIE=
Date:   Mon, 5 Apr 2021 11:57:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Sawyer <dansawyer@earthlink.net>
Cc:     linux-serial@vger.kernel.org
Subject: Re: requested message -
Message-ID: <YGrfDYj+CA+dsLQh@kroah.com>
References: <b85d1bb2-71e7-a2db-1e0b-11317cd8f16f@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b85d1bb2-71e7-a2db-1e0b-11317cd8f16f@earthlink.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Apr 04, 2021 at 05:16:27PM -0700, Dan Sawyer wrote:
> Below are outputs for a pci dev. I am not sure if this device correctly
> configured or not.
> 
> Thank you,
> 
> Dan
> 
> lspci -vv
> 
> 01:00.0 Communication controller: MosChip Semiconductor Technology Ltd. PCI
> 9835 Multi-I/O Controller (rev 01)
>     Subsystem: LSI Logic / Symbios Logic PCI 9835 Multi-I/O Controller
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin A routed to IRQ 21
>     Region 0: I/O ports at d050 [size=8]
>     Region 1: I/O ports at d040 [size=8]
>     Region 2: I/O ports at d030 [size=8]
>     Region 3: I/O ports at d020 [size=8]
>     Region 4: I/O ports at d010 [size=8]
>     Region 5: I/O ports at d000 [size=16]
>     Kernel modules: parport_serial
> 
>   9.855040] parport1: PC-style at 0xd030, irq 21 [PCSPP,TRISTATE,EPP]
> [    9.872857] intel_powerclamp: No package C-state available
> [    9.946228] intel_powerclamp: No package C-state available
> [    9.969597] parport_serial 0000:01:00.0: 0000:01:00.0: unknown
> NetMos/Mostech device
>                Please send the output of lspci -vv, this
>                message (0x9710,0x9835,0x1000,0x0010), the
>                manufacturer and name of serial board or
>                modem board to <linux-serial@vger.kernel.org>.
> 

How many serial ports are in this device?

thanks,

greg k-h
