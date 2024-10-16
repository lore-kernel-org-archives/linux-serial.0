Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73A208D82
	for <linux-serial@vger.kernel.org>; Wed, 16 Oct 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082513; cv=none; b=OKVOkdku59oAKWYGlfAkoVichB+cB9PDV1IhHCJZQF1BKpiKzUGllbtcxSygDzPtWxV94Nf4g6l+orU3L0Mepfo769jH62QTg8hgP24jcQtwnhKZfEJxqxY7QB6EZ30fS9hpEmt76ERMfZa2LpwO81swmfIplO0VBMMvDO05sUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082513; c=relaxed/simple;
	bh=YCSleCRL8+zgmB0F5bhpOuGHDhDr1YVS5o/lIBwlqhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eo7ROpQ958hJv9gD2nieEHQut1hwxDiWFAye+UgaheDJuVykCyY8kJMxt1igOLxBLGY5ELA60AZiVxZ22D66Qvcr6SAIb1kL5srarjxq1YMMoi1O455ATwuL1lQraY39IECR/fNDenwKKIJtUMsPjv8Mu3fF8GXHSq+vY4CVAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/N81taf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/N81taf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8Pv00ipT6Qdh9I20/5aALEzhWkgYoXaIfeUPDxIxig=;
	b=K/N81taf0MrKCmBxDBlyqQ0GN9gJkNDLSJH5oDJ8VUwTzNntwyfltXbpy+KzJI6gN3/TtI
	HfrWcL1P6XAQ90tiZiMUvX0IrqpCzPLuXPtxnMQi57iFL9RjhAFDGiJKstZZxDt5wIF+h4
	oOncLr+SJL4asI7XKUyyLCGu4RL6lZA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-GB56Vyj7PQSbHERBCBUNrQ-1; Wed, 16 Oct 2024 08:41:49 -0400
X-MC-Unique: GB56Vyj7PQSbHERBCBUNrQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso3349834f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 16 Oct 2024 05:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082508; x=1729687308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8Pv00ipT6Qdh9I20/5aALEzhWkgYoXaIfeUPDxIxig=;
        b=Byb2mtferILe93nwfj65NFUfPD/VWgTxsfUKSLgRYUZgmDwqJ9f8UBVcfG6ZmyYpQN
         /BgdujA6pOfEGOy5Cv8KPeqWZFFMge1Im8XngiF/TWODI0k8yvCAUm+1+SA6P0Zw7xRs
         Pt+y1sXvMavbYBdxow638fY12yC0B/Mm8o6zjGMPwF0TFJS9eOIRXzUWLIHxrwwifdlh
         qJW98b0LLaiAZrvX56SA2WGl760qbrGNVDDh5H4Pe6XGvu8mtYJztETkrpvINfQ+srnq
         aI+czMLdsNe5Ik/ODuiqbdzR98y4lqh6QjarUwErvZ5apqd0xYNaaJD8P3WL4NSAq4CV
         zBow==
X-Forwarded-Encrypted: i=1; AJvYcCVvoCYJZwwizCd8wNZSOEpvdlEp5/Qnj+arBYPlE0T/C59H3cUvqsgyg4+tGUh3+RFCBFqq63cQyHsvus4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCp2kmUGb4zrf75mw9WDFlnm3jX+7G/X7nJfWrcY4idl5qEQC+
	BGpQUluj4YLvVxX3AYfPBVagX9G4Kg3FWhcEm+kBU1gcFCr2YguETm9y2xRbAl+Xo4ml/ddG7Yg
	oDHYAIaehESi7fvE0uDvuQTJ3qlMc+1W0mP+0IOm/AN2Sq7vm1xp45F1LFKqO2Q==
X-Received: by 2002:a5d:6c62:0:b0:37d:370a:5248 with SMTP id ffacd0b85a97d-37d86d5577bmr2997237f8f.39.1729082508499;
        Wed, 16 Oct 2024 05:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZFf3YMQtDBztciPqJ2fi/zHZMLQU2JKkhwWU7eBvggnRvVoWkn4lFSqQuDt5+GBXjzzR48Q==
X-Received: by 2002:a5d:6c62:0:b0:37d:370a:5248 with SMTP id ffacd0b85a97d-37d86d5577bmr2997196f8f.39.1729082508065;
        Wed, 16 Oct 2024 05:41:48 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:47 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
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
Subject: [PATCH v4 03/10] crypto: qat - replace deprecated PCI functions
Date: Wed, 16 Oct 2024 14:41:25 +0200
Message-ID: <20241016124136.41540-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016124136.41540-1-pstanner@redhat.com>
References: <20241016124136.41540-1-pstanner@redhat.com>
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
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c | 11 ++++++++---
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c  | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
index f49818a13013..788a11cdb34b 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_drv.c
@@ -129,16 +129,21 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Find and map all the device's BARS */
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
 
-	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
+	ret = pcim_request_all_regions(pdev, pci_name(pdev));
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to map pci regions.\n");
+		dev_err(&pdev->dev, "Failed to request PCI regions.\n");
 		goto out_err;
 	}
 
 	i = 0;
 	for_each_set_bit(bar_nr, &bar_mask, PCI_STD_NUM_BARS) {
 		bar = &accel_pci_dev->pci_bars[i++];
-		bar->virt_addr = pcim_iomap_table(pdev)[bar_nr];
+		bar->virt_addr = pcim_iomap(pdev, bar_nr, 0);
+		if (!bar->virt_addr) {
+			dev_err(&pdev->dev, "Failed to ioremap PCI region.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	pci_set_master(pdev);
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
index 659905e45950..115eabfd1f6b 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_drv.c
@@ -131,16 +131,21 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Find and map all the device's BARS */
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM) & ADF_GEN4_BAR_MASK;
 
-	ret = pcim_iomap_regions_request_all(pdev, bar_mask, pci_name(pdev));
+	ret = pcim_request_all_regions(pdev, pci_name(pdev));
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to map pci regions.\n");
+		dev_err(&pdev->dev, "Failed to request PCI regions.\n");
 		goto out_err;
 	}
 
 	i = 0;
 	for_each_set_bit(bar_nr, &bar_mask, PCI_STD_NUM_BARS) {
 		bar = &accel_pci_dev->pci_bars[i++];
-		bar->virt_addr = pcim_iomap_table(pdev)[bar_nr];
+		bar->virt_addr = pcim_iomap(pdev, bar_nr, 0);
+		if (!bar->virt_addr) {
+			dev_err(&pdev->dev, "Failed to ioremap PCI region.\n");
+			ret = -ENOMEM;
+			goto out_err;
+		}
 	}
 
 	pci_set_master(pdev);
-- 
2.47.0

