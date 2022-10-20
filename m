Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873DDC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 20 Oct 2022 05:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJTFEI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Oct 2022 01:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTFEI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Oct 2022 01:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB7192DAF
        for <linux-serial@vger.kernel.org>; Wed, 19 Oct 2022 22:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC2EB614F6
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2022 05:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4505C433C1;
        Thu, 20 Oct 2022 05:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666242246;
        bh=K4Jjt07dMLopM/8GOESL72o8qfREKAk3uE+vzUJw8c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDwZrXIHH2VXgSRQEw+ykUUF6/udB8iOH954dAhVT2hBR1D4srV2TirD7dPlqSfE5
         wF1C3MgADljzFFliKplfoLz06cA2l/bpWKmJ+FGzYIdt0103lHOnUdUF+StQZ32wjh
         2aqdB9awZVD3qiNiZecuMoX9L8ulIo3eAMvmKguU=
Date:   Thu, 20 Oct 2022 07:04:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        robh@kernel.org, ztong0001@gmail.com
Subject: Re: [PATCH] earlycon: Fix compile error when SERIAL_CORE is m
Message-ID: <Y1DW9Q5HLsh4kBnm@kroah.com>
References: <20221020032722.3263846-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020032722.3263846-1-zhangxiaoxu5@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 20, 2022 at 11:27:22AM +0800, Zhang Xiaoxu wrote:
> When set CONFIG_SERIAL_EARLYCON=y and CONFIG_SERIAL_CORE=m, there is
> a compile error as below:
> 
>   ld: vmlinux.o: in function `parse_options.constprop.0':
>   earlycon.c:(.init.text+0xba5a3): undefined reference to `uart_parse_earlycon'
> 
> Since the SERIAL_EARLYCON use 'uart_parse_earlycon' which defined in
> SERIAL_CORE, so should select rather than depends on.

No, please try to never use "select".

> 
> Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")

So this has been a problem for a very very long time and never been
seen until now?  That feels wrong, what changed to cause this to not
ever be hit before with all of the tens of thousands of random configs
that have been built since this very old kernel?

thanks,

greg k-h
