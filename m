Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BA2F1FED
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434010; cv=none; b=ZHJTUEY8GUY5mqIFo0YrFQ83U9DjPukhXGIYJLJ2drMkNwULv1tXj9PIxpcslu6cxSrteKtbasvE9lMHbUaeXbVdwooIEvIn57lktPfkFP+6pjEBqH56SP/yJtLCaB7KKkPxnTviekL6EMJsfGvjpup9GGcvXxNY7I7tYUd+F6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434010; c=relaxed/simple;
	bh=qlgJnVNJnJoSBLr05eULVqVezSxg7LvXVVWvg2QlTUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmkDbR34OxnNZ7SKzChw+ezGItGDm5u2o3r2fUU77KZciE4pcAF+7xpiYVMbIluSZXugPBfiZupfBkUchGijeAjsam1J34fQd5k1ajbNPoK53Nt8WgQGJXxjRpIwvLVRr7dKkI7aJg12yNFUUxUE6k3+5VKUhfonP3vFZEwzF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqcMNKxC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqcMNKxC"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-530ea5dafd4so32273921cf.1
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434008; x=1790038808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y4EOq0mriYCuSqS30PzcXKU3cp8OOqJ/M9Nu6QAqqPk=;
        b=RqcMNKxCn0U5dhNFHaOsM5me8NtmkMVOOruZx9BhY3AS0kTV6fv7V5CGt2ZWxY/sZq
         V8DNz30USFiIZIlP/q+FKBrLA5MebozEUz6NlXJCYJkyBmjqksXRMMZKsui+ud7vAPHS
         UPRPasW3fd6NeFVRoQkFPfp7CLdILEH7pHjjzkTqLXer+AyywcTRpzj5Ndgd3cjIsBMP
         s9TexaiszmOwkoLav9nRqNUOpRCqapzH9loAiXVOqF3UK6hSv5FDbHNPZVdYSnjHbNNF
         UWZAICBiV+CCFID9WK1OLyB8b6bY/5NGj7oCivvYk+lU4qawZDRx4GnYs47PJcCUJIfu
         FROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434008; x=1790038808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y4EOq0mriYCuSqS30PzcXKU3cp8OOqJ/M9Nu6QAqqPk=;
        b=zjNLgcyBW1sp13BX2Hl5CCZww1p6PKjfQ/4jm+gQqjCMQn0Gnk9qYfQLbRPboEdq8H
         5IRdizLY0BhlNWthAzTtEirdZTfYu6qtg4lZoyBn+IajKoEwKmTEkeMtDyiVdkz0jt2X
         L83FzxkI+m23lvO2rfXdKlVO/Q3zroaFoxsgdGKw2Wk+oJA0FfiDsxzcE2Dzg2TMVXYd
         IzmjvJLms8OejAt2mKuAVPZtkzwTVzPG08icwMIAEPi/Av6i5HcUMSnmC/cPFEoT8v+3
         UwGvKlbwp2YdIVv+PsbvYKOwP3PJ0deseKELuGS46mGJ74RbMkafn1JAMX/I9k30sj06
         DhQA==
X-Gm-Message-State: AFuF++lNtcPwdB5T6UlLa4sxtKeMkMOKi0o4PTY+fboUsbDrYaxX3i8V
	JijYrlNMyj5kLvEqykBLTHWBHkm0e5FKSxk3pRfojMJ4DamonqZoohE=
X-Gm-Gg: AYBFou33ePhNrQKoIOtIjd0T/mPWpMlSnaFXM9MNyd5+hKBWwuB41mf7XqrJ8xGv/vn
	sDhGfSuZvczDtljUc4A8o0Yo+5wIAcexsyYg/iWFMusTcwcbq3ax8uIxv9Hhkv6A/iwmrxKJRVh
	YPR0khzJbKTnUWbe+cua4NxHLR1Rz1aF8CyVO2nU3IZjacWGuhVchhxFZmx7Om64HYuaFAWAdkD
	xBdF0WQgpfh3JzXWC7GFOneBnla5xAANgP+7yBgK4BHoSB/S06Wiqq6cvWUiVEQNGxS2KfuZDuu
	SwXH1sPMJspyEfZa7kRxULb13cWH6+rXYg+GGCzcJpb6hEqGyy4qZilBx/O6kb+/Q0lvBZsuT3e
	esYbis5aedtJ1PiDgWAGyFICZa71OBEaUvgzqYgzLoNuLwnxMCsHGQ0IEU6CDvh1O4WGHn+y/dW
	pJaHlP7pQKsPYqxkJk6aFvuHENIF6VYBpm+l1u6kmCGXKfnTkUQOKITKZB/Z5OaXLD/uMCeDsHi
	qf4iCqKF5sthHvUZeLzvZDHwf63aWTx+u85PRgl+UxBLPA3PR9CYxI57ya9yp3DkBydvMGCT8zq
	jr08xUpIrCAWnyDo0tn1HfSCr+JTFb5bbKw75BYhkUyCxVnvTKJE9HzFsUJjm+OQlSrbvzuLxn0
	84qim
X-Received: by 2002:ac8:7c49:0:b0:51c:6b6:9d0b with SMTP id d75a77b69052e-5310cf168bfmr75785851cf.2.1789434007725;
        Mon, 14 Sep 2026 18:00:07 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53112de74a4sm22931071cf.14.2026.09.14.18.00.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:00:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: icom: Disable the PCI device on final adapter release
Date: Mon, 14 Sep 2026 20:59:59 -0400
Message-ID: <20260915010000.52974-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

icom_probe() enables the PCI device, but the final adapter release
never disables it. Balance the enable after releasing the IRQ, mapping
and PCI regions, while the adapter's PCI device pointer is still valid.

The imbalance is already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/serial/icom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1691,6 +1691,7 @@ static void icom_kref_release(struct kref *kref)
 	free_irq(icom_adapter->pci_dev->irq, (void *) icom_adapter);
 	iounmap(icom_adapter->base_addr);
 	pci_release_regions(icom_adapter->pci_dev);
+	pci_disable_device(icom_adapter->pci_dev);
 	icom_free_adapter(icom_adapter);
 }
 
