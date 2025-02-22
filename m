Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC71B2182;
	Sat, 22 Feb 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740230036; cv=none; b=Sno9OZzqh4TG+W/Vl4pI+H+1OCV8VEiXX45oS2C/v+c6uGR4u3QPTmDT28gqdBdcjNxPG55M3rViGOvQIYHcKF4+33AVFmxX2eQ2x/ndVbD4uCMssTosMaQjz19C45bvYR01x9UG1ij63Ef1nNk87qylOpBd+uIRdFjzOZztJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740230036; c=relaxed/simple;
	bh=mXH3JYuC1B4cV90eQ7b4EH0JW2bZwrAnvkXGzrs39eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDcvVZlbnftBofWM7iN7h73iwa0McvyfdaNFtPkpV5BOe+GdGI63HwP5o+HMVzvbghPbZSuSiKQ6ylO7/ezRFn22dYCGVX31rUYrhzmVVhuVd2pgQgaQllv2z5sZCJdGnabUDNSCIL5zEJIf6+T+oaGIhUjCNSb8mrnTRcHGJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HzxCS20N; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HzxCS20N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740230004;
	bh=mXH3JYuC1B4cV90eQ7b4EH0JW2bZwrAnvkXGzrs39eQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HzxCS20Nz2HupagQrpVeD5TAFNicRRwGXk/TZbhWos/6iPNWM3T8rmkrfEw6jMUbO
	 bOIpgiyHmoKaGC8SPE2mwdMFchRXSRSMkvYYg7DHX4LtiPqcII7zxyCsvi/HlhHYSY
	 Ade9DvRZbSDRoQM/WEO/FnK+ky+N9sk18huwGPLg=
X-QQ-mid: bizesmtp91t1740229998t3nkubr3
X-QQ-Originating-IP: eZmeH4T0oGceHFRLLdVjuh3gSKIayh57qi3KGFtbWB8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 22 Feb 2025 21:13:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12607526295032000996
From: Wentao Guan <guanwentao@uniontech.com>
To: jkeeping@inmusicbrands.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] serial: 8250: Fix fifo underflow on flush
Date: Sat, 22 Feb 2025 21:13:16 +0800
Message-Id: <20250222131316.23214-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2025021859-renewal-onto-1877@gregkh>
References: <2025021859-renewal-onto-1877@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NQDSFSrlZSaixcUw1G7qoCDKItoIY5PwNMmfTR69Ms3B6Wnj2rpgDaxH
	ja0jLbQexEBRMWT8IddfotcJwdmZ6inwYrwuuDoHbOYs+8RU1bDyyRoNAzXojdP4MkQ4nAZ
	H5ax++KxBjVPawdIjWgG5sFi3cJsAcjhmH1rJFN112LE0xrwNLSR+wp1YXO867A8oCAP8ZI
	ezma7AzX62XzfeVB12mL4DOCs6hODHxZYahCPtoGYu8DstnWrLFWczOsaI94yn1OACthIyx
	e6ZFfTPirYhFiTZD50/RlNWjCgibhLCZQsX6lX3AAm+ZAROKiJEFgO1X/LTRrQ+Ue4autMS
	qu1zfVc4bqdWJJJ37vJXxE0FQspnVZeaf+nYLSTU1cCrJ3adC4VMHTIAn9H+C/R9AHT9Kvr
	9DcoSkCyfmJPhTPczkDt+vwa9RAiNS0dFBQ5BwTfRBpQXrO2qVVgiD19ocQnqYqRDsXtEzq
	CnfZ483VNAJGBf0qdd7wqKd5hj91jDzXwF/HcwFoNSFqKdpA6RYZFGt2nGqM+lU0Wwb/yLX
	TDg6grJRCCavWVgc8x+5RPUcov4XmqrLPpzIoVU/egFD9Aijl5JOO0dv2BJlW1kMNXYZMGP
	0pMX3uM0OpVoV+K1MJ3qPob8foRg6jTpSj3Uv6mIxP2cChnv9+QmccIhuipaGG4Y0hjVGqK
	30D6nDF3ngGvULOAHoh66srrYvid5Y6it+SBmPxifyCtXq49409g7aToKL6b3qtUTmoZ+Vg
	InqwMAlz2WdVGr0srePqFBvc3ayXaJ/gO1kTfLCxXnz1fRHVvXG4T+TIBTP4/iTfkvOORwh
	45IEuuUKlpL9hFbMQ3mLmTj+dfO5Y26G/o6GoHmByf1ZUf2O/mR9s9ID5ozfbmtD5AlRU6X
	Zhc5gAa1Fhqn2MWIZ+xb1+95Xg8mqYy5LYcSBgyO1ApZIdJOC8JpCLeUXI3nYDVoMZ2OQYa
	SUDHPYY1pwqivnzdNgFxU4xW6kxWJBWR8tS8nQ0adobHDCH01UsyCQJD5
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

It seems strange that call 'dmaengine_terminate_async( **dma->rxchan** );' in
'serial8250_ **tx** _dma_flush' during code review.
I am not a professional reviewer in this module, could you explaim the change?

BRs
Wentao Guan
