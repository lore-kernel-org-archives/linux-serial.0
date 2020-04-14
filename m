Return-Path: <SRS0=CAPS=56=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FCBC352BE
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 17:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEA520678
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883831;
	bh=hwHnQDgIoW19lCoLAnrpKBo69x4YnM2jX32aKx4IPd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T8b1aUj+DTXgE9ZcJYzdJd6IOAvOlqUAd3Q1I62WBymZ+scFvRYiivOvspRBJvS5c
	 4dUmRy5vhRR6k7UzOrXncPox2we/rywZYHD0xoWFRyL3prSqxH70Jbz5Xdbwr2gyJE
	 PiCIt3HO3JwlfzkuDw+cR9eK0dktWH/USQxdECE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgDNRDu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:03:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46593 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgDNRDk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Apr 2020 13:03:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id w12so292990otm.13;
        Tue, 14 Apr 2020 10:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jaXxYQ2FYpSVQsJaEvJ0tlJfoyPl68Crc2WxdCdXIYU=;
        b=T51wxXppjDfrn19kOTet2iKoIIax3Lvy7J2tfyYErQUs+ptzGw3teNlRyst2v6pCu2
         xRsEtgeLzSLWq7us729b+lMu7DKfqneVydKzZNJ96VRTlMnhyadM5opWIQZCRYXYJAb/
         ygMx6Su0biE/1qYB5sheh1yz9lENdKolmyKaMFiBfr31lMJfePOg6byZAEX0YYJJKPtH
         rqNtfnbNAk25sIZwus5XlJSNVT4XFNKVXPafMZagkDn//7iupBy/EvtitKKvVOMjSSqc
         OLk/xEep9pooENBWno03epvwwZBBYsPYddYQHQ6jmfgnMMfcLfl79ilTAJrLaYrLV2vD
         Wy9A==
X-Gm-Message-State: AGi0PuZftsD04c7TZ7DC4MxXzSw0cGntOhq/wfnBY7NFigEeR3zJAjVM
        vww4MBKrHneK/FREPZJC3g==
X-Google-Smtp-Source: APiQypJLVVe9ZYo0KcdXWrYnv+be8t6aET3lPXMMKhLrbG6rm1kd16c0H9/OvnOO9p4vB30IOLnDaw==
X-Received: by 2002:a4a:c408:: with SMTP id y8mr19491246oop.42.1586883819021;
        Tue, 14 Apr 2020 10:03:39 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s73sm1275570oih.14.2020.04.14.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:03:37 -0700 (PDT)
Received: (nullmailer pid 6695 invoked by uid 1000);
        Tue, 14 Apr 2020 17:03:36 -0000
Date:   Tue, 14 Apr 2020 12:03:36 -0500
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
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: soc: document LiteX SoC Controller
  bindings
Message-ID: <20200414170336.GA6657@bogus>
References: <20200402084513.4173306-0-mholenko@antmicro.com>
 <20200402084513.4173306-2-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402084513.4173306-2-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2 Apr 2020 08:45:54 +0200, Mateusz Holenko wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> 
> Add documentation for LiteX SoC Controller bindings.
> 
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
> 
> Notes:
>     Changes in v4:
>     - changes compatible to "litex,soc-controller"
>     - fixed yaml's header
>     - removed unnecessary sections from yaml
>     - fixed indentation in yaml
> 
>     This commit has been introduced in v3 of the patchset.
> 
>  .../soc/litex/litex,soc-controller.yaml       | 39 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
