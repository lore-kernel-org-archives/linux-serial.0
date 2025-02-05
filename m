Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A25213240
	for <linux-serial@vger.kernel.org>; Wed,  5 Feb 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746617; cv=none; b=g/FD2PsoZtxIFiXCELIEToOmwawyjD7o1sm5HxE2PwSo8fo0XHaXDnrPvZCRqjuJUV49eNJEOxcJV6u0gPe8P8DCmoAIxFRl5pyPB8lDaDpdFiOz3Dqa8aKUtvnleWnht7MxkPusWiOSOuRhxv2CEkF4ToyQIirpNPszznjx/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746617; c=relaxed/simple;
	bh=L/CmYd7y7NKrcUEKNnZykph9GGavFaQ449DtmmF2Dyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GHaVo6OfQ2EN3it8yDOltH+mtbkZCY0mnHTwCpVuszMF7DKh1HhpuAthCJ6lZB2qJX7aMZrWDtgBbCC5CMSHAhlzGQZZtQYcBosCJKRkOrsrv/StP5y0YBkN8+Q6meSpgfwFOJedH2fUc6RAL6Q/4iZeS07dlT/zqtiOyyXxDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NXWJAh5/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NXWJAh5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738746612; x=1739351412; i=wahrenst@gmx.net;
	bh=+S6G4zmkA5YzJTmgMp+eR+5O8QLItpFjyk2X1UppwnM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NXWJAh5/TP0katLwlPIkMz4gW1nMygeAwVIc9QKTIGd8F3iLQ05GxXm6j39g81a/
	 yV0DPJakaW/+/hGOaIT/2axh8rlg3XS1DP6noOG3sE1Y2rASjH9iuU0ofdUHoR5KM
	 LUElrviAffarXTH/1AOi3B4MnmNwBvAPIibU4RJvlCvN1nAALAa7VP6SEmd7sbtTa
	 NVkkPdCxKZwx1Au8WlHg642fzbz2Q6We1Mijhj7bMSIjUCzDj3UUyZ74GesoSj7DV
	 ProE8gcJh3M7OT/slYg17cMlIVRzIINL67/UeUbUtBMNQHXPpxlxIxdYUW+wgv198
	 CeMLTC/ZtjxQGw6acw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1ta42S1z5A-002ape; Wed, 05
 Feb 2025 10:10:12 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Luke Wang <ziniu.wang_1@nxp.com>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] tty: serial: fsl_lpuart: Make interrupt name distinct
Date: Wed,  5 Feb 2025 10:10:07 +0100
Message-Id: <20250205091007.4528-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:60Tc+1nIQ9nSFeQy+OlyzbUZCfnlD2oCBLSginRi6opc//X7uOb
 0PM7u/75AlC9rhPjKduoQfozROIpMV/lE3LsNPtQCbXn51Lt0Xva/mdv5XC2F9rv5xF6cGT
 FVWQNryz5HHI62wVv4756mgg/wDt3nHPNZRjznxi+Q5x5Oefiy9yx3ORqUHJfqrkwT9oP6G
 9EFO56uJ0Wu9NOmoLqXiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+udilvF9vPM=;1P0AXIvJe/Fy0DmsA/dAQLODzdr
 jkatR2oOVXuNJo7osLepH56asvcNnkJlkNsImJG0SkIjiNGIzhGIe6asdsMl07KhJ6ncr4dJF
 o7J86t3VkYiatuOHxvbIR7I3kQnh0w9WpieaRVBi/oC/ISgJfoO22ESrY74shCdbgAzR0Pg4Y
 AVI0E+1kMXLmXERy1PbTUCl1/TPBIEI+HwX+5bVZSOveymFpldBr7wtgPtwW670Hisqy5Uuwq
 602rsSHmjarX8DBAva7n/zjHyWEfN++lRWFlg0eMnUDVGCl+N0RNDkLRMoz15WxeFF9McUcdw
 08aIOJaKp5a2eFxhnDPxHEB4RPlJkI5ZrT3Wor0vIgyjR/Xiutd59VdmsooL9sZhlSn+JXwwl
 FjfqbCQ68wf3GL7C4P2et7xrUTgPISU/IJraniAyD7TUWHr4Ulzbe+u0FNKCf3u9hPdZZ+Ddg
 Bt9c37UXN72FTXlCZAQNz1mpQNJFM865o0OUXZ3PjUhnfYv+l9zfL+5SYNToeA8l1lp7iL1IU
 DzGbfYgUlil6oZFGviY0m+CHBRRq1i7AStRPZiAHKVaB0iTrs5gxZi/E3hj3M+a/qf4ZlkJu2
 a+K80OihyVLqGqd+xhO6+RzAgB2Vkj86aFAGidoBNBCnfBh46QUv+gJjqbpgJQN8U7D+tjj63
 NvNtAC0+EYZVEvj022B1C90QtFHg1tqUZP63dDLYjjjQ6f3E5lieao1ToGn4ODPEJmwDa6t4v
 8a5fpwVn241eVkB+Oz9VMX3QlHIYQAPu2E02ar4MRYOruy4veyvQrg1kvzfRyin634PnTfwti
 DbYtEW2cUSePItOwHgnBMqSX0N0lV5rbbJdAAKid4oVCnvfkP2gbzrcmB8CaqCAVAd/sfhAmh
 +dOVNeI86BB3n9ADgHlI5eO3L5kuDZNZX9j6lHow6ppZ+3uA4ee4LMjIqkAo4s0+4zYvQhUYA
 rNt3SUrPJhYWZP2WeNMdS8i6h9HRLBlP1AbTimCjBNFRJ104j4GHvOA5hlZ+Ny/107heEXG73
 jJpHDDAp/LUzsT4MJy/4uooRc/wcAloOQwH+ZHlhUSxJ2nQS9J5IYxLQzz1vCHRjZoYRY7nVT
 Z+IJWnGyzIQkgA/oCmLQGcxBOr98ANRh0Ja5rM0saicGfRJ39uxfTuGSoPsvqVL3onTer6+oo
 MAFnkXORlXL5gDXYVRbeR/p+QpE6HcnEHAWkK4zB7Bb4vb8FmintDQd5/xOisdkNTgrCk/m2r
 ooXU1JPOw/6MIpb1Rm+G2230DUIASPD6du3RQD+whDEmXkddaWWSCWnEuT9xIHDsC2oySqjrA
 A/3D9JMQFPWPOmTsgsJjysrbDhyd68dQW5BHme65/CvL4s=

SoCs like the i.MX93 have several lpuart interfaces, but fsl_lpuart
uses the driver name to request the IRQ. This makes it hard to
identify interfaces from outputs like /proc/interrupts .
So use the dev_name() for requesting instead.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpua=
rt.c
index c91b9d9818cd..91d02c55c470 100644
=2D-- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2954,7 +2954,7 @@ static int lpuart_probe(struct platform_device *pdev=
)
 		goto failed_attach_port;

 	ret =3D devm_request_irq(&pdev->dev, sport->port.irq, handler, 0,
-				DRIVER_NAME, sport);
+			       dev_name(&pdev->dev), sport);
 	if (ret)
 		goto failed_irq_request;

=2D-
2.34.1

