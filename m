Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13392C0015E
	for <linux-serial@archiver.kernel.org>; Fri, 11 Aug 2023 19:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHKTLy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKTLx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Aug 2023 15:11:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4243D2709;
        Fri, 11 Aug 2023 12:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93B662C2B;
        Fri, 11 Aug 2023 19:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38F1C433C8;
        Fri, 11 Aug 2023 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691781112;
        bh=qEv0xjlpZqHRIMwTcKgbAHEP5C2QlnmhQGw49ZFdUD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wZpr+uOJNOY+Z0Lu+VlxW5+wWTG7S1wMJ48xBu91FfFO3O4ANr1JlGl0VrrU5oj+c
         ykBvI/XrE7Pc+8JW/C5DAy1k8hF7jFALZQr1KTJu/dD3m4g0l2dnRQu9asVeZvLVvk
         +LR7CjPh1T3KLXDzgdSrssuEBX/AvwtiD70OtKuk=
Date:   Fri, 11 Aug 2023 21:11:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Hu <nick.hu@sifive.com>
Cc:     zong.li@sifive.com, jirislaby@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/1] Add Sifive uart suspend and resume
Message-ID: <2023081143-flannels-verbally-9d0f@gregkh>
References: <20230809135042.2443350-1-nick.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809135042.2443350-1-nick.hu@sifive.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 09, 2023 at 09:50:41PM +0800, Nick Hu wrote:
> Add Sifive uart suspend and resume functions for system suspend.
> 
> Changes in v2:
> - Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
> - Remove the unnecessary check
> 
> Nick Hu (1):
>   serial: sifive: Add suspend and resume operations
> 
>  drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> -- 
> 2.34.1
> 

Does not apply to my tree :(
