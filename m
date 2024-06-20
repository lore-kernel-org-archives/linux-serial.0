Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BF1C8FC2;
	Thu, 20 Jun 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906293; cv=none; b=Ogn7gefBpvloN5p+3JvAjcRoIjDAzqVkE1HTxD5bOogckt73P2GGXYoPJ1gdIAGjiJ5R/c6D9R1aU6kEzhP+MxV3NAquX95Kpkumr1AXpZ2CFLaQpisdkgawpce1WIOk5ncRDyws97qJSqnLiETJbvBjTPDl6VWQ7aW0JsBBq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906293; c=relaxed/simple;
	bh=uWAIPWK/y5sntscGmoFoKf1TBYYoJ8omzWsjZLwiJ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMsT9j0AA23Ul7nmlIXG0W8yV/H4uzPchlIwcyoNgwXVzDeohjTouePGlTyJp27h9UWoXTrQEAyEOIrpKh8oS1SsjBmXepvIIp0hx6P5cZ7qWo2KAHmCOI05Tsh+9DBwsz7VuFCcbaf21wSfXldOLd2J1OGwGmX5aDP8WpB/bX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAhWVB/Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAhWVB/Z"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f47f07acd3so9491225ad.0;
        Thu, 20 Jun 2024 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906292; x=1719511092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5EYjko3sqn/5zVhVGKhFedN1WIYjrNTNEVk8UsUCrQ=;
        b=WAhWVB/ZT6IY+ZWG8oL8+CIyjjKosAXvkrRyugjSHoH1BHk9YtZEZPsiLilvQr6w2Z
         XwtHjwY5w0b+2ZscCIXtImQOOj0CYFaudCB+XjlUSoHsb7UQ+H716thQ5H1Bv7fEtACb
         c5JxMkb4eDYpe6BYge/8TFBYxnylb3+j7JF4iTbkkOcgPsO+og3dPBOkrQYlMKEpeedD
         WopWSIRPxWy12EgnY2PJ2mc7zwIh16JjDE6QibYDvcw8IW3lwe8mVk/VBC4YPzdMVopP
         yVNwwhWAVmrwe4ML1DMt2bmFCFgK8YbxcrWR0LeYaboT5tuuwJdmtSTOnKZMMS8bfWyn
         PXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906292; x=1719511092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5EYjko3sqn/5zVhVGKhFedN1WIYjrNTNEVk8UsUCrQ=;
        b=fMqLPm5BGaSLmNIDeG3czmU807P+0eyDol8VJBBdRJltVbK9JwU71qjwuEDqJkPGu3
         rz+SzQpVV/vlR17KydOjuQsWgvbS0QswGqL0pFrsM6hTGJauepPgfG1jP8SyR5hMdVcd
         tNW0MOiMc/gV8WPiBBgonNaKczqn0GCNbKONWhVyhci+vTUa6ppGLfqs4d54ClIpijQ1
         bWl4sOWpoebl0AQI3yJCVT4tO2kKQfD1OW6YIsksKgfOIBMzytCopfH0kr4a8udbJfvO
         eKI+aAIh7zbHEzvj3+yCwS4KS4lAlbI5pQNUQWjC5jzY27d0Klp/QHIt/+EDx0WfGziZ
         6aNg==
X-Forwarded-Encrypted: i=1; AJvYcCV9gviVYfGj3S646ETF3OPGGg0rJKiQ53HnPogER/QyOrTrHOQemMddo2jdfMct7s+KBtj7ANghzrCcHDm94f3Z0tIQ6iiWxONySjVe
X-Gm-Message-State: AOJu0Ywx9cu+A2B5PbAF17NVFZBpIsJUVwaxNbIHgMMU4h93fd9ds1f8
	3/egk1xfO8qiy1SXjNohmXNgDELI8sssRNmh5KIOwVNWXDFJUlPpvO/0vCROS6w=
X-Google-Smtp-Source: AGHT+IGNZgfeQC5tH36QJE9gcJwoghUtuEwxnBd7Pq0D1sgVZTvkF9LD2b5agbKQAwWjRSTyP3W0ow==
X-Received: by 2002:a17:902:e88a:b0:1f7:4021:508a with SMTP id d9443c01a7336-1f9aa3e8931mr78300105ad.33.1718906291691;
        Thu, 20 Jun 2024 10:58:11 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f85bf28552sm136016905ad.132.2024.06.20.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:11 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 22/40] tty: nozomi: optimize interrupt_handler()
Date: Thu, 20 Jun 2024 10:56:45 -0700
Message-ID: <20240620175703.605111-23-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the exit path of interrupt_handler(), dc->flip map is traversed bit
by bit to find and clear set bits and call tty_flip_buffer_push() for
corresponding ports.

Simplify it by using for_each_test_and_clear_bit(), as it skips already
clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/tty/nozomi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index e28a921c1637..2fe063190867 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -28,6 +28,7 @@
 /* Enable this to have a lot of debug printouts */
 #define DEBUG
 
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1201,9 +1202,8 @@ static irqreturn_t interrupt_handler(int irq, void *dev_id)
 exit_handler:
 	spin_unlock(&dc->spin_mutex);
 
-	for (a = 0; a < NOZOMI_MAX_PORTS; a++)
-		if (test_and_clear_bit(a, &dc->flip))
-			tty_flip_buffer_push(&dc->port[a].port);
+	for_each_test_and_clear_bit(a, &dc->flip, NOZOMI_MAX_PORTS)
+		tty_flip_buffer_push(&dc->port[a].port);
 
 	return IRQ_HANDLED;
 none:
-- 
2.43.0

