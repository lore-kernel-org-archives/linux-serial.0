Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FAC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 27 Nov 2021 23:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhK0XZE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Nov 2021 18:25:04 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:36626 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356509AbhK0XXD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Nov 2021 18:23:03 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4J1ndG31SVz9Y;
        Sun, 28 Nov 2021 00:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1638055187; bh=3IuV4KHyseUP25B0hUamJUw90nzzT3r2kSgbvRYgE4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JK3pRYOLYNeG1VcAGugry8zKUgI8IWUX2uFGnlwLGpXc8D3CmoN3u8y9Tr0anjhA5
         0A8Qy/LOhaD8VxlEdNWsqrCEdfoL4kLYajCPHahkwjsSyh1fyNTpAP7OaIv8Cd41Fp
         bC/yFHHpqOVfJETijNRp4vh1CboVefrHEBTckwxDI2L7pXNeWUcUoW/R8bYvSvqtcd
         qLfLXpsIzFQ+14JZRfK6vjf3MeRyOWzB//m+Uj9hi+ZCRg9j8osGTQF3afK6drcmvx
         vuBpRT8IcEeEOSwUYU3B9S385dK47IOQYa8zaMoD9LKBYMCCBgQnmNvnJAHjHmkz26
         Mypbfh7tLnFGg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Sun, 28 Nov 2021 00:19:43 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Patrik John <patrik.john@u-blox.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathan@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: Fixes lower tolerance baud rate limit for
 older tegra chips introduced by d781ec21bae6
Message-ID: <YaK9DwsgGr8eaMuX@qmqm.qmqm.pl>
References: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 22, 2021 at 01:44:26PM +0100, Patrik John wrote:
> The current implementation uses 0 as lower limit for the baud rate tolerance which contradicts the initial commit description (https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5) of +4/-4% tolerance for older tegra chips other than Tegra186 and Tegra194.
> This causes issues on UART initilization as soon as the actual baud rate clock is slightly lower than required which we have seen on the Tegra124-based Toradex Apalis TK1 which also uses tegra30-hsuart as compatible in the DT serial node (for reference line 1540ff https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next)
> 
> The standard baud rate tolerance limits are also stated in the tegra20-hsuart driver description (https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt).
> 
> The previously introduced check_rate_in_range() always fails due to the lower limit set to 0 even if the actual baud rate is within the required -4% tolerance.
> 
[...]

I have a same patch waiting in my tree [1]. Feel free to use the commit
message and to add:

Reviewed-and-tested-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

[1] https://rere.qmqm.pl/git/?p=linux;a=commitdiff;h=b658dcd83d0db777410fe960721193d35a38115a

Best Regards
Micha³ Miros³aw
