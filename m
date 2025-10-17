Received: from cmsr-t-8.hinet.net (cmsr-t-8.hinet.net [203.69.209.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E423A98E
	for <linux-serial@vger.kernel.org>; Fri, 17 Oct 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687365; cv=none; b=pMAs+0tqM9oR7moOXBpsAXDG0sZuqI65BgwWKA7Rj8isLqCs3eTIMjxKo9cjBhiMPSIdXhIFzAwmSgGfxYAh+1+kEaCQIQHClyYQiLpoeG0fMa2NL+2PzAnM8Ml7zWyrB/oNIaReUR3O3+4bxrCppnYIugnhPiLcuRhBVrK22zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687365; c=relaxed/simple;
	bh=WrdEc21Lyu7YgLOUI8A0yi0sx4kmguhPjttxRcbEbV0=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Z+FWp/yniDAFxat3QirU0BW7+uTSyeiw2C9aj8VDVLsJ+kPKP6OubiYME0N/XLS4aQDfLcQIAhPseb4cCVwiR+I1X9LBAkW4csy9truKxyY5nPrlghaQNtWC2ypUaLhRU6TIaRZOnRXfnle3CDqZXnN89DXvl0jDS7prQrdbDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=Hm2dW2lR; arc=none smtp.client-ip=203.69.209.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="Hm2dW2lR"
Received: from cmsr7.hinet.net ([10.199.216.86])
	by cmsr-t-8.hinet.net (8.15.2/8.15.2) with ESMTPS id 59H7MSvY931182
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Fri, 17 Oct 2025 15:22:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1760685749; bh=WrdEc21Lyu7YgLOUI8A0yi0sx4kmguhPjttxRcbEbV0=;
	h=From:To:Subject:Date;
	b=Hm2dW2lRTrPFPILEBX4QdWZn5z1kZhSP2GtqUpfDEorMXPfEl9ViXtscOZDk6anJO
	 DLHNllRWtLqbVeuxuFOsbmRbgnNSsp+/mwFa1OwoXHRtd/FamUytsZ1IBCasWWmO6n
	 nrIZAKHiylPmNgyxt44CbyL+PVOHV2rHlSrPp9UM50teJUMW+CUbDyQhxEkuR8+jJC
	 CmLz218K1MWQT9R/UxG46PSauWe8C7xfR9OEwC8xeX9zvGFKhmtbMGFvyY+pA0ZhwZ
	 d7C955rlNkygeAGb1pXh1RjACs1nA+9A4wS3tVqkoF5WX+ioVnVxx+FupQIUQS0mMq
	 U8Z3w+D7IbITg==
Received: from [127.0.0.1] (218-164-149-150.dynamic-ip.hinet.net [218.164.149.150])
	by cmsr7.hinet.net (8.15.2/8.15.2) with ESMTPS id 59H7JemI476298
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Fri, 17 Oct 2025 15:22:27 +0800
From: "Purchase - PathnSitu 987" <Linux-serial@ms29.hinet.net>
To: linux-serial@vger.kernel.org
Reply-To: "Purchase - PathnSitu." <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TmV3IE9jdG9iZXIgT3JkZXIuIDUyMTEzIEZyaWRheSwgT2N0b2JlciAxNywgMjAyNSBhdCAwOToyMjoyNiBBTQ==?=
Message-ID: <bdf954d8-11b4-15e6-c421-43d97312528c@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Oct 2025 07:22:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=fop/Z04f c=1 sm=1 tr=0 ts=68f1eeb4
	a=LTSunQPlcsZIodFpDfL6WQ==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=9ibCsRhy7-NA9_nKIewA:9 a=QEXdDO2ut3YA:10

Hi Linux-serial,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

PathnSitu Trading
