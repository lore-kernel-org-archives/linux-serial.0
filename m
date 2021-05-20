Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B90DC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 02:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B134611BF
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 02:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhETCQK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 22:16:10 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34237 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhETCPu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 22:15:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id ACA925808EB;
        Wed, 19 May 2021 22:13:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 May 2021 22:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=odecAKUaHKQG4X3qJBH558YiNF
        7tYkLnTOKSXP3atJM=; b=TBAjCkk+uY2vL+OPwD/lYfZ9Qd6hy31ihSr8xd0dER
        PAhQvk5iYF7YH9Yvo8H2rOcZGIc+JjioT2xksAA+5QM6/HRC2xe94VBjExBy/FhF
        MGqjFe0RWKq60dai30WXXqO4IsJXrc34UIvxcctz9BqHbDSLzX2pzkgILvtmvjDQ
        b2k8t2xr6ZQTQ+wb23M2rYocYszl5wjFwXC9feT0j9PDvdwFoYJE0ARQGoHitZNL
        idcfpvX5BO1Ai500+DqKTMofPg+IPjidnX6VcyeHc6T+Xt2wvZNnQ/tNzo4yHFkK
        RM8vQUUax0XWYWW4VVQYN9JDDZCmJg85nJW5ag3eHIqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=odecAKUaHKQG4X3qJ
        BH558YiNF7tYkLnTOKSXP3atJM=; b=ajPVZwIRN8x1f044hZZ78SjOdzZ2dcid7
        4O6D8HV1KWmQxN+3WPnvpC0HCqGiV4QRKIsofQhNldfU/IZJFNQ0HroscZdCsjtI
        21SuRslEESk2tql30Hb2Ryu8Y54iI0JaOEW9y0mu9VC7oL68I/4++1XEifSKRTyi
        tAVkRR2lEJh7O5Ldk+q46JxM8DF/+yPv/k53jlg7rJflyJN8ckBrI49tZAo+AjnQ
        KH5jL39tibMDPP5TANRlf1IFKXi2HOqnuGQW/K8PCioBUD797wBgVF9ttEy0CFI3
        FW3RdwTvQNBqrP7N758PDBV/moyULfKMQ0yQRv2QDuj8tmJxuCSUw==
X-ME-Sender: <xms:28WlYGlXskmb1XwY4GSsxAC9mvToJbTFdD70sq56mJm1_iX5Udrvlg>
    <xme:28WlYN2pOYZmMq2P-RRQGPhPnoqb3Tg46zgAtz6jwqc1G5f7wpF8J7yEFlAZwXOl8
    NKXqVI_SmSHW7u9lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejtddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepieetheduveelhfdvvdejleeuhfelteevhe
    ffgfeitdefgeekjeefieevgfehhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucfkphepvddtfedrheejrddvudehrdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:28WlYEo5Rio_SEtewHw5ZoTy2Ou0_uUJu5VAoj60hxWk-9-QXLcEWg>
    <xmx:28WlYKlMelg0fgen-9DB4jqEXMFfdYJONK8y4Z0Rbo8uu4BmGb4tXg>
    <xmx:28WlYE0-AgMrl9NNVVgJK64_JsAuy6pFlTfMd5xht_AomF0uh0eS4Q>
    <xmx:3cWlYFIIfjWE1XJLFk1Uatd3BEamHkRzhE9tFYuTqURUSbFhXtLTxA>
Received: from mistburn.lan (203-57-215-8.dyn.iinet.net.au [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 19 May 2021 22:13:43 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com
Subject: [PATCH v3 0/2] serial: 8250: Mitigate Tx stall risk for Aspeed VUARTs
Date:   Thu, 20 May 2021 11:43:32 +0930
Message-Id: <20210520021334.497341-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Briefly, the series works around a hardware race condition in the Tx path for
Aspeed virtual UARTs. A write burst to THR on the APB interface may provoke a
transfer stall where LSR[DR] on the LPC interface remains clear despite the
presence of data in the Rx FIFO.

v3 addresses comments from Jiri on v2. v2 can be found here:

https://lore.kernel.org/lkml/20210519000704.3661773-1-andrew@aj.id.au/

The documentation patch that fell out of the discussion of patch 2 of v2 can be
found here:

https://lore.kernel.org/lkml/20210520015704.489737-1-andrew@aj.id.au/T/#u

Please review!

Andrew

Andrew Jeffery (2):
  serial: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
  serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*

 drivers/tty/serial/8250/8250.h              | 32 +++++++++++----------
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
 drivers/tty/serial/8250/8250_port.c         | 12 ++++++++
 3 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.30.2

