Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903CBEE57DF
	for <linux-serial@archiver.kernel.org>; Mon, 11 Sep 2023 07:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjIKHQ5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 03:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjIKHQ5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 03:16:57 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1139CD1;
        Mon, 11 Sep 2023 00:16:52 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so5218032a12.0;
        Mon, 11 Sep 2023 00:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694416611; x=1695021411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pifjIYv6Hyk5rsiSFmdRIaR5tzpXVSFZgH+NJpSIZKo=;
        b=lmUSpUopSxMapEwB+PWMoh4/IaOe3TGQpl/nAji+AgNVYG9zgjzXE1ehVs9qa/me7l
         IG9JwMmZAlj5o/tVnwi2DHLj/39x6LVKYwiPKtECgjb2hvXhT1RMNohuaGwGf7EIokTm
         Pm8KuBgKPFGPIRNSH7Cohfhz24MbaSD5XYAmNBpGw2K+WdakzaaSJwxY44AS+Pq2y60K
         3bO6TEylwBk0gSGeyJSmc8+61uAjDgDU3JXiG2oPD/DSrAGuSb0Gz0FxS9t9rgkdSBbI
         3yB43usKnNsrr+64ORx+X94FzrPY+2AsjXqbN8Sm/hypg/o1nRbZO8fvLjNUVa+PhSvG
         kobw==
X-Gm-Message-State: AOJu0Yx3N3O3jK4IANkJgGHZl1xIfNmgKY12Nqc3powGSoOXyTowxl5W
        uXo8b1DonJ7ZefoI/uw41wY=
X-Google-Smtp-Source: AGHT+IF8WwlA+cjc7QZ3b7ObgufEBSdtFZ7KGlJIYi0Vw11q+BUCebVWj2pxlmXKlPh+iGDNpddDFw==
X-Received: by 2002:a17:906:31d8:b0:9a5:b814:8254 with SMTP id f24-20020a17090631d800b009a5b8148254mr6660837ejf.24.1694416611007;
        Mon, 11 Sep 2023 00:16:51 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id x1-20020a170906134100b009926928d486sm4848237ejb.35.2023.09.11.00.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:16:50 -0700 (PDT)
Message-ID: <9a3ed34a-10f2-c778-501e-8be600dce167@kernel.org>
Date:   Mon, 11 Sep 2023 09:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tty: hvc: remove set but unused variable
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230908061726.2641-1-liubo03@inspur.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230908061726.2641-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 08. 09. 23, 8:17, Bo Liu wrote:
> The local variable vdev in hvcs_destruct_port() is set
> but not used. Remove the variable and related code.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs

