Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVLR28wv"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A61706;
	Fri,  8 Dec 2023 02:23:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b5155e154so22850215e9.3;
        Fri, 08 Dec 2023 02:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702031013; x=1702635813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qAGg9UeNXryzT3QbGGLxwGOXJOdstDFVfB+aigcAG/A=;
        b=UVLR28wvH/rmkXBQmAKlF9SGGeQ2SUIjXnAdNA5LBTN8nlZwJVNX8kjl6fCsNunw2y
         l4sXyjZhqIVqEzGAFLiE8tfSrcNBOpqhKpDlAV/lH+WtU5jWy79ulelxcSREq8rYHacT
         D53Pu9mejTeqjInOmjUGUWcAISlOy79JGChiu4cvivs0jxlkSLaNI29NH6mgXyTWXkvp
         59c5L037wy9ev+2N6kYUxURFcP2qKvMmy7N6gLYLZO2AISbmH6n0ymFBVDbw1njdI5ya
         X3l/DEy/ErQ+5DNn67is5B+8JpqpZQlfqobg6wNJqL9CGENtyuQEDkM1+I19wIxhKoRV
         FHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031013; x=1702635813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAGg9UeNXryzT3QbGGLxwGOXJOdstDFVfB+aigcAG/A=;
        b=lDgTGBsFLA0o04eaCDj3EzyNu8lzSME9+AXY8cdiSHFMK3wmRUK/R+xdkr3bJQDnsl
         hbKsWauEvYrqYrO4MXB77QMOZNOMVdLyEdsqAtTFpNX8vVGAbvLkYIELvE5c2udKYSeL
         9t6HNOI4dJlGV0QlZCQuu7h9FVcPtIo9rCUQ7hkiaxn4QtM5lsFGrwwkXk7/OASWtWyY
         bcvFFKkhZEXhlXuxXDhN1K5W1IZY0fcOs20fpepImHHNnyLC+o91Ac2CqiK+h2OGlgOF
         sis+f9XQ+X+fiMPavNcYPLv1YjHivWDawWMUwne+mwL0QW/hh8j3/qs7BI2h+L24dC9F
         P3uQ==
X-Gm-Message-State: AOJu0YxHIhDP8AkwgCleRlfecoX2hATPu+GTsW+gr/VWGxPjdE8/WJbE
	Lblo3LPn/NL0o2RO7trd9Ds=
X-Google-Smtp-Source: AGHT+IFS7ZHwRE9UbnYNBEtbQTHICdnWfcjDSaEjcDUJIT+5c6ZgwUH0wA4GCjPPgFfshvyqb0RD4w==
X-Received: by 2002:a05:600c:4f91:b0:401:b6f6:d90c with SMTP id n17-20020a05600c4f9100b00401b6f6d90cmr2335319wmq.35.1702031012515;
        Fri, 08 Dec 2023 02:23:32 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b0040b4b66110csm2402840wms.22.2023.12.08.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:23:32 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] serial: ma35d1: Fix spelling mistake "ononsole" -> "console"
Date: Fri,  8 Dec 2023 10:23:31 +0000
Message-Id: <20231208102331.3267192-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/serial/ma35d1_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index b4dcbd0c95bf..19f0a305cc43 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -558,7 +558,7 @@ static void ma35d1serial_console_write(struct console *co, const char *s, u32 co
 	u32 ier;
 
 	if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
-		pr_warn("Failed to write on ononsole port %x, out of range\n",
+		pr_warn("Failed to write on console port %x, out of range\n",
 			co->index);
 		return;
 	}
-- 
2.39.2

