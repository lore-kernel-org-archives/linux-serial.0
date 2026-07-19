Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDDF233D9E
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499049; cv=none; b=Aw82wNbmw1eZFfhcz5ULq4+9St3KnWUo4bYKTXqcRDHB+tGQXSWVJirVK6ELoE5R/o+yKMbKPM8E05pOmRyg2hw0VcUFKz9NO+AmFqcY//Uw3e+BdxnfALFObbWa4nt485vnS4JaF45Yc6LHrwP0dLhF3p29YdXpQ6J5E5elWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499049; c=relaxed/simple;
	bh=xep+DbUTODAyiI61W5CCxIKqMCWLvMAtORFdzKJXX9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlQb+v4cMlFgb0wfiJtBHlOpdpwOpp+vNHRaxS29PlVSFQoONFWJ7UoCbvir8ecNVpGZyNysWab1yV3feyUDpC86ImrXbYoB/jFIc/1C2Pj/BWok+kZAGfJGF8TaWTcgrX21INKywLyAVydq3vuFUl+b7eU0MuY63WPjnowr0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qruG3Nyg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qruG3Nyg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f6de72faso21913245e9.0
        for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499047; x=1785103847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T7BUDbPgvu4uYiB0I4Tcu6S0zkTXWIU92UBF/zE/Z4w=;
        b=qruG3NygUeT3MwGKkZWDoY67KUpNkZjbNfUG/HakYPVTGOE0StN/UW1O0LSYcg/6a9
         8ZfS+lrz27UleaNUTfbV7XHyb7E8DQjAhjJ0w3FUtGdCWJBCoZOTIP8HpL5hD4Fuea6S
         TPMbLHmKBHwgde4pPMHgEmB/6ciCjpCf11vvf/f366DOAUqak70MJXMICVFFaKT5nLwh
         RiUgShY4q3N7rkGfOKVzw2mSUkuSrMnOM+lIeUgN3tvnHvZfmzSWrsqdI5RpXJURyFeC
         wB0gZopIStURMsgFrYmzHAtiYXS+qn+ELJiNsbH6ymAzUy4AiNPv16nNZML95yUFjDH6
         K0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499047; x=1785103847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7BUDbPgvu4uYiB0I4Tcu6S0zkTXWIU92UBF/zE/Z4w=;
        b=Gp26MDNuNusVDhpFDgYreVNtJalvOXoOqRRRl584XvKKBaBUMd+5WcGGBDJEngXgCW
         Lh6X+pKVaZeIOxQc7wFlTpCP1YNoegrXfUZWvMP6/Iwx3ict4pmcMJ4094VUgrMdSeBI
         CZfqC9hr1n3qlUqFgRIoBgeul6N3ZjDoK22ldBCdjYfX0CniC+yvQMkEWPN2MahXA2W+
         4G4NtUjzniQfeopXErFE+FbwJYdiuRsQe11z7Q5Fw6Je7TdLAwkrGIaKJ4wgVZwMnhTA
         uD1iIMtAsOhvB6ou3zWGOmNvPugxmqvXyZvTEWnr0W5MBRB77qLtvM2wG104qPITh3mj
         V+0A==
X-Forwarded-Encrypted: i=1; AHgh+RqHzoKddrjplmmKuv7BzaY088xN9sdTjGtgPcMn4qu2uwXVXmHokPNH0EeUScXPvONZEGVKlh7nKBKXJx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypnjRPtnFgOobEev5h9nSbxnEW4H5L9Rkbsb3O25ge+GVIXSb0
	rZyOD2agy0zdfdxlt4lN3hkUH/hj1/MIAtHzt5YKxo/OVLWWrMrY0Sxc
X-Gm-Gg: AfdE7ckyX5Nbt5Az3RgvqBCD6Rb/ZRxlNdDVNyLlPW2a/bLdR/jdx0/OYP2lj8lbu0U
	wXMd1kkKczqagaj9i7EsKtTMIGGvWrLAVDP9F85Gmc9Lhux8hTV6ir3LgeUmZS6gOFdVu/dvti3
	cbXFRys6k/R0bsk2lkzsLGTvLhStWDjGIY1yz1RNqLQhOEA7bSVzA0OaF41+i4q/dIn0N3+ETvc
	rK9ie2rKuvkFpaiCoHL8Zw/RG6QhEHiwrMotid9VyV920u627mUs8MYL5EgSgIUrpx1OQ40CnMU
	486PoRztom5xEDoMwethEoljg7LueYnG1GJCt6WfWOnPhb3E5Ncteh80P2oa0G+ZVLsha64aWx/
	+wjru9xkemgAHdSW8t5e3YDzwR+0g9Y9SHVLLqHNFjW2kyvg6dWaCe9u2MxZJLHpPihCilJKR9W
	t22MFgNUyKb3DVo4eiZNYmFKe2VaaPZNkrudLN/5X/k8kud6ihaunByf1Kuu7brDY6ptDVvfQDh
	j4lfpYd9Pes7zIQQ0Mv0aqU9HXRbSqmc7NB0Iwqa/GWq5ah5udfD/a64woJMRWwERAr6kh3cX36
	knxqiWvFtxr9Y6duJotgTDbv
X-Received: by 2002:a05:600d:8443:20b0:493:ecf5:89fd with SMTP id 5b1f17b1804b1-4954a341a2bmr91369185e9.17.1784499046380;
        Sun, 19 Jul 2026 15:10:46 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] tty: don't oops in tty_unregister_device() when no cdev is registered
Date: Mon, 20 Jul 2026 00:10:13 +0200
Message-Id: <20260719221014.44354-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719221014.44354-1-kmehltretter@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_core_add_one_port() keeps a uart_port when tty device registration
fails so setserial can still use it. It marks the port UPF_DEAD and
returns success. Removing the port later reaches tty_unregister_device(),
which unconditionally passes driver->cdevs[index] to cdev_del().

The slot does not always contain a live cdev. A serdev registration error
other than -ENODEV returns before tty_register_device_attr(), leaving the
slot NULL. If cdev_add() fails, tty_cdev_add() drops the cdev reference
but leaves the slot pointing at freed memory. The later cdev_del() is
therefore a NULL dereference or use-after-free.

The NULL path was reproduced with failslab during UART bind on qemu's
mcimx6ul-evk and raspi1ap boards:

  Unhandled fault: page domain fault (0x01b) at 0x00000038
  PC is at cdev_del+0x14/0x34

Clear the slot after cdev_add() fails and only call cdev_del() when it is
non-NULL. This makes a non-NULL slot mean that a live cdev is registered.

Fixes: c1a752ba2d6b ("tty: don't leak cdev in tty_cdev_add()")
Fixes: 8cde11b2baa1 ("tty/serdev: add serdev registration interface")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/tty_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03ff8..4889076b975f 100644
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
 
@@ -3305,7 +3307,7 @@ EXPORT_SYMBOL_GPL(tty_register_device_attr);
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	device_destroy(&tty_class, MKDEV(driver->major, driver->minor_start) + index);
-	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
+	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) && driver->cdevs[index]) {
 		cdev_del(driver->cdevs[index]);
 		driver->cdevs[index] = NULL;
 	}
-- 
2.53.0
