Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5270C678D4
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 16:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjAPQ3R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 11:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjAPQ25 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 11:28:57 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947A2DE5B
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 08:17:03 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id cf18so62857686ejb.5
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJz5BoK3GgPDqcU7pWl4q17s4L0JjfCwaCMyEea2JRQ=;
        b=Kf+9bFXIXrDOV7fwxGuKb7xahSiFTZhm+HVwKMcOLlz0eQgprpoCX+Uj0DajSwKvmV
         EA4tDRy+KDO2CnNIUSR16WXXilM+HLjmGmoamAMWRY5xIwYeVk21D1aLjQ2sYjAJVdds
         8xoK3SHygmxIKMWdayuL+DFkJ/7Q4Wvk3rwA+qVJYVmXn1tTKz5zJmfs2OEOQgNK/NGH
         tgO0AngqpaOxShtbmzfNRxQSFYe5+KuEf+yJ9IpO7ebNyXJwSUnb4Nkvni4I0bGh/FvE
         daAF+JJci4FrbZEjQBgi54wEVLkB9ikTi6rHi4F+cliQM9HGDueYBHI0G4byvMOd/spa
         LUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJz5BoK3GgPDqcU7pWl4q17s4L0JjfCwaCMyEea2JRQ=;
        b=11F+vKZ84BImoNk7prG4pGPP9wEsUFaN7euFnkttzBD+ewIfceZM9FdmIxtg3PJYSz
         G+ZcYKFWKrpKnWLiejamj0uZEg+GVgzbaUFckciDU/wGS0mPFI223Nn2sJmb8sKWyR0+
         gGe58NRdAQT3rRS26H0QHaSq2ksOHV4T0pMiTzsu0tni1JCy65voP8WFnGE5r81y76t+
         B/pMWOBwA2i0N5FiCurbHVmN5hLWGiCJXAqxiFkiIj2YfLqNx/+oOHNrr23Wgim3AG2s
         szejmn9QJA5XUmvWnqtDx57Uegy7rids6a06tUG1w4V2sixUg4UFtc7+aaiaI2Z9q2el
         NHyw==
X-Gm-Message-State: AFqh2kobzofbWCcauVUuhwWbUy1xdNRA7B1/1/G0+rTTPzym9Q2aOpWo
        2jpSAezgXhIlvULaWbZPQpRIPg==
X-Google-Smtp-Source: AMrXdXtFqHRraX+0naNrs+PCF+WmprEZHd41bA2z/ODVuNq9y5Elum6nd3kmzJUMQwxGuk0Sbm63dQ==
X-Received: by 2002:a17:907:d08d:b0:7aa:76a:fb3 with SMTP id vc13-20020a170907d08d00b007aa076a0fb3mr86872292ejc.66.1673885822349;
        Mon, 16 Jan 2023 08:17:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b0084d4a60b3d6sm9165568ejf.117.2023.01.16.08.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:17:01 -0800 (PST)
Message-ID: <b82b1194-622c-fc65-d831-7731c72264b7@linaro.org>
Date:   Mon, 16 Jan 2023 17:16:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] serial: samsung: fix buffer size for clk_name
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230116141658.GC8107@altlinux.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230116141658.GC8107@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16/01/2023 15:16, Alexey V. Vissarionov wrote:
> Although very unlikely, the 'clk_num' value may be as big as
> 2**32 - 1 (uint32_max), 

How it could be that high? Code has num_clks defined from 1 to 4 and it
is used as strict boundary for the loop so how it could end up here with
higher value?

s3c24xx_serial_getsource() also returns value & with mask, so up to 4
max. This does not look like real issue but some change to satisfy
static code analyzers, so I don't think it's correct approach.

Best regards,
Krzysztof

