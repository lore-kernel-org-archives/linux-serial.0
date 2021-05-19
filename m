Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A49C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 00:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512D961360
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 00:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhESAIn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 20:08:43 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:54437 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232153AbhESAIm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 20:08:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6FA455805F7;
        Tue, 18 May 2021 20:07:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 May 2021 20:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=kIJvSpFWD6QHDHPhzb9ntcgPgn
        4w/LCFBFJ9RCTjTi4=; b=TIoHkM0sHSsjducPcvC1Ss4gb/P7sKBK6ZOfm8TTtc
        d0Yz4mjGZdZWjlJBvIFYU8Zty0FCMcs7Scjz3M1BqUcLdLxZt5Cf9L8ZuyAOJ98q
        AOWnPF3cNzVPcmcPccvfGbJgJBpBpGqcduyVkQ4xq6azYznWRNpO4NuqYa3LmFXB
        IXyTghSN8PGvupj16+PzLFuA9a1M966seYeG6N4AAJY/64FtqxOLeel8FOtUSILP
        gbvxbk/LjuU7FDxbl2r0Q0VQ393NavsbdQKKsZkrQnKq6yK3lKxEwtjJAs9lH7F/
        OqKgRhkRvc2JuOSjQZCkJJ7cCKxPK9Y5TnhMrAZZvPQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kIJvSpFWD6QHDHPhz
        b9ntcgPgn4w/LCFBFJ9RCTjTi4=; b=Uuf834IhHqMCxkknLbgFvWhJg98elUBWc
        y76VXgu0cBj7bSApJojkBQ6tXG13hGvHkzvMJxW0uSdKG9iozyt71z73R/Z48sev
        CSeJallINraOnhkLw7HGmtPx9DLEadhOijl6gxKmYmQpg1Ule1Nea+CO/JyaPS3o
        yhg2JrSYjUpJFit7X61q20weLLokZ41X2J/1QpsZ3zW36b2tgm23Tkm1GrkgrehV
        vFJKXiniWI03Uez6TbhxVEWzWW05t4ksc9RbJXeoHgLQ3HBUxNk6/C1vUE1Nd2Fc
        5DI5PL63nj5Id0l1tuwHNjniTyb2n1rhBF7EEbRbf+TxY1gcDT4bA==
X-ME-Sender: <xms:ulakYM9EmuUHsLnPgH75B8EZ4Ds5jkZv01yu4hpzcgIaDxsdID58iQ>
    <xme:ulakYEtiS5XXCdLHE_pAxlOJuUrpK-H3VBhXLvjk3MMGwc4WT63zthAOWE7Md97DD
    ssNsuifl9Vk9EYk_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeikedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepieetheduveelhfdvvdejleeuhfelteevhe
    ffgfeitdefgeekjeefieevgfehhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucfkphepvddtfedrheejrddvudehrdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:ulakYCCU7OmYcifnTP7xL0KirYw095x0krpjui-HQNSYvQ7PugAdcA>
    <xmx:ulakYMc9M7mTd42rxif6Q6_Q8Ztzz19_VTgti1LHrusK_sOnVjTMSw>
    <xmx:ulakYBPcCabYVH-GxZnJq8ozZb7e2B8nS2wuOR1Sib8U2y9CgY6n1g>
    <xmx:u1akYKjEaJS08qP0dhCiRSDRxbMRfUDVJL6hvb5Zn9Y31DErHF9WCw>
Received: from mistburn.lan (203-57-215-8.dyn.iinet.net.au [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 20:07:17 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com
Subject: [PATCH v2 0/2] serial: 8250: Mitigate Tx stall risk for Aspeed VUARTs
Date:   Wed, 19 May 2021 09:37:02 +0930
Message-Id: <20210519000704.3661773-1-andrew@aj.id.au>
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

For the work-around patch, v2 addresses the request for a comment about the use
of serial_in():

https://lore.kernel.org/lkml/d7918dcf-b938-498c-a012-3d93a748431b@www.fastmail.com/T/#md75702fbc3704bd4b375f1251a1415bcddea26a3

The second patch addresses the request for use of BIT() instead of an explicit
shift by converting all of the UART_{CAP,BUG}_* macros.

Please review!

Andrew

Andrew Jeffery (2):
  serial: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
  serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*

 drivers/tty/serial/8250/8250.h              | 32 +++++++++++----------
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
 drivers/tty/serial/8250/8250_port.c         | 10 +++++++
 3 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.30.2

