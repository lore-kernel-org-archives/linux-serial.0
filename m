Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F93002DC
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916091; cv=none; b=OAAsXWrCSivpAtJyPRHVOivk4YhcH5z+ncFUTa4fz8gxooX5NUatlIXbsJl309d2lZRdAaFsP+B8s5ODx5IWHQV0Z1TwQ5lubFndtn3U7D0tPNPuAp2Z8zU8qwwqBdS3CoP4MHveHNslkX7L+OEurxHiTbCSzwC5dWEkcnOamsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916091; c=relaxed/simple;
	bh=OdkOVVUwyUCkh1B6JQsC3nJSBLu4XBNP6DBzk88L5hk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=p26G6j3d79bIq//6iI/e/iAxan3i5HNGfIkczVSFwc7Keg9kCIJGlgcTz9hk3goEFMPfEx1VTw81Jpcce1XrKjg50rlEZTsE10dbVGya9Eki+n5ZnlABaWV2d/Dnvu6S7SBM1v+YJrI1I4rvWWP4MrBto4N35CSjy7Ei7OX7cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=p6eaXQBz; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="p6eaXQBz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HgG9b4NdfrA6b/tB8cKuuqeuPQQJuFXGCUCkYQND6+4=; b=p6eaXQBzIZBLBEilc9JONoWtZh
	FMRH013T9/R8Ysg07+8kZgZbSJlv4s3AUszkaKAAUwJZ1oyHQ80Ma+v7DTDCl7mw/1eKX/UDEmnGo
	M775LHu4svq5u6IefbTrgISMz0EHOF+FZNrS6wT3xZwlQwyH6xyF7P83v5dVqQN0as24=;
Received: from [188.23.39.151] (helo=hornet.engleder.at)
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vVarc-000000005P3-1BtA;
	Tue, 16 Dec 2025 20:37:40 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH 0/3] serial: 8250_keba: follow ups from review
Date: Tue, 16 Dec 2025 20:37:23 +0100
Message-Id: <20251216193726.55449-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Andy Shevchenko and Ilpo Järvinen had some review comments after the
8250_keba driver was merged to tty/tty-next. So here are the follow ups
from the review to bring the driver in the expected shape.

Gerhard Engleder (3):
  serial: 8250_keba: Add missing includes
  serial: 8250_keba: Add ICR defines
  serial: 8250_keba: Use dev_err_probe()

 drivers/tty/serial/8250/8250_keba.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.39.5

