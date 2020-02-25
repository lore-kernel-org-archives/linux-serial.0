Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75267C35E04
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482B32084E
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 16:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gl9kLKaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBYQQB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:16:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYQQB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 11:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=KJ1E/IKL8/N0iOQYE5NPhqXs5/0FveqGImaznQIglos=; b=Gl9kLKaEkQylYsxWgr3khdKcrX
        34YYPKX7ymbat5fWlSXvuB/MSBAcx11UasM94v9O0vI1rNBxCt0wTSGqWy1407vR7witvvIIUgbFr
        G3AVPbDtpS7+k8GRDBmHoti3VR64XDYIMH2HfSxzVsurLVARvXBIoOAcSBF5xCFZ7Bz5WkkYCv9e3
        KlLQg7TnRIpaT5APRPi6eMvwmCPLRyNvOoQVuihpZ0DCenzZ63A7G2mkHRPDeyx/BG7xyDR31GUaX
        Lq74JtPFF+uHyTZiZouQ6OM8cNwykLEFbXO+TnVWF0IIzI2YjUSaIuNKiVeu0eDFWmssUnES3bX0y
        6tI4e0AA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6csK-0000YT-0G; Tue, 25 Feb 2020 16:16:00 +0000
Subject: Re: [PATCH v3 3/5] drivers/soc/litex: add LiteX SoC Controller driver
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
        linux-kernel@vger.kernel.org
References: <20200225094437.4170502-0-mholenko@antmicro.com>
 <20200225094437.4170502-3-mholenko@antmicro.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <291b0a18-2b50-515e-d6f8-31f766dbe567@infradead.org>
Date:   Tue, 25 Feb 2020 08:15:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225094437.4170502-3-mholenko@antmicro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2/25/20 12:46 AM, Mateusz Holenko wrote:
> diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> new file mode 100644
> index 000000000000..22c78cda0b83
> --- /dev/null
> +++ b/drivers/soc/litex/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License_Identifier: GPL-2.0
> +
> +menu "Enable LiteX SoC Builder specific drivers"
> +
> +config LITEX_SOC_CONTROLLER
> +	tristate "Enable LiteX SoC Controller driver"
> +	help
> +	This option enables the SoC Controller Driver which verifies
> +	LiteX CSR access and provides common litex_get_reg/litex_set_reg
> +	accessors.
> +	All drivers that use functions from litex.h must depend on
> +	LITEX_SOC_CONTROLLER

Hi,
Please indent the help text with 2 additional spaces, as explained in the
coding-style.rst file:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.  Example::

  config AUDIT
	bool "Auditing support"
	depends on NET
	help
	  Enable auditing infrastructure that can be used with another
	  kernel subsystem, such as SELinux (which requires this for
	  logging of avc messages output).  Does not do system-call
	  auditing without CONFIG_AUDITSYSCALL.

> +
> +endmenu

and then end the last line of the help text with a period ('.').

thanks.

-- 
~Randy

