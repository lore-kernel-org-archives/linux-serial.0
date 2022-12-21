Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA08C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 21 Dec 2022 15:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiLUPw5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Dec 2022 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiLUPwk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Dec 2022 10:52:40 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648472189F;
        Wed, 21 Dec 2022 07:52:32 -0800 (PST)
X-QQ-mid: bizesmtp74t1671637921tlvskkd8
Received: from [192.168.3.2] ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Dec 2022 23:52:00 +0800 (CST)
X-QQ-SSF: 01200000002000B0C000B00A0000000
X-QQ-FEAT: I8hG9CuxGDJJpNoVmawLaM6DqS/R7OsXQqE9IbZmAA6LxNl+5/9H8NzhOuTyB
        w+zxihHCZEK4KJd1b1IK2u12+KZIGQPs95OXUv9lMMie5hw+Wbj6KU3zssmEWjy5bKSqANc
        b+N+1jW0oTmqECR+KKqN/PJ55kiws3Um2rxdohXKscDjLUQeoqNZWUHlbhGLAEYnFBrPe/P
        tncbcQgJZ5XXop+uxRXSEy9V3jhR+O2X/tYAhBZbJxqEkmh55dp6/BosTSiWYCEymmGQhF5
        FJ3rK+KwdIvhiT1pukNnfWKHLmKG51QJIeJ4uvPu+EVHW5NtivwCyv2IKMst8i61ICndwox
        DANIkULdQ9il3jSlAIGA+Jh3pdWptcuNHvkO3McpJaY3KahRgU=
X-QQ-GoodBg: 0
From:   "Bin Meng" <bmeng@tinylab.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] serial: Add RISC-V support to the earlycon semihost driver
Cc:     aou <aou@eecs.berkeley.edu>,
        "catalin.marinas" <catalin.marinas@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        jirislaby <jirislaby@kernel.org>, palmer <palmer@dabbelt.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        linux <linux@armlinux.org.uk>, will <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 21 Dec 2022 15:51:59 +0000
Message-Id: <em37536add-7867-4e7d-9294-9a8389a661e2@a9022134.com>
In-Reply-To: <20221209150437.795918-1-bmeng@tinylab.org>
References: <20221209150437.795918-1-bmeng@tinylab.org>
Reply-To: "Bin Meng" <bmeng@tinylab.org>
User-Agent: eM_Client/9.2.1222.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022/12/9 23:04:34, "Bin Meng" <bmeng@tinylab.org> wrote:

>RISC-V semihosting spec [1] is built on top of the existing Arm one;
>we can add RISC-V earlycon semihost driver easily.
>
>This series refactors the existing driver a little bit, to move smh_putc()
>variants in respective arch's semihost.h, then we can implement RISC-V's
>version in the riscv arch directory.
>
>Link: https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc [1]
>
>Changes in v3:
>- add #ifdef in the header to prevent from multiple inclusion
>- add forward-declare struct uart_port
>- add a Link tag in the commit message
>
Ping?

Regards,
Bin
