Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318626FA6F
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170423; cv=none; b=VJXGaCF+fEs9RCfnt4NyMsDltxN695xbLpJjWu8/HonL5Lz5ZQoricdRJbeANm3HFinMdklIy988iF7fUXidlHS4G+a3w8hzuaYklYEbbJZTdGLDv/QdC0eeNLuo64AnjtSXjSM7eQAuOFPziCCsAYTJ28Px6yVd4DEUKQBxAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170423; c=relaxed/simple;
	bh=xvXQhPP4ZRqcCri4q8Oi/Im7WM8JfEN515pvr3WL70Y=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=PciH2sqFW82h66WhPqF1f2RPnarj/sw406v8zYOiPyAr29qhf9luvgQ2NEUFvaBi1CaLVwQCDthGmBCdWpgqUOwQsQrNDVgyyFQH1rwm52fet1Cz7CHBttaAoDS/twe0KD6hv4SonkFq6hI+MIM5bDrjnSFxrsw5cCkkdYXgqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=Wz/1Bup8; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="Wz/1Bup8"
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I4e8Tm477505
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 12:40:18 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758170418; bh=mqgWEPSv27CzYJyNQezNG+Rd4sg=;
	h=From:To:Subject:Date;
	b=Wz/1Bup802Q13UYDlBndqqPFy48t3jYVhaXJM5QgNLdv4YvHtaY5QZWwBvK8a+1VA
	 mSaOtha2i9eh6SaWWDQ0FmBTEPI1hJQBV++Qow/S0byHeQAoQlYExzl5DrlrRWJcRm
	 Pl5HsRXE2kAXZFBiHQ2pZiWdCR/aACKG8qWfiSeU=
Received: from [127.0.0.1] (118-168-151-224.dynamic-ip.hinet.net [118.168.151.224])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I4ZfhJ805412
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 12:37:19 +0800
From: "Info - Albinayah 840" <Linux-serial@ms29.hinet.net>
To: linux-serial@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNzk1NzEgVGh1cnNkYXksIFNlcHRlbWJlciAxOCwgMjAyNSBhdCAwNjozNzoxOCBBTQ==?=
Message-ID: <674cd8c4-0d7d-f1d2-33d5-7e4800ef603f@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2025 04:37:19 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=LvQxyWdc c=0 sm=1 tr=0 ts=68cb8c80
	p=OrFXhexWvejrBOeqCD4A:9 a=e5F7gig5EpQPrytNyzNjOA==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

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
