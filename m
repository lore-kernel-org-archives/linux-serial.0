Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BFBC4363A
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D702223C
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 16:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394568AbgJTQXR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 12:23:17 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394563AbgJTQXR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 12:23:17 -0400
Received: from localhost.localdomain ([82.252.146.14]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvrRB-1kBaLT25Nn-00stxd; Tue, 20 Oct 2020 18:23:08 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Joshua Thompson <funaho@jurai.org>, linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] serial: pmac_zilog: don't init if zilog is not available
Date:   Tue, 20 Oct 2020 18:23:03 +0200
Message-Id: <20201020162303.1730562-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bKHy5QQSiE77OMXPCG5t3IA6kn0O8DJhl6MV+YUQP93v0wYpsUL
 coTYiKGAtOBLA3PVaVWj8x5zDK9kGX+W2jYNGYsoMOJ+HEuJCUxIACpOjZfKt0VmMqsTss8
 oVtH8p5n8HCTCqiQGfX6xdIAfG94PL2nv6jie7AOlG5rdMQJGKfXBCXpbqfcyprrUMeyXxf
 NqH1bsfQST/Ym95UPoE9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WAQu6MsbUZI=:DFWpJUDEp0IFwkElkkrpXo
 fbfo3nBHI5roarW7M3YyaoC2urbG0Wl54DII91AjRRDRFDIPBvsdVe6SyIdkp1XTHv23+208W
 1deQ6qZf6K+8yFpZg4eHwgbC1J6bbAsrlMorSD5kryvSmqf9RmcKceASTgaXYVchQkBAWMbTW
 DhRZVLW0B/EbxqSlc1b33ezKElxQ/7t+i97CdaI6zVx9yUvyWyWcwkkKKu9WFiHW9ID7DcQaU
 EF1pa4ZTBMYNZMVfm2Wyg1IvAw31QxpAODLRC6yNqa3u773bhhj5j8nBQGB1mXjhNn9m8Sn4+
 5/Z++c17HCYYREiU6APO4nHMwSEWx0mdRuJ6vvwHU9ev2lmbdWm9xEDKb6M/CP85weFnoXQhf
 wC9IO5lNPF/yfso1AexECLSOeCM858pne4EXT6dXRQSIlFi0wjA/OMTgj/3Imr5AncWUmfkSx
 +kIltyMbVA==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We can avoid to probe for the Zilog device (and generate ugly kernel warning)
if kernel is built for Mac but not on a Mac.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/tty/serial/pmac_zilog.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 063484b22523..d1d2e55983c3 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1867,6 +1867,12 @@ static struct platform_driver pmz_driver = {
 static int __init init_pmz(void)
 {
 	int rc, i;
+
+#ifdef CONFIG_MAC
+	if (!MACH_IS_MAC)
+		return -ENODEV;
+#endif
+
 	printk(KERN_INFO "%s\n", version);
 
 	/* 
@@ -2034,6 +2040,11 @@ static int __init pmz_console_setup(struct console *co, char *options)
 
 static int __init pmz_console_init(void)
 {
+#ifdef CONFIG_MAC
+	if (!MACH_IS_MAC)
+		return -ENODEV;
+#endif
+
 	/* Probe ports */
 	pmz_probe();
 
-- 
2.26.2

