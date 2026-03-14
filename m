Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F28387581
	for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773526264; cv=none; b=Dn3kmd+7jXX9+fiez83fYB6TgEK/kg1dV4Kc0E1ihyZ531oY8wjZ+h3h2e6+6/bmug7qy/yvLk2RYN7EW/JR2Z+j6iBC2GkzN38mmpqnuA2if5XkEQE+mOQs24lggrIErjPmwvvLR9ILroKHLWWoax1WJwzKL1CilxN/PMJh1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773526264; c=relaxed/simple;
	bh=zfWBb2gzdNn0PhhVUKdPsJYBOm5sizTs1LPG8K092Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7OarSdHy60uAH+oEHZG7dt2EAPaQ/Z+FVePVTRhMYHTKwqkIZbnQ083sUypWtVi13gsi28S4D1urizfOzn235G+1qvjsdU0nyVKETIQ52HdVknIVTKY61SQhHs8zautZAMIXPYU9l5oNZFFeTryRExONGMotVrZyU5fRmNmWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+5s7V20; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+5s7V20"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c56e822eso3593699f8f.2
        for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773526260; x=1774131060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYHENs7oYh3Ieeryh1d39XShMklYVG+5PCHFmQooVBg=;
        b=W+5s7V20lTZm+Sv3mtAUHNyWHJB1NrO9rmwgDjcd0ezKqHUJ7fd9Bz6dYNQu54y6iR
         gufL9J8ESAHR61XpP+1sYkwvKIsu0rIy9dK/O7nusLeP4Lz2WDFmmQXb3bhTbJANYV27
         O2J2Zbs48rVgeXc5Y2DpkSrhU0buWEjHt0ypgxVhksark2JOPlVfYPnHHfKg3dzwuGUS
         h9x2Dyo1ECGWoqsGHKi1CxImRtjQ2JdjA6JDv+oPvkqRb7KT6aE5RzhT/nPInbaK0yYY
         +Ap1spsaHJ+TUIcSKTPJn34K/FpdRb+Tc1OeGqS866gtk00J+TsmDYKdZ/Th0q1MyZIt
         FFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773526260; x=1774131060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYHENs7oYh3Ieeryh1d39XShMklYVG+5PCHFmQooVBg=;
        b=Kcm8spzQYUCvoRq7ZzmkBwKiNzs5X6epjlRkbEGhfEFgKjapPhcYJxMXLRuJlYmrW0
         2Qz+WpQuVlkIS2CVz1RxqhlZ9rNixRfZD/2kWoJEv/q+EgyNIRtjBarKyMCR7noW+9MG
         FcMBA8IoC15Ivpp+g59f9izSoT5EQLfZ/Eeu3He7Zx/A1qEDnvIkL/YEWrWhoD2ElZwg
         bIpgjQMtHpkLexylB3SqrpAzuWxUOKahLjgTKDaXMKPf/A1205BtLKRgNuuHt9UnoEXn
         +wSDqVgyiK86omPSNo9+CFP3ogV5iIqt3uIvDeVlw2XjH/oKWO1Cp8EcEh21fLtJIGyK
         9zTA==
X-Forwarded-Encrypted: i=1; AJvYcCUDN0yGfwQr86GpLwDYBsh3IpOmCovN0Q0P1PwZUEp8ykB/sX4pgXCIHUZpJvDhIoosfiopgI/8UEwQyR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAis3wkCA5F5JHxhL1tfPxj08kARkVHhS9+DZo2vFz8+1pYtL
	r08LpT7IcXogppJGDsMcFyASEUuiub0nrc2qvTcy3CJnbTGsHbGpWZfHm5uFKg==
X-Gm-Gg: ATEYQzzR4DAVVV/39+jNNIy+XSXsZrkBpD1Re4OcfulbVVGEyd1oMiw7ddWPCfHZgUa
	8YwVY9fvCsBBRhmReGVAO73twn+MIY9DcRG4X5nS8d0j/STymkRk1vfIBInWXESCZfOM/nG+d5v
	jgYMws9ZoEMtcfzkPNkDM2k4Zr0RpXWS3cE2Ro1pT8I23/y+FDo71kyzTkl6DaHd5WjWx3/sM3U
	uVHO2OwGSUpVyldIu2VaRYL/888fjq5vA4psPzh894LDccsewVUZYNAYdtSDnwlQ4UuHAE36zfq
	C0I8QPmgqU0pYyoDXkauu0S1YLJIurKrPLn9HkipD5DNR1yg8W3MzVxE5rqhwdEuBDsygnoKJrh
	OuRi3kRhj9jLxpcv+5ZvDuW0SUYPE6O57g1+dnCj9bRWttGPrsSEs9cd29W7Px36Zi7UYzFCVIj
	1jqseLzh6RQWxrU6Yi/S0ufRXb8GnIlbJbREUVSjiMiTR0JPq3pc1a9TotNls=
X-Received: by 2002:a05:6000:1acd:b0:439:ddc0:4bf1 with SMTP id ffacd0b85a97d-43a04dcbf4cmr14628177f8f.55.1773526260557;
        Sat, 14 Mar 2026 15:11:00 -0700 (PDT)
Received: from osama.. ([41.238.114.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a78cesm28064825f8f.11.2026.03.14.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 15:11:00 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] n_tty: add null check for tty->link in packet mode
Date: Sat, 14 Mar 2026 23:10:44 +0100
Message-ID: <20260314221044.148442-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add null check for tty->link before dereferencing in n_tty_read and
n_tty_poll. When the pty master closes, tty->link can be NULL while
the slave is still reading, causing a null pointer dereference.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..dc04b87364f6 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2232,7 +2232,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 	add_wait_queue(&tty->read_wait, &wait);
 	while (nr) {
 		/* First test for status change. */
-		if (packet && tty->link->ctrl.pktstatus) {
+		if (packet && tty->link && tty->link->ctrl.pktstatus) {
 			u8 cs;
 			if (kb != kbuf)
 				break;
@@ -2444,7 +2444,7 @@ static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 		if (input_available_p(tty, 1))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
-	if (tty->ctrl.packet && tty->link->ctrl.pktstatus)
+	if (tty->ctrl.packet && tty->link && tty->link->ctrl.pktstatus)
 		mask |= EPOLLPRI | EPOLLIN | EPOLLRDNORM;
 	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
 		mask |= EPOLLHUP;
-- 
2.43.0

