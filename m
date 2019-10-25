Return-Path: <SRS0=5Xrm=YS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B04CA9EA0
	for <linux-serial@archiver.kernel.org>; Fri, 25 Oct 2019 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB2321929
	for <linux-serial@archiver.kernel.org>; Fri, 25 Oct 2019 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392288AbfJYKxV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:53:21 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:48316 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390265AbfJYKxV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Oct 2019 06:53:21 -0400
X-Greylist: delayed 1403 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 06:53:20 EDT
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id x9PATuPm052443
        for <linux-serial@vger.kernel.org>; Fri, 25 Oct 2019 18:29:56 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9PATZEq051688
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Oct 2019 18:29:35 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 25 Oct 2019 18:29:17
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 0/3] Add Unisoc's SC9863A support
Date:   Fri, 25 Oct 2019 18:29:12 +0800
Message-ID: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9PATZEq051688
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


SC9863A has Octa-core ARM Cortex A55 application processor. Find more
details about this chip on the website: http://www.unisoc.com/sc9863a

Chunyan Zhang (3):
  dt-bindings: serial: Add a new compatible string for SC9863A
  dt-bindings: arm: Add bindings for Unisoc's SC9863A
  arm64: dts: Add Unisoc's SC9863A SoC support

 .../devicetree/bindings/arm/sprd.txt          |   8 +
 .../devicetree/bindings/serial/sprd-uart.txt  |   1 +
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         | 536 ++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi         | 188 ++++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts     |  40 ++
 6 files changed, 775 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts

-- 
2.20.1


