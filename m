Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE985260;
	Mon, 14 Oct 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929146; cv=none; b=PffAi8h+1j+3+xJCBGBqK4L/go2nl3HJNdbYR48owX9Y3LMlp59jLFg55PPr/f7XZWqoxZemyolPXGnPmQIBeJMNLA66Jm71LYiHC77Q8VR5NtqYEeT1OYYzR5xtTIEoJCtLRe/PPbaz/JNDiuCGGhdgkKjLNC284mgp+0YQpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929146; c=relaxed/simple;
	bh=27ErVbh7h8ZxcfPHZxgIspQgOTWYNG5o7CCpFNn3ql8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nyPjJgLPmgiLPHBt9qPl2vm8+zuDE6K3fd7fvA66eTFG2pu7zgBBeUGKk55TDMly0aJCDrkL9UJd5knwtdiisktkavDnJVp49jzRAEatE/hGMzHv7KCo08mFoHJXuMbG8GMEIlpfR6Yy5bp7IHs61B8T1hX8d8Qp2xrRt/MK98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7pxfERv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7pxfERv"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so2033692a12.0;
        Mon, 14 Oct 2024 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728929144; x=1729533944; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FZfovKOyM8E1BrFHHULoso6mXcE9/T75keyfKjaDFE=;
        b=H7pxfERvp6T9yKd63f9EREWFhVpc7O90XHIBXjfjNwotLcXrKY4J4Mhw2bvT5V87vv
         9HDsuV2CspZKmhRzX1ngncp3qCnTMoQfj7r3EWnogANwCnPfG9C8tHGNJFD6QrkdhIjI
         FtZDIdXsRGUNVWaMEeEubNodGlW+mNeX/5o4GSCNFqvv8rwKycSaZfoqW1nPeAWxbG/5
         TnddIgITgJgbGhanQfTbNcg2tJuQHMFg56jxOr9ErvXxvG+73sXmCDkC+FbMWIrNlGRw
         eaj8MezS2fHbHZOAcXlJ26meCKd9H5Yt5GC+IDzqq+KZW3ony10nuDMJ6edVdu/7B7x8
         Eq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929144; x=1729533944;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FZfovKOyM8E1BrFHHULoso6mXcE9/T75keyfKjaDFE=;
        b=ixxWP1RFkvkTdlxw7hfuJU0VCIGR6P5xt4Jn5QEp/JDM+AUMiDgF3/475TB6Hoz5Pp
         gA94z9nMdCYNFJNYVhkzztDgNvOmPgrLIy6o9rtTjg6Rc1KRhZffz7gwiJjWIFqNvfsI
         PjMgRff8SGW5zAmmWqbJZBtZ21G82kNvfwlw1DsRgB1fZw3ARHJ2aUabdfLodaWfksTz
         BSKssr6kueD22qGYWzHTMtgFyBszEacFS5s2sPugu49ZuK7HyLz/SOSVo5x44JvvbhZX
         ffDAqi8fMwSUq6wfQRfRxPuxxJFeQIMYdjoOont3hfJmAhMCAybXdwL8uZ2sy/ccg41z
         EIbg==
X-Forwarded-Encrypted: i=1; AJvYcCUh01KQJA3yfyk4vwsuWyP4JaMKlsuO0p27lPX9xpcUPusxj9KoVdqWsCt6iSc2yc6pHlEUA1l2Hq42RhU=@vger.kernel.org, AJvYcCW+uPoibJ71tIC0R9adwnWnUGDQMcZ53nT0vNCsmfiJ/VtNdlRa6pOID8T6omrWHqLV0oxK+Yov6G/K93bJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmeu4r6idmf0uaLPZ/oXJZLVyFeSt70eURJSE9sSfH6SLOGc+Q
	Hpfq2BqR31AYK3ubVVRJXsdoTwpxTKmGIb/F1TLXTaoHKxTgCs+j
X-Google-Smtp-Source: AGHT+IEUAxLe4Vxk9u4m8O8dQg8gMHzbunihp9zdYaQKMJqLoMBZdbVg1T1Iq1qZJoM7BunwAQtCUA==
X-Received: by 2002:a17:907:944c:b0:a99:4698:cc5a with SMTP id a640c23a62f3a-a99b95bc0d1mr990488866b.47.1728929143494;
        Mon, 14 Oct 2024 11:05:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:e0:9854:5800:a0ca:7a31:1c3b:247c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a13e31a13sm144314266b.4.2024.10.14.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:05:43 -0700 (PDT)
From: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	pmladek@suse.com,
	andriy.shevchenko@linux.intel.com,
	paulmck@kernel.org,
	john.ogness@linutronix.de,
	tony@atomide.com,
	arnd@arndb.de,
	u.kleine-koenig@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Subject: [PATCH 2/2] 8250_core.c : Global variable shouldn't be initialized to NULL
Date: Mon, 14 Oct 2024 21:04:15 +0300
Message-Id: <20241014180415.2365-1-m.omerfarukbulut@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

I check it with checkpatch. Then remove the NULL part.

Signed-by-off: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5f9f06911795..435396233863 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -304,7 +304,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 		serial_unlink_irq_chain(up);
 }
 
-const struct uart_ops *univ8250_port_base_ops = NULL;
+const struct uart_ops *univ8250_port_base_ops;
 struct uart_ops univ8250_port_ops;
 
 static const struct uart_8250_ops univ8250_driver_ops = {
-- 
2.17.1

