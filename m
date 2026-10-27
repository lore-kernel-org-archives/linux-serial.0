Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079821;
	b=YeQdduEFcwzpOJgjBF59T5ZUYv2BZ9Jm92touJNCzOJifn8pfgAUWjDKRcVOg+B8abWi
	 ECGcD1jh9i8s3dLl/Md1sH+rjBqrOjIiV5up7SzF2BzIf6HS0cwEU1jgrg9pYXHUerChd
	 L3SZxolZppRnpR7Ldly4GyTWsEm6ARr0BVuQK/GKVQh/Q8Mq6I05ODKOMSWqstcXs2TTe
	 YDN++Fzt7A7HkFfJRIzVR6poFDRq5SY2jtc/n0gmqMAcvWtIeD7Sqias+UgeDQ2kgkVNv
	 GhyIV6Z/Qaj97s7P1g5WIVD1GG11n1wovaFAM0VlNln8Hx3uF7+bMDNkSAeSdK/5d0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FqWB2wVkmtIRr5mzG2098ehyTIGBIw8KJYdLx1Y6IvQ=;
	b=WfSuLnjMYZP1vuQktPjDGMrSh1xgUJgiO/vDzX4qg809vdqxct30oKpmUGmKRo7OmAl3
	 cBrwKTq1Jc9RxkKlFWpAub6FLMJXNlguf/neFjeVjsye16GWJKgzqzh5UgcBAOl3U5KW8
	 yf6sOOjZf0+cOB8o5josxGmNh/EMySDpROFzWI77hBWg7trpPAsoiMNqBmQ9JIr5dOwqc
	 mGmy9RwhWpCIFUhPPHHAdkpiH5mJjo5rCHCEXM62JyZkw8UgYBNupBJey9m3LdKeb6tft
	 huBdtX3Y9s3Ycid0uwUNRuszf4qoVqN0y2UjedFxY6A5Lhq9DfMQS8jPKyCxB2qDV6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UScxL+7p;
	arc=none smtp.remote-ip=74.125.82.195
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878E606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 05:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4878E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UScxL+7p
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-35d0be18c71so781236eec.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2026 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793079820; x=1793684620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqWB2wVkmtIRr5mzG2098ehyTIGBIw8KJYdLx1Y6IvQ=;
        b=UScxL+7pN50Cx5va0u4tF9i803tCUmr1fjXNMTJYSvUCBWs81tT39d6+7lEpMpfDuX
         vRFAdOq0vqk3UgoucZaFTpIiZy6NJFjRBxS4KFUl4j4ibma2Bb21zSP2bi/allqV6elu
         xcCe0RzlL6Sp1LMcLMhspT1e0k2odbEZ0I7T0BvnSOWF/oR9H1YO1B8L7MD2SEKSSuxZ
         70GzDqIGlLZ9sciXG+dH6TyTZ+Ouo38rg8BZk1COix1B/Sza/xAHTv78dcPoKw6Tp4rG
         TYol7YC7pY42JF8uhLOaWpob5I1ljDct2jINcFosy7JpQuQeKeODNoeMD9+guzOgxdPz
         Se9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793079820; x=1793684620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqWB2wVkmtIRr5mzG2098ehyTIGBIw8KJYdLx1Y6IvQ=;
        b=ZIdhE6n5DKULtaymTKNYIjZZV44NPZZ6asbi9muXTKUmQa2+kJ0b+n+Y6tnNH+1pUI
         /rUwmIvrgDRJJrJw0jxNC05zXBxPYV+3DL70vjlzYf9AlRyv18YWY5wJSfTZUNWbGhtj
         fk0+UQt5sgtY2CJmtGFwWQUmnQDakZ2HhcDLhQC2UatfELSQ8rj0RtaLqXR0wwl5Y4fA
         lGZSme40q9LFWYGpmicTNhy44fQvz4l6v8bi3u91/2EO6tSGlcwx7FWxIk0zEV+VaLMq
         WeAz8frm3eX4q0NUAaVg7PiFmRKgE+lixwQ0wfL++Zh3w3yxmzey/msQXXmtruh//aVr
         RSww==
X-Gm-Message-State: AFq9FYJZc+hQsZGKMhBd13fsuxY7ZyYqykZBtHK2e0D1yDm3jLq6DNca
	eM9ntAgQQEJqn35J5IE7mikXbm/TVY4ISWvkViyC92wYB6MSR+0+wd47
X-Gm-Gg: AYBFou1BQ9WrOdID9DLAUrTXE5a5L3KpBxeY7rAVzpgp8vUgKGMKHoz0jR0lo5Nhp6G
	XN7C0+6ApsGEX5glaw/BNBnKyxxxFB/l6lmFyxSMUz/EV8ogqLmFQFtfwn8uvup+4ETnh2LK/7K
	QTY/g1fP1UPXftvYMhnCSZ76Or8QYFcBYuV0e9zo7BIU6vUDYCWDV8p1cpHSWyhuMO6UQr8iGW2
	u4oqW3iPaCv5jub02ziqVSs5RwOYg2O6Afzlxb2zM6gSEdzUxTMPm9fl20kucVH4fNAhJxRWaZk
	MlA17+3sRc6VAdllgdm6ICIGnSY/FszjgQVrBQMXiKYv+HdiTOEfjoB663azw/ADnuHymrWhu/D
	MqLc4X9b/4Q9A1q4MKASqErsVDdkeV7GMapvlf+vLcqDBRXzdNAD3GkwmPKmYm9rycJvWDnIvbE
	/l32NRucVUHRR7rA5iKt9wVFQ/12ZCInEWWUYZxZoYdv6fkJn3+barJAzv0VfaNPLw3ABjatw8I
	NZ0Pq91wkPiM8DP1jN2qLxFPNFuxQrQhqH7+GLw/iyqMgMpOyIkRRn2vwM2K/WXEVInnfTsW3P8
	JL1cqTJuKxWIMQNWaySU85cbnhYv
X-Received: by 2002:a05:7022:2609:b0:159:d448:dd1c with SMTP id a92af1059eb24-1a3c904ca8dmr2950895c88.19.1793079820223;
        Mon, 26 Oct 2026 22:43:40 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm29033485c88.3.2026.10.26.22.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:43:39 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] tty: discard flip-buffer input for TCSAFLUSH
Date: Tue, 27 Oct 2026 05:43:04 +0000
Message-ID: <20261027054304.35543-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

set_termios() handles TERMIOS_FLUSH by clearing only the line discipline's
input buffer. Data already committed to the tty flip buffers can be
delivered after that flush, leaving old input readable after a successful
tcsetattr(TCSAFLUSH).

This can be reproduced with a raw PTY: complete an 8192-byte master write,
wait until the slave reports 4095 unread bytes, and apply TCSAFLUSH.
The remaining 4097 bytes are still readable afterwards. Small amounts of
pending input can also survive if they have not reached the line
discipline yet.

Use tty_buffer_flush() with the referenced line discipline to discard both
receive queues under the existing buffer lock. The helper checks for the
line discipline's flush_buffer callback itself.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/tty/tty_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 90c70d8d14e3..45cb77185dbb 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -496,8 +496,8 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 
 		ld = tty_ldisc_ref(tty);
 		if (ld != NULL) {
-			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
-				ld->ops->flush_buffer(tty);
+			if (opt & TERMIOS_FLUSH)
+				tty_buffer_flush(tty, ld);
 			tty_ldisc_deref(ld);
 		}
 
-- 
2.43.0

