Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA814D44D
	for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844945; cv=none; b=JGPZ191Ty62GHdQC248Nmt4YOsMEQ51tLRVMRvo9c8FdbpmFL5vqlYurhZRzGe4oQq+T86PK1E4iAc2u5Q7ea2+OZpVUrVr0LZ1PG69ji1KwVYtsO3jMveN5A9EI0q9ALdvmYjIl9SM+qtB0Rm+YymrSctXkB1om2488N3x5L/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844945; c=relaxed/simple;
	bh=7JtiDzH4j1fn6e/l1CbreMTpZlhxa3kkuVFDYh4FXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jrfkt2YqlIg5wKJp2YoLXkzQsdYvsoeZlQLHP+KhZ+FT6IbUG1YBujAVCj7VP6+mos4iQZef4dJHL5TGLO0ldmrrJ7pKTmp3VOIg0+l450fGAxDc/jAIuFhRZgXJGH91kiMUrWs6gywu+06MnitjwcIyoVdBb/kMxU21HN5PH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtTb9RYj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtTb9RYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WfVVRPiytk6PFyUBJOpMrU1ppuGmgzu2AH1RznbocA=;
	b=GtTb9RYjSfHNr354oiRG3rHJdu/aH6mX/TbTxg3IP3bieST0SIbLxUo63MYmesbA/i3b/5
	CR5NmI/DQwt6gjDFH+DymQN7RM9qlPNu1QSjf4dTuEEwsveHepo6jaMg1j1/H9Fd7mOciZ
	I8uLeQcJEANGybF0H6qW6uy5T2rHxv4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ENCMhwDdMw6qYXbIb31aHg-1; Mon, 05 Aug 2024 04:02:18 -0400
X-MC-Unique: ENCMhwDdMw6qYXbIb31aHg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77cd5611c5so79465066b.2
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 01:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844937; x=1723449737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WfVVRPiytk6PFyUBJOpMrU1ppuGmgzu2AH1RznbocA=;
        b=pRO2CF0zhRC5gBORstA7ODjEa1cgbyz71u7Ujiy4QNVC8H0gAwNU2/HmS1xQRIrMQE
         wBkfNt+B3iOQlr65nBuITwI/CiMQZQWrVFWeGa5FOgGjHUMzcQeh4EhCyPOX5n5EZ2UW
         VRN8xzK8VHE61Rr5L+NtFsO9ZoX42K3r/KHqDQ1igY3L8VudH+b5UViU/ywR0E8LkCiD
         lML6AlW61Wcs6f7VO2PK6QbSUENzZ8FtQZSZxecvfpR7TNJJZldDbWqug/GtBMi+xkGr
         Oef9TH5B2CfhaYA4bKxv3eh6ql/a/fwihkKiLNqg+V1B4fkktDl+ZmM21jErZ0ZhXtqe
         wyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPBRdYn6BVM/Zvr/H6MOwjogn+ZpUlYALxwFVnRJbTTG6gvk0fI9Pb+p1CECyYeErd2+7paM9M/QKsP4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69IELiFq7FX5zr7LKfpZhhS7FF2RrY3c3t4DD2vLtKYFAf3j1
	4cJHo4+oWuhbwe1DMA1713a8xub8IKeZKlkgQGM+pxspI+L/jKle5RNgX4bITM0eFSmff3LZvdQ
	V33NLz0yr4Lz9CD/Mk4OxBGtdVIfX18J5+9g48wvk1GiuQ2+rQIXlFMw/kQNSMQ==
X-Received: by 2002:a17:906:794b:b0:a7a:87b3:722f with SMTP id a640c23a62f3a-a7dc4e50c8fmr559112366b.3.1722844937220;
        Mon, 05 Aug 2024 01:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG76bxvYb5Yaoc3VRVGn0E6yzVD6z6UB6d1yYJXJ3VBKVznVuoeO63AJt78w0QvkxaZORLkrA==
X-Received: by 2002:a17:906:794b:b0:a7a:87b3:722f with SMTP id a640c23a62f3a-a7dc4e50c8fmr559107866b.3.1722844936734;
        Mon, 05 Aug 2024 01:02:16 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:16 -0700 (PDT)
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
Subject: [PATCH v2 07/10] ntb: idt: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:34 +0200
Message-ID: <20240805080150.9739-9-pstanner@redhat.com>
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
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 48dfb1a69a77..f1b57d51a814 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2671,15 +2671,20 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	 */
 	pci_set_master(pdev);
 
-	/* Request all BARs resources and map BAR0 only */
-	ret = pcim_iomap_regions_request_all(pdev, 1, NTB_NAME);
+	/* Request all BARs resources */
+	ret = pcim_request_all_regions(pdev, NTB_NAME);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request resources\n");
 		goto err_clear_master;
 	}
 
-	/* Retrieve virtual address of BAR0 - PCI configuration space */
-	ndev->cfgspc = pcim_iomap_table(pdev)[0];
+	/* ioremap BAR0 - PCI configuration space */
+	ndev->cfgspc = pcim_iomap(pdev, 0, 0);
+	if (!ndev->cfgspc) {
+		dev_err(&pdev->dev, "Failed to ioremap BAR 0\n");
+		ret = -ENOMEM;
+		goto err_clear_master;
+	}
 
 	/* Put the IDT driver data pointer to the PCI-device private pointer */
 	pci_set_drvdata(pdev, ndev);
-- 
2.45.2

