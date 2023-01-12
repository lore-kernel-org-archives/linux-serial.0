Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59ACC61DB3
	for <linux-serial@archiver.kernel.org>; Thu, 12 Jan 2023 10:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjALKC5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjALKAz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Jan 2023 05:00:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384E1634F;
        Thu, 12 Jan 2023 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673517610; x=1705053610;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3GPAZq+fNFCTPuMMMbtI7zY+8CXHFdOVJOWXl2x6qzg=;
  b=h2oOgE11KWKcLHPHpDXXsA2k12p7m8i48pAbxq0QLWDvVFQr1YLLBHDC
   dUBt2e8U8PHOW1/m0GzSoO3erLG10X8il1aJuaPxatpW3dmDAS0E3aXua
   ekXDtpbd5Hr0XXqrfZyB0soqgjf+akKq+ZnZ1LT/ijGXMCuoNcxsLZeAI
   x68rGffETDImkO9+cXO2QsEhxFUaA5EHx9OuXIHNiHO3Wv4A/YV1bWnJ7
   H2D6EOD7a06hs8BW7w8x3Rhqfo65IEIbav9HXgjZ9TRPV/WnPqwKIbFXe
   OxRwClhe5h78OkySbvTw/C9C/hCahiharMOEPlDJkUkz6PCu9YEc/+t7Y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303363541"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="303363541"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:00:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800155113"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="800155113"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:00:08 -0800
Date:   Thu, 12 Jan 2023 12:00:06 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] tty: vt: cache row count in con_scroll()
In-Reply-To: <20230112080136.4929-11-jirislaby@kernel.org>
Message-ID: <629b305a-bc9c-7dfa-907-c96d7e676f74@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-11-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-540318884-1673517609=:1665"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-540318884-1673517609=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> It's used on few places, so make the code easier to follow by caching
> the subtraction result.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 165c81211bdc..671304b31f9f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -561,10 +561,11 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
>  		       unsigned int bottom, enum con_scroll dir,
>  		       unsigned int nr)
>  {
> +	unsigned int rows = bottom - top;
>  	u16 *clear, *dst, *src;
>  
>  	if (top + nr >= bottom)
> -		nr = bottom - top - 1;
> +		nr = rows - 1;
>  	if (bottom > vc->vc_rows || top >= bottom || nr < 1)
>  		return;
>  
> @@ -577,10 +578,10 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
>  	dst = (u16 *)(vc->vc_origin + vc->vc_size_row * (top + nr));
>  
>  	if (dir == SM_UP) {
> -		clear = src + (bottom - top - nr) * vc->vc_cols;
> +		clear = src + (rows - nr) * vc->vc_cols;
>  		swap(src, dst);
>  	}
> -	scr_memmovew(dst, src, (bottom - top - nr) * vc->vc_size_row);
> +	scr_memmovew(dst, src, (rows - nr) * vc->vc_size_row);
>  	scr_memsetw(clear, vc->vc_video_erase_char, vc->vc_size_row * nr);
>  }
>  
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-540318884-1673517609=:1665--
