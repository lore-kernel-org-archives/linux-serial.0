Received: from cmsr-t-8.hinet.net (cmsr-t-8.hinet.net [203.69.209.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758491459FA
	for <linux-serial@vger.kernel.org>; Sat, 30 Aug 2025 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756587022; cv=none; b=fytK8v1Xu51snaMqw4FB31NSXwVPZPig2AvQIL1adg6cXpMKu913Y5jxwGze/e6Lwl+4hVw2DTb5aU/7ClLz7FKynR4D+um7nCE3D6eR6zScF3Qn+sC0Zi3tlPyc0jbWIyADqFAPZsnrmc0/G60ZxgJju8oSzcwdwLHfoAnk13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756587022; c=relaxed/simple;
	bh=xvXQhPP4ZRqcCri4q8Oi/Im7WM8JfEN515pvr3WL70Y=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ZqNLPuArJjGb92BcOhj0HwWU4B/xJoO1mUMcjz4gPbqSs+JBrtt8k8X+GjeAvyQjCDo8UI4CYN0TpWSmxQ1zvy/0m0UI6PRjLpowMvS1DddQbsnsLKjgiHvKYAFJedNWfJK2iNoSSRnd4PoNa19t5S+JKSZjt9R8wklofLrOCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=VtHjxXKP; arc=none smtp.client-ip=203.69.209.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="VtHjxXKP"
Received: from cmsr8.hinet.net ([10.199.216.87])
	by cmsr-t-8.hinet.net (8.15.2/8.15.2) with ESMTPS id 57UKCu9u312376
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Sun, 31 Aug 2025 04:12:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1756584777; bh=xvXQhPP4ZRqcCri4q8Oi/Im7WM8JfEN515pvr3WL70Y=;
	h=From:To:Subject:Date;
	b=VtHjxXKPbAhYZRPEh1cMyITY85nhf6dkMXVW/FPvz3GpRnqqB8iiYKSyaEaSdvv9t
	 +/3LBMNr6187VWV1xpAOoFX8n8kZV2Ipuq8NwdF1YBNPHS0Qm3KPQyCA1o3bOA7NlK
	 H2JGVGu5rcWl9lCphk0om0qtO5DzWz1hE4peS2cj/Y0s1DNAXgWoMPl3JRZ+dC0aQQ
	 nkLjhCe9TVfb5waTAT8zwIcn8bYECmmzKT0ipFiz1im6HB3FyVcJpTfDX7OzEHhfLF
	 gSCmdOgyhVotLiK2oQ0bMvdqNVfDnK3wHWFhEZ+JnNXyR+uCTpkLke3UnZhh6ZUx07
	 qCJJ9Z/VdxldA==
Received: from [127.0.0.1] (61-230-192-37.dynamic-ip.hinet.net [61.230.192.37])
	by cmsr8.hinet.net (8.15.2/8.15.2) with ESMTPS id 57UK9EmA863196
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Sun, 31 Aug 2025 04:12:55 +0800
From: "Info - Albinayah 829" <Linux-serial@ms29.hinet.net>
To: linux-serial@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMTk2NTggU2F0dXJkYXksIEF1Z3VzdCAzMCwgMjAyNSBhdCAxMDoxMjo1NCBQTQ==?=
Message-ID: <03ed2b18-3b70-351b-915a-87b086bbb509@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Aug 2025 20:12:55 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=ZJd0mm7b c=1 sm=1 tr=0 ts=68b35b48
	a=v5BfitmIEQD35Mg+6JuSWA==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=OrFXhexWvejrBOeqCD4A:9 a=QEXdDO2ut3YA:10

Hi Linux-serial,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading
