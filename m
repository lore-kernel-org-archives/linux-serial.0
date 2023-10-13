Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D33CDB483
	for <linux-serial@archiver.kernel.org>; Fri, 13 Oct 2023 14:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJMOTf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Oct 2023 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjJMOTe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Oct 2023 10:19:34 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1CC95;
        Fri, 13 Oct 2023 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=KQrKVxYQCrMBjcH0ANoR+56jGVR79jGy1Tv47viYRdk=; b=S4iUb1ptzFVW2Zqb2FnCoZZw0z
        nYn6cVrI7xdQWuXOTm523FoDo8w4LMcK1jcxELn7urirnmGy41meYfOBxHf3Byj+Bjp2SCnVYEp57
        0I4C+cRKRGKyK6wtTz1ImCTyJJ6EmFHhCAWlZr1rPWL4uSsMNjs1RKB4kpxt58vv1qJA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40430 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qrJ0i-0005Ve-AW; Fri, 13 Oct 2023 10:19:28 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Fri, 13 Oct 2023 10:19:23 -0400
Message-Id: <20231013141925.3427158-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 0/2] serial: sc16is7xx: device tree improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series fixes style issues and remove a unused 'clock-frequency'
property in sc16is7xx YAML DT bindings.

Based on gregkh tty tree, tty-next branch.

Thank you.

Hugo Villeneuve (2):
  dt-bindings: serial: sc16is7xx: move 'allOf' block after 'required'
  dt-bindings: serial: sc16is7xx: remove 'clock-frequency' property

 .../bindings/serial/nxp,sc16is7xx.yaml        | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)


base-commit: dd976a97d15b47656991e185a94ef42a0fa5cfd4
-- 
2.39.2

