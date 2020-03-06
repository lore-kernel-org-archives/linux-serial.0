Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF4FC10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 21:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0749206CC
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="OvQjSoWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFVor (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:44:47 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:41037 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFVor (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 16:44:47 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7AB0923E5A;
        Fri,  6 Mar 2020 22:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583531084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cxD5IohuBmq+S0fo3u31OLf+lK98IHcZz1tmd3ZCcyc=;
        b=OvQjSoWUVujfGF9j+SNMpJOQd2egfJgzDuCHhrVWGEM1bqzHFynfwQAAxJeVWD3z9WIPNj
        kYRjiNYDIa8DZ0PELxTdtbXtxzfIas+4/dvmkeNvvjteERU0I8FnlC22FgkDrPMyjaGefQ
        QrPnz8g32OI+7hCqHzD7B1e/oA2hHOE=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 0/4] tty: serial: fsl_lpuart: various fixes and LS1028A support
Date:   Fri,  6 Mar 2020 22:44:29 +0100
Message-Id: <20200306214433.23215-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 7AB0923E5A
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.545];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These are various fixes for problems I found during development of the
LS1028A support for the LPUART.

Changes since v3:
 - Dropped patches which were already picked up.
 - Changed the subject of the former patch
     tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
   Thanks Rob.
 - Added errno to error/info messages. Thanks Rob.
 - Splitted this series and removed the dt-bindings patches as well as
   the device tree patches. Thanks Leo.

Changes since v2:
Changed DMA channel request handling. Spotted by Rob Herring. Thanks.

Modified patches:
  tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA

Changes since v1:
DMA support fixes.

New patches:
  tty: serial: fsl_lpuart: fix DMA mapping
  arm64: dts: ls1028a: add "fsl,vf610-edma" compatible

Modified patches:
  arm64: dts: ls1028a: add missing LPUART nodes
   - add dma phandles

Michael Walle (4):
  tty: serial: fsl_lpuart: fix DMA operation when using IOMMU
  tty: serial: fsl_lpuart: fix DMA mapping
  tty: serial: fsl_lpuart: add LS1028A support
  tty: serial: fsl_lpuart: add LS1028A earlycon support

 drivers/tty/serial/fsl_lpuart.c | 210 ++++++++++++++++++++++----------
 1 file changed, 149 insertions(+), 61 deletions(-)

-- 
2.20.1

