Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A851BDABB
	for <linux-serial@vger.kernel.org>; Thu,  1 Aug 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534407; cv=none; b=Ruz10Cb3aAnD7C7bLmoZkflP0CS//b7mfrRJobvM0nY/mK/N1JqfVzWMxG/9DljZ7Xh6u04JJMhgRU+Ui/UDzly3J+WHhSOcF1mYCjGG4wCh1QPBN4fuvwEkKUT7Oitdtv+Sz/J2wCekHjjHwRhjVquKrH4dXH9ruF22e6L0tb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534407; c=relaxed/simple;
	bh=4GexEWYmB++TVKtf95ojSGSSevwi4ufn2RVpQzXAHG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bhc8Th6tasNFLupZXxh1/uBuib9HWHM4qzOeCTRDcKsa0gFxMDfQ0qSC60DDwrlzoNq0JjxtaEH1CUTlrmksS3xCJhKe2YwBHu9qClKmjRa22k70gyyu8vPl7Dc8hgraed1Gq+MMJl/txEw98F2tbFw6CSwNwE17fLB2Gqkg7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGxthnr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGxthnr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5hpd+G0LExVaxl+UI//CFwTq02L8uYAsSV7qLlWbdA=;
	b=IGxthnr95n5stNJiIORDU67MANtdEh9nc8NhXZvQP8kT7BnSdmtZSkLWTCR2Q/OUIYMn9o
	N7EFf39SENb4XJf1oVhNhCkk7VdudY6dE2XR5LX8/s/d37kehaTaCL9acfM0Wii8QgwvVk
	OSpJKaAa3SvRpV6C5r+4POG5TQuCniA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-diQKMir7OYCxF4kcsS09xQ-1; Thu, 01 Aug 2024 13:46:43 -0400
X-MC-Unique: diQKMir7OYCxF4kcsS09xQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a0f73ff43cso1109916a12.3
        for <linux-serial@vger.kernel.org>; Thu, 01 Aug 2024 10:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534403; x=1723139203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5hpd+G0LExVaxl+UI//CFwTq02L8uYAsSV7qLlWbdA=;
        b=KHREbLakSmiwN323CB8AymZl2OweLYwoUeC3PqltxFs+HyDiQQh/QwKt5gtSidUsTc
         dV8lGSnVheAqB7mhnU9ewIG1FKtCdvzBeuDvdDvznZ1lwBH343blTtGIMAGB2f0aHKLr
         MqsYAfeH9k7PL1soAf+gsWiiH+pAWYGZJnnhc43t0vX+PF371Ne2aJgIlgwl/WKfsVY3
         xczB08wmZ4Wv2MBVImqzZqpyQDqgjZO6z02xrtHXZLhzWFGsu9VE4t7x0IeRhtLJhdXd
         zDQ4B2Ibc4I9gJ6AHtG9ogF7bfQqN8sTd+6dhLalQQPe6hJVO+e61PWsJSJ1Xj5Hdmlm
         /3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf1R8GWiCqM8nLdHAvgfFmlC7vCf4Ih/Gn/zHj944hMueWa9HIkNlSMQhxzqshUWAcTo6YMejLxSaBV7uO3LrzDXRizljGm6UuXXSy
X-Gm-Message-State: AOJu0YyWOMYoXKH/TgQsHPgiyNAgbt67w5dDnztaknU9my83coDgX9bc
	rI4/rrCsiYdvYZ7gfNJV1whCJPWcOpcy4U0AxH1ZUMoJvTFu2HqTT4lThfw24JkL/B6gfZBdMak
	5hDdOhgfRPca7kV/9hQ6mgRGsrzjMtjkhmwDzK1dmHCI8HVByPv1VyGARAoOpWg==
X-Received: by 2002:a17:906:cad7:b0:a7a:ac5f:bbeb with SMTP id a640c23a62f3a-a7dc4d9510emr40292866b.1.1722534402508;
        Thu, 01 Aug 2024 10:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAz8VECBqGLuxnHbBqNGh97d2AXukf5BmEUdwoQf65+BgJnzGGIwfvlOLLLnXxYF4IguemOQ==
X-Received: by 2002:a17:906:cad7:b0:a7a:ac5f:bbeb with SMTP id a640c23a62f3a-a7dc4d9510emr40289566b.1.1722534402107;
        Thu, 01 Aug 2024 10:46:42 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:41 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 08/10] serial: rp2: Remove deprecated PCI functions
Date: Thu,  1 Aug 2024 19:46:06 +0200
Message-ID: <20240801174608.50592-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801174608.50592-1-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 4132fcff7d4e..b6b30bb956fa 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -698,7 +698,6 @@ static int rp2_probe(struct pci_dev *pdev,
 	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
-	void __iomem * const *bars;
 	int rc;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
@@ -711,13 +710,16 @@ static int rp2_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc)
 		return rc;
 
-	bars = pcim_iomap_table(pdev);
-	card->bar0 = bars[0];
-	card->bar1 = bars[1];
+	card->bar0 = pcim_iomap(pdev, 0, 0);
+	if (!card->bar0)
+		return -ENOMEM;
+	card->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!card->bar1)
+		return -ENOMEM;
 	card->pdev = pdev;
 
 	rp2_decode_cap(id, &card->n_ports, &card->smpte);
-- 
2.45.2

