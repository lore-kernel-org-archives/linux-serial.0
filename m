Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687E1FB897;
	Wed, 13 Nov 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496279; cv=none; b=jcxdMKw2fbdC/deqsw7ZrSFXygQg9+ccbXoxD2hFXbxElB8KjrLBu02+sEnGMZLsjBRRp+XxN2uvKAk1vM8l6lNYhTfxCtf6b0mdrg8F6+C60+LkbHT5hqeL4SHK6Mv40N7R2dm3qpMF9trdQFBCC9GyMnPTb7s3IOUQ4wmOtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496279; c=relaxed/simple;
	bh=7IOmtBsoXUsjSZ/nwSZs90vr9M0qMVamz1gKQiMAu+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nBfBpCYOz/Zu3+RihziTl0b0oIQG8UL+vajT4pToNret4d0z285jXGux4USRanfT6ocGGEl+eZ04FaOhnjFQ36YCEtYrkSamEcXlWuVQ09Rz6EV6iVVbEViMOPU2cSqZhvcQeMaNbq5ud4CggjmYz/hMQXlxt2mhKhHfWja1lCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4ADB5Md2009431;
	Wed, 13 Nov 2024 19:05:22 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XpL5F0d0fz2L0nH8;
	Wed, 13 Nov 2024 19:04:17 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 13 Nov 2024 19:05:21 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Cixi
 Geng <cixi.geng@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Zhirong Qiu
	<Zhirong.Qiu@unisoc.com>
Subject: [PATCH 0/2] serial: sprd: Modification of UNISOC Platform UART Driver
Date: Wed, 13 Nov 2024 19:05:14 +0800
Message-ID: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4ADB5Md2009431

In order to be compatible with UNISOC's new UART IP, the UART driver uses
private data for adaptation. Patch1 adds UART timeout interrupt BIT17, and
the old project uses BIT13. In order to be compatible with all projects,
private data is used for adaptation. Patch2 adds a new compatible string.

Wenhua Lin (2):
  serial: sprd: Add support for sc9632
  dt-bindings: serial: Add a new compatible string for ums9632

 .../devicetree/bindings/serial/sprd-uart.yaml |  1 +
 drivers/tty/serial/sprd_serial.c              | 41 ++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.34.1
