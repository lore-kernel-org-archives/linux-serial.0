Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C31F708D
	for <linux-serial@vger.kernel.org>; Fri, 13 Dec 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118559; cv=none; b=JHyik8k8vo7dOyeZzH4y9SfDEQ30mudoIH3SkhlhhIyz37MVDGWPsAwmM4VLT1kgMGbl5HcWksnHdZbLxjO0QcirUVCr/vO1nC/HyM1VKxGPWvvs+otkrMuAoXCp6XGGyeBIXT2LF9nUVaku4GSIc15LBUG3xIPNrqCb6JZ1NTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118559; c=relaxed/simple;
	bh=AVG5onnfQvs8+iU6qz/Y4bR5+DooUuKWyTYlN50ctus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q+OG6BNrfYDf4EgzWXXHHrJ+304qxRJOYTLBnhqmXzgnjs3sDEn4oHj0uk4wdzz2EBaKFUEF7ulZhufhK2PREbknjZkou28/0CEP6BWf9fX4+jzK7s1KA4pKPyMW5vs3313sEQq4txC1oHVMXm0cI1Xc7OG1kYb9MFZwCIvJq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cob+kDWt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cob+kDWt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so1791109f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Dec 2024 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734118553; x=1734723353; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctb+O+QkBtTHayJps0vIwHU3lfYjoUBnA3ZC8GD97Y4=;
        b=Cob+kDWtaXth9ZptVg3K6gQmxBddSiMORZpMoJkMm8yxL+ggGRURg5JOrX6ds9i1tw
         cl9lz/kaGWtAfr1zeixrdPgMqBbyVB0DTFZP3CPvp7Tt9ORNJn5Tkxqamn67nchZO07V
         e2Ul3kgU7rnjar3n0LGGH683KRfQvepYoHMdSKf1SaqXKUUARxB4x1Rm25Ah4oqp7eWx
         PUpC/t3wKaWSiqL9Eqj6MLwe6Q1zN9xMbKHjAtN6MQLwcNcndggQzukL4ohFv3iw83Yw
         6fCFcil/FqPw22yh219wPURpF6qv0wlsS1NWPGq5kii7xF3hWzPOkqCzSHlNRQTGyYjy
         g5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734118553; x=1734723353;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctb+O+QkBtTHayJps0vIwHU3lfYjoUBnA3ZC8GD97Y4=;
        b=qNzOfyDubm59bv4vxKKK09DDaU/ykIK+PfzN3FCbBCXO4aDoQI6oVzFcIKdbxMZf7l
         CNls58vH0Og0C5SPL2wtlxmIyOdXG6sWl+uxB7ZJP37RKGMzTy+POZRtWp4v5AqI8OX5
         P0SSdUhMXXmMnXRDrh+jjARpUMzIzqMOFSMUlHgBEMR/2d0BitdCvoWdNGI/fVIWC0tR
         3e4CqtonOUYKBBb3prbzGfNzCUFfnQZzzYqnbB/qvmSDCoj07Tkkq95v021Yl39XA1qB
         sr38ZvoW9VSBKgc8P3xksCu1XSejQlvYPJjiZ3OpMQ0n5660ZP08QIaHl7ZwRgkDZKh3
         P10A==
X-Forwarded-Encrypted: i=1; AJvYcCVHA3Y/92AbcHUErjSTMbz6xxvG+rcQpq+VKO353ePLZFubohjdVE7BujgE6XFpcVAWW63Aw2Z0kAFih0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAx7KmY0dbqOr0Q9I7xXokaiEpalS3do1yhT7wlbo6kpMzpBb
	ovZcZAQHxsVBN5fsRa38Ph1OFmKC4u6azL9Z0qyjZOfi6qXtlX/hGWDNZ6q94xLXPZKOi3APqh8
	YUrY=
X-Gm-Gg: ASbGncuQJjMrH+quph4hsvd76SxLGUVHGY8kV/rIVoJlJOBUx8L1NbqHmGiK6roqjrY
	l19/3+9uMV9zGOYGC3U6OkZ8vgadNToYUOQyw5xPpTUMjQyB4m/DU2+ptx0R5xa1o5KnhU81jPo
	v7Vg5ADIxJ2S1M8KoVEAcBd2YRnTS5f36Xy6s1ihZTmlBc3ibiqg2BTHMmHXRyEB4EBkEoLV+51
	Z7myfJb+l7I5lYwwo7Eq1DtA2GsvguL9BPynuyeVHMx2w==
