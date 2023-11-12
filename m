Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73130C4167B
	for <linux-serial@archiver.kernel.org>; Sun, 12 Nov 2023 00:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjKLAzv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Nov 2023 19:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjKLAzu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Nov 2023 19:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE830CF;
        Sat, 11 Nov 2023 16:55:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AB5DC433CB;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699750546;
        bh=+f1eXcr91euPusl3Xe/1/DfSwfjp6Uid8mOwDf2yltU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H9MS3tqxULUVIVZESINTI28qjs/DgCx9l4kuIeVhz4pohNE2WbN6BAyRD14y7BF90
         RY/kpgyT8TdPukD/AJXGR6o8Z2GVO/Tbn0sIbWVqCz5W7mWfsxghmcPMVtHUtZAPrC
         qqNpGPrxFKZ3yyxP0rldcBKY2bhSoRfQtQVcL8qvIMNKeEmyCCrEvebptP7LgI0KBF
         /AnhzXoAPcu8zsPopEYtFbsEgq1v9bjfR6k6cNBR6JEHcNqYRsqNMQaFXwH/40eL5s
         lBAwWg+oSDpWNSMXZQtdILBi85B+aR6+jOZwz8NZST6UxEclBVUtElAOeYPYWgvOQi
         DZpbY6goJKsuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BA38E00089;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/9] RISC-V SBI debug console extension support
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169975054624.11360.10545081285064306783.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Nov 2023 00:55:46 +0000
References: <20231020072140.900967-1-apatel@ventanamicro.com>
In-Reply-To: <20231020072140.900967-1-apatel@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, pbonzini@redhat.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, conor@kernel.org, ajones@ventanamicro.com,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Fri, 20 Oct 2023 12:51:31 +0530 you wrote:
> The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
> SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
> functions sbi_console_putchar() and sbi_console_getchar().
> (Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)
> 
> This series adds support for SBI debug console (DBCN) extension in KVM RISC-V
> and Linux RISC-V.
> 
> [...]

Here is the summary with links:
  - [v3,1/9] RISC-V: Add defines for SBI debug console extension
    https://git.kernel.org/riscv/c/dadf7886993c
  - [v3,2/9] RISC-V: KVM: Change the SBI specification version to v2.0
    https://git.kernel.org/riscv/c/b88e87a0a1ec
  - [v3,3/9] RISC-V: KVM: Allow some SBI extensions to be disabled by default
    https://git.kernel.org/riscv/c/56d8a385b605
  - [v3,4/9] RISC-V: KVM: Forward SBI DBCN extension to user-space
    https://git.kernel.org/riscv/c/c667ad229d13
  - [v3,5/9] KVM: riscv: selftests: Add SBI DBCN extension to get-reg-list test
    https://git.kernel.org/riscv/c/d9c00f44e5de
  - [v3,6/9] RISC-V: Add stubs for sbi_console_putchar/getchar()
    (no matching commit)
  - [v3,7/9] tty/serial: Add RISC-V SBI debug console based earlycon
    (no matching commit)
  - [v3,8/9] tty: Add SBI debug console support to HVC SBI driver
    (no matching commit)
  - [v3,9/9] RISC-V: Enable SBI based earlycon support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


