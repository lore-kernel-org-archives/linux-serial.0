Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E135C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 11:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1616161353
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 11:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhKSLU5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSLU5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 06:20:57 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6AC061574
        for <linux-serial@vger.kernel.org>; Fri, 19 Nov 2021 03:17:56 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 866D9103B1FD9;
        Fri, 19 Nov 2021 12:17:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 627424A8C0; Fri, 19 Nov 2021 12:17:54 +0100 (CET)
Date:   Fri, 19 Nov 2021 12:17:54 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Su Bao Cheng <baocheng_su@163.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        chao.zeng@siemens.com
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control
 while in rs485 mode"
Message-ID: <20211119111754.GB9692@wunner.de>
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
 <61ace2ea-e0b3-599a-3098-8e8a2a4772fa@siemens.com>
 <68b02a33-6cfb-5139-f8b3-20f289c2befc@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b02a33-6cfb-5139-f8b3-20f289c2befc@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 19, 2021 at 09:43:12AM +0100, Jan Kiszka wrote:
> Digging a bit deeper: One issue of the original patch was definitely
> that it tried to sanitized mctrl inside serial8250_do_set_mctrl, rather
> than serial8250_set_mctrl. That caused alternative set_mctrl handler to
> become out of sync /wrt mctrl. Just look at omap8250_set_mctrl, how it
> will work on the unsanitized value.

All omap8250_set_mctrl does is enable or disable autoRTS if autoRTS is
used.  Are you using autoRTS on this port?  That's one of several pieces
of information that I'm missing here to understand what's going on.

Thanks,

Lukas
