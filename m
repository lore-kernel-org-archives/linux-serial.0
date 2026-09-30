Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D97448B9B
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754540; cv=none; b=K2F6B03dhZBMfuclUdQplCEVcOGJUPvIS2YiH48uYbor9O4cg+x1E8UxjFOc6j0li28YTSiZswNVENEdBWoz75IiKKriFEq4MhdBoslyKiw0Ah4t/4/PzJs7naGE1GSMrKww6Odm+IS1IHPDk1z/pFbeI/CEyZI/WbRzgwKpAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754540; c=relaxed/simple;
	bh=3w5BbDKPepU8mBMOX3dhCfOjjm8w0wlAQiggXHD5Vmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyTQdHMK2gS3+E4SwV8AWyuIeZRDOi63moghJ/0bVm805kG+S8l3WWVRq1LrW4+Cp5n6ejG+AcFJr0SnPAjh3+D9IDKzZHyZHPz+4Z9QL6s3kOI2ySSysTVhfz6hHZuMOaRjh6URGlu+/ZHzFgYlJ+XdrErhXskNGeCYY/IXdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omxj08JE; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omxj08JE"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2727108a12.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 00:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754534; x=1791359334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pV8LsaTP1EHfiM4Wd101Evv/UuZGOjLB8O3Pkph9NAU=;
        b=omxj08JEnqExWRadrfKRD3QoJ6F4Dpq0DD8hmeZYqC44KVa8pndlpPRzn8331Lq1JJ
         rukBevIlOA7GCch7qNd5kErB/UEw3EPLyJhoAekxeP/2+dusPVW0yBwaQK/RWSQgqkTc
         77MU9OKaMPQcgCyB73OFCG2xfxSExkGqMhZoIJdbLhdcd9jyUY/TS4dvSvTR70OYrkuM
         Wh1LGgwFvYhOM1invYUhiJCMoxU/PBCiORZ4c+Qga/yzJP07pcKjNJYl4qiKHOHubWX5
         TunmJEIkKtPWAwCVJHDko0YXvLbEHNmB2bQQq1SgpkzQIoEcVgXC1z3U9IfauaLER4eb
         o5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754534; x=1791359334;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pV8LsaTP1EHfiM4Wd101Evv/UuZGOjLB8O3Pkph9NAU=;
        b=PHLY5Bt7UUwUDx+9MYl3xt8h9Ggc4z6UJTR8Zyx7JjiH2Vm/g04aPhCe5+3WqaTPF/
         XFO3Ado2uSW0AWDdKt9wYhnn61QwVyOB22So1jdUGqH8qJKxkZ0+jRMktRpziFzQvr1Y
         NO+uW/BwVBdEkwUQNWZymCb5ECflXchcs5AbB+sjQ+R+tX6KefzhlLloz8nlFDXF3TjA
         hfWN3MIfrvQZFbRt1Riu47sCjaJTGQU/hF5Y56WwByO5jwiRZhVqWqIKXOg3G7atQigS
         kEATyuRJPeroo9nAtKqNUtTZQdQYuyjHPsj/XpsEka4RSnTS3MNpDUZEgfRlyMYKSkFm
         P++w==
X-Forwarded-Encrypted: i=1; AKwUvBwkAPI6AREf0EltjqyM0yv/8xsgm1j7zvMKoXHKTcCS+akA5ET8NKeCWGF82Rho9HsayKrnTZPYGekFthc=@vger.kernel.org
X-Gm-Message-State: AFuF++lc1ZoWHELjJH5eLMIazoupHuAL+frjRFQ3XAD0BYUOwTvasI9l
	1zpyJIOswTBVbId2myw4NI4iH3yQA7woYOzIM24j1eTcmBnGUDk4eG6K
X-Gm-Gg: AYBFou3G+5/YOiSMhyOERzsSWz0d1UzKymntMIlTUr9QRbOwaJ3gVizRdbQnCQkc/9j
	qZqU7ZlEYUEkkpri9fTtpFu+3XjJWX6crT7ePTH2mOTQx3fytd3Z/hFw9mdTO5elqgg+ipAyQPI
	y28aYaKBOblumPxDI3qZgv5c50Bype9AVeiDxuyOYZMyp2OV2sQ1/Wz9IrFJVhty9QdJsf0uXZJ
	msiLEenI/AjELRZv6s50hn1wqqhfUZl4+XXqyTJ3kkYpuyWbxKHVbaZN6Vag+aBJCGheeRkLpTr
	WkbAOa3ZDOqVwhmzX98WTvDdIU0Jq6DP1iMgNcL8QdP98ksPs/mkX2FjCSvP7Qxo4Zuu9Ih6eEP
	lluplHuF7X2dP3gKl/IRgXVavzSrLF0qinKoSQTnOZoWO/71xrCls1/uWxL3LAmxLUbKVvfHU8X
	HckLEzEo9Jy1wXvEJDp+LkL4zAID1rxlVjFDzCELsfNXR8zPLoW+LghQ0Hrj+pukG0fNI2Viow/
	mRiJ5AAtA7MtCJZVSb467CE+O4d8Xdwrs/o103Jx+gmzCSsSyL2nQVMMe5mg1sZ5AqHltm0bkoJ
	xfCKLVYeRw==
X-Received: by 2002:a05:6a21:7001:b0:3de:557e:5ea6 with SMTP id adf61e73a8af0-3de9e8093acmr677760637.27.1790754533970;
        Wed, 30 Sep 2026 00:48:53 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725881fa6sm376732b3a.27.2026.09.30.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:48:53 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v6 1/3] serial: 8250: fix deadlock in serial8250_register_ports()
Date: Wed, 30 Sep 2026 07:48:48 +0000
Message-ID: <20260930074850.465003-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930074850.465003-1-benquike@gmail.com>
References: <20260930074850.465003-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In serial8250_register_ports(), mutex_lock(&hash_mutex) is acquired while
holding spinlock_t serial_port_lock during IRQ chain registration:

  spin_lock_irqsave(&serial_port_lock, flags);
  mutex_lock(&hash_mutex);

Acquiring a sleeping mutex while holding a spinlock causes a
sleeping-while-atomic bug and potential deadlock.

Replace mutex_lock(&hash_mutex) with spin_lock_irqsave() in
serial8250_register_ports().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9e4f5a2a2eaa..f64a1b0a2eaa 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -102,9 +102,9 @@ static void serial8250_register_ports(struct uart_driver *drv,
 	struct uart_8250_port *up;

 	for (i = 0; i < nr; i++) {
-		up = &serial8250_ports[i];
+		up = &serial8250_ports[i];
 		up->port.dev = dev;
 	}
 }
