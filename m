Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE5366DAF
	for <linux-serial@vger.kernel.org>; Fri,  6 Mar 2026 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768467; cv=none; b=HbQzoehC1wYGymV5wwIMZu86oQ8BcZOkrWUrmm3kBnL//XO48yLcCTbitpN7BlsI4vHU2qjqzqSoaEi7bTW4tsaMTE7aeUo6VohyXkTKJO6M606a6AJB7BwUJlEbe0JstBysW1jU6kL2lUpYJVnZfFhGwPLTBmmr4ruUknZVGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768467; c=relaxed/simple;
	bh=o7fIf5OOycLC9qngUuRxTqt9gkAdOEzhp3E9nahQNQ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TxB+o0XrHbHGc91jAWypZ7phWb5sC1Bc/KlilQUMF/hPxZI4r6RLu/9AU6lC6IiQqq3WFkACNTI2v7i95jG7UXjktHW3cW2rwS4grualNBZ6nkZeYi215v4//X6/SdnK6s9OcuYBblY9kklN7iRbImrZhUBnl12MruahYlnCL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUNtFG5H; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUNtFG5H"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9419e561fcso139577666b.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Mar 2026 19:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772768464; x=1773373264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wglCAHOQz9caPuUxvse8NP45XIi3Vs8/MIsuXO4kGI=;
        b=kUNtFG5HNfJYHFuiXhSgQeX3auqxiZxYkJ57NjsR5KQnvsmnNvM0nPw09HUSDjQ5Tn
         Q2DC8ipd0gTYchIWq+N50HAC3ivoDCkyuSLxBoGPq23fT36j7ztsQOiw8hwmtn3hWusD
         Dqk6/zAqNkte719lcKCO9s60Gr9ODSuxg/XZW39xJmITWbBJLfjkevnV/bBEdxuxQPn9
         4t95lM6RwAZT4SB9inE6ZCNFjkkOze6agjzuxqnY4YDiqPVEpRwAaG5Dv9iovLEhwl+q
         WqyMo1WjUE8D8/7NAL2mjaXWohK2Nb7u5jcZK9HMZG6y6VhElzOVLDglpysuc8ZUdxe+
         H0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772768464; x=1773373264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wglCAHOQz9caPuUxvse8NP45XIi3Vs8/MIsuXO4kGI=;
        b=lm+5Ki15V0/zW4OwybbjI0Ym9+2MlnXrwpVptw0Vc/NJf/Uu+CtNBoMWxaPIci5QH1
         gUTwDAD3fpsP6omq5TDYFSQgLDBWizKLSSYT5J314I066NPgGUfA2vFJYkTwMYIWkATv
         mn3bGtM/A71D91XpXvqfx4rXGgyNUI0rdclxC7tqIQaTi9GIf96lLLqQfAIZVMg8NI37
         2N/p844oyPRAg0qQt83ygrDAMXtvE0Xz+dXiW9gDckULfzms1n2xNbQSvBL4Q9LM7kBn
         3qwk17vFnkwjmgKsqcbVBtaBWTDd2ylr49QKS4KHimGBPrD03TyzWapmPeDMnW1P/4fN
         cL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs+PNSZuvYg6IDcLGvhLWByN2Pu65vKnNu9fJaCASSkk7C8ytL9lyVCXGQowgL/tWAmemKaHYgZ7ROQKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwspLC2ajwL5C4ubLQlGggaLIGrrrkb83l+4F28RYWj6akeZ8xc
	secKmi3eWLquqjzKjI2ugWhDzfZBtyVr9DPOm20PPPnHrlB4gsDLjJlN
X-Gm-Gg: ATEYQzylcsmoYmRdh45jcdEGyX07x5VEKnZ4IgkDYNbNOrpkGiXu0YBQ36bIPSIs+7x
	OcMsvGPz3T4xjp22+3mMzTuDQ9hWpLt58OdKWQWfnM4bJVKHIwlWDkHw5JKMgcm3AIn+O3EpaMs
	ihk1WAUSvxWiKCpvW0X1Xp7i7K6C9meB+AJIgbMHmu+8SgGa/BoIqiEMNamzNadW6p3a/FLV2RH
	W9rMWOO+ChWhxHFF9k5iUggndomqK0fSSuKVGRAJXLXLS98by47kEgAxqBpHbnaPFXEhOJ/1/zt
	dy6GqZlBKls4Ys/d+epDeKTo87AviwDN+13cbrpskeZsV+JhvT5Da8DQ6+aLrXJOipqfW1bk5On
	Ix0gX7c5NXXJl8hGUW0tk9RUqqECivXuTtDVlbdtWKEQVwyvp4ZM8c5IHULL2E9JBslo8Cu9Bao
	KhoQ9DUYiQ/JcR/g==
X-Received: by 2002:a17:907:26cc:b0:b88:5ef6:17f4 with SMTP id a640c23a62f3a-b942df77fe2mr28205966b.17.1772768463919;
        Thu, 05 Mar 2026 19:41:03 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e27:2705::3e3:31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f13a3afsm14979066b.40.2026.03.05.19.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:41:03 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Stephen Blackheath <stephen@symmetric.co.nz>,
	Ben Martel <benm@symmetric.co.nz>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: ipwireless: fix memory leak in do_go_offline()
Date: Fri,  6 Mar 2026 11:40:58 +0800
Message-ID: <20260306034058.386747-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ppp_channel is allocated and registered in do_go_online(). But when
the channel is unregistered in do_go_offline(), the driver forgets to
release its memory. This leads to a memory leak each time the network
goes online and then offline.

Fix this by adding a kfree call after unregistering the channel.

Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/tty/ipwireless/network.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
index ad2c5157a018..ec0353c1005a 100644
--- a/drivers/tty/ipwireless/network.c
+++ b/drivers/tty/ipwireless/network.c
@@ -303,6 +303,7 @@ static void do_go_offline(struct work_struct *work_go_offline)
 		spin_unlock_irqrestore(&network->lock, flags);
 		mutex_unlock(&network->close_lock);
 		ppp_unregister_channel(channel);
+		kfree(channel);
 	} else {
 		spin_unlock_irqrestore(&network->lock, flags);
 		mutex_unlock(&network->close_lock);
-- 
2.43.0

