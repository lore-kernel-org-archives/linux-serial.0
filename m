Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0F20D4FF
	for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845844; cv=none; b=rVlK4QAdcnmFW5+QzcuPve9kZyaB+FC7j/c3fRyr5+uKgwZB7Q3cihh4D+ZuMfGEYO5HNfzE2HPPyyvVYHXhhON/K3EJNeg6JBA7is41eN+4JAZFmfoEk3Lch3yv8B9L1JJ942TYPIqI2bW02sEC5UbemdvZKoJ8SwmMsinsW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845844; c=relaxed/simple;
	bh=Zy7ASpqhFt5c+INfQRNFAal3t298cDaPiH4RumhTKTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNlc1SKsdCL7yy5HEmBYG5TN6G3kdk7SVTvQpOk4ll7u5HEMJrPRG9UtM05xuFkmU6h2QSatq41icpvhyB9nNRLrVlkgH5sibE0vu0Pt8w7zz+N0bB1z64BgeUy1QUYrEibL4TrJxc43TgX3bkG4WyW+Ay06NHekpRtS6kz6460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqkx4KAS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqkx4KAS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e2406so8552465e9.1
        for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789845841; x=1790450641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8VITylu1cym2OHkrOqz+VmhrGBWx+8zb7FdhaZzSZCQ=;
        b=eqkx4KAScUMwDBSTbTemYTsTVLtFSLogB+L+4euztImj/ane+s7h0JVhKN06RA4IQK
         410p34af8oKIHO5EVQy2Duze12Rm4+rtoH4CmCjzG292mqe+8Dfj9P/E98dvXz0+2Mrj
         k9bLcLrI3Hc1LBkB1LKFhTBS1DVnKNl/f8laBPdGnHBZIazUIzHO41QEI/BbVKC8U2nx
         I0X3vZLCIP9g1TDXuWKwWo6wwvv03QmFkBKhw+SNKtaQAFBHgXLNYk62dl0Xnz6qEanm
         vOM4Hyk9YI4VGVQj1V+vGPtjLuSjM/rFPQ/6Smi6FvHRbNrpWi/Bu8zzo5FpPiLeiUn/
         432Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845841; x=1790450641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8VITylu1cym2OHkrOqz+VmhrGBWx+8zb7FdhaZzSZCQ=;
        b=oKLuJZli7xzxlpxYlFN6w8ZBVPjQzNMvyFx+s2s2w0oarxBzIyAwc5SwnZibFJGTIo
         VsnSdqOvpGuAuh5eSLsmXGeLFPxGnKddzdDrtOmFR9iNL+brKXuW0vkccOfnnfoXVqv7
         3aB/0JaxV1joh3BovkNQYQwiN+3dI+mjKPa3IQNHYoyV1kUSrvZvi0/ostziml2S4Ceo
         ztONBdPYyZ2fOlD6bGUlOdsaFaClndJGsBK04recC3kD5+Q5VswE9mIn8DrQKeXI5tsx
         Ivi/GTvXLmj9c0jGKAZukKVIch0hb7a1aky8x/9B8ZF+BGeHrju4ol83N8CYXgwAfqte
         yk+g==
X-Forwarded-Encrypted: i=1; AKwUvBygC48Jyyp34Fl0G+9DuD9Tg102rap7z36DO8GD1TZAbrzYkdM2877jBBRnUJ90zFgbMH6Kwb7NyTLh/ak=@vger.kernel.org
X-Gm-Message-State: AFuF++kDi5EXJvvmsxAF0k+q1ijMVbe0izTQgeGoJS+lafzRZuq7ZibU
	N5xk36mEZkEfgEHOYR3TcMGvuCEnjBPXg3y6EvuetRTcvvBgAIQhdBZz
