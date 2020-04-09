Return-Path: <SRS0=pwFA=5Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6AEC2BA19
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 23:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217F7206C0
	for <linux-serial@archiver.kernel.org>; Thu,  9 Apr 2020 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586473541;
	bh=UnftFM45HZ7FMvzfR/S19bHZ+8ZbiUHPbAYrR9FXHhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YSzIP0RpoF8IURZM4dst+KIzdSC0AHBVGep4w2j9/vd3nHQu0xaWzrFoA7/i+XRtj
	 kKi8LaWwJe8hguVkQM22dMJsSdBtIAkxdS9HhtKtpXjq2bt3c0EAxQFpwVxG3eZMxG
	 dMPMUgPl7WnZAUwaeS1zmWYmLJewtSO0xMIV2GBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDIXFk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:05:40 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46587 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDIXFk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Apr 2020 19:05:40 -0400
Received: by mail-il1-f195.google.com with SMTP id i75so315414ild.13;
        Thu, 09 Apr 2020 16:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQyrK8vVqRVwAwr1JBZF09TbS3JGH/e3BJI7n/Em6vU=;
        b=YZBf+Ha1EXYuFTxqtU6NofLnImdTQeDgK5o0TsfwbRQ8Euutz1qyR+34i4d6rJGXrP
         fev9y2yV/hu/BBx+IOUZsjKS1l3Q3puaJ15xQX2q6QFAwyAAbTuus6DmhgOnIm2pk7w3
         58J2lwX2HncqZvKoT9bGgWONXBN/MKvBmbvXWxJPYrD9ndT5szG5OInW19eg5nrEZy3C
         0RocDykiX6pLS3JhyydqeM1o9ZZydh3x6y9aflN2h2NfSb6agEJpu5GMUlELjcZC7mxs
         Qo02/l4fojWcFzpdE87rJlws+zphWZH9qJMO49NyMlI+9AcrqcvehI/yeIvfG2TsLL4o
         Gd0A==
X-Gm-Message-State: AGi0PubOwYJba+z9udrRY+NJ1igIcaCCB2N19hLJT3qIiZRGTYkStsHs
        X6qIOvD8Cpx8RMZ5DoLpxg==
X-Google-Smtp-Source: APiQypJUcwLOtiJp+aVer06rGJe8zrvrqHSjMZReVzgW446GJMMapoEsUCnTcfyU6nX1zj6Xxly33A==
X-Received: by 2002:a92:c6cb:: with SMTP id v11mr2328474ilm.41.1586473539462;
        Thu, 09 Apr 2020 16:05:39 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o7sm66586iob.32.2020.04.09.16.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:05:38 -0700 (PDT)
Received: (nullmailer pid 19190 invoked by uid 1000);
        Thu, 09 Apr 2020 23:05:36 -0000
Date:   Thu, 9 Apr 2020 17:05:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, krzk@kernel.org,
        Hyunki Koo <hyunki00.koo@samsung.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: serial: Add reg-io-width compatible
Message-ID: <20200409230536.GA13891@bogus>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <20200406230855.13772-1-hyunki00.koo@samsung.com>
 <CGME20200406230906epcas2p3f5703f7f9f00cd1cf7dbe5cfd304481f@epcas2p3.samsung.com>
 <20200406230855.13772-2-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406230855.13772-2-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue,  7 Apr 2020 08:08:50 +0900, Hyunki Koo wrote:
> Add a description for reg-io-width options for the samsung serial
> UART peripheral.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
> v5: first added in this series
> v6: clean description of reg-io-width
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/serial/samsung_uart.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 36, column 13
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/serial/samsung_uart.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/serial/samsung_uart.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1267104

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