X-Google-Smtp-Source: AGHT+IHjdMefGKHq7odDuQp5K0uGGft5FyrGiSjextJXpxOKkRftrzI0f+kJplHZxP/JnFTXIcO6jA==
X-Received: by 2002:a05:6000:1848:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-3888e0ae4e6mr2977730f8f.24.1734118553152;
        Fri, 13 Dec 2024 11:35:53 -0800 (PST)
Received: from localhost ([152.250.153.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac7789sm152833b3a.12.2024.12.13.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:35:52 -0800 (PST)
From: "Ricardo B. Marliere" <rbm@suse.com>
Date: Fri, 13 Dec 2024 16:35:05 -0300
Subject: [PATCH] tty: Make sysctl table const
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241213-sysctl_const-tty-v1-1-2e2bcec77f85@suse.com>
X-B4-Tracking: v=1; b=H4sIAGiMXGcC/x3MSwqAMAwA0atI1hZs/eJVRMTGqAGp0hRRxLtbX
 L7FzANCnkmgTR7wdLLw7iJ0mgCuo1tI8RQNJjOFNjpXcguGbcDdSVAh3Kqqpxm1xSa3JcTs8DT
 z9S+7/n0/nukgwGIAAAA=
X-Change-ID: 20241213-sysctl_const-tty-67dfc1bc83b5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=rbm@suse.com;
 h=from:subject:message-id; bh=AVG5onnfQvs8+iU6qz/Y4bR5+DooUuKWyTYlN50ctus=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnXIyWHZTzHm7yH5zgHyyvbhxKU8Id5B6Hjry+8
 2OaNNtGspCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1yMlgAKCRDJC4p8Y4ZY
 prfTEACyu97TJZ4jkx+0JiRyhUTNs81Ae7GGz59jQApoLrV915+GoGugAls1k9x0bPhHphtfSxD
 jyLI9/FW0hzlTaQJC6rzAGURAtWJmKK/2fIEWJfcl7MssNThWkiUj4kpBKSbzJ0X01tEOfwjovi
 5n/CNRLvzEMOGatyA9qd/6rJAw0kv92KNp2j34Qu0/T1+yW8d87NYnnaoN1I91jET6LrFi/L2Ta
 YgXQ053Px41L84aFCBU0b13NXqRyn/YGzvWrqO557Pdp0b1razXdWT1Q4S9a8+BDum+M83xwuX4
 LWT1i5kQmPGFr+1LTgPydHhXFhxMRlGGRBt3fDL9fwk/H+XwTP1EYqvhxUXw63ISr+8SXc74Mot
 Pwl5hLG9tfcQNwVntICeDjVpSmmaHhyQRVdsRh5HHFXJKoAkePjUruielJpDRZ/KWVQ+oa+0J2Q
 INICj/pm6fiVpH7I/KNIlvlqxEYHjiUG2oscCSu4SPxyU57vWl5c/S8jFgtZBS9ji8IkdQHFUhf
 iogr9Iax03ZTBoNDGIpuLFVJmXpevmlt+mL+kkPIdLalaeU+DFYMj25RwIPJWTN9A1+Dq4y+d18
 dbTCSGq89Ry391vTl8KfZDbHS/D2jgrTfGqyk1Kfstd39+jYhRXf4in+rn1YamoPgHAkR+6UfaK
 KV+ezEFhEvZ1tYg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows for struct ctl_table to be
in read-only memory. Move tty_table to be declared at build time, instead
of having to be dynamically allocated at boot time.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index dcb1769c3625cd0f7d1555260adfe6051139a305..0e84677712b4e1eb72f209c4d9c54a940b3a9041 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3618,7 +3618,7 @@ void console_sysfs_notify(void)
 		sysfs_notify(&consdev->kobj, NULL, "active");
 }
 
-static struct ctl_table tty_table[] = {
+static const struct ctl_table tty_table[] = {
 	{
 		.procname	= "legacy_tiocsti",
 		.data		= &tty_legacy_tiocsti,

---
base-commit: 535a07698b8b3e6f305673102d297262cae2360a
change-id: 20241213-sysctl_const-tty-67dfc1bc83b5

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>

