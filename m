Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542C21D3CC
	for <linux-serial@vger.kernel.org>; Tue,  2 Dec 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657485; cv=none; b=G5yycN0uZKJPIcQblD+aDrOFADdFRkpAgFUzdRFgi7WLum7EnERTmp+v4BARi5Dit/s5Jqytsz2JpwJM6T/0ytPaxkaqR9Dvz3cqJtR1NgMf8n+3Xp2UUaz5RlOIzn1FwnLV7dTKQ1XRtySSq0BsVjWA8AzqAnEo352BgswUHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657485; c=relaxed/simple;
	bh=sstyFnMpYZQBdS1AqfURxxfI/z4kR/FGE9dNT0lzCwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=It0qtWQDyxJkeEZts5m2brRrrGZGWw/DCwsIxyE/ZkioWYcJMqxwo23mp4z5ysaKjTjkl4GlrHuaX/AIDFLCqXOrJ5adyeDwCD6PDdO6kbZeoTw5ct7KmR+z3Jhx2nyLKnAAeFRheZCFZT+x2sdMlLyttAt2zHX8VfZlm1hGlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIpHsC0h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIpHsC0h"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b73545723ebso1001313766b.1
        for <linux-serial@vger.kernel.org>; Mon, 01 Dec 2025 22:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764657481; x=1765262281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xU/ehQzgoy5IJfNnWDZeimYkIusU+phaEXEPKsptZaA=;
        b=mIpHsC0hlKRkmNIgibk/Zh+u88DpaoCTQa0yxg/bkZYc1OKoVyFViQqg4TBDUgq+vV
         r806lezNhErjYpa35nbgYv4FipK8pdDQyFiqBqMq6usb76qUEUUX9/oThKJlPNAuqnQy
         KD37tve0Va7McnuQuL9ctLQg6iX7q+pWeAMjskU9NcLN1vtldnmS9mV5+/B/OrFqLRXm
         sxQePHe3RnUO4h1z6v4xRAA+6eFpZ70W1hH47fRC57QmjWrkI7+ghpDiFD3rQNxUj4D3
         CTysBLvy6af8lhCu2axMLAkdXNScrH8nDbZZoEK7I3JiwtirAG+iVts63F1rCg7elY59
         tEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764657481; x=1765262281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xU/ehQzgoy5IJfNnWDZeimYkIusU+phaEXEPKsptZaA=;
        b=AM6FTzMwhf8XcM2iu0Kjc2EN7+TGs9FDVcoVifGAXyMUxdk7Rq4ddltInrzmGU8d2g
         emTtveAMGAYEiDF6IR4wxrklXoV0EW/2kIXKqfmWjssU6h6llDmRnWOLFeNa6tF339ir
         FIzG7F43H2cqZMRZdvqWts4DBllk/JAlOnc/SjCi5qp9zxJ38YFpOUtw6Ba1G4rR7rYh
         HWkedbyK94/ma8z/ikpGfnm0hlE1nrSxRX670NBPIvM5nO3+5BalUptybDyFlyBInsfy
         qwxYoInKT8YuOWINmEgFxF20fsdlF3FrpUOu0TimlWsASuEExqzeh5RZ9vTAQjgxr0Rf
         DxiA==
X-Forwarded-Encrypted: i=1; AJvYcCUktaz5RjpMn2p1k2v25Wacz7IQY6ktEMKvvb+voosWznU8cdsTEW8NR9kSdncD7nK88OewmIIOZ+x7FkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbiOiFXnEJlu5ULXXmiW8NYBZWsBBeQhh8Jpe2ivb73lnyj36
	v4DIN5UsSxS79NdrBihHWmpZh6G6dKHNOGoECa7dupl+PPk5OEWK6pJM
X-Gm-Gg: ASbGncvT9gALBvAz6OZlDtWtVOIJAr1rBeqImd7Ttgbqqv/OFUKTYr93AvtV+2nqGMj
	axjDNryKXnD5H8/ftLhV0nMSkZJiStfWe42KnB4gk6LJSl0jIfLOk3T0eG7xUGtaf708hP6UzB3
	TAs9Zwf8xlqGEm9MaLlFXecH4GzzBzAeioVESkCKU26vxyWK+3xPD6VIt2NkOVmRpOvcfz9FCPn
	1Obo14Y/YtcNE1BfoYiWuuagqCVDpf+3l/kv8vqUzd8JjtPwI1iOKysCnWX/eYzhNsUAqEAzEG/
	yX5FW4Aap9EIxjAJQSpTVaKggfx9rd7rAkKRMBQx2VMk+NFnUhCm1+76zwJ0YhsJ7XjbxOW2JTQ
	SIHgX+j9nlmAroB0UK1/F57sTiN2nAC3y00HI8GVjeBL8O9ru9WP3D4DDHGDZhO3+4B+477gf+o
	2wOpfVgcgiqbkpNOp8/bCqoJp4n02zYLObRlL1L/jEmD5bNinj15eBWVIT3i/dMGw+6OmeoSi1R
	sj7FbU/07ib4P2rqyIw5Xb1K2JueIVxM/UBQ8eqFweK5ugwtlz12lD2
X-Google-Smtp-Source: AGHT+IFeKQHPFGG+303VAn1mYEbLpCoJtv6qFCVlVACUY4E4EYVg0dNCagka16l8BXssZYkp3qVq3A==
X-Received: by 2002:a17:907:9489:b0:b73:5acd:4650 with SMTP id a640c23a62f3a-b76717016dcmr4366330666b.23.1764657480838;
        Mon, 01 Dec 2025 22:38:00 -0800 (PST)
Received: from localhost.localdomain (user-5-173-222-11.play-internet.pl. [5.173.222.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162d26sm1433035366b.3.2025.12.01.22.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 22:38:00 -0800 (PST)
From: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
Subject: [PATCH] tty/n_hdlc: Fix struct n_hdlc kernel-doc warnings
Date: Tue,  2 Dec 2025 07:37:48 +0100
Message-Id: <20251202063748.1210359-1-kubik.bartlomiej@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing descriptions for write_work and tty_for_write_work
members in struct n_hdlc.

This fixes the following warnings:
drivers/tty/n_hdlc.c: warning: Function parameter or member
  			       'write_work' not described in 'n_hdlc'
drivers/tty/n_hdlc.c: warning: Function parameter or member
  			       'tty_for_write_work' not described in 'n_hdlc'

Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
---
 drivers/tty/n_hdlc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 4a4dc58b866a..ac0605ac9d46 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -127,6 +127,8 @@ struct n_hdlc_buf_list {
  * @rx_buf_list: list of received frame buffers
  * @tx_free_buf_list: list unused transmit frame buffers
  * @rx_free_buf_list: list unused received frame buffers
+ * @write_work: work struct for deferred frame transmission
+ * @tty_for_write_work: pointer to tty instance used by the @write_work
  */
 struct n_hdlc {
 	bool			tbusy;
--
2.39.5

