Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50319259CAF
	for <linux-serial@vger.kernel.org>; Sat,  7 Jun 2025 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749264859; cv=none; b=sFrxQN/bf4pVjhmrIa/Nuh0EnnIs4YmVkmLKpejmyo2PxfI+6VZ65ulkHoRE3qkH7fvvMYTWw+vqTpSuRAPAokgzSkbGAxTJcsYRUiQzWhsa72LS3ok+F7dOxP0DDFgMfQHMTmNtLpzbYdp75aGOiPy1wC4saPaWQ7mGYsoVHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749264859; c=relaxed/simple;
	bh=9kLsFVdVHZC1/N9aRdTRVFrJ42xC1c+3yhppaJpMsio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFZ2TwnsZ12tvuLtUkYEr5uMdtz2OU0FUJoJf8KvmlVTc3Dax3LCkHqsM+GI6ZwgzXC5TwgPPu3ZJnmdb6ac5IdwdYMLRoHo8IKEnjpnMfhDORtcc/tdAbH7+SOCFiYCGMHXYnCXKTO9m4sDixMO7nCxhX0mqmz6cHHETQfQdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VzmvQCE2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VzmvQCE2"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so1615978f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 19:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264856; x=1749869656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blYZX9SALP3mKTtW5/j2PauIX7nPWCX8bAWtr1pxWl0=;
        b=VzmvQCE2peWp2L63NLmLKZMio1jAlZ9G1z+X6Ob6JvrVNq+IU9Cwqg2jED1w1JOvJB
         2aqLmrdFnNG3+k66uqjzG3kqbCE0xCPSl8ajEWvMmrcNMpTLYLoAQhmNIKeNrQl7i0sC
         0C54h12js4MVJElzAmPFzokO5BUswssMjV9Ih6n6ryBNVFMhocVlDa9ngIim5LAfatx2
         oiw7KyBob3rFqQ0HBCH0hne2LwiEngoKJiKnjnHyPRVmUozo05Fnz20p8Eb1Qx4cw9BZ
         eE03TyKPnAIu2PMBxkFdufbHwlvRXFUrj4U+/gQtQ4zG5p6FILCNtjiATM6yR/F+5Jcj
         Tssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264856; x=1749869656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blYZX9SALP3mKTtW5/j2PauIX7nPWCX8bAWtr1pxWl0=;
        b=l4S/FMjLZc229OQ9n/YY9PjGbWNGjACrqPHApgWuXNxntgMQBi17ekEPc1l5YY49As
         sVoN4+wTk94TW/1NWq29VCO+TbnwfARSXX/+XX+6LC5wZZVh39Dn4aSqMfDqdek9L/+h
         J3VmhLwWKQPVkemr20C138JCPX+EJNErB0eqepesVIA5JoJfS5zuMR5aHWwp/fz9lv8Q
         o9NQJc12CDt1xfiVX9ucpaO58yw78dTtV38TTJIPnJFXKXqc5gxCYwXpr1PVirF/hm9D
         ICqv33PT7Neotvjwwh+ONyJG//eRsjqL+gd8hM4OKqjxIy15CWnFHaGorYjDZQ6JFBRF
         3cmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE8uNQEwxUjRNVLeidOqO0ga+W/ZnPWJPhOzpTZr7Ac8Fur2oYAXB5JVHsT3YIUjdjMCDxN0OoztgGHWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoeLoGfZMbyIeiDWWSPRaqQqOrBWKMV1/3uj0O676rFRPW2KjJ
	Tq4x3ABFiwsS6o4AaL73ldASlFO5kF9Bln3xYwxGvgxBk9lrzleJHIccS2/P47VMGmo=
X-Gm-Gg: ASbGncuuD6erlexAMzS8L8nDhwuONEtR/SsFB7MpJbVBWxm6HbEWQS930Ggg6iRCMJG
	Vo4kYHYEIh9qubg433bLzhQqSYsuceETOU0cNFcd7S8YhZFOXmrfCKVyYY10wpVWp7xYLg/TS5c
	zKOzfrjtRaChdMDMxe4NpgWgEMTNSycz2yAD64tpo89J3evDeKwtMHiHy35FEb3zMU1ZI+ANWq9
	K4a3XrlElHjzVeos1xzBF5wvHjCoucxQoQRDe1DoG46pC8eSdKNLwJ3WQz1ld8O9NYCe8+A1GF2
	ertpFIPz2jvD0oqp4KUoKRPGdnp9sEfuPdfXkHEhIDXkI0DM
X-Google-Smtp-Source: AGHT+IHJ8LwIhaZRKIgzpbwHMvqzg7hdB3xBlwSSNm2xX/hnuxNAGse4PY3D/NNj8BudY/DwljmTRg==
X-Received: by 2002:a5d:584c:0:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3a531cec750mr4573998f8f.53.1749264855737;
        Fri, 06 Jun 2025 19:54:15 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:15 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:45 -0300
Subject: [PATCH 3/7] drivers: tty: Check CON_SUSPENDED instead of
 CON_ENABLED
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-3-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=849;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9kLsFVdVHZC1/N9aRdTRVFrJ42xC1c+3yhppaJpMsio=;
 b=V7C9sb6tGmba5WbbzCCzgvis2cX9AK+EeOcGSXwItak8TkY+K+TnnSUrBrbGp4mQBLXbhFXa1
 b5sMv8+wDMXDBlakfIx+M5fO23Lt7wo09cled0jB6DCtxtxEcDyqWTt
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

All consoles found on for_each_console are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ca9b7d7bad2b6807b29d3768bb655528ea162816..42f81573d8dfc668b38cd0b1c14962a7370cd954 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3570,7 +3570,7 @@ static ssize_t show_cons_active(struct device *dev,
 			continue;
 		if (!(c->flags & CON_NBCON) && !c->write)
 			continue;
-		if ((c->flags & CON_ENABLED) == 0)
+		if (c->flags & CON_SUSPENDED)
 			continue;
 		cs[i++] = c;
 		if (i >= ARRAY_SIZE(cs))

-- 
2.49.0

