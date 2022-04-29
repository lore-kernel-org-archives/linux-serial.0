Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C6C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 29 Apr 2022 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiD2Unh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbiD2Ung (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Apr 2022 16:43:36 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDFB811A39;
        Fri, 29 Apr 2022 13:40:15 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4C33192009C; Fri, 29 Apr 2022 22:40:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 44D6692009B;
        Fri, 29 Apr 2022 21:40:13 +0100 (BST)
Date:   Fri, 29 Apr 2022 21:40:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: sifive: Correct/improve baud base handling
Message-ID: <alpine.DEB.2.21.2204281344190.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

 While fiddling with other serial port devices with the use of my HiFive
Unmatched board I have noticed we do not correctly report the baud base 
value for the SiFive FU740-C000 SOC's on-chip UARTs.  This small patch 
set fixes the initialisation of the baud base value and then simplifies 
handling by removing now redundant duplicate port parameter.

 See individual change descriptions for details.  This patch set has been 
verified with the HiFive Unmatched board.  Please apply.

  Maciej
