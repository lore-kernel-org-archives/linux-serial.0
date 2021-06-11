Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A911C48BD1
	for <linux-serial@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048FE61357
	for <linux-serial@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFKUaf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:30:35 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:52410 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFKUaf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Jun 2021 16:30:35 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2021 16:30:35 EDT
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 031817A024A;
        Fri, 11 Jun 2021 22:20:13 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] serial_cs: remove wrong GLOBETROTTER.cis entry
Date:   Fri, 11 Jun 2021 22:19:39 +0200
Message-Id: <20210611201940.23898-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The GLOBETROTTER.cis entry in serial_cs matches more devices than
intended and breaks them. Remove it.

Example: # pccardctl info
PRODID_1="Option International
"
PRODID_2="GSM-Ready 56K/ISDN
"
PRODID_3="021
"
PRODID_4="A
"
MANFID=0013,0000
FUNCID=0

result:
pcmcia 0.0: Direct firmware load for cis/GLOBETROTTER.cis failed with error -2

The GLOBETROTTER.cis is nowhere to be found. There's GLOBETROTTER.cis.ihex at
https://netdev.vger.kernel.narkive.com/h4inqdxM/patch-axnet-cs-fix-phy-id-detection-for-bogus-asix-chip#post41
It's from completely diffetent card:
vers_1 4.1, "Option International", "GSM/GPRS GlobeTrotter", "001", "A"

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/tty/serial/8250/serial_cs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 63ea9c4da3d5..6f3996502453 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -804,7 +804,6 @@ static const struct pcmcia_device_id serial_ids[] = {
 	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-4", 0x96913a85, 0xcec8f102, "cis/COMpad4.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96913a85, 0x8fbe92ae, 0x0877b627, "cis/COMpad2.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "cis/RS-COM-2P.cis"),
-	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "cis/GLOBETROTTER.cis"),
 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.", "SERIAL CARD: SL100  1.00.", 0x19ca78af, 0xf964f42b),
 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.", "SERIAL CARD: SL100", 0x19ca78af, 0x71d98e83),
 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.", "SERIAL CARD: SL232  1.00.", 0x19ca78af, 0x69fb7490),
-- 
Ondrej Zary

