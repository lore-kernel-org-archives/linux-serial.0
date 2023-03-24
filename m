Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BECC761AF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 10:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCXKCe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXKCd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 06:02:33 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 772522367E;
        Fri, 24 Mar 2023 03:02:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,287,1673881200"; 
   d="scan'208";a="153660269"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Mar 2023 19:02:27 +0900
Received: from localhost.localdomain (unknown [10.226.93.228])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8C158401BBF8;
        Fri, 24 Mar 2023 19:02:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/3] Add RZ/G2L SCIFA DMAC support
Date:   Fri, 24 Mar 2023 10:02:19 +0000
Message-Id: <20230324100222.116666-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series aims to add DMA support for SCIFA IP found on
RZ/G2L alike SoCs.

v1->v2:
 * Added support for DMA tx and rx.

This patch series depend upon [1]
[1] https://lore.kernel.org/linux-renesas-soc/20230321114753.75038-1-biju.das.jz@bp.renesas.com/T/#t

Biju Das (3):
  tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based
    on DMA direction
  tty: serial: sh-sci: Add RZ/G2L SCIF DMA tx support
  tty: serial: sh-sci: Add RZ/G2L SCIF DMA rx support

 drivers/tty/serial/sh-sci.c | 59 +++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

-- 
2.25.1

