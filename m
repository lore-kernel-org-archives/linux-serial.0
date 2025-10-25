Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B132304BCA
	for <linux-serial@vger.kernel.org>; Sat, 25 Oct 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408747; cv=none; b=nKM5qqbM6l3Ne6HA7iNEJZbHT+8GrZJGpMPQvDF0v1tWfFZBlggOCzMyyXG5xyV4SMa997aES2VPb2kysh7IvG1MNZ7PdaclztZ+zSQlVyZ0/9LHf6jDmx1m+kQGsB0YALyfkPZV96dFJ1EWpDcXogucwR+SJ/QoO1cw2E9VV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408747; c=relaxed/simple;
	bh=yu/Dh+IfCLtGqdkzWYmGphnHwzjdW7LS4ezBwM2rJ4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gi6zOy5eOZ1rV54qjyE/Jf86SgDVnP4jj97jlQ0juR4kaDl8h6c0qha27sioqaWK11hVYyM72avS3J8YEKsa46vg5kxP9+SoCWe0eJOPLEJusXkQnMVnWqexz4aa+3yHFimtvz6OXB6BTbTugCR7WPXO+YAI1FBTIgH3N27TlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsF9pIbf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsF9pIbf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso3478399b3a.1
        for <linux-serial@vger.kernel.org>; Sat, 25 Oct 2025 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761408745; x=1762013545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XFTdA7k8wwzMFaWlCyo1JPNHO/S9MJnKXZUm98Yf0w=;
        b=RsF9pIbfUsxTwz4xvwVpDGuieJ8HNVLvzfwcioixeM1hDDJxOM6I9Jj3df2e5y5MXi
         9SdnIO2kjLY20ZRbkMbxb1H2JZfrCYmPjA2oxmdfI27HtzLQ7YUQY/Nz9SEplSG6U/9T
         UdAqzCJZYxmraFl9MlZi/sd8mf7Td5y4CDOuKdOo9I4NOBtjeSbi+VzvGbwdHXE7tcy4
         lrODzMWvVgeTDVj6fVT3jUdsHnCW1qctahX9Da3XRyN+bHBsriSEs/DSLqGXyXY4LkGr
         Ve433qHjC6RCQJygzLKtYI5HPdN4vc512Gk8PH7a96gjEFogkLrEwJ3ZK5FecsxxIhSd
         OMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761408745; x=1762013545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XFTdA7k8wwzMFaWlCyo1JPNHO/S9MJnKXZUm98Yf0w=;
        b=dyE2qwjFIuQPHJ6yhMO4SYr7yPcQFx5LjvXD0QXaB8d9cSUo++1tlHE49Kl4CD88O5
         pWkKvM6lpwoobl9bAn23WAhqYzFg+VKBu2NiQhycFiL44lyoKjMzDaXmFeOLKqZGtCs5
         TmhIeIHvnFtvxfK+YjPGhokZLCmFpuky9U1oxoWgo1s5BOvEAtOZQ09352iNJL8Z1FqR
         LjO0Zp06HQGz45t3onycN/UUXeA6UayoKqWDx13VUKPh5L2g2Fkd4gsRdCe8o7J5QZEv
         poqPy8PhkvUA4KEk68m3MOckK68aA6zI25bFdzSGpOJxvXUbnpisyx5vcUO2wDCmFuc4
         CeFw==
X-Forwarded-Encrypted: i=1; AJvYcCXuOh/12FgTcptaGY0Ibt06zGaRx7xlqTFebqOOt8LV4Yu+9t7CgCBEX3FFjlUymrwLdjfj/hcIk7O2zoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJBxXvSZYsCle7XBJmQ/lK6fVdGupZ9YmTGmY/10HjntQ80jW
	AqCeAHFZs03tsfqefES9CutTI4oVoMlDydKcbBy9zgeq/ZOg6Z+8f6kqkaMjPk/E
X-Gm-Gg: ASbGncvKkZ55LWimBL1OJABaCp71YfQbJfLwTDdoIGDMmSCm3bSixqpDWoUc4yBMR35
	joAI8XbhnLHhoUO5MyHF8etoAFqGN9BuNfSzFe9BB5Ffn2inxNY4CjG5LUDb86fMHZ962xKrd50
	9BG3psLVgHuXU/wcttTnvcX4U+kXjTpmXEkIaIf+TQYKUG351vUVoRYQcMdAAWZYANoj30GZBn6
	xlJocbU+F5zagEKcuFHxpgUCJBtedC0tDSZVCwqfk4Rwasv1aH7QdOIoOguyU0Xauxpj3ghPSfe
	zhML1xIf4in53IjqTAHtTr4ovZg/4jB7L5eQ+bO+VMTvIdpELEkEs+xFSSsC/1eU4X97REZcgC/
	yhYRggWaMAAARu2EbbIinltL7kL8s7u6MSbDc4BCBE4ExY+uMY2a6jT7x1tPt9IfALI1Frs3qE2
	+5whcENOgbaI/P6iJo
X-Google-Smtp-Source: AGHT+IE8vlEVwjfaCK6fWdzSeAWUbPUodgqwlEaURtg/eP8og+MlqNHWouRBq41EznCRbBnlLq053A==
X-Received: by 2002:a17:903:2445:b0:246:80b1:8c87 with SMTP id d9443c01a7336-2946e220396mr116623225ad.43.1761408745210;
        Sat, 25 Oct 2025 09:12:25 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b50sm27823415ad.75.2025.10.25.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:12:24 -0700 (PDT)
From: kriish.sharma2006@gmail.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] tty: document @dlci parameter in gsm_modem_send_initial_msc
Date: Sat, 25 Oct 2025 16:12:06 +0000
Message-Id: <20251025161206.795784-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kriish Sharma <kriish.sharma2006@gmail.com>

Add missing kernel-doc entry for the @dlci parameter in
gsm_modem_send_initial_msc(), which fixes the following warning
reported by kernel-doc:

Warning: drivers/tty/n_gsm.c:4175 function parameter 'dlci' not described in 'gsm_modem_send_initial_msc'

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 553d8c70352b..214abeb89aaa 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4165,7 +4165,7 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 /**
  * gsm_modem_send_initial_msc - Send initial modem status message
  *
- * @dlci channel
+ * @dlci: channel
  *
  * Send an initial MSC message after DLCI open to set the initial
  * modem status lines. This is only done for basic mode.
-- 
2.34.1

