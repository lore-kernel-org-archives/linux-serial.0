Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEDDC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 14:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbiFGOLM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiFGOLL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 10:11:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D2A3C23;
        Tue,  7 Jun 2022 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654611070; x=1686147070;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6nyYrRsld2hYKi7Jf8o10LvQWJ7y4xctI5lUl7RnMpY=;
  b=Vg4BHTbVhkF9B7UHieHaCzuZmOlNMBeUs337FZJwFUuLLV9jmJNxYZdE
   B0CA6GYTO7wrHzpeC+1/BtZ32AR4Fb7+WMLOzjd73unTMUj6oG9RR1g2R
   1QSLobDcSDFSodB/sVqSYhm4llTx7GfqA+PbDOK1hCs41moz9PIVMhB+r
   Yl23ET51d4DHImkLqIYUlptdRpVHiSA4Iw4meMhXXaCXvFvgD+uGwDOvB
   wSh763uvJiwhoFySXT/Ct9/QkNUgpEhg0A06OKzPRro+esMLl4e/rVcGy
   BO9Xv36A7wh55zhShi06HXEnJfxJ9cefaQ1UrqIpNEScn7vufzN7Vp+RW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="276763667"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="276763667"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:11:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584211974"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:11:07 -0700
Date:   Tue, 7 Jun 2022 17:11:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/36] tty/vt: consolemap: make con_get_unimap() more
 readable
In-Reply-To: <20220607104946.18710-14-jslaby@suse.cz>
Message-ID: <10b17051-fec-7b2-aee2-f62cbe8e9a14@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-14-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1347469348-1654611069=:1622"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1347469348-1654611069=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The indentation is completely broken in con_get_unimap(). Reorder the
> code using "if (!cond) continue;"s so that the code makes sense. Switch
> also the "p" assignment and add a short path using goto. This makes the
> code readable again.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1347469348-1654611069=:1622--
