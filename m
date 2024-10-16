Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A520E02A
	for <linux-serial@vger.kernel.org>; Wed, 16 Oct 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082519; cv=none; b=S0yFCJt9IWhdO17zUepL5scJVdoORFRnwV4k+EZU9wV4MrMM1ODh42yGjovMk9ZcdEG/Vo3HqybRogiTFN9uyyD5dWzUOw1iCI2iuztl77itAqpgB8NJ30aGZdwfg3C7YwLZi93tx14xdr2EEScnTfU0kazJyL5BoxXBzXJDP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082519; c=relaxed/simple;
	bh=xqbcT0teETgc9gYJIx/Gpdlf6NMW2EiA0uF/aZLVnhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPsfWKobeXBAlJFXL2Okq+IQumIsguwQ2Ee7GjZ191jXGRiKQyQN8NxHeEF7VExRjd7Aai6KHeUDLyQ+00/URwQRKjcRlPrIzPmQEtmnWbtSdkmbuZl6evy2jl5UixW/7Y1p//DflioX6wReDgg2+UOhofZd90R74jKOdcQXVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QR84tqvM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR84tqvM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HQZvfLDOQXSIlF97X3lGTL3T04sTNcN/H3+TBJ6Tw0=;
	b=QR84tqvMHEquxrwJKCrg/PsMPGr0L8z62tZ6utdsip3Ffv/gTTgAdIhsJJ9NAWBQiKklt/
	ik4ovyu+gVs8Rcq/ZGnSNa2UBpjpQhq+yZfCNJ062wLJtA9/DPlJ9BpqDU6LCA/ySciINT
	kNBXVSk7xsM5LPA1Ce39/M8+TPwvymY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Y0WCkk4SNAKLRbJzOwl0EA-1; Wed, 16 Oct 2024 08:41:53 -0400
X-MC-Unique: Y0WCkk4SNAKLRbJzOwl0EA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso41379025e9.3
        for <linux-serial@vger.kernel.org>; Wed, 16 Oct 2024 05:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082512; x=1729687312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HQZvfLDOQXSIlF97X3lGTL3T04sTNcN/H3+TBJ6Tw0=;
        b=R3rnxzUD9bnKleWInlDey1osOyl09vpby6D2NvJfN7yA1ongHlDiaVluhNankTn8En
         2ng9gbwAH9AxERKVhC8ZO3Ckzj73H0S+WsgFo0c4rtSsZgfZF58Gx8bpDuOnsY0X3wQw
         6afaPjPNh5pZsYZXvI1DFjtXuV4XL3sUK2S/QymPm1hZCeuiVSt5iiCgDCZOllpPxOFE
         oHjTK5izEkauM43gQVe+l0QcqVDgrRw7sAX9dK3+6Bp+lvG/hJfeDCpaOc29sJvPdv+u
         ZiS95aeLim5/sxGo6Vi9HGDik78AvNpXSQPcRpkteML04jCbQ6Xns3UDJF2HY5t9UbLc
         5zlw==
X-Forwarded-Encrypted: i=1; AJvYcCXyUSjf9IjnRt7RJHYM56dgJni5yhIKAbdtuHMF+WwdPZAqjI/eVgspgC5n6nMWv5nF+qpTYZKfYk8XPBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtefDkL0NYDt1ATMfE6+B+jxliyWfeswEFk21xRXbU9hfE9g2
	1tm+ivLufOhRZHEYI2/hNxMZKl7Qij8ZUywWbDNI0BKS75FvoNteEfc5TKoo2SpZIIhjaQC5b7V
	0hXMyAmGqeFrt+bxWoBup6yXKrZ2fc1HzDp/xmUuNJqNBj/5n2fU6PNBT1E2MXg==
X-Received: by 2002:a5d:5259:0:b0:37c:cf0b:e9e6 with SMTP id ffacd0b85a97d-37d86d5521amr2837775f8f.42.1729082512126;
        Wed, 16 Oct 2024 05:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuuOf1sTYXDilZR7nD/RZHfWfnDIJXaRup8pfdRiWUJNRcHMmBtXXl2psjBzvHRiWx8thnIQ==
X-Received: by 2002:a5d:5259:0:b0:37c:cf0b:e9e6 with SMTP id ffacd0b85a97d-37d86d5521amr2837729f8f.42.1729082511712;
        Wed, 16 Oct 2024 05:41:51 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:51 -0700 (PDT)
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
Subject: [PATCH v4 05/10] intel_th: pci: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 14:41:27 +0200
Message-ID: <20241016124136.41540-6-pstanner@redhat.com>
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
---
 drivers/hwtracing/intel_th/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0d7b9839e5b6..e9d8d28e055f 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -23,7 +23,6 @@ enum {
 	TH_PCI_RTIT_BAR		= 4,
 };
 
-#define BAR_MASK (BIT(TH_PCI_CONFIG_BAR) | BIT(TH_PCI_STH_SW_BAR))
 
 #define PCI_REG_NPKDSC	0x80
 #define NPKDSC_TSACT	BIT(5)
@@ -83,10 +82,16 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions_request_all(pdev, BAR_MASK, DRIVER_NAME);
+	err = pcim_request_all_regions(pdev, DRIVER_NAME);
 	if (err)
 		return err;
 
+	if (!pcim_iomap(pdev, TH_PCI_CONFIG_BAR, 0))
+		return -ENOMEM;
+
+	if (!pcim_iomap(pdev, TH_PCI_STH_SW_BAR, 0))
+		return -ENOMEM;
+
 	if (pdev->resource[TH_PCI_RTIT_BAR].start) {
 		resource[TH_MMIO_RTIT] = pdev->resource[TH_PCI_RTIT_BAR];
 		r++;
-- 
2.47.0

