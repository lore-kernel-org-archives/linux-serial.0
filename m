Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14B470115
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521941; cv=none; b=qj6xmZmLo3fb7XhaTHkeg1ssevKpCmx+4L93xvgtHgPXGISwSgJSFmwPEnrlMs7H3ZckHNUsrue1QRmgf9yloiApnPxW6d8svCsV645FLwbYWGvo6QIWKfTAdvDNKRIfPOg6eQxah4KsM34i4JghUQ+z4PoNkIIFdwbCb3XVClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521941; c=relaxed/simple;
	bh=SJRRGxOTPHxzTyKNjhPZiDQLH8oJZ0bbZe6wvXlfvs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAaZfgY55Mamr/VTg83DMHoSrG8rY3/fu2dEMFOO10vVeNARpIgUulpSAju2/UmehLgunVs3aYWlgD6HXjVfVrpeJ+fQbHrAfO33keRG/UHSzgrgFehiOMGTpLmYHEGG8LBAnrm6zXbD+ImPmG3k84HUud+1haqasF8V3sTd5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwsWsvWc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwsWsvWc"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f703a9d05so863287f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521938; x=1786126738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ov0n2RcORghbpUiI0SclFJ455T7zBH3NXkUIJ9HOsqI=;
        b=SwsWsvWc4BBT4JDMWM+dkt721JDhd5755F7Lm/U8nHxlfV3kSeRs8K2cyipWxUrZHo
         8wf+Gn9hFbRp0N0iQqZ+uRUBP1ZXEr1JxHbepEY2VxPmgD7ZL2jkiU2ZI1eEFGt4DEuD
         Eh6s9ABxYFiXxe0aK7ybGNOi+K+Jn6MEhLspx4D1J299svFntBWIb4ZkAaua4xh0Z24y
         8CVSzMx6VPIGA8JMGJOQ4YXn/86IMy0XLrsphXN6NTQz6YenTQXXwtrgVCAnJTsbfw46
         yGvbRRWSfkCU9KVXZyigxWOB6V//RRf/BZ5o2RZelc7GZbplN9v3TE8OvweC1MXdQN43
         a5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521938; x=1786126738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ov0n2RcORghbpUiI0SclFJ455T7zBH3NXkUIJ9HOsqI=;
        b=GWFPlsaBod9NT2fc4akfxsRaaDlNe6yd7uNERdf4l6ombGaGJHYSClGscnAy9ROJ+q
         KyWYMIaLn0JKwlPTDwnTzco14BkmhUc5suoOYxuVbbvByZU8uyg9xyluDG89gawtEirJ
         MSkWAddu79iKKfUV8W9Lfx5WqsoG8uJeBHZAXTyWuLHiP11EqTa2AvqXp4JsITSjFG5+
         bXw0xXD1KQ3US84YW4GAeoxU5pQOyxnhNEhLzP47fvz7gAe4MWm1VzHCOSYd3rD/m6lJ
         cPYDx+O8xOWMQkF8w30LiPvEZlKSorZ0tkGnVXEEzaeCNLGvtjfFiWzsfuT7VsnkGlLX
         sVzg==
X-Forwarded-Encrypted: i=1; AHgh+RqJz/zllu120x3AV8x2KVYe+oqFVJjqVRqKGB+2hEthA/JN+pL8i6X4AQGduTyHb2PPL7JDDvotU0zpGGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbl52woWihZVxj38MMr1WY6K5Gbc7JLX98x8hkoW+Rs7i3dNW0
	jzJukrseaD0mRpOm0wfU7ojDHlpiNl7GZskSpINiU/dGw4j/nuFnNZzg
X-Gm-Gg: AR+sD11AMd7T/19n+YNX+Jhw5v40PNG+F/YWvVaqrNFL2/SJ2mS429BgXAlcja+jVkX
	hfFPoY5EZ9ZekZKmWUelmaxjgY6mryEmoUkWkAdDhx2Ki+r9M/I3f+wBaxmqOyUlycYHYKQa52O
	v2zkfGlhlkTr4LAhmCHpLVo764x2qIzf8+ojqXZt2IoAsnfHjkiuAozouZnKgXurZ9ezkCJsEem
	g5kkJwMmzVwDdoW8o+e9e+9a8O1/hVs/JNZva3n4a/4ktk0tTYwzc/IqirXneC4T4Bt2fnnOAlL
	BRiewxRPSo5jWSnls3za6Cr0RBE/8/0OxXFiixDgExqOrtC/3nvffJ1ymOo7asA1OF3+zhY6MWf
	ZqZQzshhHGGGPp25Pb5IE44KqOmiW+0g7jrrUh/MxrXYLenyRv09x1rCibaFw7RpwAFULBm9qcM
	KR2IoGkaKQtMwgzryVU9eQcTD/0PXKwal6rK1CtEsDNf39hDv3snIZC1+Dgwwa6/75TKGzxR8Wf
	lKdHZEKLLqaGwUOrX221sqShMy2eNrO6Nlw+myBEz+At1y4gMQH55d4sZHgtUMiEZ5Yit6dKgwM
	01MFITWcBxgm+YT+yVWaWhJA0ADXFrS4kGQlvCqO1P/J7Dm0w6DAvwsn+lyi+urG2JV7
X-Received: by 2002:a05:6000:40c9:b0:475:f0f0:9ec9 with SMTP id ffacd0b85a97d-47fd732cfdcmr1364879f8f.52.1785521938332;
        Fri, 31 Jul 2026 11:18:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm7293694f8f.4.2026.07.31.11.18.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:18:56 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] tty: clear cdev pointer after cdev_add() failure
Date: Fri, 31 Jul 2026 20:18:43 +0200
Message-Id: <20260731181844.11330-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260731181844.11330-1-kmehltretter@gmail.com>
References: <20260731181844.11330-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_cdev_add() drops the cdev reference when cdev_add() fails, but
leaves driver->cdevs[index] pointing to freed memory.
tty_unregister_device() later passes that stale pointer to cdev_del(),
causing a use-after-free.

Clear the slot after dropping the reference.

Fixes: c1a752ba2d6b ("tty: don't leak cdev in tty_cdev_add()")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/tty_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e742bf9d8631..4889076b975f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3167,8 +3167,10 @@ static int tty_cdev_add(struct tty_driver *driver, dev_t dev,
 	driver->cdevs[index]->ops = &tty_fops;
 	driver->cdevs[index]->owner = driver->owner;
 	err = cdev_add(driver->cdevs[index], dev, count);
-	if (err)
+	if (err) {
 		kobject_put(&driver->cdevs[index]->kobj);
+		driver->cdevs[index] = NULL;
+	}
 	return err;
 }
 
-- 
2.53.0
