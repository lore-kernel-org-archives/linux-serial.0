Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE5202963
	for <linux-serial@vger.kernel.org>; Mon, 16 Mar 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667720; cv=none; b=WxfuCchoh5QldbQoviR6QXcr2RIN7lAAikhgbLR65Qt9qUYLKAj2BFCoZzH5hbAF1rirGRKmyq1ZG2ab8cT8takaceJ5xeOFehkDgDCp1LB2urkWGdMHalHyith8XzL/u7qH34nY94Kglwf/+gAo7tgEtxIFmnvK11g2atVo51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667720; c=relaxed/simple;
	bh=G/SLPghRo53Tg169Ly5NOqHYFY6F8ur9IKZ+lOWYtvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C3Cst3qJ96dg4BsDIk/oXVQO4Lhv8QSE4XWQT0ya5oXbT54ZH3nrRQyWiBFY9hNOeLQCcQgRXfsh+YWX9YgMORKKDcN5sviR4FPe6KxIDgJJ4Lq5Nndnsvs5wDeBOhud6jch5rK7TaiL3gRO3EkadUo9RCR8RHppJyM3Fi6bg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWLi0Vdc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWLi0Vdc"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35b982990aeso66220a91.2
        for <linux-serial@vger.kernel.org>; Mon, 16 Mar 2026 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773667719; x=1774272519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3dKt2UPO2MLKISaClvkDDM2F7IRa7ud5ELpWtAwlBw=;
        b=kWLi0Vdco7uvhlBVq00NSue43GZ4ZhUJt9lOTUkkopiBdEGLl26IUAkMvySRwPq88U
         UHdVVEV0NrlvjK0QV2lTMzHP0YvzjW13a+Jg8kSGFsURzpzNGc955ykP5zT6k73nyPl0
         jBJPrcgGfekARM+87Yas35V1TgUA+HGZ+iaBXv8FDlHuKFD+ZlFx9vxpt5N0Gg//Fd/+
         i1+HXAP/8X+nengcSAMruu0YhQKMAUuuBonTwzCoPt/+oc6ltpXrYNn9T1cc9eu/3PrD
         37SkxfVZC+AaXUHcLbdA77r0sDKs5QRzozlaXscQRFcHwGkYh7gZax4F5+RQuZZfjN0s
         ydtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667719; x=1774272519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3dKt2UPO2MLKISaClvkDDM2F7IRa7ud5ELpWtAwlBw=;
        b=ApM7e6IbNZElmg5dr73ZvFS4/ysW2aUPlpCJRi1PYg4yxqWB1pd6a2AcW/98YzfEvT
         pywg02rhCyVFuEBZhMcvPgBpMT8ShRk7h/hUFFx16DlgGeA6KL5BfRABiJkBzBDKN7T6
         JbnAPNi0+qAI4ZUYNDCRIyJGzfurdoaglmXlS6PB+jAZ1AG6e++5/J3qFCQ7WPuJdv8d
         uUJyFxy1IN/eo/jLW9mSgjwuxuvUVf5jVosyba1JdWPnBx4Cf4ujZfkf5jjtIiZOYJfR
         GeMtBthLdQnBG3JsJQNzJXxlJSrQM0cNl8ozW60rQEJobq7FMu6l3utArqfxETKsl8p2
         UZdg==
X-Forwarded-Encrypted: i=1; AJvYcCVgPWBAOKrqh0yCG7d6wLxr2Ha+C/9Mz5OUUUmtFCNNa79gmLUO0rVVcKfFQtJZbe9XpwRa8QOeg6001eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YythwVPJhQuEX8JwChyck8xKTnsX/kCiNqdhIKVAb1pECXeMWL3
	H2kaKhX1iXNFwObazkZMlkIzVvO9EyUDooQeaimn2UKCdOfiRLq3eNQq
X-Gm-Gg: ATEYQzxG1WXputfMN8Iu6f/gj3BAmxe0UK5I//tHmwYo6STVG9YBKV5pipuPWlGxI22
	/nl8P1Oq3NnEIe9McGI7Q3ogCW7c6yrjAGXeiklAgR0glUkt2K7M59g0fT68bUePA0m/vBvxKLa
	eqc4e+RhtjS+Vq/guJ3hvIcQwZQA3wZmRGUN888bg8nBAgWREZzbX9RFqL1gwNSHDYTYZxvLUQ0
	TJZCSmJmrMGlu6DESbFMjtm+ERhKpWly9qsmH2khNf69Y4hHgLp+wo/k9Am0z5XhbOHBRPRAnzk
	5suD6qQGUuusGeRHpE1rjekIHk+23mZQ1IROG/mMMEyeKPalKO5RipjaCX+Uvu2IM4uN3rZaIZY
	jsipEeGvITSsnh6rP8SqGRiZmnOt3v69gEyzlJJ4TUGxUCZ9Bv0GDyvUF1V4Er8dWQssE253Ncx
	uORVAOxypFI9/GCEOToIx9eYBkQE3IiqlfpKZ3EDfz+SrqWj6w
X-Received: by 2002:a17:90b:1845:b0:359:f825:570f with SMTP id 98e67ed59e1d1-35a220b4660mr8952217a91.5.1773667718762;
        Mon, 16 Mar 2026 06:28:38 -0700 (PDT)
Received: from localhost.localdomain ([36.112.120.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b8e1cb60esm3434666a91.2.2026.03.16.06.28.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 06:28:38 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	zzzccc427@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>
Subject: [PATCH] tty: n_tty: annotate lockless read of ldata->icanon in input_available_p()
Date: Mon, 16 Mar 2026 21:28:27 +0800
Message-Id: <20260316132827.17855-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

n_tty_poll() calls input_available_p() without holding termios_rwsem to
check input readiness for select()/poll(). input_available_p() reads
ldata->icanon, which can be concurrently written by n_tty_set_termios()
under down_write(termios_rwsem).

This is a benign race: poll/select readiness is best-effort, and the
actual n_tty_read() path re-checks icanon under down_read(termios_rwsem).
A stale icanon value in poll only causes a transiently incorrect
readiness result, which is permitted by POSIX poll/select semantics.

Since icanon is a bitfield, READ_ONCE()/WRITE_ONCE() cannot be used.
Annotate the read with data_race() to document the intentional lockless
access and suppress data race detector warnings.

Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
 drivers/tty/n_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40..aa3c11623 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1909,7 +1909,8 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
 	const struct n_tty_data *ldata = tty->disc_data;
 	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
 
-	if (ldata->icanon && !L_EXTPROC(tty))
+	/* data_race: benign race, poll readiness is best-effort */
+	if (data_race(ldata->icanon) && !L_EXTPROC(tty))
 		return ldata->canon_head != ldata->read_tail;
 	else
 		return ldata->commit_head - ldata->read_tail >= amt;
-- 
2.39.5 (Apple Git-154)

