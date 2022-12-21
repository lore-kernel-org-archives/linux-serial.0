Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC86C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 21 Dec 2022 16:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLUQJe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Dec 2022 11:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLUQJd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Dec 2022 11:09:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169372037A;
        Wed, 21 Dec 2022 08:09:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B05A461737;
        Wed, 21 Dec 2022 16:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E89C433EF;
        Wed, 21 Dec 2022 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671638971;
        bh=WegjlHZSrUxyZMNhSDJru775pDVx95szKJ8e3B7Aeog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QK5xUwZmJxxObJmEls87rAGucBZJ6W8OjeLiVl95LTXFoxW95UFG7boYHy5pL3o2O
         GxYB1CpzmH6ITfFI401jAUqO1llQBDywynG98OLbwq5C1+JozHW9ei8iO+ZTEKsPx7
         3r07rVP5otc87SecBDuro99rlqBsWPZmfnZ6qDME=
Date:   Wed, 21 Dec 2022 17:09:28 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Bin Meng <bmeng@tinylab.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        aou <aou@eecs.berkeley.edu>,
        "catalin.marinas" <catalin.marinas@arm.com>,
        jirislaby <jirislaby@kernel.org>, palmer <palmer@dabbelt.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        linux <linux@armlinux.org.uk>, will <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/3] serial: Add RISC-V support to the earlycon
 semihost driver
Message-ID: <Y6MvuJfocYIw9NPv@kroah.com>
References: <20221209150437.795918-1-bmeng@tinylab.org>
 <em37536add-7867-4e7d-9294-9a8389a661e2@a9022134.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em37536add-7867-4e7d-9294-9a8389a661e2@a9022134.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 21, 2022 at 03:51:59PM +0000, Bin Meng wrote:
> On 2022/12/9 23:04:34, "Bin Meng" <bmeng@tinylab.org> wrote:
> 
> > RISC-V semihosting spec [1] is built on top of the existing Arm one;
> > we can add RISC-V earlycon semihost driver easily.
> > 
> > This series refactors the existing driver a little bit, to move smh_putc()
> > variants in respective arch's semihost.h, then we can implement RISC-V's
> > version in the riscv arch directory.
> > 
> > Link: https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc [1]
> > 
> > Changes in v3:
> > - add #ifdef in the header to prevent from multiple inclusion
> > - add forward-declare struct uart_port
> > - add a Link tag in the commit message
> > 
> Ping?

It is the middle of the merge window, we can not do anything until after
6.2-rc1 is out, please be patient.

While you wait, please take the time to review other patches on the
mailing list to help with the workload of the maintainers.

thanks,

greg k-h
