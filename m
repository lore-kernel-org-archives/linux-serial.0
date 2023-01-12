Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BC0C54EBD
	for <linux-serial@archiver.kernel.org>; Thu, 12 Jan 2023 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjALIn5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Jan 2023 03:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbjALInc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Jan 2023 03:43:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48555274A;
        Thu, 12 Jan 2023 00:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673512879; x=1705048879;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+yHyE9ATjVCE06kM12+yzDWxrejUryPNZr0eQsaD0Fo=;
  b=eJfDrHwdlERSzfx4HavjPOPdcgXs/njXHMeSUk8iTYlnimQYQYkYcYCV
   GdwQN2XqQ1unq0D/KW5X6NVDac+Midy7e/1X6E62ny52aBVOHlAza9EPp
   LDNjaf2nZltJGBnBCwVIC9rFzOB6cgBFES2vVBxNbmw+7DeFfqWazqhjv
   fs5ilQlT3IjHT7xf9bRK76lZzrcRVcX8JiEBAEexV/LkOBr+5GzR35LzE
   9ZzW7vvGb3yw7DMXUdCdwc/O2i53koiP0eMC7ayukMPQlCyJwJgAn1XE/
   iZZgMiLQ3/MVURztUPp9ut4cfFqRWRwZgZZP2tQYSOWsuep/jSTzcjSqf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311470876"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="311470876"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:41:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659700505"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="659700505"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:41:17 -0800
Date:   Thu, 12 Jan 2023 10:41:11 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, Kees Cook <keescook@chromium.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] tty: vt: drop get_vc_uniscr()
In-Reply-To: <20230112080136.4929-2-jirislaby@kernel.org>
Message-ID: <f7854019-b7da-27ce-5b97-17196e2fab72@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-2-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-151321998-1673512878=:1665"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-151321998-1673512878=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> Its definition depends on the NO_VC_UNI_SCREEN macro. But that is never
> defined, so remove all this completely. I.e. expand the macro to
> vc->vc_uni_screen everywhere.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-151321998-1673512878=:1665--
