Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00440C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 12:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17EB611EE
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 12:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352205AbhDGMcW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 08:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352203AbhDGMcW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 08:32:22 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8824F60FEE;
        Wed,  7 Apr 2021 12:32:12 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lU7Lu-0064Pb-H1; Wed, 07 Apr 2021 13:32:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-serial@vger.kernel.org,
        Valentin Caron <valentin.caron@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: (subset) [PATCH 0/5] stm32 usart wakeup rework
Date:   Wed,  7 Apr 2021 13:32:07 +0100
Message-Id: <161779861853.1095473.5644490984272878167.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210319184253.5841-1-erwan.leray@foss.st.com>
References: <20210319184253.5841-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: robh+dt@kernel.org, alexandre.torgue@foss.st.com, erwan.leray@foss.st.com, gregkh@linuxfoundation.org, mcoquelin.stm32@gmail.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-serial@vger.kernel.org, valentin.caron@foss.st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, fabrice.gasnier@foss.st.com, patrice.chotard@foss.st.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 19 Mar 2021 19:42:48 +0100, Erwan Le Ray wrote:
> This series reworks stm32 usart wakeup management.
> 
> Alexandre Torgue (1):
>   serial: stm32: update wakeup IRQ management
> 
> Erwan Le Ray (4):
>   serial: stm32: rework wakeup management
>   serial: stm32: clean wakeup handling in serial_suspend
>   irqchip/stm32: add usart instances exti direct event support
>   ARM: dts: stm32: Add wakeup management on stm32mp15x UART nodes
> 
> [...]

Applied to irq/irqchip-next, thanks!

[3/5] irqchip/stm32: add usart instances exti direct event support
      commit: e12c455055e9abc7403ce532616c0124a9d85ee7

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


