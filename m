Return-Path: <SRS0=5Xrm=YS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8737CA9EA0
	for <linux-serial@archiver.kernel.org>; Fri, 25 Oct 2019 23:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881E820578
	for <linux-serial@archiver.kernel.org>; Fri, 25 Oct 2019 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572046612;
	bh=Q+R4TaibVUX4jiQdxeM1DVlHqPXZJ16mAiIKYbQ1GnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EqOU4BScctiF/Pp2p7wP5+LtUjA8gDmomUL67iKpS534xJ2rgt40flihXTJx9IV1D
	 Dk0WRh+9UC+IuTU4M2whAcc8Sx3BJW885vaSDBstd9eFa+cLsMsouNW1X987TmyfJ1
	 mzxmo8i32wvLKoRxneslOuSyTGCgzUnx//4r+PT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfJYXgw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:36:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42027 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJYXgv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Oct 2019 19:36:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so2700358oif.9;
        Fri, 25 Oct 2019 16:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QelFjeLnXTzQm+/jVY211bMV4zz68SHWxUjeRItzkdk=;
        b=mF3WkcocZxZ6ge77t8sPJf9EGSCJ5cQOBMVlAQmjF8upskmK43O7OWOuv3dKGQRzjZ
         QVT/CtPfMBZyimnXylHH8N0bGztRBLck/iT9IcW1V4jjbkunyLs9s85sJOZkQgp5Xz7M
         X5WweB0olvDAxm/jPX6+uP3S7+jHFCUOva76+7230msyJObruMWqN69vtbk7/+N8eXpI
         jd4vNZAOw7ECdVRQSCAFMZGLTZ05ey/4O1Zmr4SNAtihEOj8A/vR4Y3tGlQUhQnVsvYm
         OBYmzdJDiBrb8qL1AjA0uSzQGKg510Hs7W3ZePZnzuWwXGSLnhakElh7pFwRz9bj/I6Y
         SiLA==
X-Gm-Message-State: APjAAAWw5lX9OQ0mNI/HbAFBwHOWNXR8yaFZL4rAjAdcels+tLK1Gafv
        RbJxzrwqIlqqm+bvnKJ7tg==
X-Google-Smtp-Source: APXvYqzUdlvG3uMUrVRI3bkL4tL/thoeu4v0Mzcv11oPGxvYMjVRskwBP70/En6JHS2t/rJdUtp9lA==
X-Received: by 2002:aca:f403:: with SMTP id s3mr5214754oih.23.1572046609344;
        Fri, 25 Oct 2019 16:36:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m50sm1252608otc.80.2019.10.25.16.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 16:36:48 -0700 (PDT)
Date:   Fri, 25 Oct 2019 18:36:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20191025233648.GA10625@bogus>
References: <20191023114634.13657-0-mholenko@antmicro.com>
 <20191023114634.13657-1-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023114634.13657-1-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 23 Oct 2019 11:46:54 +0200, Mateusz Holenko wrote:
> From: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> 
> Add vendor prefix for LiteX SoC builder.
> 
> Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
> No changes in v2.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
