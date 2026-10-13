Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913E4E325C;
	Tue, 13 Oct 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903244; cv=none; b=BNJxqn0cG9ZdudSxALMLUuQ7OEhYLyuS60+hTDrLKycyk5Vr2v5THsFqATxmR+NZoVTdqYwebmrOBPganhuRXqmd3bqF+l44OGpgyIEsokxXRbWiqZjK14EFELFGZX4qOfpZA1q3LTds/w4EBH391DqZRDU/H6FR7DTBtMgY+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903244; c=relaxed/simple;
	bh=P+CPU7t17pFOxuS59UGTMMiidILK5onemkd1D6VSpns=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Sx2dhMI7uZ9VtfZ/dT2V83SB8Dq2CyNuFctc+GFNjlvQPsSWqmu1k8kyuAEf6sjv5dwZokWvZyi0TkX1ZkM9kU0U2v8qvUCIL//ADD+BVC5psUj1lnrhb8zdrpKjlECOMjn/8rM55UqOJzHZ1CDFTGVcZWip+zRHNmsWIzC+7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=e8MFJKD1; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="e8MFJKD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791903231; bh=zfHUEK5r+Q8EsAo7+VJbXKLZtAdkraVczSGBW8lA+Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8MFJKD1Ty3PMm3kDqlYEaq1bHeJEk/L57X5Z1ERqBvOSM9+0HomDy96cYOqnds/S
	 Qg+y7DJy3tCVGcGviEAziUrPI09a5VH8rDZhzTjH1c2cAfAFRzwtF5Ir7LtB/TAY6u
	 SwhWqKllnYlPS4j0roeVTZ8wfj57msVgbP7LR5HY=
Received: from localhost.localdomain ([14.116.239.36])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id D718F4A0; Tue, 13 Oct 2026 22:53:49 +0800
X-QQ-mid: xmsmtpt1791903229td3cgoi6h
Message-ID: <tencent_057ED543A755947CC4918458329DC07A8E0A@qq.com>
X-QQ-XMAILINFO: NCmjBvJFq6XNSgPw2gx3LwztJk2cKPW0fhvDeoQLrzZgrwxsoAAJusCY8fDfF0
	 Z5y502Gg+TP1ENMQfla89C3kym2zNcamcGvcQBGRZqwTVSPDT9ubvSyTtNRa/GnqmjhP1UoYaWDC
	 MLVNM3Ez13IKP/w/AUzD1ZDndTML/jLJdIjKgBrexE411RkSqXL6PQMy4AEbgehCV8egVxxLpWmX
	 jrsJiuopB8LkaV9sltbhOX4m+AMdwc6iD0qVWoDMVkn+WTo3YKMJOBShWU2bigpYzHsAu+K4AS4x
	 mHTsOu/vwfDwQ4VlG3ICpcBtEwHRXk86wjojVy0HQSQZA/g6zuTZxswY2wVTPeVjOUtpsCqwk0Kc
	 CnWd8IV3nwTDDWn7flWSerOQYejCLHfZjgZmPOC3KGxhSEeNEQGTHkT9UH1IERxvRN8POkAQUfAO
	 FRd6iUCmXXi9AFouiwvW80oMwLsnBzcH4/yJzTl7jkKSnybJ43Wv3SEBARHQBixiuccFMEK4ngkb
	 oCroNFLpFfRjAfIm2DLecHNEEm55+5sXx1+npzJmeZZhmjYwTkBWIqbK7PctqFqTGJ9WpVxxaDrh
	 86IRDyNCuSC7EVP7A4FQS4DWVv1wFBWswCPcu04F7R67qvdFOgeOakH9ZKD/6H5CnlLj+1+lHj+q
	 wEZ6ZJUpfUUcSDG3kQQ2NjCuiip5MNYduU6Z2amkPz6n9KxbtsQsDV6qhbEHNHW+X0UkorOsOYEq
	 1xCoHFzc1zNkawgREbC2AopxXEixwUUl3VTzgSyDyvFYOh52eU0EzCagpg/slccMbkjlGlE7gBxf
	 u0Y2avAUaFeAXDqauh49oaM1c2a18NDrayXXHWmoMsZbaWzrtkivQQoDEjxYo1n1GIhFdofgCJy8
	 NkN7Tf4UF9BQV6u33rJKDcpDjVMdkpfM1zkExfvJpAVbD+HzyDkrXdXWiz9QeUI5OeiWnZAnlrZA
	 XG7Z2mVLnSLe33sjZ7nHOwHgLeIaXkHFaFs6B8C9ig8EYLQvrHoET1khG1MuIGyHzyfmeq6znSyV
	 YkvOOLPiqlKtjTsL2L
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: shatyuka@qq.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: dcc: Detect JTAG connection only on CPU core 0
Date: Tue, 13 Oct 2026 22:53:49 +0800
X-OQ-MSGID: <20261013145349.1351923-1-shatyuka@qq.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <2026101305-maritime-wilder-2006@gregkh>
References: <2026101305-maritime-wilder-2006@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

> Please use your real name in Signed-off-by.

Sorry about that. I'll send a v2 patch with my real name.

> > +/* Cached result of hvc_dcc_check() */
> > +static bool dcc_core0_available;
> 
> Shouldn't this be per-device?

There is only one HVC DCC instance, hvc0. No need to store this per
device.

> And how was this tested?

I tested this on an SMP system with no JTAG connected:

  # stty -F /dev/hvc0
  stty: can't open '/dev/hvc0': No such device

With the SMP migration issue present, the same command succeeds and
prints the terminal characteristics, because it falsely detects DCC
as available.

Best regards,
Jiannan Du

