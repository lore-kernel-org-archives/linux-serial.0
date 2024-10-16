Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2435208D63
	for <linux-serial@vger.kernel.org>; Wed, 16 Oct 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082509; cv=none; b=qfcbQPAeVLLInjwxuvjxXZcL7dBmmDta560l2b27wlSLcV8sQoUNwRsY4XYe4uXOh0SN6O2ocC/ZGThtW/+aYStgItECYyV+LrJVZwKDZHqdyIu5ZY/jT/h6heOQ1XyEWAscMGlYp8Ed6xzlQfFSl7BrXHaHmprWYDuhHzxAtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082509; c=relaxed/simple;
	bh=pzHm+p7iOQ3ZHeJddCbAsTb72gDaFZfayku/dAdnQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T08t+SWJ2wDBmwjc/JvBg1e/2/IaRPkKVOWA2WGZufKmGTr3aNdJLAhzBBNcorBJhrwNWGaEMe65jgf+632Maa5CVs1MrgvDhU0YHtqIVMRs2ZQ9szlNEA3+hQXeMYl3C8L26GW2nk7i5ZSQxzqapCPsE/wPzuFKzxxB++8DJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Diju1pwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Diju1pwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
	b=Diju1pwomIomH5zgPhRZq49bmMcMohcHZ8QV2IfJvSRhNyoHb9ADftsZMqXgzXyMkXw0Tk
	oC5v/vuGD08RwsyBViudujRWz6XQ23E92GpAiUztQL7GlxiqJhCiNyUGYZ2WPFpaX+zQkA
	hMFYeAQqbX9uUdJ125vyIU47TzjbtWs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-9N9HOfKTNX6hZHLsjFYtlA-1; Wed, 16 Oct 2024 08:41:46 -0400
X-MC-Unique: 9N9HOfKTNX6hZHLsjFYtlA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4313a8e81fdso12689305e9.3
        for <linux-serial@vger.kernel.org>; Wed, 16 Oct 2024 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082505; x=1729687305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8B9LV+ler/WieU+IGPE+8OX97zcf6y+ob4ao9vxZG8=;
        b=gMJrtfJN/ilf7VqqyxvyHHMpTKh8z8o7/KT2FKmVvIwjx97BaPEqvZ/kLR5QXh8m51
         cQKxj2IMr8Onh7SJqAndX5jPLUjk45+IEQkGi2AIex8VKcsL+x1TtZt2gH0rRQvQ3SCz
         /xDbROEw2xQFpkTSWMuJLaib8FxlXZ5zRWKRf+elrEHXr5J3eaVXV34J/5q0Y5C0CXHP
         4hWb07Z/B9XujO8aFFDV08AOi099NoBOk7buRhTW53SnGUpqLSVum5qWBu5KwDRpeFB2
         mXRfvYWfwWCtb6oxHMSuhZXyZ2owxrOEqyUlZZyb5MXDhXPt6nfQUH6i1glps172K2a0
         nWww==
X-Forwarded-Encrypted: i=1; AJvYcCUOgFB0Z2VcHKUOBYBr76G5n+5JDoDpOmVMFY366G0eG5TBMSlfxsv3YJBIH+2cxgt5coQFxtLL6riuJUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhz6XN6QkbEl+bJ808YS2dqzXhZ66vi+WOBut5uMdWJs+C5rUZ
	Embh+Jv0L28e6lyCAZ8iNK2C7q309lUmzssKFu/qyEFEUzUwD1XttEzuVsdC9+bQlAXXuvPi3J/
	kQlC7Dhf43XbcKeStYGRE+1EvhX6XDqww6Q2u5QDvBI/qC0qZg6Qh2jVAlLSrYg==
X-Received: by 2002:a05:600c:5251:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431255d53a7mr128784765e9.7.1729082504820;
        Wed, 16 Oct 2024 05:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGxF9+2xYoc2iAcnZEJLUiZOKpsxfW9lx+KNsJOv5CduYI06lG5Znx9zhblHV4xRBC8nAdSQ==
X-Received: by 2002:a05:600c:5251:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431255d53a7mr128784405e9.7.1729082504314;
        Wed, 16 Oct 2024 05:41:44 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:43 -0700 (PDT)
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
Subject: [PATCH v4 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Wed, 16 Oct 2024 14:41:23 +0200
Message-ID: <20241016124136.41540-2-pstanner@redhat.com>
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

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..2a64da5c91fb 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -939,7 +939,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -957,6 +957,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..3b151c8331e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2293,6 +2293,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
-- 
2.47.0

