Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF07C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F3360F21
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhINJNA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:13:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43336 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhINJMy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:12:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B8EC91FDD3;
        Tue, 14 Sep 2021 09:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pJJWMdcxHneXOWb9CMwKHFCECeJ256Rm7qUNuZChoA=;
        b=vitkAkhU7NRjmWz6RpNunirgH6WE7aSeY5pmwRfEHMCykfRDv8dTplRIXHIl/L5h0/1MKy
        oqHWMY3oWSj+A0ikF865VFiFUzOUvVshZm2PDRgAzfKu02kDDDldwNGv68fLiHlOrY63JN
        L2Nkb4ezr+m/yLC4oYx5kAdz9InllyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pJJWMdcxHneXOWb9CMwKHFCECeJ256Rm7qUNuZChoA=;
        b=W1C8VdYFmzYQQrmpA64gKit1yI5LyodLvRsiSIfqKM7+fbtsKhnRnDHks2SuAn/VImgmfa
        C/I13MghIRJQ+JDg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76BA4A3B90;
        Tue, 14 Sep 2021 09:11:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 06/16] tty: remove file from n_tty_ioctl_helper
Date:   Tue, 14 Sep 2021 11:11:24 +0200
Message-Id: <20210914091134.17426-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091134.17426-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous patch, there are no users of 'file' in
n_tty_ioctl_helper. So remove it also from there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/bluetooth/hci_ldisc.c | 2 +-
 drivers/net/ppp/ppp_async.c   | 2 +-
 drivers/net/ppp/ppp_synctty.c | 2 +-
 drivers/tty/n_gsm.c           | 2 +-
 drivers/tty/n_hdlc.c          | 2 +-
 drivers/tty/n_tty.c           | 2 +-
 drivers/tty/tty_ioctl.c       | 4 ++--
 include/linux/tty.h           | 4 ++--
 net/nfc/nci/uart.c            | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5ed2cfa7da1d..824d1c7e3e53 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -790,7 +790,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 		break;
 
 	default:
-		err = n_tty_ioctl_helper(tty, file, cmd, arg);
+		err = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
 	}
 
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 6492523fc234..f4429b93a9c8 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -310,7 +310,7 @@ ppp_asynctty_ioctl(struct tty_struct *tty, struct file *file,
 		/* flush our buffers and the serial port's buffer */
 		if (arg == TCIOFLUSH || arg == TCOFLUSH)
 			ppp_async_flush_output(ap);
-		err = n_tty_ioctl_helper(tty, file, cmd, arg);
+		err = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
 
 	case FIONREAD:
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index ebbfea0e1140..b3a71b409a80 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -303,7 +303,7 @@ ppp_synctty_ioctl(struct tty_struct *tty, struct file *file,
 		/* flush our buffers and the serial port's buffer */
 		if (arg == TCIOFLUSH || arg == TCOFLUSH)
 			ppp_sync_flush_output(ap);
-		err = n_tty_ioctl_helper(tty, file, cmd, arg);
+		err = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
 
 	case FIONREAD:
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1d92d2a84889..03a98c93006a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2651,7 +2651,7 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 		base = mux_num_to_base(gsm);
 		return put_user(base + 1, (__u32 __user *)arg);
 	default:
-		return n_tty_ioctl_helper(tty, file, cmd, arg);
+		return n_tty_ioctl_helper(tty, cmd, arg);
 	}
 }
 
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 580a37b3fe1b..7e0884ecc74f 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -630,7 +630,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 		fallthrough;	/* to default */
 
 	default:
-		error = n_tty_ioctl_helper(tty, file, cmd, arg);
+		error = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
 	}
 	return error;
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index dcb5e6ef8747..9fc2319a394d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2418,7 +2418,7 @@ static int n_tty_ioctl(struct tty_struct *tty, struct file *file,
 		up_write(&tty->termios_rwsem);
 		return put_user(retval, (unsigned int __user *) arg);
 	default:
-		return n_tty_ioctl_helper(tty, file, cmd, arg);
+		return n_tty_ioctl_helper(tty, cmd, arg);
 	}
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 99a29d72d294..63181925ec1a 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -854,8 +854,8 @@ int tty_perform_flush(struct tty_struct *tty, unsigned long arg)
 }
 EXPORT_SYMBOL_GPL(tty_perform_flush);
 
-int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg)
+int n_tty_ioctl_helper(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg)
 {
 	int retval;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5e73f577c2b4..5dbd7c5afac7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -407,8 +407,8 @@ static inline int tty_audit_push(void)
 #endif
 
 /* tty_ioctl.c */
-int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
-		unsigned int cmd, unsigned long arg);
+int n_tty_ioctl_helper(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg);
 
 /* vt.c */
 
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 502e7a3f8948..9bdd9a7d187e 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -349,7 +349,7 @@ static int nci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 			return -EBUSY;
 		break;
 	default:
-		err = n_tty_ioctl_helper(tty, file, cmd, arg);
+		err = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
 	}
 
-- 
2.33.0

