Return-Path: <SRS0=zFmD=YE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8966DC10F14
	for <linux-serial@archiver.kernel.org>; Fri, 11 Oct 2019 03:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6167A21A4A
	for <linux-serial@archiver.kernel.org>; Fri, 11 Oct 2019 03:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KzBWLKoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfJKDAT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:00:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45574 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfJKDAT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Oct 2019 23:00:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so3715011pgj.12
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2019 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nP3GB4eev/Uw/7TzzPBf7q6vVOFurBjXFqfQUZ+MDGI=;
        b=KzBWLKoFEXWJXPLXk8rihO70idubrVY0AvebVOxegnFY86QJmJGnQAku+lqeexuYjB
         9G74EjZ5ZvlXtWdwx6WwfpqvWL6VZhkBTLucMGD8v4+2hORNhyJnUiBwwpBCF8JxvYyl
         Y/VEUCQaO4qMcQjX25jnBmyNowejWuBTvCczZAtLpuYiP3fyFPOQUIuwfkc7KI12BXX2
         EwM6/7cZLGE5aW9q4v+KkZG7M4Ko8VEfRigsYkPSfXxu8CCT86YN8Kz/jywZSNG+JnPs
         /EYL79jv7SvwRhbBYvBe5MtI4NC0fHqrZX5X0RP9DTqt0mKF84SdidfQjH90hJrCfHuU
         JAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nP3GB4eev/Uw/7TzzPBf7q6vVOFurBjXFqfQUZ+MDGI=;
        b=eUh/LXC6Zagj7G+TBVWy7jqixL4aFgEjuec+xuwqNSk89pX0oWt4ysuIidpPzx4BIY
         UDmoYG+ArAf6TE16UqSw9unSNR/mhWGAHYblrCCV5jHPMliUiTdi8r9vhLphk8PCTKAV
         /zYr5rWLfdEB3uBD+QWu15fW9Mj4Cla6ZMPUIQFaYLITgsVRvVFS5ozZXCeS0cg3uXC9
         nw6b9KWyevwjtj4WjAOgFOT/n++P+BzsIwCy/Dp4zsKLDCLhRLfAVjS+sElTatt0jDTg
         8tYHAmCTAHKV924cBBzVAFhX53OV/Gn2ZhmknsyNGfZj9terQGpCI0fuuti+tkmeLiA5
         kH2g==
X-Gm-Message-State: APjAAAWtaG4/ythx6Uh7qQQKdZfaMcfHF8jLJMTSRawV9TOj+3x+Gknh
        LtfTgWaRnfvNpBhoyj0loY8M7w==
X-Google-Smtp-Source: APXvYqyC7PSkR8RT7VypdyqNldAyGXeW91322WLbhsrNNwrkgAMBn6eiIibb+JzCUjR+ko/vo+L6ow==
X-Received: by 2002:a65:688a:: with SMTP id e10mr13223631pgt.122.1570762818461;
        Thu, 10 Oct 2019 20:00:18 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id q6sm8505284pgn.44.2019.10.10.20.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 20:00:18 -0700 (PDT)
Date:   Thu, 10 Oct 2019 20:00:02 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Message-ID: <20191010200002.5fe5f34f@cakuba.netronome.com>
In-Reply-To: <20191010145953.21327-4-tbogendoerfer@suse.de>
References: <20191010145953.21327-1-tbogendoerfer@suse.de>
        <20191010145953.21327-4-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20191011030002.9eytSUKqT_2loTv-sKxoAXpnuYAwwdvr1Vdt2rV7cbc@z>

On Thu, 10 Oct 2019 16:59:49 +0200, Thomas Bogendoerfer wrote:
>  	dev = alloc_etherdev(sizeof(struct ioc3_private));
> -	if (!dev) {
> -		err = -ENOMEM;
> -		goto out_disable;
> -	}
> -
> -	if (pci_using_dac)
> -		dev->features |= NETIF_F_HIGHDMA;

Looks like the NETIF_F_HIGHDMA feature will not longer be set, is that
okay?

> -	err = pci_request_regions(pdev, "ioc3");
> -	if (err)
> -		goto out_free;
> +	if (!dev)
> +		return -ENOMEM;
>  
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  
>  	ip = netdev_priv(dev);
> -	ip->dev = dev;
> -	ip->dma_dev = &pdev->dev;
> -
> -	dev->irq = pdev->irq;
> +	ip->dma_dev = pdev->dev.parent;
> +	ip->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (!ip->regs) {
> +		err = -ENOMEM;
> +		goto out_free;
> +	}

