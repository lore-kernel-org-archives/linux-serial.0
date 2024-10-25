Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A940166F33
	for <linux-serial@vger.kernel.org>; Fri, 25 Oct 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868445; cv=none; b=SOZtwBitVnRSXwZDArFmVZWikmnyzUOjrYRhi93vxMeRvNEQTDOcp0b/HzqER2s2INC11vkcf5/XdOy//rR5L1ZERc8cfNCmIb7+DrtLxJBxtLXJSG2X4Ca3xuLycuVIG9chYF3hH1mfb8tjVPJrN1YNNORm3vLy3Y1413mkv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868445; c=relaxed/simple;
	bh=qn2zisIVAp1A3sOByjD0CKUjzgN/331GtrAdNv9H2Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=he7k/xVDDY1QBlOFX80ZgxRjFFzEfH/+pssyazWRYkarXjDrHtpG/sHG2B7Jk1kDt6Ih7/5Xc5mHjN9bk0R/DMT5mbFxARSG1jg2CPzwOEf4PXk/7ZaeetkoEvnfkNnKwNIl45EpESXmF6nYikCbiPnKrNU3AzGn6UnYGloSC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qob7HIc4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qob7HIc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6mk7pVJi4FxC5YCmtGMcoceHkePQhE8sXwo0Yl4cl4Y=;
	b=Qob7HIc4Wrm3dkeebT65QDRBQdpwoDIr50JdBVgorj40sDsV1WuiJcMLitmOc2WTxbIrIN
	S1nPL4XT2eeE/DmmOobRZ2wf+wCnVEe3ePTwXu0bpOwqsHE/7Eo8NuN4Y1Bbpx7cy8XgLS
	k0I1KyDjI9nPDwARkxi54pqE1icV5Ss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-1RB2wHZ8NYmrua8qfXaZhg-1; Fri, 25 Oct 2024 11:00:37 -0400
X-MC-Unique: 1RB2wHZ8NYmrua8qfXaZhg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso1013551f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 25 Oct 2024 08:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868436; x=1730473236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mk7pVJi4FxC5YCmtGMcoceHkePQhE8sXwo0Yl4cl4Y=;
        b=l2wBNmWu32bq2dVTDoGHyxYDhCck27kzvVS3BRG0umNefELPBM3G2m6+hOYIZcMZAw
         y3TP2GYJGZHq8jpGLPfF5OLhgiISSGqkkz5bLK8O2hc+0qZN8S2BbQRnTt5ugWx8gByZ
         MmKCnJMySF/AaoEClcbyIZUJJMp4LDMdxLxQ5q1nVoQ18ey9YD7iwRKfl6RxBQtRnUM/
         hKc615NTEcHs7q376xvtUSgsZGp4feTRoCUzhATaDHv8xeM89ZJ6t3Es3xtXqhnLvRrj
         6V8GU4Nq0sZ14VnCOL9emygxSoLDP0UC3H6SJeT1q+eZpB3cvxoBd24aRnIp1W4gAPNn
         8aeg==
X-Forwarded-Encrypted: i=1; AJvYcCVxNY6djCdq/INtoAotWUg9uezITRVA0KuMQUWVkYVZT3425YzTlnpUrAnTmgpWIZjqZ1tHDrImaKu1+zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+y+GPZAFq3cJOXg+5hIX6/8/by3zkok13KWnL9qMy6QwXTcQ
	M67kZApLYQr2MmcP+w02ZD4/7V8bwoR7l4YyfD0Sm7Rm/ZK3HSTl3oCyv9E8BYa2r0D5sLQ4x+8
	TKxrmb7941xYom26htECqXvksrpm0IhUXrxDMmLApBOE3t9QZKh42iJRmfZWnow==
X-Received: by 2002:adf:eac4:0:b0:37c:d2f0:7331 with SMTP id ffacd0b85a97d-3803ab1a8bbmr4410331f8f.0.1729868435653;
        Fri, 25 Oct 2024 08:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDs+qGkPhYGAaZ+QRORXNw+V6iATQJifr1mVHJ8hw/ogKGV0BNUWn6+ubNlvP8p8bNny4MNA==
X-Received: by 2002:adf:eac4:0:b0:37c:d2f0:7331 with SMTP id ffacd0b85a97d-3803ab1a8bbmr4410253f8f.0.1729868435070;
        Fri, 25 Oct 2024 08:00:35 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:34 -0700 (PDT)
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
Subject: [PATCH 00/10] Remove pcim_iomap_regions_request_all()
Date: Fri, 25 Oct 2024 16:59:43 +0200
Message-ID: <20241025145959.185373-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All Acked-by's are in place now.

Changes in v5:
  - Add Acked-by's from Alexander and Bharat (the latter sent off-list,
    because of some issue with receiving the previous patch sets).

Changes in v4:
  - Add Acked-by's from Giovanni and Kalle.

Changes in v3:
  - Add missing full stops to commit messages (Andy).

Changes in v2:
  - Fix a bug in patch №4 ("crypto: marvell ...") where an error code
    was not set before printing it. (Me)
  - Apply Damien's Reviewed- / Acked-by to patches 1, 2 and 10. (Damien)
  - Apply Serge's Acked-by to patch №7. (Serge)
  - Apply Jiri's Reviewed-by to patch №8. (Jiri)
  - Apply Takashi Iwai's Reviewed-by to patch №9. (Takashi)


Hi all,

the PCI subsystem is currently working on cleaning up its devres API. To
do so, a few functions will be replaced with better alternatives.

This series removes pcim_iomap_regions_request_all(), which has been
deprecated already, and accordingly replaces the calls to
pcim_iomap_table() (which were only necessary because of
pcim_iomap_regions_request_all() in the first place) with calls to
pcim_iomap().

Would be great if you can take a look whether this behaves as you
intended for your respective component.

Cheers,
Philipp

Philipp Stanner (10):
  PCI: Make pcim_request_all_regions() a public function
  ata: ahci: Replace deprecated PCI functions
  crypto: qat - replace deprecated PCI functions
  crypto: marvell - replace deprecated PCI functions
  intel_th: pci: Replace deprecated PCI functions
  wifi: iwlwifi: replace deprecated PCI functions
  ntb: idt: Replace deprecated PCI functions
  serial: rp2: Replace deprecated PCI functions
  ALSA: korg1212: Replace deprecated PCI functions
  PCI: Remove pcim_iomap_regions_request_all()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/ata/acard-ahci.c                      |  6 +-
 drivers/ata/ahci.c                            |  6 +-
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c  | 11 +++-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   | 11 +++-
 .../marvell/octeontx2/otx2_cptpf_main.c       | 14 +++--
 .../marvell/octeontx2/otx2_cptvf_main.c       | 13 ++--
 drivers/hwtracing/intel_th/pci.c              |  9 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++---
 drivers/ntb/hw/idt/ntb_hw_idt.c               | 13 ++--
 drivers/pci/devres.c                          | 59 +------------------
 drivers/tty/serial/rp2.c                      | 12 ++--
 include/linux/pci.h                           |  3 +-
 sound/pci/korg1212/korg1212.c                 |  6 +-
 14 files changed, 76 insertions(+), 104 deletions(-)

-- 
2.47.0

