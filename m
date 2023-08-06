Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1BEC001DE
	for <linux-serial@archiver.kernel.org>; Sun,  6 Aug 2023 10:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHFK2G (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Aug 2023 06:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjHFK2F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Aug 2023 06:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94D128;
        Sun,  6 Aug 2023 03:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59AEB61015;
        Sun,  6 Aug 2023 10:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE6C433C7;
        Sun,  6 Aug 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691317683;
        bh=HvLJ++4+vllHa04qfBVc6aFLPg2QE1A25oIoz1ifOtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/mNEtwLJQozWj7lttks60F4QC8ZMMAMXF++8wBpKcn28YasY6/QrZ9RshtO31jZf
         QnUnip3lJ9tgNpiS65Pk0+CeX61AxClmtY85zkc9J3pilo3AW9JmxJNvspeVhKVy4L
         TIVqzihHsf8CCA8nkgG9bapmxHicOz8c3J7XQCkAuos/tV2LsgH+JBmfc65V03LfEj
         t6UxIX25U7inBteX4vEPrK69N9M/LTI6ixGfLkMa2yqvc+jwLQrTO+6RYaBnBWFPIK
         CydrhvQtkK8fi5WCXWuWkQSo4zvhFJm3fbRyxeKADQIX6TKtF0Ne9DnwYMsSZdKzCX
         ZDjlNhn/AlEUw==
Date:   Sun, 6 Aug 2023 18:16:23 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] serial: 8250_dw: fall back to poll if there's no
 interrupt
Message-ID: <ZM9y93rVVnIIQzzP@xhacker>
References: <20230806092056.2467-1-jszhang@kernel.org>
 <2023080643-chalice-exploring-e7ca@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023080643-chalice-exploring-e7ca@gregkh>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 06, 2023 at 12:20:11PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 06, 2023 at 05:20:54PM +0800, Jisheng Zhang wrote:
> > When there's no irq(this can be due to various reasons, for example,
> > no irq from HW support, or we just want to use poll solution, and so
> > on), falling back to poll is still better than no support at all.
> 
> Ouch, really?  Why not just fix the hardware instead?
> 

Hi Greg,

The HW may be designed as that to save interrupt lines if the uart
is dedicated to debug purpose. I also see similar support in other
uart drivers, for example liteuart.c, altera_uart.c, altera_jtaguart.c
8250_ioc3.c and so on.

Thanks
