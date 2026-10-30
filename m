Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399842;
	b=azkNO9/3g/6Ycs1Cb6skVq+bHpsbgHfj5J4IYKsXbIQMLna6CVf31BSmfJC84at3tVFp
	 jLZfMIuM4riulEf8kXds67FDUYUQ6w7X04Ir3S+hQKvWArajFZ9n3xcrS57ioqkQlbpmS
	 YXo1XUbtVtXItLHC+c60dEyji/lD92NpcN1XSfDjTjs4Zlq3kPq+UJ3cANikTOe/8+I7h
	 2SBadhRy3lmhNRkqZdncTN0PY2DVo7ktBzapAAql2eOWIwym3sZnjnQ1umYhRY7ghEqQz
	 J9kANxJkxgONUf6B7F2pLiT+PuAh0JWb6WQByAwlbb0WyBe1sD1VbeXZGPDVDrFEVPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
	b=0QpGgN+t7wtwCxCaU070dup/xmpwzJ+Q7+KwSKkvXf/sc94SWiSyqg94ksr/w+DArxni
	 Jn9JqBjXc6UuEgsnLAyyGpcAVVc/Ul2IIO83woaMMAWxTMrmfSLdJcqNzbI4bMRjkQ8Wv
	 geDQmCVgTe7ybjhnOhKn9TPgdugQCfug/jv1Di9+JzY34g16AsfQcgVD3ZYNkEvvpm0HV
	 9+dLAoTbI8Jqjn+ZhWopRVutuscqofUpx2gCUmQEyHle1b+ESkrYc0ei3Dk6OKK1+I8ZD
	 jHbyDQ2vStGKZlivaHQYuzeyEYkeb4Y4iwYleQ1EFwQeNSIznQyzMrkPazc+c4zIrAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYiSZd5e;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4E660A260D
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 22:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D4E660A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYiSZd5e
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso12232295e9.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399832; x=1794004632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
        b=OYiSZd5e/v9Qof0ZiLjCYYymHax/1QU48N2uX9dn4m1M4qccuhF1G7wPnKY4H9k4q5
         PtpzB3sAcrowhyCGu5SnRwnulcJ7mN5TYRubKPzHnWxekRYqBKKcn6vcPvG58wvpXJFT
         /5Dy7btFOddSdWxm31iuemYh/f+k0YgEHMlL9VebsDp0vzJl0OgB7BPRP+6RfiNU6nBI
         yjiLDMgcpLVx3nD6nstKc/BKRdRWRjaTXUJjTgQVhyQm01+g6C9edPm9evr2s2YlQpWr
         HUk0Y7meX1O0+a7b+k7Y2aSF/JhI48htx6On+lmTbAlfeFl1JuUNy7WdfgUMCJQneyHe
         cvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399832; x=1794004632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MVdIdJZip4V6Y6Le2JTKH9hHaIZalIL6VdbzzoeRaKk=;
        b=qdE6D+62l63pIOtO5/FaiBbgyH6j0hzoS6xkSeTG0ynXiK97oA6c9h6RviMcxeNPdg
         iMi4f34WkVCduPflS2yePDorJb9YtuSfKnm3R+oImE56npl4R0FqyVnXWAUUFO0Bak2N
         zFR4SEMPLKuVktMSUIiANsSqMwXGKOvqKRKLSQB636/c2sDGI2HckZ5g+A/NAGGyyPFV
         fMk5fCjZ+sv5N1X6BBJ89+25NbWoooRBg/zLyb7AocF9/9E4RTaJtEVo6SuBCXUeapQy
         HMYi9RPGG/6HVL0O57/00l922SjHJUcrCPIyFsPuYbEnZJ8mF/RmZHKrbIF2l02IMJ9w
         PWsQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/8PaU4ixS/7vxRKI5dFQ/qv5mfKKh57UGWKVhp9jM9D3Zf+V8ZxBV6BpBAo/1qxLnkEdVoEbdGUD6Lm0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+seg0lD2QBMf4EceI4VGQjW83XNEMoXfAJGMisQ1TK+pVctfr
	0isT9HUPWhEzfK1JVpL6Dfl97ZCSti4qPhM1dsNEva7j21Kn/wYJNRpz
X-Gm-Gg: AYBFou0AVREyRjLUQoEHNug3nNFGs+UeByX5dusuCGh0ztWJlrOTb9I+tacBryvsaBC
	F5DAEInFQheTyLhuwtjkne+LBKMU6dbaIHc05hLmSWBoPr8srbYpMn2YQW4VPI+GUowGsYQLVa8
	F8QODuC8wDTsc4lE1ytPyTp+QKATLrhhcKuU6QAZX+8C7eEZeVHnQRplEY9grI+9wOeE/m9TjIo
	Iq5fw6Tlq2mipXk8sIQ3HXoQ9rjb7h9vq9zHcsengiu9PnWzixjmI1akmm+YEmzO7DAJnJB1cYr
	kF5+zPQ2PpaIZVLm+3NZeVlNR/WnuCKuaYVxd4mqIOXtp1kwVxTTpVH1FCCVtzN/vKl/NN/9DUg
	1IW1AFv/a+efqkcFpl7WeqLh2RyOfZitpofTG0dVjYtWSiV/iNNIXkJqYWZQgJmgn32+yHQgSnf
	kVUEFW11/lFNH7/G0QJlcnyvbT8ttS1N/Mq4zIxMifrD++NghcXTsg3U0WwXOgQjaxgn4OrTyQy
	/Dp/HY7CV6gKXt1nHmDZaJ45MykkpvuzhqfSl4ZKBhUqDgoMpx+d+5zSWYZaJWluXYzuzyXxxmW
	JVYzWL7VMKTlRYKHhakf53gwEHXz
X-Received: by 2002:a05:600c:3554:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4ac18c7461emr88275265e9.35.1793399832545;
        Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:37:12 -0700 (PDT)
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
Subject: [PATCH v2 07/15] HID: ft260: uart: enable flow control
Date: Sat, 31 Oct 2026 00:36:29 +0200
Message-ID: <20261030223637.86907-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030223637.86907-1-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
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

The FT260 is a full-speed USB device. Interrupt transfers poll at 1 ms
with a 64-byte max packet size, so the theoretical UART payload ceiling
is about 60 kB/s (~600 kbaud in 8N1). The chip advertises baud rates
above 1M and small transfers can work there, but large transfers are not
reliable above 460800 baud without flow control.

Stop forcing FT260_UART_CFG_FLOW_CTRL_NONE after termios setup. Honor
CRTSCTS (RTS/CTS) and IXON/IXOFF (XON/XOFF) when configuring the UART.

Tested at 1500000 baud both directions against an FT2232H with XON/XOFF
and with RTS/CTS (~2.9 MB transfers, no data corruption).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 6f8d72938702..4b0b55c98f90 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1897,8 +1897,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	if (termios->c_cflag & CRTSCTS)
 		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
+	else if (termios->c_iflag & (IXON | IXOFF))
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_XON_XOFF;
 	else
-		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
+
+	req.breaking = FT260_UART_CFG_BREAKING_NO;
 
 	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
@@ -1906,9 +1910,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
-- 
2.43.0