X-Gm-Gg: AYBFou0i/iqNTnZJgRZID5pmBH1/L3PiFiB2vd3ZwLjlG4p31c0NHESTRKxfLRvYc2T
	aYJmtR9gpd8UQZ/K1iQSe1kqgqdC7o0xZ0coQIyhryOcWN3hWb3cIb5RRheByF0nCAgX7oL5cYg
	xeCYIMN9NWm7YmJFCd2zP3zXT1RUZ8ohaUaoRWqBKicd++Ui+XAsw8q5q+hOhIGDNCaQxzWS955
	cWhkjx/7/Lz6fdcGwoyjQulI4L52/8ACqGGw7tJFKJCk0OSEg6b/NsaAN95cMNb/OQlowyshNxx
	XgXR/hjWpe1v9/bkPHNzpwQ04KdYwpPnc/tNAXzMAvSgDCIWUSBD42PpPNB9xci7NEKg8v+JFnF
	QtoK1xVPIHeuJDAdzmE4YBO28qfh31CBUVFUkOtKIR5rmtH8gMygU8lnYtF+1x/O+puoEw8Sw1j
	NcEsQcAVhkGzVTmDc+pZ0P5swpKTrjjjEM1IIbmaxg5OdaRLbjJTZ7RYkAcRkynHtjZYPmWTP8Z
	I/s5N0+d6DUk6VCEyZwF6lfUCyqUUFQtrjDXzDYsfrjZr2ZoGS/
X-Received: by 2002:a05:600c:83c9:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49fc4ff402cmr91842905e9.10.1789845841098;
        Sat, 19 Sep 2026 12:24:01 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f7e05sm100096265e9.4.2026.09.19.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:24:00 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	fseidel@suse.de,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] tty: nozomi: lock tty_icount reads against the IRQ update path
Date: Sun, 20 Sep 2026 00:23:49 +0500
Message-ID: <20260919192349.272409-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_flow_control() updates port->tty_icount.{cts,dsr,rng,dcd}
while interrupt_handler() holds dc->spin_mutex, but ntty_tiocgicount()
and the TIOCMIWAIT snapshot/compare loop in ntty_ioctl()/
ntty_cflags_changed() read the same multi-field struct with no lock
at all. A concurrent update can be observed mid-copy, and KCSAN flags
the unlocked access.

Add ntty_get_icount() to snapshot port->tty_icount under
dc->spin_mutex and use it at all three read sites, matching the lock
already used on the update side.

Fixes: 20fd1e3bea55 ("nozomi driver")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/tty/nozomi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index ed99dbc9f990..4b2e224c0aa2 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1671,10 +1671,23 @@ static int ntty_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
+static struct async_icount ntty_get_icount(struct port *port)
+{
+	struct nozomi *dc = port->dc;
+	struct async_icount cnow;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dc->spin_mutex, flags);
+	cnow = port->tty_icount;
+	spin_unlock_irqrestore(&dc->spin_mutex, flags);
+
+	return cnow;
+}
+
 static int ntty_cflags_changed(struct port *port, unsigned long flags,
 		struct async_icount *cprev)
 {
-	const struct async_icount cnow = port->tty_icount;
+	const struct async_icount cnow = ntty_get_icount(port);
 	int ret;
 
 	ret = ((flags & TIOCM_RNG) && (cnow.rng != cprev->rng))
@@ -1691,7 +1704,7 @@ static int ntty_tiocgicount(struct tty_struct *tty,
 				struct serial_icounter_struct *icount)
 {
 	struct port *port = tty->driver_data;
-	const struct async_icount cnow = port->tty_icount;
+	const struct async_icount cnow = ntty_get_icount(port);
 
 	icount->cts = cnow.cts;
 	icount->dsr = cnow.dsr;
@@ -1715,7 +1728,7 @@ static int ntty_ioctl(struct tty_struct *tty,
 
 	switch (cmd) {
 	case TIOCMIWAIT: {
-		struct async_icount cprev = port->tty_icount;
+		struct async_icount cprev = ntty_get_icount(port);
 
 		rval = wait_event_interruptible(port->tty_wait,
 				ntty_cflags_changed(port, arg, &cprev));
-- 
2.55.0

