Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D877C6FA92
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 08:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiITIjD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiITIiQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 04:38:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476F6B651;
        Tue, 20 Sep 2022 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663663031; x=1695199031;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9ncUnQaz6hGQ12Cfhs2Iqdzf8lbhCz+Jwy0A7Sr0wfs=;
  b=V7sPmyA9vdqPZ5jdF4eksRDyzI3FNuDglXgnPbvW4pacY5TLJUkUe0X9
   TL/bkqhDxMHU5zxKnsbubbgmxKRp64bxvgbAZFxe9FJvG5CKfchKa4zzM
   fNuVsBfeVDAbzUOaXSYXHqnsH7tFkNTyqe/zPH9tqh99Am8UJR0nAxUEE
   /02XLot2TfbJGwWVTxW/GL4RPvxI4+rREcDUcrlR1vtVNOP2+VTIip03D
   HYIAWBJxHCoH7lcxYuX/Qjzt7ivBs4T5w4PDcp5lve6g8ylg8WTPGGqLZ
   k7M5U5eV+q73qfWvKW0jJcNvjpWHQDcWjyf+7eC5tYqesu/oOX8VOV7Gf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300455097"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="300455097"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="569995860"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:37:09 -0700
Date:   Tue, 20 Sep 2022 11:37:06 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] tty: serial: switch mpc52xx_uart_int_{r,t}x_chars()
 to bool
In-Reply-To: <20220920052049.20507-7-jslaby@suse.cz>
Message-ID: <5918019-2abc-acd4-7171-54ad2a81854@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2142333720-1663663030=:1766"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2142333720-1663663030=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> mpc52xx_uart_int_rx_chars() returns unsigned int.
> mpc52xx_uart_int_tx_chars() returns int.
> 
> The both results are binary ORed to the "keepgoing" variable. Unify all
> three to bool as the only interesting value is whether we should keep
> looping (true/false).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2142333720-1663663030=:1766--
