Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05F7C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jun 2022 07:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiFWH1J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFWH1F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jun 2022 03:27:05 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A346644;
        Thu, 23 Jun 2022 00:27:05 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id c13so22760641eds.10;
        Thu, 23 Jun 2022 00:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c6yTXw2yLdl9FUORd9XTbKmD+hTxds6vw24+wNHfO/4=;
        b=zSRvEq15hRO2HmEqg+TYmyX8wFtW6aGVy7PgvU+fxtuyVW/O0LR2YcNMhd8l2DXf4X
         iUcPkoId1Apwb7uW6FgFQJwEkZhbA5yf94QaVNDta+vbWN0R+qiaN8CzA26msUtESkNX
         Q/QUkYVL1ir2I1GRHNDKEGCcrKgIuUcDFz4tL0a/didrdVab7i7psLSyDnFFRg2PBv5E
         5vRdfFqWpvvLc0A3rd5kEFeP4OTO/SUz6s9ja+N1HiON1dm6x+RJi3/pIRdTQWBxbPGr
         PToV62FoWeIMvTO/TgDwvJnGWHike2nlWccUCyPm4pnLlkgFiFsXN3K42q/ayQna41qK
         XVqQ==
X-Gm-Message-State: AJIora8cbDa09xmmZMwUW2FWdNP/26GJvygb0Z72KzTs2eQNqN9nPXEo
        Nu5QYc7uwFzpnHDfNhsGUS/0sw5En/EDPg==
X-Google-Smtp-Source: AGRyM1usnp8oNx386pFZFnzY99wkX+HjfCw1BQHBoibJwaqXa10OQnbcyUmfTndfrn2Xb7sslpwccg==
X-Received: by 2002:a50:fb13:0:b0:435:90d1:19ca with SMTP id d19-20020a50fb13000000b0043590d119camr9167197edq.159.1655969223708;
        Thu, 23 Jun 2022 00:27:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906480f00b007262a1c8d20sm132852ejq.19.2022.06.23.00.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:27:03 -0700 (PDT)
Message-ID: <7a7cb1e4-7d74-6569-9fcc-d6a88b917deb@kernel.org>
Date:   Thu, 23 Jun 2022 09:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] serial: 8250: Use C99 array initializer & define
 UART_REG_UNMAPPED
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-5-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220621124958.3342-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 06. 22, 14:49, Ilpo Järvinen wrote:
> Use C99 array initializer insteads of comments and make unmapped checks
> more obvious.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
suse labs
