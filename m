Return-Path: <SRS0=m2iq=5P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8515EC43331
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B9B2073B
	for <linux-serial@archiver.kernel.org>; Mon, 30 Mar 2020 14:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgC3OyP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:54:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:60238 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgC3OyP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Mar 2020 10:54:15 -0400
IronPort-SDR: pcKkBecesCYQYAEhSLrmHhd9iAOTbxUCjmiDCmSFuMsI6cbXg6kRLy9YKYcdoDb9y/MTcXYJGu
 SojQ5YIBZT2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 07:54:15 -0700
IronPort-SDR: Bs3XdiFeZtQH4K5bsHjV8wanFmSPUmzbxhxZtyTEhHLwB5ZARnEYjxFG1MUtHpz6/UQHScWbdL
 pgandAE3rLYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="248724484"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2020 07:54:11 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jIvnq-00EEXp-1H; Mon, 30 Mar 2020 17:54:14 +0300
Date:   Mon, 30 Mar 2020 17:54:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: serial: Add binding for rs485
 receiver enable GPIO
Message-ID: <20200330145414.GW1922688@smile.fi.intel.com>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-6-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231422.1502366-6-heiko@sntech.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 12:14:20AM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> RS485 has two signals to control transmissions "drivee enable" (RE) and

drivee -> driver ?

> "receiver enable" (DE). RE is already handled via the uarts RTS signal

Typo in abbreviations in parentheses, you probably need to swap them.

> while RE signal on most implementations doesn't get handled separately
> at all.
> 
> As there still will be cases where this is needed though add a gpio
> property for declaring this signal pin.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> index a9ad17864889..e55730de796d 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -44,6 +44,10 @@ properties:
>     description: enables the receiving of data even while sending data.
>     $ref: /schemas/types.yaml#/definitions/flag
>  
> +  rs485-rx-enable-gpios:
> +   description: GPIO to handle a separate RS485 receive enable signal
> +   $ref: /schemas/types.yaml#/definitions/flag
> +
>    rs485-term-gpios:
>      description: GPIO pin to enable RS485 bus termination.
>      maxItems: 1
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


