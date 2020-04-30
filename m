Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0977CC83000
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0E2206D9
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588256382;
	bh=hzSSexDW86oMOkOlWRBOrrNeDAP2YNg01Nwyvsplym8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eEdzjEK1D4PQPb3MOyEOBJowt2C7IAR6tGJDxWxzrN2JIAt3h5k4zNXwLbHFLtvi1
	 YiBrs6j5ih/DMUS3zeSSBlXx+9O7ev9rzBmsPrxmF1aeq7g2yqfKi588DpDs5RAgq8
	 xxqB1ZBGvaX7xaoSfjqnz2bj9ODZcNRU9AsDYOw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD3OTj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:19:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40717 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgD3OTj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 10:19:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id i27so5014958ota.7;
        Thu, 30 Apr 2020 07:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DENVQBsUvtOTi5SjhKWIVkv3BHJdyUdGGFEYj8GGi+g=;
        b=kfv5bGywgdm9yw3D9E7YrZ9sCvCrSR0FqdL0YbwAmTGGPahK6Cs2xLLuJ92+J0sff6
         Ob72ztGjvIYPPPY2VgQakJ6N+dn8CTYax7Ynt9xK4zdQyzGDh03aztk/J9q++qPurTH7
         c4zb19unKWQ+dhYksw0iP6iidRrG9A76qlngQ41og70JP7uVtQDSJzqqs7OBWG28oP0W
         WW4wpyuUmxuHocqYKX1hlni1Tz3PVgXd4JPvQVc1U8FYGwaWMN+GFD+x7dLqduVs1CkW
         4lsi8YfrLYazKLIoTB94fTBzbxNuCRlPYC4jbP/TiQzzLNYbbxh5NbMRULsfv0CR+1b0
         jXAg==
X-Gm-Message-State: AGi0PuYgdYMY5iO7J8atBvc3stZt9wGdarCv8feiQpnjSwM85VSS6wW1
        A21FvEMQ4El6nBt+dQWLSgZsT8g=
X-Google-Smtp-Source: APiQypIw6MDuh8Q2e485ee7Y7XEXFKcld99PiXzHbwdDh4z3okrKqE1I96blaiAxWEKf482ANOOEww==
X-Received: by 2002:a9d:6e3:: with SMTP id 90mr2747810otx.261.1588256378256;
        Thu, 30 Apr 2020 07:19:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l21sm1365605ooq.18.2020.04.30.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:19:37 -0700 (PDT)
Received: (nullmailer pid 21255 invoked by uid 1000);
        Thu, 30 Apr 2020 14:19:36 -0000
Date:   Thu, 30 Apr 2020 09:19:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: Move Marvell compatible
 string to 8250 binding doc
Message-ID: <20200430141936.GA21096@bogus>
References: <20200419201716.679090-1-lkundrak@v3.sk>
 <20200419201716.679090-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419201716.679090-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 19 Apr 2020 22:17:15 +0200, Lubomir Rintel wrote:
> These ports are compatible with NS8250 and handled by the same driver.
> Get rid of the extra document that fails to document the properties that
> are actually supported.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt        | 2 ++
>  Documentation/devicetree/bindings/serial/mrvl-serial.txt | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt
> 

Applied, thanks.

Rob
