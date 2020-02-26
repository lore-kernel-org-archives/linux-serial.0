Return-Path: <SRS0=ccOi=4O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F35C4BA21
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 21:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A794524656
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582753042;
	bh=WGQ6NUV/Nq5CEhlta/6kB+OE4mCNdRqPyY/dZRNpOEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hWoUBV99HeM+NrwmVhoSDgGGiZGPmKi54ITLQmC4+kQLlslneIXcq2ERoq2ivSEql
	 OoxcNH+UwkA9tkKrfWXvpw1qqYXF0dGW8aQnzQ7J5mxV6A3jLE4v2eiLMREk1v9SOn
	 7ORU6Ec2dehiXJNuEnap/VZ9V7/eey67BaX8Ni8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBZVhW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:37:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41068 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBZVhW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Feb 2020 16:37:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id v19so893729ote.8;
        Wed, 26 Feb 2020 13:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BUfZ3V0xBDGwOALHfUr9ZrS1JEBM9H8lpVzraU/a970=;
        b=BTW9sNY+psCns7vZRgSILOpJBXpUKeT8ftQVSs9u/Bpvp6AAwXMGUmz+HI8YqsrYZ6
         1ro+qVdvYpR6xx8v0DbwVXoeUGj0Onn+gTOu6b4LuhWm3lulI8jJcCehxF0DzD2LWdID
         rcgq9/L88KUMyde3Z4eROHuN9OBTEVBd68NjGH2jyz6aeqmqXtWAJ4f9DAxWo10RDVzu
         a/lWoMO1675sppjszh6v+EQpdEicuCUmxhKBs031NVqHB649IyFt2OO+lk84Y1o6zLuU
         tVETxAtB1+XiNT8PiRDWBm+gsz0wAMxqU78+JpoFdDNomUOZeDis2pgY5yitwF+QrPPM
         JXsg==
X-Gm-Message-State: APjAAAVDnAxxricPubRG+Kih2BGQKLgau9Tk6WPmerjKjIUpSPDBf3+Z
        9RwJphdNCHBZg8Z8z6fmyStkhqI=
X-Google-Smtp-Source: APXvYqwVcJhepVheqsHg5PUb4PEPVIuEdNpHnqGYdfi/G+PyJBA9spLO6DGQPJWkCR7g20EWo5LDMQ==
X-Received: by 2002:a9d:5885:: with SMTP id x5mr704064otg.132.1582753039707;
        Wed, 26 Feb 2020 13:37:19 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k18sm1209704oiw.44.2020.02.26.13.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:37:19 -0800 (PST)
Received: (nullmailer pid 2770 invoked by uid 1000);
        Wed, 26 Feb 2020 21:37:18 -0000
Date:   Wed, 26 Feb 2020 15:37:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>, Jiri Slaby <jslaby@suse.com>,
        Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 5/9] dt-bindings: serial: lpuart: add ls1028a
 compatibility
Message-ID: <20200226213718.GA2712@bogus>
References: <20200221174754.5295-1-michael@walle.cc>
 <20200221174754.5295-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221174754.5295-6-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 21 Feb 2020 18:47:50 +0100, Michael Walle wrote:
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt          | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
