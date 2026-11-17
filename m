Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945936;
	b=0PX1/7yFRoe6Q4aNeCSe1BJoV0Qq6vCnX3/sxdHzekCycXzFb/DeceX23waME2B6ttYS
	 XpHjzLu3PkP407gDUYSDJO1Kk6eRU0dfsAINNv8ZAX+qhyJKkIlVkPNeLK+1g14jSH9DJ
	 oFoeDaNqya1KYI7IEP+Ax73kRGzGY0JHHgu6ydGo80muy8G5KiaeNDq5Wocvemzy4dGu6
	 Xy9/rkTW25A04ZZxLeAB9GjSupZ8xw/DaGcB13mYeB6wAn+QvzA15B2Ma2jb8WEHxAB/i
	 9DPpFotpD1S8iIuhC9VpbXucNZEtWWoKA/rSTYpR7pi5RrqPxBUKdEaOylJ6HAWBe8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
	b=SdfYqyjXrQ1kb/y8iMbuhHH93XmUTmNsX6ZFICw0rRKm0P6eT6iy69bmIBLDAstrVp6/
	 ClAW4zPj/Cs2mvk6Y6wcnlqdzNUxVG5qCyHfJIXc7k8UdAFy/lC70dj6/4/DYLkzB+g7C
	 aSxd6/SV6lhxZBHeoi30pvnjF5dTwCp7j5L7lb9jdcXv03xtw27cuEohDEeJn2itH52+I
	 07ORu03NugJ9lcPCUu5dmib6vFOU0Ogu5jCXkXb7aZnmai2uUvY6/+eLT0Qzsjz2tNsvQ
	 fx/1xFdoX2GjSKmr9RnPuF1hCNxMTboCJiMc38SHWrXvSrQ1ODkHrCMaugatFRfoUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g82d6f8q;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF1606B440
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CDF1606B440
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g82d6f8q
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-49a92144733so79291f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945935; x=1795550735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
        b=g82d6f8qYdcw1P3PeliLS1T5H9U0IcgDSvbHbmDNXHG0YNHiKA0wzAaPTw9Yh9l0xf
         7Uxfu4V7F5KzrLi/15wIWpNl08nASI9JBMPfRbI6o0edRbvvmS8HvC5AZ/hd05NwBVXH
         oKzj7FSQcG4BTI8GcUvUiqBSRNipAC2I0536YmAMRfZn41nIb6zEP6IHABUl8GqAUma1
         Oo6RA2mFZ025y2RZdQnNSpK6v8ZZVlwGjLDHCFuvCRcRpDT2A8L/6gh+E0/PtHoSSHww
         ND/W24jbWzgH48f0xZsH0RZ2MuiAhjFykGzY0s328KEEiKbIf3AlRRU8vYLDvLGKIzLa
         ELDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945935; x=1795550735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RPFM0kM1cCqmHm1/QYYu9V/6YMFz96kfdMoyD2/miDk=;
        b=kuiX0RelCAKvnapZHcT7M8X1D+CoN7Et6cacTkIlmDZ2Bb17/eiHJqSujuKuLVfFZ+
         E+nTYKbnGj2evRA/rSMgfI0eYRAzNkb0+x7b34mtWN/Z5Vhr/+hMARxkqHJNOJia5Ein
         Y526SqOM/YResCc6VXzl+2DtblIyqyAhw16vhz80VpXkDE7Y9IkkHVK1GDKJDEouFge3
         SjQZnuV+YyKUiRYxoZPCVAPkAKLG72R6XsOnYmMz9wmTgyzspxhKZwGrdVUYfza8rDua
         d9ovT2TfoaIhpF7UJHdAR5MStmjSsbXtkOX4vMHj1ULEXQ2p9p/297L46fg7Kl6/ozTv
         H8nw==
X-Forwarded-Encrypted: i=1; AL+hErEZwC/b/DC7aAEqXYYyuZ9QAfomT7Wsia4ONL3Q9Yf4Q41YHGsz6eH9BFw1FBQvHjwIQb+HiN3MQLpUrCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z80NiJ5w936RLoWCzWHjp98jETHz17ieLh3y+2tiIn9+0/73bNj
	lPmi1xa6ohy/MI7A15QU51k/NGrX1mOMQ9fFEC6RlyYduZQWyQgxrrES
X-Gm-Gg: AZFdTZcMD5XgQ3niwhBIGswNqWQeZ3cJxdQjFUOtcbxEc3Th45tIpqgaPTTb/eXNBs6
	QuS7cyxLsMDr/SNWUuo9/pqZUG6/EPyO1l2nZtFSONZi8D50q5Lg78tjm2oGtmBIzn4KMHv+OLO
	CxkncyPuAHFBAL8TU9JsIugI5l02vUZxcrLC/On/mNcgWl/73CCRRi1JXfkxwBJ6wDp+zOjOEnb
	ZFyrIOiQ7V1Aawr+CwF2FhHVH1ttgZZkUYiDGsao2SjtB4d3qLcxrlyXYbQV3GqeBVDa46mPRIA
	yz5w0x9PPqhjw40OEMmVEWVvD4+lyr/DMSfNXDV9DCr7PVUIwO59q44yebFr2ehREj2RoGCBERR
	o+KtE3S9uiSCIkpWhjLDcF5Nkpuc0520Bbz1r/oaNoxqn9mkEBxx7MjKtvaZW6dRfOzwdAkDlyL
	FArR2HzBa2qdcWJxttUwvZvjMPJGhqMr9H8y+6tB7mY9fbdJBDRW/qz4u1/iDqUZD9PhfRFEofT
	0eiErZajSEyQZf0bGW1w7nV+4DzIFiZkcZyOTzLtdnyccVldcFJfe9CQd4qiKwqjNGt2ADroWng
	2TLvQsSJOr+O2eX01Dfv/jlYCB0FCVlOsvE=
X-Received: by 2002:a05:6000:24c9:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-4a633a652e2mr1441900f8f.1.1794945934473;
        Tue, 17 Nov 2026 12:05:34 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:34 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v4 14/16] HID: ft260: i2c: fix i2c_reset sysfs store return value
Date: Tue, 17 Nov 2026 22:04:20 +0200
Message-ID: <20261117200423.19561-15-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs store must return the number of bytes it consumed. kernfs
hands that value straight to write(2). i2c_reset_store() returns
whatever ft260_i2c_reset() returns, which is the length of the
feature report it sent, 2, not 0. The "return count" below it never
runs, so every write to i2c_reset returns 2 whatever its size.

A write of two bytes is right by coincidence, because the report is
two bytes long. A caller that leaves out the newline, as C and Python
code usually does, writes one byte and gets 2 back, which is more
than it asked for:

  echo -n 1 > i2c_reset   1 byte, write() returns 2, bash ignores it
  printf 1  > i2c_reset   1 byte, dash reports an I/O error
  echo 1    > i2c_reset   2 bytes, correct by coincidence

Return 0 from ft260_i2c_reset() on success. The value is discarded by
its other callers, ft260_hid_output_report_check_status(),
ft260_i2c_probe() and ft260_i2c_abort(), whose own four callers
discard it as well.

Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index d5250bf5da61..e89f8a2fc06e 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -615,7 +615,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	}
 
 	ft260_dbg("done\n");
-	return ret;
+	return 0;
 }
 
 static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
-- 
2.43.0

