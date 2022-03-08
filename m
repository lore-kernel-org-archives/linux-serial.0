Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CF2C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  8 Mar 2022 07:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiCHHnG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiCHHnB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Mar 2022 02:43:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7C39838
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 23:42:05 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 763C53F7FB
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646725323;
        bh=Un+PBm7TVpil6wZFl7iMD+ssa0pQW3YglAFfrUmMR/0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=RiWmPGZf5LU/YP4wUN2kuEJHeIwOkaALEnpMfDDKoQnerY/Mu6WcrgqTO/T9dHTch
         86P1MG4bO4XhgFRkwn9piJ7kF+Tqzo+SY2JQbUknjAPXH1chndM7aoIDT36kIbnHL0
         O+aPMRWluszZiWPkUovv7RugGOzCExC0GVcE81wsdr9exRxoKWFlWk8YZITFfVGqaH
         CNpI78poLuPwM/Dh80eqSi/Q29AGOEkqW7wlpygWybNpWcdDY95G6tbcz6fPGRonXF
         rnKxPfNP/EpWwFLMLxcoUMooy8JQHkPJLuO/RvMkkNoYTIIz4TPkmYZcWqg++jzvwy
         0vgK3dlL6OfUg==
Received: by mail-ej1-f72.google.com with SMTP id l24-20020a170906a41800b006da873d66b6so6925665ejz.3
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 23:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Un+PBm7TVpil6wZFl7iMD+ssa0pQW3YglAFfrUmMR/0=;
        b=pTt4yDKmABHduoFE+dZjwIik36fgU5CoHukkkxuVwEDDKLBqK8lWE6Jbxdmaho5kDF
         yp2rUP7TtyRW0xa1LNYE+9TsFEPILXM+GDbO9D2fdLQOI4fTJxiAzn/w8rp4QAocGDlh
         1LkDR3IFlfkGT2u8dIhPFKozWh0kobI0tW2ni3C2nJ5CNmCih5RqYKtqf5iPkCILoqW1
         oG61lhm2ZA1n1FShoOZh9Eidwl0zv1RGhOtPQhclFxTrn/y3Ca16RfIM0E6dXiBP1PuP
         L6ISApi/Y3PJo1cnuwcY12GxdV0ixWhcqmNr33WySqogemj/86olN010sXtWEHvkzmRq
         D27w==
X-Gm-Message-State: AOAM530nBfZTQpzhxp0znSbugJvkeTfFL8OoFYUZxOmK8nkCW5Y1mQVr
        K/K+iN1RzLnJXGJnsp+Rw/Tg1gWWjd1d5nuGvWyRKQQiRqiQWrr/o4+lt5oRSG5vn1aD+KO1gTa
        CLhuwJ+0fuNTtLvis9/0MzIf1YNE5L6bK5gQrbKr0kQ==
X-Received: by 2002:a50:d498:0:b0:416:2b00:532 with SMTP id s24-20020a50d498000000b004162b000532mr13081365edi.396.1646725320735;
        Mon, 07 Mar 2022 23:42:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjhCqo9HH0cK+RI8/E89ekTwyLjLyg0tpT17qz7uVBuNxty/NMegrabspJHC1kBpHoMxQrTQ==
X-Received: by 2002:a50:d498:0:b0:416:2b00:532 with SMTP id s24-20020a50d498000000b004162b000532mr13081352edi.396.1646725320534;
        Mon, 07 Mar 2022 23:42:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709067a0400b006d6e3ca9f71sm5565533ejo.198.2022.03.07.23.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:41:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_tegra: mark acpi_device_id as unused with !ACPI
Date:   Tue,  8 Mar 2022 08:41:57 +0100
Message-Id: <20220308074157.113568-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver's acpi_device_id table is referenced via ACPI_PTR() so it
will be unused for !CONFIG_ACPI builds:

  drivers/tty/serial/8250/8250_tegra.c:178:36:
    warning: ‘tegra_uart_acpi_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/8250/8250_tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index e13ae18b0713..e7cddeec9d8e 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -175,7 +175,7 @@ static const struct of_device_id tegra_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_uart_of_match);
 
-static const struct acpi_device_id tegra_uart_acpi_match[] = {
+static const struct acpi_device_id tegra_uart_acpi_match[] __maybe_unused = {
 	{ "NVDA0100", 0 },
 	{ },
 };
-- 
2.32.0

