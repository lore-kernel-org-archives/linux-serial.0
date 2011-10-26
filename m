From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 60/79] tty/n_gsm: fix a bug in gsm_dlci_data_output (adaption = 2 case)
Date: Wed, 26 Oct 2011 14:13:05 +0200
Message-ID: <1319631204-23262-60-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32836 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932932Ab1JZMN4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:56 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>

in adaption=2 case we should put 1 or 2 byte with modem status bits
at the beginning of a buffer pointed by "dp". n_gsm use 1 byte case,
so it allocate a buffer of len + 1 size. As result we should:
  * put 1 byte of modem status bits
  * increase data pointer
  * put "len" bytes of data
but actually we have:
  * increase first byte with the value of modem status bits
  * decrease "len"
  * put orig_len - 1 bytes of data starting from the buffer beggining
This is evidently wrong.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index da3b31a..14c26cd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -833,8 +833,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 		break;
 	case 2:	/* Unstructed with modem bits. Always one byte as we never
 		   send inline break data */
-		*dp += gsm_encode_modem(dlci);
-		len--;
+		*dp++ = gsm_encode_modem(dlci);
 		break;
 	}
 	WARN_ON(kfifo_out_locked(dlci->fifo, dp , len, &dlci->lock) != len);
-- 
1.7.7

