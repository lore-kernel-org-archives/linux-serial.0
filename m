Return-Path: <SRS0=JG5f=5H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03702C54EEB
	for <linux-serial@archiver.kernel.org>; Sun, 22 Mar 2020 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE292072E
	for <linux-serial@archiver.kernel.org>; Sun, 22 Mar 2020 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lovelett.me header.i=@lovelett.me header.b="qxuRhDbc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bK1RDI2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCVTkg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:40:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43949 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgCVTkg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 22 Mar 2020 15:40:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C88365C01B5
        for <linux-serial@vger.kernel.org>; Sun, 22 Mar 2020 15:40:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 22 Mar 2020 15:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lovelett.me; h=
        message-id:subject:from:to:date:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=36+dQGWpZ4VZjKx3FtdLFh9/jn
        t53I2Fwi46CWP7yck=; b=qxuRhDbcAzT7zAnL62gR9fwl1UOdkiQd2r0Tr3BqVN
        ahPJtklfW1A337+D/9vOyq1k7FRnQhpH41hE3Wg9ra7p7flSvSjFoAvpvY824PJn
        LhthiaHLCCTgkYdQSUyvCKiJkaSVP7XhDW+wInpkNjyh52DHfVa2qdC43trs/Nrv
        ZtyRTum29q+NxVJ/k61qqiYAUSTBwSDXWtjMwCPFueFj90kyxnftsfbYX/l27Mjd
        2rX+0Wo5b6k+RPyrkGgfIdBXJy8zVAx52h7rd4/JHOUlm9A6hvxwNgGXCaDoZi36
        7C+wW+RYzIBfyVvFxsQ2zsx2MIst3zg2QbEA2hCjyZMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=36+dQG
        WpZ4VZjKx3FtdLFh9/jnt53I2Fwi46CWP7yck=; b=bK1RDI2nJJV7vu4gVUesxL
        oXZ7MN2wHgLQxPay4hmRNsrmNVugNwb3scI9WBlFvKFVrdlHQnwJTF90SMfrCrlI
        xkh9rQpR6pHj5icw2C7vbPPt6RPhiolHl1aZZMbN3PFP0hZBvt8Ry5V8iyClMgpl
        LNXLzzOUcwVOydYbJ6Cp5cjA4N4j7PwaKen3CMwOi4vfCaJuldQbkVFKw0ygIwnZ
        n4eEBznVg+VfYGdSuYgS1yC9zE2aAa54HbcfS9nG7ycKEUZICjkhDjp8PWPRDARR
        7KHRZnukqramBjEwvY/HQ/nBkYHG6fsON49in95RuVf7rRFkIgS7Vo+UYb1LCnKQ
        ==
X-ME-Sender: <xms:Mr93Xs5yijPMbwa4_7oCYqqROFRD-u9LVOyLEXtMWBxOtnrQhxTnWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegiedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtfggggfesthejre
    dttderjeenucfhrhhomheptfihrghnucfnohhvvghlvghtthcuoehrhigrnheslhhovhgv
    lhgvthhtrdhmvgeqnecuffhomhgrihhnpegruggrfhhruhhithdrtghomhdpfhhtughitg
    hhihhprdgtohhmpdhkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedu
    tdejrddugeehrdduheejrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhihrghnsehlohhvvghlvghtthdrmhgv
X-ME-Proxy: <xmx:Mr93Xk33ksj6-9eOoEUI2S_Dna8Ok2aiJDHfkppV1FgHbcmbSQRs1A>
    <xmx:Mr93Xh4lf71pjBc9g3U9V0Xuh9JS-ITsUig8kJ7ZjzC_7dh6NSIFdw>
    <xmx:Mr93XvrKlmdUP-3zFZADuTNBNfDIIZrw02lIp9GP61BTrBQx1enQew>
    <xmx:Mr93XqlRwqbjWUJpQpzeZRlPaJkl1qAow3bRkgrKd7fuCbFQYl8-qQ>
Received: from linux-development (107-145-157-103.res.spectrum.com [107.145.157.103])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E3CB3280060
        for <linux-serial@vger.kernel.org>; Sun, 22 Mar 2020 15:40:34 -0400 (EDT)
Message-ID: <6267385dcb44b73f3b5b38070da602bbdb56d545.camel@lovelett.me>
Subject: FT232H user space GPIO device
From:   Ryan Lovelett <ryan@lovelett.me>
To:     linux-serial@vger.kernel.org
Date:   Sun, 22 Mar 2020 15:40:33 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I have been trying to find a way to get my Adafruit FT232H breakout
board [1] to appear as a user space GPIO device so I can use it with
libgpiod. As far as I can tell from reading table 3.5 from the
datasheet [2] ACBUS5, ACBUS6, ACBUS8 and ACBUS9 should all be usable
for this.

I found a patch that was submitted by Karoly Pados in 2018 [3] that
seemes to add support for that (though maybe only for a specific chip).

Through a little bit of ftrace and printk I realized that the switch
statement in ftdi_gpio_init was falling through to the default case for
the FT232H [4].

I'd like to see if an expert on these mailing lists can help me to
understand if what I'm trying to achieve is possible. If so, to learn
how I might go about getting it working. My current guess is that I
need to implement a new ftdi_gpio_init_ft232h method and possibly the
modify the ftdi_read_eeprom method. But I'm not really sure.

Regards,
Ryan Lovelett

[1] https://www.adafruit.com/product/2264

[2] 
https://www.ftdichip.com/Support/Documents/DataSheets/ICs/DS_FT232H.pdf

[3] https://patchwork.kernel.org/patch/10614055/

[4] 
https://github.com/torvalds/linux/blob/v5.3/drivers/usb/serial/ftdi_sio.c#L2100-L2109

