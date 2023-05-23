Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A76C77B75
	for <linux-serial@archiver.kernel.org>; Tue, 23 May 2023 07:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjEWHvX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 May 2023 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjEWHvM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 May 2023 03:51:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A48F133;
        Tue, 23 May 2023 00:50:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f8d485ef3so533064566b.0;
        Tue, 23 May 2023 00:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828110; x=1687420110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/ga9kfQAmCrlcMothWIufyDqrfE6sQdv6qR5XzdMOg=;
        b=IyIPMLgRJ1DjMYTbFIxo1ovlPQM30aOjLMxUue560Gx/eVdltG8USokBW5FTDofUQY
         mfTMyJ+hsdsxNayoJZgZlaZK1rYJCIBaQWygpX+rRHt9jKduIb/kjEMFWBsYz1Nw+A9w
         I9TMYAsmCfZfkkQGym+RL2vkOBWVzKeaoeT+LWFYlaMycfPxv5IcglLrqvxtPfk9Z5Tw
         9cNr0i94jgyfB5YYTNNAzIJS29ZscF163C2lhAeMnHtnZ2Nh9/0Ofdc2+6Q1zqiPxiZO
         dVK0T2I1lGURWQin9fFnhvz78c7CdO433sPPLeTlvoTf6vo4bMQ13+GLQOVWUv2wGr77
         vu+A==
X-Gm-Message-State: AC+VfDwjntfecvkvSgFuyoxV3tcXR1Qz28/9SqG3/79fWwaLdbP+KWBV
        3eqCLkO3z+//kYQgb/OTIXM=
X-Google-Smtp-Source: ACHHUZ5Lkei+0eevntPfv1VfTj6uFljsHPeKK8tvdztEH9quqLFDVH+u77ys6bL04uOufoqRWiCGNw==
X-Received: by 2002:a17:907:928b:b0:96a:411a:1cc4 with SMTP id bw11-20020a170907928b00b0096a411a1cc4mr11813594ejc.66.1684828109630;
        Tue, 23 May 2023 00:48:29 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b0096f689848desm4087738ejc.195.2023.05.23.00.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:48:29 -0700 (PDT)
Message-ID: <e8c45035-1834-7214-46af-834e879cf3c5@kernel.org>
Date:   Tue, 23 May 2023 09:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/2] Fix COMPILE_TEST dependencies for CPM uart, TSA and
 QMC
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230522082048.21216-1-herve.codina@bootlin.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230522082048.21216-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22. 05. 23, 10:20, Herve Codina wrote:
> This series fixes issues raised by the kernel test robot
>    https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
> 
> In COMPILE_TEST configurations, TSA and QMC need CONFIG_CPM to be set in
> order to compile and CPM uart needs CONFIG_CPM2.

Ah, perfect. Greg, please disregard my revert posted at:
   https://lore.kernel.org/all/20230518055620.29957-1-jirislaby@kernel.org/

and take these instead.

Thanks.

> Best regards,
> Hervé
> 
> Herve Codina (2):
>    soc: fsl: cpm1: Fix TSA and QMC dependencies in case of COMPILE_TEST
>    serial: cpm_uart: Fix a COMPILE_TEST dependency
> 
>   drivers/soc/fsl/qe/Kconfig | 4 ++--
>   drivers/tty/serial/Kconfig | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

-- 
js

