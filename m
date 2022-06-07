Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A0C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 13:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbiFGNgn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244847AbiFGNgi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 09:36:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F5F5061;
        Tue,  7 Jun 2022 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654608994; x=1686144994;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6yxE0YEFT4sCKWHndd+S7xEcoefnVAYtf/Dh/JT+JA8=;
  b=FCsvp1+LxJeXDfe+HcyBE/RYr1XZBfH9m35JwgR4mZ7l8wC3luYOrBuq
   TBsJx+QVoWiSJZPFaadZ0Q9jFq+7/Nl/5t/T1d9CbIytIT707fvzcQpTu
   8fj2TqGVY75VTNlBgZgmGDeKgJmYz0qcC9C9V3rW5Ju8thnrLcYbsqbet
   1Tnhs8ZGdwtG5OVjUT8tYc4pa+VPSYnHuVhwUpnTwCoeUBTLVUMxYPBvK
   2qurAJ45GwGkvaKTqnTCOLb1zaiknh86MW7RUxXV+ZD7Fb80PTZgHscEu
   kekMm3OnfRszK97W14quHZpStoa6w6FOtHSloyt+J6OGuzxskNCECyKvR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="256557852"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="256557852"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:36:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584201116"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:36:28 -0700
Date:   Tue, 7 Jun 2022 16:36:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/36] tty/vt: consolemap: use | for binary addition
In-Reply-To: <20220607104946.18710-9-jslaby@suse.cz>
Message-ID: <76b4c430-50ac-9c7f-a34a-b9fc12fc760@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-9-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1617839474-1654608989=:1622"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1617839474-1654608989=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> Unicode letters are composed as a bit shifts and sums of three values.
> Use "|" and not "+" for these bit operations. The former is indeed more
> appropriate.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> ---
>  drivers/tty/vt/consolemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index f97081e01b71..016c1a0b4290 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -265,7 +265,7 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
>  				glyph = p2[k];
>  				if (glyph >= 0 && glyph < MAX_GLYPH
>  					       && q[glyph] < 32)
> -		  			q[glyph] = (i << 11) + (j << 6) + k;
> +					q[glyph] = (i << 11) | (j << 6) | k;
>  			}
>  		}
>  	}
> @@ -788,7 +788,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
>  						continue;
>  					if (ect < ct) {
>  						unilist[ect].unicode =
> -							(i<<11)+(j<<6)+k;
> +							(i<<11) | (j<<6) | k;

I'd have added also the spaces around <<.

-- 
 i.

--8323329-1617839474-1654608989=:1622--
