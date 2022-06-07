Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E043C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiFGNkq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiFGNkq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 09:40:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE225EDC6;
        Tue,  7 Jun 2022 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654609245; x=1686145245;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gAfJmXcwb8Nnsd2+PjBpV8H78IahsgSnLyUUp+5B3zg=;
  b=YcDGnO3JR0BXn4KnH1G74pA56T8cajtwOLqNyi+Sp+5uI1qf/PVulTpC
   zQZ8C3gl9ctoDNGLQK5uwLuFBT73YRJfPYJFTSFZS7xGSUcY1FUOH1LDE
   Q5Rel05fES2Ahq3QINky8BnW9Wk5/ZqCj0nTv2tgoqjT+84VMOR0xB53F
   xdl4n0PPhH1gR8+rsEGuEVhau5KfTD9PeHP9sNE/re5DZPQiMdp50uYjV
   uud2+tO8gKEddKoKztBw4hDQAhWrYpa9pdcLGZYKTe/zqhanA4+/RxegL
   3unC26Cq57QM5scfem8Dv1pD5FZlIbBj0i8ZSfuOXjMM9xkjf1e8D5p8g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277198867"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277198867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:40:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636128981"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:40:30 -0700
Date:   Tue, 7 Jun 2022 16:40:27 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/36] tty/vt: consolemap: use | for binary addition
In-Reply-To: <76b4c430-50ac-9c7f-a34a-b9fc12fc760@linux.intel.com>
Message-ID: <d9ef796b-54e7-e9ca-9bae-fbec5a976bfd@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-9-jslaby@suse.cz> <76b4c430-50ac-9c7f-a34a-b9fc12fc760@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-386273698-1654609232=:1622"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-386273698-1654609232=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Ilpo Järvinen wrote:

> On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
> > @@ -788,7 +788,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
> >  						continue;
> >  					if (ect < ct) {
> >  						unilist[ect].unicode =
> > -							(i<<11)+(j<<6)+k;
> > +							(i<<11) | (j<<6) | k;
> 
> I'd have added also the spaces around <<.

Ah, nevermind. I see the line gets changed later on to something entirely 
different.

-- 
 i.

--8323329-386273698-1654609232=:1622--
