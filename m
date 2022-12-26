Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F84CC4708E
	for <linux-serial@archiver.kernel.org>; Mon, 26 Dec 2022 18:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLZSBQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Dec 2022 13:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiLZSAs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Dec 2022 13:00:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D4C58
        for <linux-serial@vger.kernel.org>; Mon, 26 Dec 2022 10:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077647; x=1703613647;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=k24bYdmKLn3wKSDbOaXHKHtUr5ffwGdk/EsoSzy8NAk=;
  b=BNGm2F812ccsoDV96xX0ooLKsJXE+kYtcOWa3LJY9CndyCA+ZFDo+lCZ
   EKCcscx7X7AmmhaPhJJyqhHSaFRk30hUdkM0dN7m+3EhkUb1Jf5SsL0jf
   2RrN1tKgl856VwBKY6As3aCLbENQmGQVtq9ff4j1jd+2jxXh9WTjBWpdd
   5Unb0UnApIxOyvvmsIlhQoiE/UO/kbPpgOShyi5ggVcqZysYpuRnAPRED
   7zKRLadFPhWN1HtUSJ3Hn4mIqyoKV/Wf7Ue9OpQWFGMxoDmGJQ9kyAPr0
   NduFopicJVJVEsEw0Zseoj+vamEP9Y3qsDcjGOVAM7ogXnMzS5YZKe2W6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="382888600"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="382888600"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 10:00:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="652832484"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="652832484"
Received: from ptelkov-mobl2.ccr.corp.intel.com ([10.249.41.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 10:00:44 -0800
Date:   Mon, 26 Dec 2022 20:00:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Christina Quast <contact@christina-quast.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        daniel.beer@igorinstitute.com
Subject: Re: [PATCH tty-next v2 1/3] hid-ft260: Cleanup macro formatting
In-Reply-To: <20221226171549.73645-2-contact@christina-quast.de>
Message-ID: <b95f9df-9854-ca88-ca1d-9b79974e5773@linux.intel.com>
References: <20221226171549.73645-1-contact@christina-quast.de> <20221226171549.73645-2-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1014192351-1672077645=:1690"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1014192351-1672077645=:1690
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 26 Dec 2022, Christina Quast wrote:

> Wrap macro arguments in braces.
> 
> Signed-off-by: Christina Quast <contact@christina-quast.de>
> ---
>  drivers/hid/hid-ft260.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 333341e80b0e..52a63b966ebc 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -29,7 +29,7 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
>  	} while (0)
>  
>  #define FT260_REPORT_MAX_LENGTH (64)
> -#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
> +#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + ((len) - 1) / 4)
>  
>  #define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
>  
> @@ -132,7 +132,7 @@ enum {
>  	FT260_FLAG_START_STOP_REPEATED	= 0x07,
>  };
>  
> -#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | report_id)
> +#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1014192351-1672077645=:1690--
