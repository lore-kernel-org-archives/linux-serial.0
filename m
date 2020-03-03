Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D08C3F2D7
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BE120866
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCCNn4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:43:56 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:48980 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCNn4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 08:43:56 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id 9pjt220195USYZQ06pjtqq; Tue, 03 Mar 2020 14:43:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j97px-0001GV-Qp; Tue, 03 Mar 2020 14:43:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j97px-0005o8-P1; Tue, 03 Mar 2020 14:43:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] dt-bindings: serial: Convert generic and slave bindings to json-schema
Date:   Tue,  3 Mar 2020 14:43:49 +0100
Message-Id: <20200303134351.22270-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

	Hi Rob, Greg,

This patch series converts the generic serial interface and slave-device
Device Tree bindings to json-schema.

This is a dependency for converting more serial DT bindings that will
refer to properties defined in serial.yaml.

Thanks for your comments!

Geert Uytterhoeven (2):
  dt-bindings: serial: Convert generic bindings to json-schema
  dt-bindings: serial: Convert slave-device bindings to json-schema

 .../devicetree/bindings/serial/serial.txt     |  56 -------
 .../devicetree/bindings/serial/serial.yaml    | 148 ++++++++++++++++++
 .../bindings/serial/slave-device.txt          |  45 ------
 MAINTAINERS                                   |   2 +-
 4 files changed, 149 insertions(+), 102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/serial.txt
 create mode 100644 Documentation/devicetree/bindings/serial/serial.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
