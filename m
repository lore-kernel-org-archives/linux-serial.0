Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7EC001DB
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 12:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjHDMYh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHDMYg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 08:24:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D0AC;
        Fri,  4 Aug 2023 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691151875; x=1722687875;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HAwfm0/PPyafxhCl3GGfxMlL8NsKBkG9HFrlgRfAIIQ=;
  b=D7WYQCrlTVDQeB3mPm+lmaDTK8xsQI/wypKnn789GeCtv4LmjWGp224V
   BOuBKRVro8h8zTtPJ2LvQtI+sEGRFaxE5VMvXxzV0MVAUPJ5dRsJs8au9
   JyowlzofbNrSXd2EArvKOv9CtB8HsbrIoYom8XPnabE7JK6FAb8gtIgqW
   L5rdJ/UNNsjNbxO1UgfzLKfK1KIYgh4YxIwEJT8YP8M/MGu6IX6pjGdFF
   KZbOTJbsIwBat2QV4zniNK3quIq4U8TxDnk2mf6mZ1XWw1OauGw7wMlKE
   TAcMXcoqzbzcmsiEo08y1VuY37NCKjceWqZO32k0R4zBufxyJCe3OBXkb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456519604"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="456519604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 05:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873369669"
Received: from mmocanu-mobl1.ger.corp.intel.com ([10.252.38.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 05:24:35 -0700
Date:   Fri, 4 Aug 2023 15:24:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xia Fukun <xiafukun@huawei.com>
cc:     andy.shevchenko@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dw: Fix assignment error of data in
 dw8250_probe()
In-Reply-To: <20230804121607.191203-1-xiafukun@huawei.com>
Message-ID: <b22177d4-f911-cb8f-18e6-4ca8b2855c73@linux.intel.com>
References: <20230804121607.191203-1-xiafukun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 4 Aug 2023, Xia Fukun wrote:

> When the "ri-override" property is present in the device,
> data->msr_mask_on and UART_MSR_RI should be used for
> OR-assignment. Fix the errors in it.
> 
> Fixes: 1bd8edba10e6 ("serial: 8250_dw: adapt to unified device property interface")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 7db51781289e..921b5f07828f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -587,7 +587,7 @@ static int dw8250_probe(struct platform_device *pdev)
>  
>  	if (device_property_read_bool(dev, "ri-override")) {
>  		/* Always report Ring indicator as inactive */
> -		data->msr_mask_off |= UART_MSR_RI;
> +		data->msr_mask_on |= UART_MSR_RI;
>  		data->msr_mask_off |= UART_MSR_TERI;

The comment and also documentation says RI signal is always kept inactive 
when ri-override is present.

In Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml:

  ri-override:
    description: Override the RI modem status signal. This signal will always
      be reported as inactive instead of being obtained from the modem status
      register. Define this if your serial port does not use this pin.

...So why you think this patch is correct? (Please explain it in the v2
changelog clearly if you think your patch is still correct thing to do, 
thank you).


-- 
 i.

