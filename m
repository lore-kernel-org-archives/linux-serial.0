Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5141EB9FC
	for <linux-serial@vger.kernel.org>; Wed, 30 Oct 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287712; cv=none; b=Ptobb/GpO2BqhtuUu//YNVOQ1ap0S4PFapbFJzpS37gsD1XNoFud8MApWaunHru0FHjqPkMmROSid9r2RPZwAEPmzg14rUrZ76t8f6tBPnLVp0IlT4nMN0fLv0idbXv1QKJP4+iprQ+sayDz1UhGcDbV+BiL+XwxtUhgMbslunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287712; c=relaxed/simple;
	bh=KRhL2deOZRHNfuo7/CizyodCPj2p+YqlhuhaNJFSYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DARDt2r2GRdnD/ESTIVaabfKL2Z3ytj/TteKrpFhVpXMDAUL3MFn54ixACb+KZEECMWGuPBWJ0lF+18rPvlxriGrn4oiRDoh1+wHwOFVVJqMBeMBksLE+Ew82j8EWc5bnZIo/fpyXx1RHI0iD9zgurU7IDDszQ5s9CzGSPQZKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1KtBDDe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1KtBDDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH83zA24aoDnwtpuZ+wclLhu+n7qeaaZUv7+D6hfs+0=;
	b=a1KtBDDeNnucE867r95jAFkn5ods9i+SefZG12vx6k9Pcn/va5VAdgTtEvqfk/On2ITr3f
	C4AJoZnd4m/uUitQaIOwUsJEf1SfrMvQCAI4y+0Iy9q7lZjysLduMctTetDGYq/FLUPNAC
	la5X36Scwn/tIHVhn3aYZu2hF4NUf1s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-tcXlt0zcPZS1L0M2TdpuHg-1; Wed, 30 Oct 2024 07:28:28 -0400
X-MC-Unique: tcXlt0zcPZS1L0M2TdpuHg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a2593e9e9so468151066b.0
        for <linux-serial@vger.kernel.org>; Wed, 30 Oct 2024 04:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287707; x=1730892507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH83zA24aoDnwtpuZ+wclLhu+n7qeaaZUv7+D6hfs+0=;
        b=WxQr1X9Sl6dpkjE0Y36QZka7sLE/b1CUEkb8JajhrSWezgxO/UttaPonES0piLZ8tr
         CBBPlJM8s0RU7caTMPpUjjb3/qg8s5RhW2p5znonoAkqm76fGspYh5NlH1cImHahIPGq
         zr1PowmINjdSmkDOQI4L5i5w4ZssbvDWw6VkeJYQOaLWOdhHffdVTmLfFM+wI7U7jGee
         bUY+AQESh3uR24FosWiTSwG7X2AN7P/VWoDXdhQ7YwJQfCv9L7MgwyaaWA3Jatv7Iqnd
         FD/v9h6EW9uQCVTcxYt4vqf6za15+EDwdHNEUusnhHlzIp3BP8awjDUjVc9K59fr1SLS
         L0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVbGBjYR5chSHpbFK9KYux6NhrLVMwMAPEser1yiw7CxQxzQt+DDWLLv/vn8scUpVNg6GC9IUZsnGVv3mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxYfO3jfi+KY90g9aRIktwexBmZQ/DVfzo2Wp2oau5P4gUTqe
	Xx5/ImX5lXtFADZ+rz58LhKM+wlKPZsM+zpumpmFoKn13QPfiTb5PGxv1J+frlF74PiNPAdWgrK
	/hvgTyoaq11+M2qrXevLBhto0v4gwyXnOAKZBYkY57wAHoT7SuVClX71gmvq5CQ==
X-Received: by 2002:a17:907:2da1:b0:a99:375f:4523 with SMTP id a640c23a62f3a-a9de615a8f3mr1351690866b.44.1730287706882;
        Wed, 30 Oct 2024 04:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwg1LvHm/sBVMIGSqZqjkRb+x/AHkoEL8qETnnIUP4SEpWG85yaxrXSuFLHiSID89YoxWbOg==
X-Received: by 2002:a17:907:2da1:b0:a99:375f:4523 with SMTP id a640c23a62f3a-a9de615a8f3mr1351683166b.44.1730287706365;
        Wed, 30 Oct 2024 04:28:26 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:26 -0700 (PDT)
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
Subject: [PATCH v6 07/10] ntb: idt: Replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:40 +0100
Message-ID: <20241030112743.104395-8-pstanner@redhat.com>
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
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 6fc9dfe82474..544d8a4d2af5 100644
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
2.47.0

