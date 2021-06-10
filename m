Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1C8C48BDF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E4E613F1
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 15:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhFJPTM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:19:12 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:45724 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhFJPTL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 11:19:11 -0400
Received: by mail-io1-f42.google.com with SMTP id k5so17621634iow.12
        for <linux-serial@vger.kernel.org>; Thu, 10 Jun 2021 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CoLn4qViOeYGj00Cr57KHBOqwdLExPB58jgkoo3+kw4=;
        b=Om2bUvQgE2Xgs9cDoQxX/2kBFI2K66NFIlU9JDmEIPGlMCHD0ieH6TlNQnXGQz3B07
         M2bCCqT3HjMFO1o8A7QhWEK3x00FJzwQZAIWMPYfx29Kgnl791SPIi9sUkPq/4TDbIix
         MsvhgDVntFLr8RjuuittAj8mZltWU2WKZ9hV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CoLn4qViOeYGj00Cr57KHBOqwdLExPB58jgkoo3+kw4=;
        b=lt3qnbJAt9pNWkTAa4EPyHFldtGzyLCcMdHXLs/5U/yNF1skcN+6k/TdgmBN53k6qn
         4G4cR8foAy9fzfUQL/IiT1Geg3TWOgJzcy/42j37vDwfaq0+6rKsHSqwPVQ6u8FwaVYW
         OoZCO7wc8f7IPsguhW+VOy2Z/xF1xep7Vz4UJSb9PUn65tCBxDmDq6qas0+fezLX5tHO
         lcYlcauk/wO8kShboG2TD+eWpcZzCxMFQRsSQ9QS7EtID3EPLNqsK4UvRdJ6PshaBxc9
         oQ2N+THm5B0tVQgpkWJTBS7lMHausd0u7h23QB+D4B1iLD6TFkrWTPf6atKamgVZnusL
         TRtA==
X-Gm-Message-State: AOAM532vfHymjbIIizIRF9wjjv7ippLc3uaBuGGPrYk32YZYFL7MXpyi
        LvQpKbXmJ4iIZTg/buf4KGca3A==
X-Google-Smtp-Source: ABdhPJzrK+ymUDdzzgUR5JsVtJu/hPBNk+7tFS5Ro4H8pl6LapGKsn8k4Sq+vVh6f6Sbxu1L7cxBtQ==
X-Received: by 2002:a05:6638:1202:: with SMTP id n2mr5200296jas.57.1623338159216;
        Thu, 10 Jun 2021 08:15:59 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g14sm1671700ioo.19.2021.06.10.08.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:15:57 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] tty: make use of tty_get_{char,frame}_size
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, David Lin <dtwlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oliver Neukum <oneukum@suse.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210610090247.2593-1-jslaby@suse.cz> <20210610090247.2593-4-jslaby@suse.cz>
From:   Alex Elder <elder@ieee.org>
Message-ID: <0f61ae31-cfad-cd78-b976-c05f56c89d4c@ieee.org>
Date:   Thu, 10 Jun 2021 10:15:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610090247.2593-4-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/10/21 4:02 AM, Jiri Slaby wrote:
> In the previous patch, we introduced tty_get_char_size() and
> tty_get_frame_size() for computing character and frame sizes,
> respectively. Here, we make use of them in various tty drivers where
> applicable.
> 
> The stats look nice: 12 insertions, 169 deletions.

Agreed.  Looks good to me (for drivers/staging/greybus/uart.c).

Acked-by: Alex Elder <elder@kernel.org>

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Oliver Neukum <oneukum@suse.com>
