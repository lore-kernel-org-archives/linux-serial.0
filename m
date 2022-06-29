Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA86CCA47C
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 11:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiF2LN5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jun 2022 07:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2LN4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jun 2022 07:13:56 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19BA3B56D;
        Wed, 29 Jun 2022 04:13:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 53DA54246A;
        Wed, 29 Jun 2022 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1656501228; bh=fywTBmp/Rx3yTXANfmyKbEQMsXV/OITc3j37KagJD9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dS/P6hfgXAo+nwkFg4H3b84PP8vJ03G017njpi4uktB7KVxf1eaa4kZOPapdpzs1e
         hSCPJ/DuIxlUdJ8hVWKq/2onNujAZMpimc3NoYz91T1hY/eRxEYu2lo9Fga9mm1nmu
         Qg1O2K7IMunhjbhlJzaXvCTeYpfJpc/m5WhuFbw68kxq4RXXRWUwkV8Y3EsNfsIXmH
         t5Q96cEJ1XhfkAe9UyMxhL7KAkNv2bF7vaRxFcFGdvP2BNPITTiQ1WMzb2vjxXLJxH
         cmh5wgc+ayBuiCt9WPqvFWaPQfUeJLmD/Vw8ItjO15uhSQRnl8aiDd1QuhWrh+GBNK
         7JM/7n3YDtd2w==
Message-ID: <eff27894-1fa9-6a23-235f-70bd4b29310c@marcan.st>
Date:   Wed, 29 Jun 2022 20:13:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] tty: serial: samsung_tty: support more than 4 uart
 ports
Content-Language: es-ES
To:     Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17@epcas2p4.samsung.com>
 <20220629005538.60132-1-chanho61.park@samsung.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220629005538.60132-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 29/06/2022 09.55, Chanho Park wrote:
> Regarding Exynos Auto v9 SoC, it supports uarts up to 12. However, the
> maximum number of the ports has been derived from
> CONFIG_SERIAL_SAMSUNG_UARTS and tightly coupled with the config for
> previous Samsung SoCs such as s3c24xx and s3c64xx. To overcome this
> limitation, this changes the usage of the definition to UART_NR which is
> widely used from other serial drivers. This also defines the value to 12
> only for ARM64 SoCs to not affect the change to previous arm32 SoCs.
> 
> Instead of enumerating all the ports as predefined arrays, this
> introduces s3c24xx_serial_init_port_default that is initializing the
> structure as the default value.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
