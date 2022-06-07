Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D2EC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 14:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiFGO0u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiFGO0t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 10:26:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF601F1355;
        Tue,  7 Jun 2022 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654612007; x=1686148007;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hCMgvCBkBCY4Vcl2F8PVd99E2NYd2skQpnhgyg7W0XQ=;
  b=AcTIAvb1Cx1WTfyZgQY5cbglB6tNndtD6O7azIWq42mx914IeTzDOosh
   lLb8lJlTScCtpbCzMQGKJ8ujrOVoSyptfBkQ+V/u4carj2IeUKgE+lwYa
   8iQX4Bmmmfu4JGypiJiNzSBL3lAhPCgz3fSohvcNOhKQqm1hrwUROLhFp
   fxtAgeYKidSJx4BVoHotkfP2+n0coawer6M4kkPXXIaBOgUBoNO6+xDFB
   GrozcP8qc8Fm9cz09UuvZn/5jLfhpArFp9gkkKOIy2HhAFkC8WP6fKgzV
   Ue371mGubefyw1LXkXFDL3m4Wk1kaWaxEG48OM+tA2QoDKyJADd0gVxkG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277538376"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277538376"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:19:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636144213"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:19:20 -0700
Date:   Tue, 7 Jun 2022 17:19:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
In-Reply-To: <20220607104946.18710-16-jslaby@suse.cz>
Message-ID: <8ad44d3b-449f-4a30-1a4c-dffd43bbbd1@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-16-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> Only the return value of copy_to_user() is checked in con_get_unimap().
> Do the same for put_user() of the count too.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/consolemap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index 831450f2bfd1..92b5dddb00d9 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -813,7 +813,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
>  	console_unlock();
>  	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
>  		ret = -EFAULT;
> -	put_user(ect, uct);
> +	if (put_user(ect, uct))
> +		ret = -EFAULT;
>  	kvfree(unilist);
>  	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
>  }
> 

Doesn't this fix something?

-- 
 i.

