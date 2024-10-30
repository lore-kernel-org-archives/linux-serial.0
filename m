Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE21E4924
	for <linux-serial@vger.kernel.org>; Wed, 30 Oct 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287715; cv=none; b=uxavHqg4PI97125rxNGiGq+7BFWsO+jiT+0pGUAiPW/7G0tQgqB2LikWL9xvDcIo6mQmanfTtaaaMOBeOcOQvz79rEqpgmha3c3Lak/BLwEbrIpzCy9Y4EHmBb5fWc2AyJeCnVMivNIGBliqfB9+yzT30i192SlNgCfdqfa1IOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287715; c=relaxed/simple;
	bh=RRyy0x2PiBX++bfjCGlA/9AZOm7xwGM5wtpW6IKXyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4e5K4NdWQKS860itotpf2K3dvXqHyLjeoOLBzhIbF6CmFsgg+kIh9rb0UdKWL4/HDLrrLAWS/foJo3LRU9AOoDO48PQp+Hs5A6b8Nn80juS0lCGnREmNpLJk3Xbiz4TkTrpYU8Kdtu5ntOUqdbw79b6E5nln7j9pYQhfg3dj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnHqRY7k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnHqRY7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxQ5Vib/1yt2THpDXWI2rA9CY+VRhy0DxtAlfuLaLe4=;
	b=GnHqRY7kIMsN4XU++l+g+KWcQQUFWPR4fCGrTRqhg3bMH1wJejV7u6jZjoR+LNKKilDant
	8JALd4gs/t1vvK7cJMm5F4/jStw0xptke2R8UbjDHMoZwD+WeivY2hIrZs3NZdl3em8in9
	Od4LK9PVVNloyjop8qNgzoAwVomNBrU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-qQrXnmfxPK-kZqGq57j40A-1; Wed, 30 Oct 2024 07:28:30 -0400
X-MC-Unique: qQrXnmfxPK-kZqGq57j40A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0d8baa2cso78108366b.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Oct 2024 04:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287709; x=1730892509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxQ5Vib/1yt2THpDXWI2rA9CY+VRhy0DxtAlfuLaLe4=;
        b=HKgEt5lPBOeS8vnxUsiKadHmCrJseuCzPEkE60bNueVv7ktFsup5D2z3RQ6en4Gd6R
         EgR09h9SYUlpPt9oErv3jn0x7nHQpwxCyDU9UjAI84a2yQZm8UF/pfLi7B/fE1BCyCuG
         1f0u1Hqa52kmVBjWvV/Jk6VYs7fhwG84uoBinit69qVDWpDDy7/o0qQE9s5IkvODpqHm
         PXLQidn08ShYKA/f39aHJst8RAJeS7CjgK686pM68H4rHC6Yd+CNvHTO2T1Vk/ZUCs8L
         7Cljt6M8MtUi1nr1loVZksHJ4SSx3LMrJlUbs+mQwpsu61eTaoLnzQfyXKcimIvLfmI/
         HwuA==
X-Forwarded-Encrypted: i=1; AJvYcCWah/8nqRlbxM8Njex/9gzxSmADVpuzauPB84QXr7DvmCnJ8oXnmHEQGFD+4pbWovJDa5+PXT9nGz8jUvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxInI/kwHW8pg7VP8FS1EB2GvRoGMOxrNr6HKKjvzPbxexQ2yt0
	dRdgyAKKnqNWrUjPqkMAR7ti835mkad1AMCtNcEWk+8tGNbyfxKh7+RWYQKVZKfjTx4BXIjrcog
	yiz13hy2qa0ZYuYYUuL9yrMm8ypSLY/sGRLIS6Ii4oCybBdbZ/bSvGAtoHEak1Q==
X-Received: by 2002:a17:907:7f8a:b0:a99:fbb6:4972 with SMTP id a640c23a62f3a-a9e2b6333f2mr407079666b.25.1730287708944;
        Wed, 30 Oct 2024 04:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFETLfwRScQnX2tbEFkH21PzK0bXXqnKMORp76UY23sUZYI9iNafni9BvKTHyCoXNkZxPgyFg==
X-Received: by 2002:a17:907:7f8a:b0:a99:fbb6:4972 with SMTP id a640c23a62f3a-a9e2b6333f2mr407072266b.25.1730287708339;
        Wed, 30 Oct 2024 04:28:28 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:28 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
Subject: [PATCH v6 08/10] serial: rp2: Replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:41 +0100
Message-ID: <20241030112743.104395-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
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
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 8bab2aedc499..6d99a02dd439 100644
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
2.47.0

