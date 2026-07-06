Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C58409613
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347779; cv=none; b=mLR1yD7Cx0+VnB3g6Qe2P3nZLUlRc3NbQJE0LKtNaTj5+rKb/ehyGdKuy1S8g+AyZR+00EqUtKLEUPEO+pF0SwMPfRu07GFfhaWJgsR4XLWRrKuoSaf69kqbV8YHLNugsjIHbQt01yP/5rcjUiYdbGnhfN2qDmcWbMfrz6rG734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347779; c=relaxed/simple;
	bh=51DL6vUaSM8TmihKlGAR/etMUqJeluAlQDsrzaP6524=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw10W7sWnUiiVdmCW0x3bHnQhExxNjnBYwlw/hLlPUf5FbUAObNZqdzyP81oNeArO/b5hqZQqHeJSc4glctjGEAxmN9KVe1lJiF85HxwD0hySw2esDFCwn+E+SHgclE6yTh5nxNC4PrC9HQ9QGAukVlF4UP2z5EKVkDc9U3CniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SuP48J2w; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SuP48J2w"
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward103a.mail.yandex.net (postfix) with ESMTPS id 1111E80793;
	Mon, 06 Jul 2026 17:22:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp) with ESMTPSA id jMISF7xgMW20-Rydkzxom;
	Mon, 06 Jul 2026 17:22:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783347767; bh=oKk14A1ZTuVHNr6e8AGFcy/8BgS4W1s72KepvmlqKfY=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=SuP48J2w1FtmlxR6SN4+SoQXg7oW3DUrZhRIatcPYrGV1zs8tEk6hZBYz0V0HGcP3
	 Er8YC+r8XMxxOoMnsYsrf0h8360pkniSuS8y3PxhTnJo9nFToalfxI1oNfXH60aBGl
	 RtD+R1XeBbf8fQ/M0tv9QNqal7YaK+G4EvQUYATc=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] tty: n_gsm: issue mutex_destroy() from gsm_dlci_free()
Date: Mon,  6 Jul 2026 17:20:16 +0300
Message-ID: <20260706142016.3385636-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706142016.3385636-1-dmantipov@yandex.ru>
References: <20260706142016.3385636-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although a no-op unless CONFIG_DEBUG_MUTEXES is enabled, add
missing call to 'mutex_destroy()' in 'gsm_dlci_free()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/tty/n_gsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ce447477ccf3..548470796374 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2698,6 +2698,7 @@ static void gsm_dlci_free(struct tty_port *port)
 	kfifo_free(&dlci->fifo);
 	while ((dlci->skb = skb_dequeue(&dlci->skb_list)))
 		dev_kfree_skb(dlci->skb);
+	mutex_destroy(&dlci->mutex);
 	kfree(dlci);
 }
 
-- 
2.55.0

