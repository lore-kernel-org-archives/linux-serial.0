Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6265CC3F2D8
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C541214D8
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="EMPB6VLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgCCRnW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:43:22 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:41849 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgCCRnW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 12:43:22 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D7C1C231D9;
        Tue,  3 Mar 2020 18:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583257399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/SS0Mpitdw47OknrMdnyVNGnPtzEQcsJ+qOlq2fN2jQ=;
        b=EMPB6VLynHXmYFxKp/ONkM14baAzs5ZaCvqFD/iFs09cuXslOkpOh9Iw3zyk+Pt/xYIfXK
        0fkrfGlazORExVvOcTQEwlC+8NmN3+DP/MFu53+G/CkM9/Zj+jA8EgeHYcN2D1fCR5681+
        /6RGigOxmRBKGX4DyhS21DvMk2DCCc4=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 0/9] tty: serial: fsl_lpuart various fixes and LS1028A support
Date:   Tue,  3 Mar 2020 18:42:57 +0100
Message-Id: <20200303174306.6015-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: D7C1C231D9
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.504];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
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

Also, I'm not sure if this series should be split between the "tty:
serial: fsl_lpuart" patches and the devicetree patches. So unless
someone tell me otherwise I keep them together to avoid mention any
dependencies.

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

Michael Walle (9):
  Revert "tty: serial: fsl_lpuart: drop EARLYCON_DECLARE"
  tty: serial: fsl_lpuart: free IDs allocated by IDA
  tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
  tty: serial: fsl_lpuart: fix DMA mapping
  dt-bindings: serial: lpuart: add ls1028a compatibility
  tty: serial: fsl_lpuart: add LS1028A support
  tty: serial: fsl_lpuart: add LS1028A earlycon support
  arm64: dts: ls1028a: add "fsl,vf610-edma" compatible
  arm64: dts: ls1028a: add missing LPUART nodes

 .../devicetree/bindings/serial/fsl-lpuart.txt |  10 +-
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  75 +++++-
 drivers/tty/serial/fsl_lpuart.c               | 251 ++++++++++++------
 3 files changed, 255 insertions(+), 81 deletions(-)

-- 
2.20.1

