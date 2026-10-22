Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697852;
	b=MaYoo01sPys8NETYQ5zVyW5pEBG/JhC0rf4qmoB6LYw1+SSDVUfXS5QM65TZrzlg+xVK
	 /6ZehdZTf0OZ2gK4cnrOtJS55Z68YclhaLnbCUoJpdqnOob0I9kyHQJLL7gEaPvMIH7D3
	 L0GIzQ246mXlG1ll9FstBVCbErQhP21rBHpEtF7n8cQsONHU70pk1SkoUP9Pts8649kWS
	 XrfjRAlp1L1f4VeyXFUerm8JYYgE5vj/Ij6mn8eBzcea9g5j/kC4VpAlpOpFm8riyEH/M
	 s7TJrxLRFR91fx3zOXH2bsFoKNn8hdp3/1LRscs8Xl9X7s5FctZZEasNPEh7qTXowow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697852;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ELoY4ouw+GbHIxZXE0kClky3cyUMs3OifzjnTY/xacI=;
	b=UEzrqp8cT6pS2ygI8VG7l8eObrH0wHimmHeO2zO87Up7v560ZWYDG+qVLWASLe/BEP4o
	 yzxwMi4v9kbqrAahH3AHxFet4z15BCObqySFo7dOYe52KNuo0KDMIPp3ncDxgy/idEcXU
	 7354fk2dBBMpo3qLCFRFSHX31SGxwVexx1kYzwn+ZNO1+Z+D8oKn7/ZGIHMOYmQD93SRJ
	 y7x10yzV/GbK09HxX/oXDeCnFm9uXPIwM0jER9BFpJtlZtkdV1TOmnTuhWcHAXi2BvENd
	 zVLEpedGGSZbgwxX5AIn7Rx1hp0mGrWZ0MOm1rPvnJwPMJjooeF5mHr2VG4geKPJPuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=kItssnuZ;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C50606A326;
	Thu, 22 Oct 2026 19:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C50606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=kItssnuZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1792697849; x=1792957049;
	bh=ELoY4ouw+GbHIxZXE0kClky3cyUMs3OifzjnTY/xacI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kItssnuZcUN39djG3egy0E6ZNHiOb8YDHYqEMkK6Rz6Sb6rvOyJEYkWOnud/lE6g+
	 J7yeDQfmfgfUVx4JfycTgTAl9JeOpVFwA7pT7Rd2evP6xn3uo3Ncr1BIzMW+uygtqe
	 Sa8Agw4H87gSxN6874ud1+vUSpYrP0fg9bd6HXGJdBJPIvrdKvdub34VkBmfOtORTH
	 ZbL+9HCZHEnCDFzDGQUOsUpAMsHKkD11P/XPuvT5y9sMkyIVkMwFjaxhxI75ddKYYc
	 2kwIAJw509DxQlD4Raq2MK3V7AZwkKlSPYxhxxovKUp4JNsAlyCn78ZDfqw3DXndpN
	 4S3GzdUQ3bDRQ==
X-Pm-Submission-Id: 4j9byc042bz2ScXH
From: Michael McAllister <me@michaelmcallister.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] serial: qcom-geni: Set UPSTAT_AUTOCTS for hardware flow control
Date: Thu, 22 Oct 2026 20:36:39 +0100
Message-ID: <179269779969.81501.12855437977656454312.geni-autocts-review-reply@michaelmcallister.org>
In-Reply-To: <8b077ae2-250b-4181-94bd-8b87e9927807@kernel.org>
References: <20261021202603.42888-1-me@michaelmcallister.org>
 <8b077ae2-250b-4181-94bd-8b87e9927807@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Good catch, no technical reason to do this just an oversight on my part
