Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C708662B
	for <linux-serial@vger.kernel.org>; Tue, 16 Apr 2024 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270957; cv=none; b=ltxi2i8pCdZo6aSewm4s9CVg7jxIgaPfDSdLZ1GmDSiYu9JBxbQ31pZvNvHrgTqHKEg2+orX/bL0XJDiwpXAgoepuddKRyIVeqzoHUe0hVDbi1G2n9V8u8/5IigPKmx2mPIZbs3k1bfKQl3zamVHjpPnr2T9zX2V/g7xa78+Uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270957; c=relaxed/simple;
	bh=QzaXJp3fRmgFSdc4E+CBAgut+j23yvZ7rxM6Zesvzy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niXrl4XcbmkYtkzV9SPAWRcN7ST+8XL+BiAYyiF+ganECFRZh/cc38w+P/wT8QbvqC7Wsa59bVUCWy6OmRI5ledHz005v530BazTc+sgcaMHmycrRAuubS1pETp6bFh/O7C2FCVsK7RNzRLE31Quei0jvY+plv9kxbxuwAYKO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VMSi9Vjh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VMSi9Vjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=G4irgf2RtW4Ubq
	PlxZoWpsEr8xGEeaVxEao1976prvY=; b=VMSi9Vjhpm2RFEtcaoMJWhCmXPuCT3
	l22DoSWa+Amf9+HXYhilSot5sxoZbstyg62fOpR5Nu0CmaTxr2joHayeN+ReED1Q
	U9XWgD1WlJ4xtqqySCx7yC+0NBo1wniBo+MtylJMkxCFVJOZBF/cmpvyWi9ygK5U
	INrDyls99BGpcX9TKfzbbD20qK7MeCXXmvXIyq1qrdodoB9WxS2i9B8w7LKKzKmi
	erm6xYQlBvvRTRGAQtsR1vnJmwW1i71cVXjJeR817/Jm9HzqVuX7RyDBRpG7m+Zf
	1w6zGmb5/GKsyFyNOnBKVJ/z5Y7KoFNefiYQcJap4oFpPHhcnznacfew==
Received: (qmail 2408439 invoked from network); 16 Apr 2024 14:35:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Apr 2024 14:35:51 +0200
X-UD-Smtp-Session: l3s3148p1@JgJ1+jUW3psgAwDPXxiyACzheF6dGXh7
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 0/2] serial: sci: fix OOPS because of wrongly running hrtimer
Date: Tue, 16 Apr 2024 14:35:46 +0200
Message-ID: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dirk sent a very interesting bug report[1]. This series is what I found
out by reviewing the driver. It is not tested yet because I couldn't
trigger the code path yet. The console still works normally with these
patches. Still, I am already curious in hearing your opinions, so here
is what I have...

[1] https://lore.kernel.org/r/ee6c9e16-9f29-450e-81da-4a8dceaa8fc7@de.bosch.com

Wolfram Sang (2):
  serial: sh-sci: start hrtimer after setting up DMA
  serial: sh-sci: always cancel hrtimer when DMA RX is invalidated

 drivers/tty/serial/sh-sci.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
2.43.0

