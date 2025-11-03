Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAF1865FA
	for <linux-serial@vger.kernel.org>; Mon,  3 Nov 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131629; cv=none; b=qqRHTyl6bTFUHKo0rQoOuBenG8Kd5ZbNi0sKdQE/ncQ0UUxtFHIEZQiGc0sRr2s6WDDQioht+YCh/QVJc40ke+MpKzfgAgAJT/MqGxrL0Q/d38FGxDob7v2QjvZ+g/x6aN1rJZkErgGxwSvJ6+OamP0aDCFECLECuj4AFdyQFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131629; c=relaxed/simple;
	bh=WrdEc21Lyu7YgLOUI8A0yi0sx4kmguhPjttxRcbEbV0=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=PcSyY6wIJ40JsXxwkfyOT/EKb7ct1D5JPMt4KaweQYL599H1QQq22Vfw500U6/sKg6YWL7d+MkqTM0yVEvvPHWnEIbKPEAUmoIiMlY3kCblO3p5kq/Vu0rZAyrEpcRyMEF2oKGIQxggFDJnouG/878qNrdGO1EAcKqR91yNb1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net; spf=pass smtp.mailfrom=msa.hinet.net; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=cTT5Lb65; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msa.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="cTT5Lb65"
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A310KkH005343
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Mon, 3 Nov 2025 09:00:25 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1762131625; bh=jUfpDBAlJx416Si/8e9+JbpCOnc=;
	h=From:To:Subject:Date;
	b=cTT5Lb65g/uo8s4sVmLbNa8rC6HVwevNr4fEjNWtbsJM23QALGgcO0MhJAjYUMm8K
	 8IKqCz55cxKHnxcLQPXLESEQRMmw6QEQpoRWAvOHymm8UGJD+e2zADVmTclQgO83Us
	 43v+uFu9Fp4JBFyXoH5RVWjKbYSzuZTQkyozU6hU=
Received: from [127.0.0.1] (1-174-77-89.dynamic-ip.hinet.net [1.174.77.89])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A30tqOf739678
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Mon, 3 Nov 2025 08:57:20 +0800
From: Procurement 83631 <Linux-serial@msa.hinet.net>
To: linux-serial@vger.kernel.org
Reply-To: Procurement <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TkVXIFBPIDcwNzI3IE1vbmRheSwgTm92ZW1iZXIgMywgMjAyNSBhdCAwMTo1NzoxOCBBTQ==?=
Message-ID: <72627e71-9a41-8bbb-9541-5efbba628aa6@msa.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Nov 2025 00:57:19 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=KqTu2nWN c=1 sm=1 tr=0 ts=6907fdf1
	a=NK1ODRVW2PQyliTirzAx7g==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
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
