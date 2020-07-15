Return-Path: <SRS0=G31y=A2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F82C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8BB2065E
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594835704;
	bh=x/b+6oek5ExHkOuOAzMaafX+ZHia1G+C7ykOk8YnX1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jXH8doIgiYUVsA8llWJy7Boyl+hKPbyScNtn+TEtlAHprCzmP0dtbqWgYbBvvCyX4
	 eWmqRsR6l90R3q9s4JJJcbO+WiIgI7nezDmH+6AVTkMdq8BnsvgWB8D5Hk6wcQfyDg
	 kU4gXCjsiI5TvlRpqhvX0gSwJpviXXy3OaF5ugEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGORzD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:55:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35461 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGORzC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jul 2020 13:55:02 -0400
Received: by mail-io1-f65.google.com with SMTP id v8so3209761iox.2;
        Wed, 15 Jul 2020 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=woYWRRlvqEQlLUErEQBpQBUVNM6CQZJXoqFEveZ8nYE=;
        b=e5jeug7CMLJ4yWalVt6+h28l0S4ln8a6G0sSFgWpgY13XZX+lQe9MtL6mtmDorb0so
         rodt5zfv0EOZSCba2aPuuLqJH0nuvMuKyMNnybqbHEV+NcX7Vzd6SLJziJDMP3oZQMLk
         c+G2RaMAwWIHDg4WNFQ8Zm78ksk9s7QaDUSnePn2asV447+4NDkIhYsP+0iP5OhvwUGr
         dacCBPLy+R3cPhzsBTpf5XV0fSm66jiEckMi3Tk3meKDONvGj72URnwdvjMkRBiKD8rL
         Xsp9hSvGsYq8RtmCk8Z1n396/vFM62gnZ/mvWFlnUPVYGk+gXTRV6yFsJN0K9RWW+Zg7
         gR6Q==
X-Gm-Message-State: AOAM532xXwGkJeJHHV9TBgZB19vfj+IzE1DyU45zxRw35gkff2ksh8LS
        x4XkrfCslvfyDZrL7BNMDQ==
X-Google-Smtp-Source: ABdhPJxh8fA5ehCDcqiAyP5L5alxPVWB20vQkTrQUE6pz55njBu1AfI32x925fCetMWucCJAuM+YIg==
X-Received: by 2002:a6b:2c1:: with SMTP id 184mr417726ioc.167.1594835701529;
        Wed, 15 Jul 2020 10:55:01 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s5sm1389818ilo.24.2020.07.15.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 10:55:00 -0700 (PDT)
Received: (nullmailer pid 506188 invoked by uid 1000);
        Wed, 15 Jul 2020 17:54:59 -0000
Date:   Wed, 15 Jul 2020 11:54:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-serial@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200715175459.GA505797@bogus>
References: <20200715130641.1953227-0-mholenko@antmicro.com>
 <20200715130641.1953227-2-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715130641.1953227-2-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 15 Jul 2020 13:07:27 +0200, Mateusz Holenko wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> 
> Add documentation for LiteX SoC Controller bindings.
> 
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     No changes in v8.
> 
>     No changes in v7.
> 
>     Changes in v6:
>         - fixed license header
> 
>     Changes in v5:
>         - added reviewed-by tag
> 
>     Changes in v4:
>         - changes compatible to "litex,soc-controller"
>         - fixed yaml's header
>         - removed unnecessary sections from yaml
>         - fixed indentation in yaml
> 
>     This commit has been introduced in v3 of the patchset.
> 
>  .../soc/litex/litex,soc-controller.yaml       | 39 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.example.dt.yaml: example-0: soc-controller@f0000000:reg:0: [0, 4026531840, 0, 12] is too long


See https://patchwork.ozlabs.org/patch/1329382

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

