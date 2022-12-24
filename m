Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE89C4332F
	for <linux-serial@archiver.kernel.org>; Sat, 24 Dec 2022 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiLXQdK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Dec 2022 11:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQdJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Dec 2022 11:33:09 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7CB1EE;
        Sat, 24 Dec 2022 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671899578; bh=K/4hiOY7BCAUKajIhqlHSoKC/VJgy4tl+xgmPVyY+k4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=FRAGCzUFPmCK5IdKOA34GaiVzVxDA4FdvhtF21/qqctny0Z9yFRwh8Cqs6KLa1LQC
         ZHdPSnov8mN3XXYZ2DRn0JFa/QNLkLunEF+oYbF1OuCfX11rTOqzsz1lVK3KLczJKG
         75fU+tXZaWedxXLqdiPwgBvxPcoWNCx2zPuONow0=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 24 Dec 2022 17:32:57 +0100 (CET)
X-EA-Auth: m+O+37z/zobbcd/q9gfrbRXii/EjTueFXCMX9nloDIxpkGLpkBPGCJ7oDFEwAvnEQhKne+25H6Rm8hSOmgarMboUtcjP7TJl
Date:   Sat, 24 Dec 2022 22:02:50 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 0/2] tty: serial: dz: convert atomic_* to refcount_*
Message-ID: <cover.1671898144.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The patch series proposes to transition the driver from using atomic_t APIs to
refcount_t APIs for reference count management.

Note: patch 2/2 depends on patch 1/2. Hence please apply path 1/2 first.

Changes in v3:
   1. Patch series introduced rather than individual patches.
   2. Update patch subject line to indicate the atomic_t variable being changed

Changes in v2:
   1. Separate the change to patch per variable rather than combining multiple
      atomic variable changes into a single patch.

Please note:
   The patches are compile tested using dec_station.defconfig for MIPS architecture.

Deepak R Varma (2):
  tty: serial: dz: convert atomic_* to refcount_* APIs for map_guard
  tty: serial: dz: convert atomic_* to refcount_* APIs for irq_guard

 drivers/tty/serial/dz.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

--
2.34.1



