Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468915884C
	for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2024 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844949; cv=none; b=qgMMBGYUYQl62KxTFJj0R3NJMslm6V/11Ix0ZJZXMc9NH7+2UYBCY2xXcUfzxDOqMrhy5/eIRJDVnQ/StJBfD56eGwkcKhqb+y7MlDPpDJ7Nnq9GgAAyciTorVaWGykNuoMrIcZez/mQjw1ivn+PY5PlF6KTBOYq1B/7aZGFEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844949; c=relaxed/simple;
	bh=XVnRSeomOV2CcZ6TomefmLqSPd3/SQ4wMxlPfANkowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZBdN6NrKkKbs6nMfPyRhqtEP+rJ7kORyCa/o/GLNNkdIfRZN+rymHWzUfmnzLzZjPw3NogwaeunzgmX/wQ7Erz2SP2bHuY18SMep/j1m2wGBxyfaFMlwqQ/fs1DjS5dVhbi+WDd6/DdhOfgVAih4FseVPRpMYg4n9r67DCVzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z03uUAUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z03uUAUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0/Bizm19ADXNR3ICrhb9w7/UmlF3K0oMXeQfztA/nw=;
	b=Z03uUAUnwCre5H9R8DPhMSie6z509ImP4wGUxiMAs0QLi52fV3HMAojbSfxI1sIehQ9imf
	85z0DU1TT619hsVUF6cfrq8mCgTOxaP4Br9ghPyHrcUXr5g64QFqqIBWtZZHqFFIWK4ESS
	pN4mUWPqs/7aTQrF5ZyMwe/m6WBo+D4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vY6UmKmxMCydQy989iF0wQ-1; Mon, 05 Aug 2024 04:02:20 -0400
X-MC-Unique: vY6UmKmxMCydQy989iF0wQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5b78e856a85so608184a12.2
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 01:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844939; x=1723449739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0/Bizm19ADXNR3ICrhb9w7/UmlF3K0oMXeQfztA/nw=;
        b=DUx9pnsdPei8fvzyc+2UrkS4U8kS3O+0hROGhe6T5FtD+VJUFsDFXndDBWyqSaXjTa
         SKR81ERBpgkI277jpSp5RZDfyvXGm/j3xchtsdpKf5jCn9N+NPBPZmV3mjVJbmpff3Jz
         JAVo9t8N1+rLR7HTGa3X5L/p2/xa8q5vgqENtlzyiGUfp9audn/awiMDKoDgswxmD3D8
         Py87vXYMV46vRzgRgRhz7mWTGVFdlZLQYWE2ugQCPNLJz1HkTapaukLgL36Vma4LqWo4
         jrgNuEbRCT0+DCConUgKYK7fSdVV/mOtk6RG0GQIoqmM+r2G3qEEkKO4vGtx5DkSGNSz
         sHUw==
X-Forwarded-Encrypted: i=1; AJvYcCUnTYPatK7U88Wf8xPcN7UyZJnxK4l5MpDGRNR4y81YfqWJi2dk9a8+0m4fkU4SkbywohhHaN/PytAjBUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hcbFvULSOIHfpm3lZaFw77QgeojGkrLFPtLx16vQ+brUJhOb
	wATaNOoysCKL+m5lnzA6XtefnrKzyEBvRvu1SNs3oScLl6QlWQSYxz+z+1WnEuVsRwizNMrFlt6
	MAFnyuX3h9n9YMS2qoa1XjK2w5qsaJu9wMK9S/W1wF+Co8xV2iyCMUtBOLaZmtQ==
X-Received: by 2002:a17:907:6d06:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a7dc51b4cf1mr513587466b.9.1722844939197;
        Mon, 05 Aug 2024 01:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SJB/SW4G2idNXeZQo9TGP1SQwm7yFqzOP7n5lB+7g8ap58Lk3/dgBFHgiZuUlpVVamp1Nw==
X-Received: by 2002:a17:907:6d06:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a7dc51b4cf1mr513582166b.9.1722844938741;
        Mon, 05 Aug 2024 01:02:18 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:18 -0700 (PDT)
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
Subject: [PATCH v2 08/10] serial: rp2: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:35 +0200
Message-ID: <20240805080150.9739-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805080150.9739-2-pstanner@redhat.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

