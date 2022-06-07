Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DACBC433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 13:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbiFGNfN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiFGNfK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 09:35:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F760C0E3D;
        Tue,  7 Jun 2022 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654608909; x=1686144909;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nk2FQNCwXfa0h6pokVAdh8hD10SQTS2uKjBoUDhQsiQ=;
  b=NHR9atT3esBIw2tMOW7N8Ou6ceGX8WFtIM50ceblbfzGeYht4qMpqYv3
   VugHO6H6QPDUtx6K1uJCYzWfvVkPcodtffAmQmgUM9Pv4yP7wKviPWyRR
   0gayYe64Gp2WJI281VY1ZfHehNs4t8dPv+VZrB0t+UX+49WsKLUVAsJkB
   +xg0ppkWMiXGS9D6wzNgz+6+5uOOGstYasRTn0xnugjT9VAFq6GL1JS0q
   2OOxklnjpXAsKbAdrAdTUp7fG0tShMaUycYCSGDhAH57WC/NAfvFOYLGN
   pH7w6ZSJD1Qrd7p+FgGj+Ag/rgHo0x44V8Z1wR85s5P7R3Tlg5PteOQ84
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275496334"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="275496334"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:35:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636127178"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:35:07 -0700
Date:   Tue, 7 Jun 2022 16:35:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/36] tty/vt: consolemap: one line = one statement
In-Reply-To: <20220607104946.18710-8-jslaby@suse.cz>
Message-ID: <f38a1c1-7a35-c67-ec11-4646ba9ce76c@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-8-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1285436299-1654608908=:1622"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1285436299-1654608908=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> Some lines combine more statements on one line. This makes the code hard
> to follow. Do it properly in the "one line = one statement" fashion.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1285436299-1654608908=:1622--
