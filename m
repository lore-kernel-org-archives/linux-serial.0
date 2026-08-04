Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A153ACA68;
	Tue,  4 Aug 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837236; cv=none; b=ECOcU79z/sYV3HLoAvZQoRHrQR2hcvVQwyj2vsgi7V1716DFU9Zhr8f+PQstQddy9f1uJgWBwU9851qeoBYO2Oe1wy8GcwvGkOW7ATv/5nw/sc3M26vEyFaA5aHxD/9qRgrWtfcAhCsd1oJ75dwSuXNpwp3CdXLe4F8tNs4kwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837236; c=relaxed/simple;
	bh=3qvbNnf2kTyEuxYwIk3iG7+xgB+027kjFFo6J7yYnfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3ZYfyZsakcGoLyuW73kjJCU+v4hEhdPijb4h/SLNbDq2pgEkdu7vTg85nLsMC4slt6mmfFfDZDIFuaAgmpg2bBoSVI+E+mgdCBjISw/I9T9L9EBXvKNco5DmP/HxrKW+WDJrSRIt4qkjrRseuC9uIXaC/4W1mfmu7ZbHxvhl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=k2Jmczvf; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="k2Jmczvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785837184;
	bh=owRv1HotSrrvggmAkxnIlFUedbNCLsIBqotgGco58ww=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=k2JmczvfbzQYg+oMuPNB+5ylhH2KIl7gj3cniUk+98w9O3HPjUC2TIOMGgzZ6s1ZQ
	 bXBbV+PqFFt85+m1yB0yVmASTaUFM3uKWkeMQQkAeVWVWzfRqJ3qfFhpQAcsiPIbUe
	 w74t8yPUMr3GdJSMXwDWXmxjJdWxsp1+5UiLuZxA=
X-QQ-mid: zesmtpsz6t1785837174tb4c829a3
X-QQ-Originating-IP: j3fSjw2qT01n7GwQIPNH24dQA1Rewy03PcG7rsI6Y58=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Aug 2026 17:52:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9562648362156521564
From: Yichong Chen <chenyichong@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	kees@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts: fix pty count limit off by one
Date: Tue,  4 Aug 2026 17:52:52 +0800
Message-Id: <20260804095252.889108-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2026080419-chatting-curve-e49c@gregkh>
References: <2026080419-chatting-curve-e49c@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M83iEva+1QDBx7XHXGA5/0T5pK3EJA4ydJ08F3FXzGUXTpwDJetWeFo4
	oCQsam+OQ/xIiFj9LWbCCSiztzFB82sm7Hgn97/iicuuKkGMfANpoVp13iPB7yS+sRtw1L2
	/ktuh0TVBYFMXKIn/LVFmQrfgUIVfyFXpuKnu1zIJ04kLPnD4Cg40Elu7QRogribHFHhtui
	T5UJSL8Ixq09DTA15xy0iKAuhmNczuZ/XXV9GJ7TL3K9J09Qc3DWVN8ePkAH+uQGzkQNV5/
	Q2u/EWhJmS6DxayofIPLBXyNiu4Q5llGMugQjnpwjM+RBtgQt4PdVgxW6oP8xCtTt82HMPL
	gAjfDelQ8A2bBK/tV3c+kGYJhY/VtewYIFb68RwwkJR3dp11MDTDhZUz4xlzvB64laPCNA7
	JE02FgGjb+ZcMRMDVoV+i1PR6D9GA76AAkAcz75y7VHCl1HgrxmUX0OKK3tfASOXwu4cRC9
	RNOkfUmboySSL/sYxImbXDWRkuJXb+9Z/kHKqhSoNt5PC7dFOduTxks3bKs1RtfFaw9nx5z
	6mUZfyZZDrvMK3ArAKOifVKG/vGwkPCfC2TUP86Z1ChpE2EzJoLZxEOGvnZJIiPXesY+F1X
	pkHlLI3IB9/cejPl3cf9ro4HZZVh79pJkXHynUbGB6NKTdYorl8doT58chJXnyFUl+wmxZA
	0ANU3QjTFuJGAEn/TJ54He9q8Ajv0QOBvcnvixKXaHVECAsf3PmAYKMDFpkU74pIQCsw73l
	7LWJLZw61+jp6ve9ToYFxY2B8Szad5D5Y6HCD9V5t39qruc2bcypZ6NUd2R2XsZTxZoR3O1
	qN574oOASQSiRFbFlpqXqOuj56ANEwhHDTZfB2kvzvYwfgHaCQLd4oI6ipAbiD2sjCUYYK/
	f0hhwSTPfOGi8x0ay1++pvG6oYmAhKAXMhdcGuPM2isDf4yAm81AwDuncUwR2qUMh/8uNQY
	Ok2+LjPhOdfhW/o8RGw2BhM5/1W1eikaxwWP3grXIOoNIQSFJjfg6+MVNZ4KFKjevEsZ05+
	c6EBFQYlj0KTZ0tv5Uc6t0FjFpZdTsWDfYOJLxhi+c+/qadNAu
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi Greg,

Yes, this is user-visible.

The reason I sent the patch is that this used to allow pty_count to reach
the configured limit.  Before commit 0f0a0e54a2a1 ("devpts: Convert to new
IDA API"), devpts_new_index() checked the old pty_count first and only
incremented it after the allocation succeeded:

  if (pty_count >= limit)
          return -ENOSPC;
  ...
  pty_count++;

After that commit, the code started using atomic_inc_return(), but kept the
>= comparison:

  if (atomic_inc_return(&pty_count) >= limit)
          goto out;

So a count equal to the configured limit became rejected.  That makes
kernel.pty.max behave as an effective max - 1 limit.

I thought allowing the count to reach kernel.pty.max again would better
match the usual interpretation of a "max" sysctl.  But I agree this also
changes visible behavior again, and the current max - 1 behavior has been
around since 2018.

So if you prefer to preserve the existing behavior for compatibility, I am
fine with dropping the patch.

Thanks,
Yichong
