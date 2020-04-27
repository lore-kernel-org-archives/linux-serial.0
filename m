Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA12C55199
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C646B206D9
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7u4o2sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgD0RaE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgD0RaD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 13:30:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D94CC0610D5;
        Mon, 27 Apr 2020 10:30:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n11so872736pgl.9;
        Mon, 27 Apr 2020 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SCLyDRiJjkisSI5+I7kNMlITwcAUmvW5WBS3LcGSTZs=;
        b=f7u4o2sKuPfQQUUeIiWva27PcW47sExOw2ojdV1iJqO2YiekLlLQPdnrUK+CgZhhfG
         cJ+ZgM4cPD7Y5oXHfP1JI9yj1gmTLQnN42FMZiF4iS0jQG9ocWgmH7gSirxMIvMmnn37
         /lKlbgE9xfA929pEOUYZiTjseraB5PJQgyhO23j194oD+QjFpU1H46lSOKsyuh93rsEk
         35afT3WPxbKMLvr22/qWiT1enHGec0iP/pL33VaHplNezHvl02oBGpKQ3YTOr3YjRB2P
         3Ij9FTxtADBjH4qD0IK8bbqe7j3tXMbRQLrit3H3nqsBJwOQfm/2ExV+mpjsXDupHPec
         hr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCLyDRiJjkisSI5+I7kNMlITwcAUmvW5WBS3LcGSTZs=;
        b=R7uAU7TZWkks+LDkh3IIMZj5nCG4o7cLnvOLpzL97aNiqilCxnxon5yTdMJZJi/IHo
         XvV3Y7Rt5aXJohT8QV7O7jlsRbBaotSUZPb+zqNF9agioYsv40GD/muIdSekzb6U1lnC
         b8+dGsRSCkReA4ik9wsFGmqBVf5S85h2S70gyyUYrQQDeypKRHurvzIsEW8CmFfurIZT
         h83hNr3WHnX20dfDeBDJC+FUtCRKzJhd/U5jnssx3dYzJ4eJUowb2Wh3/3wTdo2BE5Dp
         ie9d3ECuWuL2vliUSFnHFVL5cHyiNv4drx06YR6xpWn6Xx7kg4lLaBk6/XXFOudTByNm
         k4/A==
X-Gm-Message-State: AGi0PubMe62J+RXsAESdsFA7Ge0Wql/4AOfobSklCmtr6QjKxT8ElLtj
        56OYEjJYiV41wublQrHG8uADf/rp
X-Google-Smtp-Source: APiQypLAkvMyKxt4+GqBWPPQov4z6yuIinvDdHdu3rfRqyLGtyrl9GGPdWcRQ69bAKSDmiis+wgM8A==
X-Received: by 2002:a63:f843:: with SMTP id v3mr24542277pgj.421.1588008601102;
        Mon, 27 Apr 2020 10:30:01 -0700 (PDT)
Received: from [10.69.79.32] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ml24sm11558508pjb.48.2020.04.27.10.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 10:30:00 -0700 (PDT)
Subject: Re: [PATCH -next] tty: serial: bcm63xx: fix missing clk_put() in
 bcm63xx_uart
To:     Jiri Slaby <jslaby@suse.cz>, Zou Wei <zou_wei@huawei.com>,
        gregkh@linuxfoundation.org, bcm-kernel-feedback-list@broadcom.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1587472306-105155-1-git-send-email-zou_wei@huawei.com>
 <4cd8f963-9292-faef-1e24-df90821274d6@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <73c4cebb-467b-e5d5-89bf-8a6fe29cf858@gmail.com>
Date:   Mon, 27 Apr 2020 10:29:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4cd8f963-9292-faef-1e24-df90821274d6@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 4/26/2020 11:19 PM, Jiri Slaby wrote:
> On 21. 04. 20, 14:31, Zou Wei wrote:
>> This patch fixes below error reported by coccicheck
>>
>> drivers/tty/serial/bcm63xx_uart.c:848:2-8: ERROR: missing clk_put;
>> clk_get on line 842 and execution via conditional on line 846
>>
>> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>> ---
>>  drivers/tty/serial/bcm63xx_uart.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
>> index 5674da2..ed0aa5c 100644
>> --- a/drivers/tty/serial/bcm63xx_uart.c
>> +++ b/drivers/tty/serial/bcm63xx_uart.c
>> @@ -843,8 +843,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
>>  	if (IS_ERR(clk) && pdev->dev.of_node)
>>  		clk = of_clk_get(pdev->dev.of_node, 0);
>>  
>> -	if (IS_ERR(clk))
>> +	if (IS_ERR(clk)) {
>> +		clk_put(clk);
> 
> Why would you want to put an erroneous clk?

Doh, somehow I completely missed, you are right this does not look legit.
-- 
Florian
