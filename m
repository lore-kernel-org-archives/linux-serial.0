Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82876C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51715601FE
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 13:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhEFNW3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 09:22:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:18358 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhEFNWY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 09:22:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FbZ101qmQzlc6h;
        Thu,  6 May 2021 21:19:16 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 21:21:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 0/2] dt-bindings: serial: Change to reference the kernel-defined serial.yaml
Date:   Thu, 6 May 2021 21:20:47 +0800
Message-ID: <20210506132049.1513-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

v2 --> v3:
1) Change all references to "/schemas/serial.yaml" to references to "/schemas/serial/serial.yaml".
2) Change "additionalProperties" in file renesas,em-uart.yaml and st,stm32-uart.yaml to "unevaluatedProperties",
   Because they're currently referring to kernel-defined serial.yaml

v1 --> v2:
1) Change to reference the kernel-defined serial.yaml
2) Move the new added "label: true" into /schemas/serial/serial.yaml

Zhen Lei (2):
  dt-bindings: serial: Change to reference the kernel-defined
    serial.yaml
  dt-bindings: serial: Add label property in serial.yaml

 Documentation/devicetree/bindings/serial/8250.yaml            | 2 +-
 .../devicetree/bindings/serial/brcm,bcm7271-uart.yaml         | 2 +-
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml    | 2 +-
 Documentation/devicetree/bindings/serial/pl011.yaml           | 4 ++--
 Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,em-uart.yaml | 2 +-
 Documentation/devicetree/bindings/serial/samsung_uart.yaml    | 2 +-
 Documentation/devicetree/bindings/serial/serial.yaml          | 2 ++
 Documentation/devicetree/bindings/serial/sifive-serial.yaml   | 4 ++--
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 2 +-
 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml   | 3 +--
 11 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.26.0.106.g9fadedd


