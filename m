Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E49AC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 20 Jan 2022 10:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376267AbiATK3e (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Jan 2022 05:29:34 -0500
Received: from mta-65-228.siemens.flowmailer.net ([185.136.65.228]:36955 "EHLO
        mta-65-228.siemens.flowmailer.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376259AbiATK3e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Jan 2022 05:29:34 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 05:29:34 EST
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20220120101929eb8ba33e641f260a77
        for <linux-serial@vger.kernel.org>;
        Thu, 20 Jan 2022 11:19:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=JnUF520dA6MoqiwuY5pfZTlvR7T/MvYRVU/LqW1MI3k=;
 b=ihEQCGvjxiuWjujvcWcjAG+XLKapXISTs0IrcZ8ZacEMP7xLpC6wIHihY+MddP+9tao0cz
 sZeRgVbvf1G6O3e79xUTDKsH1T4MSB2HQdIZzudqKAI/CWYSy7IyRgJhZfp83OgNmBffAd2W
 ckt28/t3NAHgzpgmiIl0Ey7IXVaEw=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/1] tty: n_gsm: fix SW flow control encoding/handling
Date:   Thu, 20 Jan 2022 02:18:57 -0800
Message-Id: <20220120101857.2509-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.2.7.3 states that DC1 (XON) and DC3 (XOFF)
are the control characters defined in ISO/IEC 646. These shall be quoted if
seen in the data stream to avoid interpretation as flow control characters.

ISO/IEC 646 refers to the set of ISO standards described as the ISO
7-bit coded character set for information interchange. Its final version
is also known as ITU T.50.
See https://www.itu.int/rec/T-REC-T.50-199209-I/en

To abide the standard it is needed to quote DC1 and DC3 correctly if these
are seen as data bytes and not as control characters. The current
implementation already tries to enforce this but fails to catch all
defined cases. 3GPP 27.010 chapter 5.2.7.3 clearly states that the most
significant bit shall be ignored for DC1 and DC3 handling. The current
implementation handles only the case with the most significant bit set 0.
Cases in which DC1 and DC3 have the most significant bit set 1 are left
unhandled.

This patch fixes this by masking the data bytes with ISO_IEC_646_MASK (only
the 7 least significant bits set 1) before comparing them with XON
(a.k.a. DC1) and XOFF (a.k.a. DC3) when testing which byte values need
quotation via byte stuffing.

Fixes: e1eaea46bb40 (tty: n_gsm line discipline, 2010-03-26)
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ba27b274c967..0b1808e3a912 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -322,6 +322,7 @@ static int addr_cnt;
 #define GSM1_ESCAPE_BITS	0x20
 #define XON			0x11
 #define XOFF			0x13
+#define ISO_IEC_646_MASK	0x7F
 
 static const struct tty_port_operations gsm_port_ops;
 
@@ -531,7 +532,8 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 	int olen = 0;
 	while (len--) {
 		if (*input == GSM1_SOF || *input == GSM1_ESCAPE
-		    || *input == XON || *input == XOFF) {
+		    || (*input & ISO_IEC_646_MASK) == XON
+		    || (*input & ISO_IEC_646_MASK) == XOFF) {
 			*output++ = GSM1_ESCAPE;
 			*output++ = *input++ ^ GSM1_ESCAPE_BITS;
 			olen++;
-- 
2.25.1

