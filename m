Return-Path: <SRS0=iYMu=4J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D7C35640
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 09:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DCF2073A
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 09:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="KmGNlDaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBUJer (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:34:47 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44453 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgBUJer (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Feb 2020 04:34:47 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C90A023D18;
        Fri, 21 Feb 2020 10:34:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582277684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Snop1RpX2rRCwWvJOlE+k0QPMCh/eFbh+WZC0GsS4uA=;
        b=KmGNlDaQ0PxdmjCYZnUUKedfMyyTcUd1gXD7yIRoHmxoX8UnGY0zb8lm/piMWP+VR63s+Q
        xDwYHFxwJHy9ZFrwvVkKljKvR6iTMLBWGm73MzpxQ7dvFMbKyX8tHOeOi7EYExgDLXEGCm
        m1eae/F2FAQ5vFJE9UpYBMB+T+cGQ+g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 10:34:43 +0100
From:   Michael Walle <michael@walle.cc>
To:     Peng Fan <peng.fan@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Yuan Yao <yao.yuan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop
 EARLYCON_DECLARE"
In-Reply-To: <AM0PR04MB44817308EA80EBEDC0338E6D88120@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20200220174334.23322-1-michael@walle.cc>
 <AM0PR04MB44817308EA80EBEDC0338E6D88120@AM0PR04MB4481.eurprd04.prod.outlook.com>
Message-ID: <51db0e6ba10b4b32dab207e0df8ef0d8@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: C90A023D18
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         NEURAL_HAM(-0.00)[-0.601];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Am 2020-02-21 02:30, schrieb Peng Fan:
>> Subject: [PATCH 1/7] Revert "tty: serial: fsl_lpuart: drop 
>> EARLYCON_DECLARE"
>> 
>> This reverts commit a659652f6169240a5818cb244b280c5a362ef5a4.
>> 
>> This broke the earlycon on LS1021A processors because the order of the
>> earlycon_setup() functions were changed. Before the commit the normal
>> lpuart32_early_console_setup() was called. After the commit the
>> lpuart32_imx_early_console_setup() is called instead.
> 
> How do you pass earlycon args to kernel?

earlycon=lpuart32,mmio32be,0x2950000,115200

please note that there are two possible declarations: (1) an OF/ACPI 
based
earlycon, eg just "earlycon" on the bootargs and (2) an elaborate one 
where
you can give the offset and access method yourself, eg. the one from 
above.

(1) will still work even with the EARLYCON_DECLARE() removed. But (2) 
will
search through all possible
   OF_DELARE_EARLYCON(lpuart32,..)
   EARLYCON_DECLARE(lpuart32,..)

and doesn't take the compatible into account. So which setup function is
actually called depends on (a) the order of the OF_DECLARE_EARLYCON() 
and
EARLYCON_DECLARE() statements and (b) on the compiler (thats just a
guess!). For me, the order in which it will actually end up in the
__earlycon_table is reversed, eg. the last one is called. So now that
you've removed the EARLYCON_DECLARE() the last one is the imx setup
function which will add the reg offset and doesn't work on LS1021A.

I've proposed a fix of the underlying problem [1]. But that fix also 
requires
the EARLYCON_DECLARE() in this driver.


-michael

[1] 
https://lore.kernel.org/linux-serial/20200220174607.24285-1-michael@walle.cc/
