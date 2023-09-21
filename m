Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6AE7D0AD
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 20:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjIUUgD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjIUUfg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 16:35:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBA8E68A
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:44:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401da71b83cso12988175e9.2
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695318276; x=1695923076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHB7MokjFazEBVZHVWPQWx+ouAjuzlds+fkP2tznoWg=;
        b=Z8I4Afu8x8Tgquf3WxTWqjYEKZtsP0sBDmTYZ5sA35sOBt+xhZDaAx6CQ7HmWe8zMg
         2HPd0vl3iUnFUOKq6h/uTPqVtJr95h8vZzRary/2RjDrj2LBSWjvGivBG0xG1t+RpY1b
         du7EnvWARe8i0EEWUbX0cgu18UxAJStCSTqo1XBxbtNaZ30HEFYhgKN0rszfjmwTEch6
         uDq/Mx/l5nuRYSfD4BtGhnnojwu8XfLdtgptB3Gme951/aKGFQNbn5mIfS3gBe5lU85Z
         r/CWtM/aQ7zVPJhDCThBAaMWILmk9qOpg+3K31Q0Sdso6RnUhiLZAsnYIxXkXTWgZBsc
         coXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318276; x=1695923076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHB7MokjFazEBVZHVWPQWx+ouAjuzlds+fkP2tznoWg=;
        b=MWC3Xe47XYqX+CoQgX8KCvAbF5tFahu8Acv91ICb1g+63jMJ3TXtuhB27xhxkcw9bn
         Y67Z9ogly22HBs56DXuOMclewxwCRjJ4vj6BDPUO8knH6vm9/jDaznMyQXYnFgPiE7Nv
         +WoAdThD6fBM9RtGwkNYdffp8RhHbb61wJ9ZzRv7PsQFy66YQPgO/5FAQfP6pNie3Ln1
         DgMHo6IEz+3lOT6V9dpDM/TRXFGW6RB+mFtS68aTL5Gskz9StGG5jLwCrLLJv+8CuOqU
         5PiZAPW2W7sxs5VBopjMd/jU9XZAPzhqIiQXW3R3x1LEEe68APmftr6PeRxBxiLWyL78
         uymw==
X-Gm-Message-State: AOJu0Yx7ukqbeusdIcoUt01osf/Qj5xcHgdT9od8qdr6Xc0hMpESnW7a
        uFWCeft6YNIBT9ziHvk4Hr54FckHiz8T8Mo4Kns=
X-Google-Smtp-Source: AGHT+IGcpjHnDw8LA8Dyh0T2ryjOdihtn8w38po8JoSvFO1h83wyuE62Gs1r8YrosYCllwS5Zi78ew==
X-Received: by 2002:a17:906:109e:b0:9a9:ef41:e5a6 with SMTP id u30-20020a170906109e00b009a9ef41e5a6mr4612465eju.1.1695292568673;
        Thu, 21 Sep 2023 03:36:08 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id gv10-20020a170906f10a00b0099cd008c1a4sm825012ejb.136.2023.09.21.03.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:36:08 -0700 (PDT)
Message-ID: <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
Date:   Thu, 21 Sep 2023 12:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Wolfram,

(Adding Andy for commit 54b45ee8bd42 "serial: core: Remove
unused PORT_* definitions").

On 20/9/23 22:10, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its type
> definition from 8250 code. As with previous removals, I checked with
> Debian Code Search that 'PORT_AR7' is not used in userspace.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/tty/serial/8250/8250_port.c | 7 -------
>   include/uapi/linux/serial_core.h    | 1 -
>   2 files changed, 8 deletions(-)


> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index add349889d0a..3b51901926f9 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -32,7 +32,6 @@
>   #define PORT_XSCALE	15
>   #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
>   #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
> -#define PORT_AR7	18	/* Texas Instruments AR7 internal UART */

I'm a bit surprised definitions are removed from the uAPI, isn't
it expected to be very stable? Shouldn't it be better to keep it
defined but modify the comment, mentioning "obsolete" or "deprecated"?

Regards,

Phil.

>   #define PORT_U6_16550A	19	/* ST-Ericsson U6xxx internal UART */
>   #define PORT_TEGRA	20	/* NVIDIA Tegra internal UART */
>   #define PORT_XR17D15X	21	/* Exar XR17D15x UART */

