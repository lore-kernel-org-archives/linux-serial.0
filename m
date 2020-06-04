Return-Path: <SRS0=SSon=7R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84714C433E0
	for <linux-serial@archiver.kernel.org>; Thu,  4 Jun 2020 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D84F206DC
	for <linux-serial@archiver.kernel.org>; Thu,  4 Jun 2020 15:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CVOVrcVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgFDPOK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgFDPOK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jun 2020 11:14:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D1C08C5C0;
        Thu,  4 Jun 2020 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=hqxSBMYgaMHcJppIVN2RkGs74NNJ8ayw/b2Z0TVTbhA=; b=CVOVrcVcDpuy53BE6gQxo+e3Yi
        sxkkl2mIhbuJQ3FE79005adrbaFHVLxFilL8esm+M+NCIITHg3vbfDzVnp/RU5A0stVgPzpmXlNFN
        wMNldE7MvonsWjSkfmpwaZvo9yneALcl8AtBRAmwXBKiB1qHZbcbOgciXTMO7oFavTMXrGpKBIqtM
        axTB8Xl5JJzyk25FPjUj4ABcYkfUhyk17BkMhRWitZIO4LTdYT9YtExy2g1a+JsTie/cKiOYWImiL
        nv1K9nIj+YN5W4ELlsLB2itDS+WBKh48GHmvYhfj86RJ74uTnHR/KlnBgy28cp0BqqYfvYR5aZ+w3
        UXS19Hig==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgrZE-0003Jb-Qh; Thu, 04 Jun 2020 15:14:04 +0000
Subject: Re: [PATCH v7 5/5] drivers/tty/serial: add LiteUART driver
To:     Mateusz Holenko <mholenko@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
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
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
References: <20200604121142.2964437-0-mholenko@antmicro.com>
 <20200604121142.2964437-5-mholenko@antmicro.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <418aa34e-af6c-3a3c-8d22-e7a122963b8f@infradead.org>
Date:   Thu, 4 Jun 2020 08:14:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604121142.2964437-5-mholenko@antmicro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi--

On 6/4/20 3:14 AM, Mateusz Holenko wrote:
> +config SERIAL_LITEUART
> +	tristate "LiteUART serial port support"
> +	depends on HAS_IOMEM
> +	depends on OF || COMPILE_TEST
> +	depends on LITEX_SOC_CONTROLLER
> +	select SERIAL_CORE
> +	help
> +	  This driver is for the FPGA-based LiteUART serial controller from LiteX
> +	  SoC builder.
> +
> +	  Say 'Y' here if you wish to use the LiteUART serial controller.
> +	  Otherwise, say 'N'.

That last paragraph seems to say that Y and N are the only choices here.
It can also be set to M ...

-- 
~Randy

