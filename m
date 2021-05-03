Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF4C433B4
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED13C61165
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhECQsy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 May 2021 12:48:54 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41907 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhECQq6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 May 2021 12:46:58 -0400
Received: by mail-ot1-f43.google.com with SMTP id c36-20020a05683034a4b02902a5b84b1d12so5268112otu.8;
        Mon, 03 May 2021 09:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=di+uDn5ZK8XbVNpFyPQdb4KQZUTMq0eTyzsl560nLCY=;
        b=SDneqELGtKyoOB48tF0pJ4F8Ap+zBKEAYdQX6P4A2ESXe7ge6uJPci9XmnnQj/tLsn
         fXM9Vf19Z0TjqX/sTVn+RRoeLv00QpqosTjZnuErOmHTL8ZKLeQXAlDpnfwA5D3XMek0
         xtfJVEtKnrwB5FkpdOvWH67m0jeF2Pgy73aHgBg3LyChXTLbnP0AGPhWImD56Jfx3JiK
         sl0qA0QYH1o1lhiFpC65oLTVCnDsjK8lN3IN68vZagd0GJKVju8Ll84HNADSWK7qoQ28
         yJFKg0JU+qdhAeZ7D4OYNDYpOq9j8K13AQx//7xfVL5abUsQQvvgRPzL/y+y+jRwajWq
         b+zw==
X-Gm-Message-State: AOAM533dSSpqToJTxc6c9U6v2qglnFBNZxIgteivkLZrC61Xgfj7RP7F
        dimCP7jJeAnUb9J6GJn9zQ==
X-Google-Smtp-Source: ABdhPJzSSVF7sbR4pB4yvtrFsCjmtS5enP7MOLuFCE2RWI0Yh8cdIviLK8gl87cgHpav5XDjUytHbg==
X-Received: by 2002:a9d:1788:: with SMTP id j8mr16508496otj.9.1620060365095;
        Mon, 03 May 2021 09:46:05 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w3sm67710otg.78.2021.05.03.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 09:46:04 -0700 (PDT)
Received: (nullmailer pid 1985483 invoked by uid 1000);
        Mon, 03 May 2021 16:46:02 -0000
Date:   Mon, 3 May 2021 11:46:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 1/1] dt-bindings: serial: 8250: Remove duplicated
 compatible strings
Message-ID: <20210503164602.GA1985403@robh.at.kernel.org>
References: <20210422090857.583-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422090857.583-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 22 Apr 2021 17:08:57 +0800, Zhen Lei wrote:
> The compatible strings "mediatek,*" appears two times, remove one of them.
> 
> Fixes: e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to json-schema")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 5 -----
>  1 file changed, 5 deletions(-)
> 

Applied, thanks!
