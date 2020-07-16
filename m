Return-Path: <SRS0=PhEQ=A3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A710C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784442065F
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="soTF6V0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgGPMUk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:20:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:57984 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgGPMUi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jul 2020 08:20:38 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200716122035epoutp0445ef5c147bcbfb637d5287f7d439c0c3~iOvOSr8GK0453004530epoutp04K
        for <linux-serial@vger.kernel.org>; Thu, 16 Jul 2020 12:20:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200716122035epoutp0445ef5c147bcbfb637d5287f7d439c0c3~iOvOSr8GK0453004530epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594902035;
        bh=mYyGwdaGLsmdtAnpge0iP3YLiOv1LCA0Vl9pK3Po7a4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=soTF6V0NMRUkwsl0TPXGPewGx4bmbqpAFyXj4YRH5DMyjYIjaiDJs6c/y1+KhUKnV
         1zlgfThqlrFmuiAkTZLEJQh5f8NAmQRsSjMfLhL++5QkcOrmVOR0DztDpASjrBzeh2
         PCMdagaVzghIxtN+bvvL5DHgVNRMHo/8Odz35f0Q=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200716122035epcas5p14e6b0541c6899cca10ba2613c2c05c4c~iOvNpA3J-0450304503epcas5p15;
        Thu, 16 Jul 2020 12:20:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.B3.09475.316401F5; Thu, 16 Jul 2020 21:20:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200716121621epcas5p376ac02b9774d95451d56b888babfc3f8~iOrh3mmSd3060430604epcas5p3o;
        Thu, 16 Jul 2020 12:16:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200716121621epsmtrp2efc5b0ac875237d9833ab0af08e9dae8~iOrh2_XPI0694906949epsmtrp2A;
        Thu, 16 Jul 2020 12:16:21 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-dc-5f10461330d1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.7A.08303.515401F5; Thu, 16 Jul 2020 21:16:21 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200716121620epsmtip1d5ea675329ad0e84bb768e4dfaf56876~iOrgpTDh01388213882epsmtip1C;
        Thu, 16 Jul 2020 12:16:20 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, linux-samsung-soc@vger.kernel.org,
        alim.akhtar@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH] serial: core: Fix Coding Style
