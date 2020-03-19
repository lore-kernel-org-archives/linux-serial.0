Return-Path: <SRS0=NQQO=5E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A1BC4332D
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 10:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1406C20722
	for <linux-serial@archiver.kernel.org>; Thu, 19 Mar 2020 10:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gSXNZdVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgCSKcO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:32:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57106 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgCSKcO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Mar 2020 06:32:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JAW9Fn129511;
        Thu, 19 Mar 2020 05:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584613929;
        bh=1kWR+CKoZeAh81DpG4GKp4GDuawCt79rl//8++rYBb0=;
        h=From:To:CC:Subject:Date;
        b=gSXNZdVIinyLpvNJk3FpLNt46U3dzVLuhngsbGaVDpfLL4b98pL+rts+c0IFRNSmJ
         gQAWhFZJeYCTVsnLVTsj7jFHsB7k/SeLUBZpsCZtrhRD8ivv0+zmMG/pUogNCjVped
         YKbntn5T1CKglo+6bcM/2hycBZe9bv8Om8PUHpOc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02JAW9QW014132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 05:32:09 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 05:32:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 05:32:09 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JAW6Ah068234;
        Thu, 19 Mar 2020 05:32:07 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Oliver Barta <o.barta89@gmail.com>
Subject: [PATCH 0/2] 8250_omap: Fix throttle callback
Date:   Thu, 19 Mar 2020 16:02:28 +0530
Message-ID: <20200319103230.16867-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series tries to reimplement commit 2e9fe5391083 ("serial: 8250: Don't
service RX FIFO if interrupts are disabled") which was reverted by
commit 3f2640ed7be8 ("Revert "serial: 8250: Don't service RX FIFO if
interrupts are disabled") due a bug that caused error informations to be
missed.
Current series uses stop_rx() instead of relying on IIR bits

Vignesh Raghavendra (2):
  serial: 8250: Don't service RX FIFO if throttled
  serial: 8250: 8250_omap: Fix throttle to call stop_rx()

 drivers/tty/serial/8250/8250_omap.c |  5 ++---
 drivers/tty/serial/8250/8250_port.c | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.25.2

