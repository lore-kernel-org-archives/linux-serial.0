Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541F15574A
	for <linux-serial@vger.kernel.org>; Mon,  5 Aug 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844940; cv=none; b=J3jmj6LA6Cu5/79/sDO7BR9FGJVzsEorQ1XiqUt5snyhFtxFUbirt16rU7Ef1swG0rU4GSSUcYCEHoyZphTqZDjhyHyJXfv8ahgut1J0qT7s3X477PCj99NS+GQJcwXpUVe7Uma9+Pe/tXF4ZBAjWWyVhv0/r/sBYFZnDzcEb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844940; c=relaxed/simple;
	bh=Yo+Ns2b3URhNU5TB+CvEDymuFVQ4WXMZyjfGA5NqkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imRTkz/lgxzNpDayX2SPFo68CvLRSkPxzGCTLc/E+cD03v0UA5U4wxfWR0bClgmSttS2CoAvym+wu6gGONveTavxsdAC/vuPr57ulGp0yiR3HQURzIEVh6/KoI1o79zL22mhb/UXilmj8P3hzi9YYb4lpIQYMrRCVSM2yJRj3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RD5Jbts3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD5Jbts3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1zjbMHqB0PmusT+nYJ2VtJ9oVjApsikg9aShs5wyaI=;
	b=RD5Jbts3hesJJDkfA+3Dq2AYU2ooH8e3Ucf6ychRIQnxvPxRKFAGGZOKCMZnbFb4AWYuPB
	8qiJ70+sgZI9y2t/Rx7/EP1MYmwYvcCxtrEqxK9wU9Zd4LDBBE4NRv5mljxCD2hi13zMAV
	rhn7qH/qWh/Id/XvF2jrxuKQYfFGmL8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-dwihXQFlOt2Cjvco8RymCw-1; Mon, 05 Aug 2024 04:02:16 -0400
X-MC-Unique: dwihXQFlOt2Cjvco8RymCw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77e377501cso105865166b.0
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 01:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844935; x=1723449735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1zjbMHqB0PmusT+nYJ2VtJ9oVjApsikg9aShs5wyaI=;
        b=afAOqp4VsO+ljG+Sz2AZ7VLpAX0E9HrzbXqo82WURC7UP13UkpzD2UgEuePYCSRQJn
         de0sl0bGZxmutEj4ou3oa60IZcT2s7zufJAWQvc7RmWkRNkGW/zyyPyPoT6B3QNDl+9i
         d40937+yBQpn5Ly7k1sgOzYUbNRNQJ7UO8qDMt0hkgA/rps900PE7WkoBlqPBREgume+
         sP4QDdUnhP7bSCJ6dY2z45PiAvDrDLJ0Vbi6bukWBU6nJTGv7QZ4fqiCRw1scgPEmkmZ
         YMsUrnVQwvrg1zdwOU21IYNd94VpsSDuLcbB3Qg4ZoJ3PCWd7b5CKWz8kKVOBZfsH3WF
         hBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRZ1MPfo8zfQpzaIMsTfntDi3zUl231B/i0JqF25NmCZicMaHxD6AOz8qUbgjUimtQvTCmRmeizFmQzYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWP7ODDE1SRT/jMbo1kCp87B5gEeDZYr+IWlT5LOiWt0wYJgCj
	SokzcmxpN9uKf6X3phbkCAwX6INvHe2VO3/BVWnurwp9yRB238hiI4YofkdvlknK1vXnGedvUYi
	ONA0roGIoKhm818jEn6UbW/PLsPHNlsN7eazswd3cF0WrnEa7qfzAAJwMryfXhQ==
X-Received: by 2002:a17:906:f583:b0:a7a:81bb:ceeb with SMTP id a640c23a62f3a-a7dc4ae7defmr473037566b.0.1722844935141;
        Mon, 05 Aug 2024 01:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKuHik2ajcs17LmubcaIaCUkrAqH7M1NRkgMmBZVBefF6pfGv29aIhP8ECYMtriJwflIFmgg==
X-Received: by 2002:a17:906:f583:b0:a7a:81bb:ceeb with SMTP id a640c23a62f3a-a7dc4ae7defmr473031766b.0.1722844934632;
        Mon, 05 Aug 2024 01:02:14 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:14 -0700 (PDT)
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
Subject: [PATCH v2 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:33 +0200
Message-ID: <20240805080150.9739-8-pstanner@redhat.com>
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
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 719ddc4b72c5..6b282276e7b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3534,7 +3534,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	void __iomem * const *table;
 	u32 bar0;
 
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
@@ -3657,22 +3656,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	}
 
-	ret = pcim_iomap_regions_request_all(pdev, BIT(0), DRV_NAME);
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret) {
-		dev_err(&pdev->dev, "pcim_iomap_regions_request_all failed\n");
+		dev_err(&pdev->dev, "pcim_request_all_regions failed\n");
 		goto out_no_pci;
 	}
 
-	table = pcim_iomap_table(pdev);
-	if (!table) {
-		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
-		ret = -ENOMEM;
-		goto out_no_pci;
-	}
-
-	trans_pcie->hw_base = table[0];
+	trans_pcie->hw_base = pcim_iomap(pdev, 0, 0);
 	if (!trans_pcie->hw_base) {
-		dev_err(&pdev->dev, "couldn't find IO mem in first BAR\n");
+		dev_err(&pdev->dev, "pcim_iomap failed\n");
 		ret = -ENODEV;
 		goto out_no_pci;
 	}
-- 
2.45.2

