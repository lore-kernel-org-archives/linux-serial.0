Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6711D6C56;
	Fri, 13 Sep 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216802; cv=none; b=UZLERGALnhsyMNGlOTbJt5org7iR2tYrx4qglZs6VTVIpmPFNFoo9yuTXNaKMybLtkRPymf+ztarGU6Fqk8sx4M35Af0QddQJsw1A1dMGZAFP7ouZhTDc7IdYdY8HpopZmb2ZIwYHlB9EyHrZdtEr55bprulX36o7ueBLvDy4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216802; c=relaxed/simple;
	bh=qAS2J7I9OmXjlgtNTpFsso9+HDg3yEapIFQ3CQadTa0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aq2K2cZO816JKTiL6IiVE+QbzSG/6FtreuoVq7eaDr784tR5xCyRP7m8haxWHDg527KrnC83N4DviE4PZ2yDy9K0fojkh0QlC2VwMt03O3Y+Sgw+9RnsI2p/TWTjSldny+6xzuXh8TgPjzlIjIERCzxhoFUzi3illYmvGuPUEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=KnFSccP+; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KnFSccP+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=oDfxX7m0Qa88E7MDrUP9Dvg8l9A6upYI0ekFaHyfiEw=; b=Kn
	FSccP+jm7JXhBqT3uF0umXJTJXL3DVxb4HCI5aPzKfWpW/yurZr3XLcPEIBN/DUL2UAuc0Q1taHsu
	HPk0LYrdNxREwdbXzAkHxh4OvDN9ZCr6rqGcAl4A+Cyemohp4rfvYuaZ5ZOVY/Q5EB7r1dQUrqXf0
	MSkfz42yjYEI8jRy+74ymSmBfvUlSU5cHnGEl0cvfHl4ISMzSHVbd0OMKJtc3x5lhHY87qBvlKlmn
	Zl1hi8eT3RWqRsF7T+GPSwAxHaqfky+cJzxcOYUXhBAAi56pd/yduH2DNieK5TpwpJZciURMrDKSO
	eGDlF9ijpKE9xsOiK6cyPuqP+fC+Siqw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp1qL-000DwN-8C; Fri, 13 Sep 2024 10:39:53 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp1qK-00039j-0P;
	Fri, 13 Sep 2024 10:39:52 +0200
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH 0/2] serial: imx: Grab port lock in
 imx_uart_enable_wakeup()
Date: Fri, 13 Sep 2024 10:39:48 +0200
Message-Id: <20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFT642YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0NjXZD6xBzdzNwK3Zz85Oy0zApdS0NDE8OU5DRjQwsjJaDGgqJUoDD
 Y0OjY2loA6jvgGGQAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 John Ogness <john.ogness@linuxtronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726216791; l=455;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=qAS2J7I9OmXjlgtNTpFsso9+HDg3yEapIFQ3CQadTa0=;
 b=8AuxQ+kdZGdKTjyhUXwPpc1vv+L7Ghnlln/WCfo5HKb3XPOQeszOE1wxDwzL5vVmbI0E1FHUr
 HJls5MtUhCHDSXe4B7UqiK6L/8M/OMl1+7yMCD2JzQrGRtLNmu64+fY
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Esben Haabendal (2):
      serial: imx: Grab port lock in imx_uart_enable_wakeup()
      serial: imx: Add more comments on port lock status

 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240913-serial-imx-lockfix-91141dcf3182

Best regards,
-- 
Esben Haabendal <esben@geanix.com>

