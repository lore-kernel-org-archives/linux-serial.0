Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDBEC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC28E61A09
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 15:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhCXPzK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbhCXPyp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 11:54:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46FC061763;
        Wed, 24 Mar 2021 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=I2xpReb+Q+Q1diYZpcjuJpGAG3Fdmg/zik0Wf8EL8a8=; b=nULHOq0vFVBfhvbxamQM8u7tp5
        XhdoIrQ8EDQXNlEFI2P6Eb0IWiWTJNWZTgkZyJM9bHNsEr5fOlBjmvIpLiFLa6/XhSt8DjFGzOc5a
        Ir+MTSN/CHEo7cbcd5v2kXo9JDkrzIgELxP7eZkHwihkxcaFEJWSCbHbJA3D+nlBhiyQNM8xf6xYT
        i/nZZxpvrsED6GLZrCGDjRz5/BM99PCl2/2EyI0SJeUnfRHnTXDnMGY4JSZb+tL4hHupCo8DLXG2v
        AFr8wh6djeB6UMWy588cc102g1Pj5J4e0gnir4BjyvA1GdTyb+iL+0IN7cciIwp9XoJk/xGMLeSs+
        nB53gbWQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP5pq-00BY99-Ry; Wed, 24 Mar 2021 15:54:26 +0000
Subject: Re: linux-next: Tree for Mar 24 (drivers/tty/serial/pch_uart.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20210324210718.0c2e6d62@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <635dac0e-a82c-d3d0-c03b-e9d87585b39a@infradead.org>
Date:   Wed, 24 Mar 2021 08:54:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324210718.0c2e6d62@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/24/21 3:07 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20210323:
> 


on x86_64:
# CONFIG_DEBUG_FS is not set


../drivers/tty/serial/pch_uart.c: In function ‘pch_uart_init_port’:
../drivers/tty/serial/pch_uart.c:1815:9: error: ‘port_regs_ops’ undeclared (first use in this function); did you mean ‘kobj_ns_ops’?
        &port_regs_ops);


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