Date:   Thu, 16 Jul 2020 17:24:38 +0530
Message-Id: <20200716115438.9967-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCmlq6wm0C8QVM7u8WDedvYLJoXr2ez
        mLLhA5PF+fMb2C0u75rDZjHj/D4mizOLe9kt7rYuZnfg8Ni0qpPNY//cNewefVtWMXqs33KV
        xePzJrkA1igum5TUnMyy1CJ9uwSujFn7mpkL7nFXnPj5jamB8QxnFyMnh4SAicSrO+fYuxi5
        OIQEdjNKzP66hRXC+cQosXvjMjYI5zOjxN5tC1hhWj59eMwIkdjFKHF+80Wo/hYmieaLl4Cq
        ODjYBDQljp/nBmkQEdCXWNd4jwWkhllgC6PEknObmUESwkCJb1ues4DYLAKqErdbdoPZvALm
        Erd/z2SC2CYvsXrDAWaQZgmBfewSp589Z4NIuEjcetXHCGELS7w6voUdwpaS+PxuL1RNvsT8
        eauYIewKiZUX3kDZ9hIHrsxhATmUGejQ9bv0IcKyElNPrQPbyyzAJ9H7+wnUDbwSO+bB2IoS
        /3f3Q60Sl3i3Ygo0VDwkGrZvA1srJBAr8fbxRrYJjLKzEDYsYGRcxSiZWlCcm55abFpgnJda
        rlecmFtcmpeul5yfu4kRnAS0vHcwPnrwQe8QIxMH4yFGCQ5mJRFeHi7eeCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8Sj/OxAkJpCeWpGanphakFsFkmTg4pRqYXrbcaj3RZ7BgTrxqb9q0Ywce
        hajXsRqe376ySsOKU9hIdKvIfO70R7FSX/afZ7imzfqZ//GN5b8fiQWyS3yNc3sXpxSf+PHp
        mbsKYm91FyYKX5TO4Ahemdf16VTvxLRf9Y3Cdt19Cy6ckfl8SuHkv0vP76+97/iprfCO2Dnm
        SynttStF7fWLCpoyIys4C7d+3HLaMG1S91rFhycUVi4IvJnOtrxCx2eRZLb4lRn9z6zann/U
        mJMqwnRpl/Pc3b8Tr8/zCetK+F3yzMFHtvt4oXLXg6jDi+2vF3ibvHZcUHyoIH9Z81d7wWsl
        v5inT1nw+9/ribrTjG7+blfi4P9dv9Dg8mOerqVFF8XuXLqxV4mlOCPRUIu5qDgRAGbueM5x
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LZdlhJTlfUVSDe4NQ6S4sH87axWTQvXs9m
        MWXDByaL8+c3sFtc3jWHzWLG+X1MFmcW97Jb3G1dzO7A4bFpVSebx/65a9g9+rasYvRYv+Uq
        i8fnTXIBrFFcNimpOZllqUX6dglcGbP2NTMX3OOuOPHzG1MD4xnOLkZODgkBE4lPHx4zdjFy
        cQgJ7GCUeHlsATtEQlxi2q/9jBC2sMTKf8/ZIYqamCQe7V3O1MXIwcEmoClx/Dw3SI2IgKHE
        0dWfmUBqmAV2MUos7l3DBpIQFtCX+LblOQuIzSKgKnG7ZTeYzStgLnH790wmiAXyEqs3HGCe
        wMizgJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcEBpae1g3LPqg94hRiYOxkOM
        EhzMSiK8PFy88UK8KYmVValF+fFFpTmpxYcYpTlYlMR5v85aGCckkJ5YkpqdmlqQWgSTZeLg
        lGpguuC++3yPsfjlGRyPe2/f8fSPM17JELPwVuJK156POcveR9T/ZNp+/a1Jotn0F4z9Z1Yl
        7vm1IHe54ZvFZ0yCjlrOOBDcsn2BumKAZNAB5TLpxy63zETr5tb9v8Z9bMaW89dN14e2mb6o
        y98YNKd+6R+NxX+/8szy6tq36veeA7vP5X9xT/v+y2Yt8+GSmRdvyL2752m1oLKsZvvd7ZVN
        ahkHZnZJ72S+Z/1sXeqnteujLZyehZZwpK74+HNCU/htUZdajVN1hfcYBWU23F5x1v/Xebc3
        /jPNZ7nbntY8M9HYP0GR9coe7XdZqd852BbMnvSNz/JVzu28zsovbmJtznHFr8va3Qw2cqRM
        PjmjslGJpTgj0VCLuag4EQA04xailwIAAA==
X-CMS-MailID: 20200716121621epcas5p376ac02b9774d95451d56b888babfc3f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200716121621epcas5p376ac02b9774d95451d56b888babfc3f8
References: <CGME20200716121621epcas5p376ac02b9774d95451d56b888babfc3f8@epcas5p3.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch fixes the following checkpatch error and warning:
  1. space required after ','
  2. Missing a blank line after declarations

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 drivers/tty/serial/serial_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 66a5e2faf57e..9334e8d238b1 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1122,7 +1122,7 @@ static int uart_break_ctl(struct tty_struct *tty, int break_state)
 	return ret;
 }
 
-static int uart_do_autoconfig(struct tty_struct *tty,struct uart_state *state)
+static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 {
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
@@ -1525,6 +1525,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	/* Handle transition away from B0 status */
 	else if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
+
 		if (!(cflag & CRTSCTS) || !tty_throttled(tty))
 			mask |= TIOCM_RTS;
 		uart_set_mctrl(uport, mask);
@@ -2276,6 +2277,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		if (console_suspend_enabled || !uart_console(uport)) {
 			/* Protected by port mutex for now */
 			struct tty_struct *tty = port->tty;
+
 			ret = ops->startup(uport);
 			if (ret == 0) {
 				if (tty)
-- 
2.17.1

