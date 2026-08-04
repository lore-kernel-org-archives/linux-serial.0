Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA02448D0D
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833915; cv=none; b=mdMhQGltnQlU9xd2UXpUDdyYguODLTs1KSJ5wf0xR4z3JpRzNkzDuNPjRTzRUP9EVbb72dO5euaxZQaHSlK4dIMcavryW/3cXGTDorCBvHqI9v+QN5wIizKAuDxb4OUgTG3sHfXZ9b6pr5plLyF6UN9Vgrg0/eENf19wmia96/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833915; c=relaxed/simple;
	bh=4ZcQn3LfgqwKMW2oGA9kk9dNfQk3j0ydJIkghJZY6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clv/8BqsvKL+WV9SjY1yxG/sgqDYtQPfzxTg8u+w8scyAuaZP0GLHJe4VYg6u+pMCgdJPD0wllja15qO1lO+RwDDVXh0VYfOO7867ZheCq1nDUpPcBVxz/9gZZn56oVRUCUgt3DBN0LvcKcMRVkGAvnfEKzi10T/14RFs3M9ytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lzEygS1e; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lzEygS1e"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso3122243f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833912; x=1786438712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MWBmS5cTt45eJ4D/3lj9BdWfjH07q+yrYeANLUmkgcg=;
        b=lzEygS1eHw5GW7H7YqZPAbGMbog/9NAHxrMC9ltbQqlDODSGPfeijFjaV8UlHyHNLM
         JvulmIYz+iTIU19JiOs4s/JO1N72kQVtkTDDOk8TLXNL1sZAcijD1Ckgab2IAA2E6kri
         bT50oIKDZP43u1V24UBtldC1EfXCBS6gifDJbeYnOzKL6RnVEmrFGSZf1YRee5z//fp+
         REB61c3F20sgCIJVlbXRi64XpiEP579/QoLhaRml+WnCHyK9b7wL13CzIqlk5JZrFcfK
         D58lYETMIJKN888TJEtWoQfoyGcDRbq/2ARWNa+GaNrQuTRFT4+SsfWOOzpAtF0lpRvz
         6QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833912; x=1786438712;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWBmS5cTt45eJ4D/3lj9BdWfjH07q+yrYeANLUmkgcg=;
        b=PGRbm0dBTHb05rSaVElIjQI7gsgSymSK+BnqmIFXarKmrDwkVMXx3sQf7huJUincZW
         eMiwZp/P80GQTnI4drdOsVKNhAa6xilCHDYywNSklo/IyBTg5gwnCSYdcvlwvZ6Dxj/W
         vwknSDkUykiS5tHjmAVwi53/ZHNFOQ4ZECVbEBxSlSnHZZbqzG1rFI951Ya8HYpzhj75
         01QTauwSKRRZCgr1hyHhEhCSiL+zeGnshpkpY4LTIAsQfdGFSERfrdMsAspjUa0NE1C8
         qTj6c9LiupYeMJpIPa/2zgCrGKpD+TAG1V/FkYt98KdGnSEWjI97R23VCdzj1+CFknna
         Hd+w==
X-Forwarded-Encrypted: i=1; AHgh+RqqJuFbEhrnoiz/PDyKkrML1NGuyfvu5tYqXrufXsJI/G43RVnPoUqcKC/WSQPNMBWTUYuBdNgM23qeacM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwxzxX6AgJHvnmjObBAK9/zQfN9fDc8lI1S8bIFdTx16MalqL
	lE8ZuWDeJViadunamJYAjkNw/+bOHT7H4yPQyYY7pihco5ssAu3CgZDnL360OpmOhTg=
X-Gm-Gg: AR+sD11+2zyBbVFR20sf2BcsCJCFdHIv3ccEZ+oS3JX8ZuNQZX+x5HoqoQWJYMCPMTW
	njbUhvDPhnqlA0YjqnRHd2ENcHdJ6Whiseh6FrRkLloVJZ+1ExR0VcAs3zxbqP7k8XSvH0O1AMn
	tXen2jfF6zIhWIp5ENzgBZ9kqL2T+utfAOJlOYxkGpb90vASv+PNVlLvmW8SxIlrl2aGHLFTLUS
	ixZvlKihK6lHcJipwVbEpI3+c/RghzgYDDDSkqTPj+/YFZamkn2PGh/X22aqJ2HA1gsj9v7sFZb
	pC73vg369DnEU2bDOr+lSDpuNkowd2c79Kk0hnW9q303sjiMf9wwaBBjEIsN8U8aEEneoEb41CP
	nQNj4KarEO1J42ayOVokFrdpDX4MEJ6XoHaYU2KPR2B2umHppo8jhukscnno2SrW2BEai2FoP8X
	3u2Wv7+15tdPVOVT5GXefjlicvl8wgoj3C/RJrXYfmue2kyUNvLLKNNWyhF4nP/HvjEy2qt9Q5B
	1px1//b642Ym216VKgXqPHirs9T0ZZu5kzAgVU9mSIKkwfAix7O
X-Received: by 2002:a05:6000:430b:b0:47f:e748:3ae3 with SMTP id ffacd0b85a97d-47fe7483af2mr11690155f8f.3.1785833911939;
        Tue, 04 Aug 2026 01:58:31 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd41cfde0sm38583143f8f.3.2026.08.04.01.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 5/8] serial: 8250: Simplify serial8250_match_port()
Date: Tue,  4 Aug 2026 10:57:57 +0200
Message-ID:  <ffdccf0570be9c48736e117dcb554e48e658cbb0.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4ZcQn3LfgqwKMW2oGA9kk9dNfQk3j0ydJIkghJZY6DA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcameFoy48mkKoeGa80zaohBP07PLUzBvofZGW fn8TT6eKNGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGpngAKCRCPgPtYfRL+ TotoCACNgu9JChPIr2zQjWl6/f2lRrkS+2R2NMUa7sjDZIRHGUsP/C/dp5ULGHOkyBLm+WVHGSf HTDByT7+s4X628jqX0BAO+bCbmJZce6qEpkxo6GsJKnbpsanRFoxcQhM+LGmw04LWGNjqOBepWL ByT7VpeOJPgbFyvMKEU5gXzEKOAfbq6DIM6r7jBN8I5R2JEyBxWZFNgYL9yt54t8DZSpEgrz0iw poLnjs07T9MquHCGjh4SgJzQ71n+exsKzzTcwzgOlXJzCpFuwdG59MxMunXobZM2lpm3n9T5oOp BSE//qyXgM7sbI4yxVbHAD3rZ8Lpax1rOK9eCjhDBLW+fnh6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For 8250 devices .iotype is never UPIO_BUS, so drop the respective if
branch.

Suggested-by: Hugo Villeneuve <hugo@hugovil.com>
Link: https://lore.kernel.org/linux-serial/20260803152228.9e3cd296a41e68304b82a22a@hugovil.com
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 3e53ef54ad7d..f113f8d5d158 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -649,8 +649,6 @@ static bool serial8250_match_port(const struct uart_port *port1,
 		return hub6_match_port(port1, port2);
 	else if (uart_iotype_mmio(port1->iotype))
 		return port1->mapbase == port2->mapbase;
-	else if (port1->iotype == UPIO_BUS)
-		return true;
 	else
 		return false;
 }
-- 
2.55.0.11.g153666a7d9bb

