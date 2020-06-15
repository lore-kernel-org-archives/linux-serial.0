Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C64C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 19:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9782820756
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 19:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkYfY1MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgFOTYl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOTYl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 15:24:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678AC061A0E;
        Mon, 15 Jun 2020 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o/JsAlwy0uiPTZJbnxb3o/jI/kR8nbsjEu/EdGG2gWc=; b=TkYfY1MZo/dHb2UhJo+l3BaQ7c
        vaFRZj1tB/FYkmWdEPCX86dDElEjgg5tk9m5mLEN8ALrYX1Ed6QtvS9z8kT5Uq09TuvUAK2Dx1ydt
        hk6WkuurSOfi1TqSWEIpNlJm2lIR/YCK5WN8H8koOsM0o8MLaBk0CV4kI909BQoAq/XTxPwfKkxq8
        lL98NcuKEGO9L/c93tY6oouMILZfuDXMbsSmmBjsihUdRlp7UO8+/S8VTL0PshAZdkRBiRaSZD2te
        SjYuAoaFtk7gN6jr5gppjFDwrwzhMWZ+oy6H45tz8uDkFrgkgHtEUVYrg8ySIXwXbwiDLwUmElr9Z
        cKjhYa/A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkuij-0004XU-8S; Mon, 15 Jun 2020 19:24:37 +0000
To:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Heiko Stuebner <heiko@sntech.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] tty/serial: fix serial_core.c kernel-doc warnings
Message-ID: <e170db8e-5c8b-27ac-79a4-81b96ac0ca2d@infradead.org>
Date:   Mon, 15 Jun 2020 12:24:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in serial_core.c:

../drivers/tty/serial/serial_core.c:3300: warning: Function parameter or member 'port' not described in 'uart_get_rs485_mode'
../drivers/tty/serial/serial_core.c:3300: warning: Excess function parameter 'dev' description in 'uart_get_rs485_mode'
../drivers/tty/serial/serial_core.c:3300: warning: Excess function parameter 'rs485conf' description in 'uart_get_rs485_mode'

Fixes: c150c0f362c1 ("serial: Allow uart_get_rs485_mode() to return errno")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-next-20200615.orig/drivers/tty/serial/serial_core.c
+++ linux-next-20200615/drivers/tty/serial/serial_core.c
@@ -3289,8 +3289,7 @@ EXPORT_SYMBOL(uart_remove_one_port);
 
 /**
  * uart_get_rs485_mode() - retrieve rs485 properties for given uart
- * @dev: uart device
- * @rs485conf: output parameter
+ * @port: uart device's target port
  *
  * This function implements the device tree binding described in
  * Documentation/devicetree/bindings/serial/rs485.txt.

