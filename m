Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61604C77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 18 May 2023 05:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjERFq2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 May 2023 01:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjERFq1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 May 2023 01:46:27 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA42738
        for <linux-serial@vger.kernel.org>; Wed, 17 May 2023 22:46:26 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so2333920a12.3
        for <linux-serial@vger.kernel.org>; Wed, 17 May 2023 22:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684388785; x=1686980785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg1ipJ/xqrWpBZefD9GYZV3hg4iDZ0jnNq8Z1o+bP1Y=;
        b=Z6o1MLs49YkXHDuMPjpw1Jr0tYAHQ1wmpMgS1JhE+BfywbybFsT6SNtDT0yWw+M0vt
         daaVBnyWpYORZ3W1e46qxDl6W6TH5KRFDnm6TQnEdCAVCXNTIiOgcksDE0DMaHJkOfn9
         wUL3B9CjPUkyAaMcKoWdEFIptKv2wrzADAsfIcOKJSVdEmf9hdAUklpnWpZ3IeOJiixE
         Cwj43kIoe+z3yHTb/ilYJ4QMwIAyxll5sNLwPALUjAkGv8rD9zk89/0vQOpn5UXiXNzl
         LJ/3eox+LYIi4dyDnpZD5JwpSGdTM1ibgfrbaIl46zrwbY551Tdo2Ean48OJWWNu2Hkd
         LCRg==
X-Gm-Message-State: AC+VfDyMj+zfIuSFDAmX8u4OUNaeF7QPp6zYFJYv7icIoS/y9Owhiqu1
        +OrRNRHQss+QfWZjeAhGq9E=
X-Google-Smtp-Source: ACHHUZ5A8mVUFWn6dzYNlaZFRS53TAWd8SvSdu0ZW+GG0oBLQWbUYRXeKM/OJVOhHJR6U+wn/ea/ww==
X-Received: by 2002:a17:907:9716:b0:966:350f:f43b with SMTP id jg22-20020a170907971600b00966350ff43bmr39024185ejc.9.1684388785134;
        Wed, 17 May 2023 22:46:25 -0700 (PDT)
Received: from [10.223.1.187] ([195.39.106.162])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402161800b00510de087302sm156934edv.47.2023.05.17.22.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 22:46:24 -0700 (PDT)
Message-ID: <335bd9b7-e27a-2702-91a0-a1e476122223@kernel.org>
Date:   Thu, 18 May 2023 07:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] serial: Make uart_remove_one_port() return void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        "moderated list:ARM/Microchip" <linux-arm-kernel@lists.infradead.org>,
        kernel@pengutronix.de
References: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
 <20230512173810.131447-3-u.kleine-koenig@pengutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230512173810.131447-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12. 05. 23, 19:38, Uwe Kleine-König wrote:
> The return value is only ever used as a return value for remove callbacks
> of platform drivers. This return value is ignored by the driver core.
> (The only effect is an error message, but uart_remove_one_port() already
> emitted one in this case.)
> 
> So the return value isn't used at all and uart_remove_one_port() can be
> changed to return void without any loss. Also this better matches the
> Linux device model as remove functions are not supposed to fail.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

