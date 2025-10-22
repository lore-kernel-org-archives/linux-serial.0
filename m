Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CB1E832A;
	Wed, 22 Oct 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153364; cv=none; b=LIbtjJ/LePNzQUMP7H/Dpn3/NfUoUdtig9qFfcsghIfVZZccW8FyLBefJS+AKXpk1piUj4WGKlMzDD7T8W+Yg99wCtcWqUIOQ+ExvX7v3nS0sxFarer/GKP/QrGpYef7+1di/r++rFxZNB9yDFmcxIQeQuSAZWzzfLOXjIBOqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153364; c=relaxed/simple;
	bh=JqfWxnVTT1ypdicUI7AC8IhNRcbcomoW0OwiZ35tAoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g108N2zcdrRgMuAq2bcPn7rDcwBa3T2A7OgxCb6qzbMHIgNqc05GTEGNQhoQlkGl8/BrAChP8Ujceq0V4qyQYccEI53MoEfswf2Rts4BT+GGBNpK4Cg8qt3FWAKS3FKVow8CNReAbew/rm6g8Ji6u3+tRNu4sxs4tHADwlV30RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TuvZrrCt; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TuvZrrCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rZ
	/lg3z1zDkgxuJypIf/Zk3oeyOe4TGBOeOsZlGv18g=; b=TuvZrrCtu/Rck3SJJ5
	zlV8vYHooWcpkklayYhqpJwO1st37YBHgLFiU/4oXmJATYf2kkq3Y/EF+IMiMiof
	3JSLheAYnh+Vu2/dGCA9OGnZ0+twexXS+8E3UZnWTO9zWogX1jVDkEg6XZS+/37y
	6g69R4V99VpmtPj0SqDYHh3IQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAHtBIxEflovIDnBg--.5272S2;
	Thu, 23 Oct 2025 01:15:31 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on specific cpu
Date: Thu, 23 Oct 2025 01:15:29 +0800
Message-Id: <20251022171529.259131-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aPkIUa73Xfr8NA-q@slm.duckdns.org>
References: <aPkIUa73Xfr8NA-q@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHtBIxEflovIDnBg--.5272S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1DZF1UZFWkCrW7WrWDCFg_yoWxAwcEgr
	ZFgr4kKF4UGr9F93W0gr4fArnYqryDGF18tFW8trnrJry3Aa93ArZ8urn5Wr43X34rXr9x
	Zw43Ww4UCrn7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtl1v7UUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgvuCmj4-VC6xAACsA

On Wed, 22 Oct 2025 06:37:37 -1000 Tejun Heo <tj@kernel.org> wrote:

> > Considering the current situation is still limited to the RT-Linux scenario, if
> > possible, I will add the logic to create this workqueue only when CONFIG_PREEMPT_RT
> > is enabled in the next patch. By setting WQ_SYS, it will allow user space to dynamically
> > modify it. Additionally, in tty_flip_buffer_push, I will check if a private workqueue
> > has been created; if so, I will use the private workqueue to queue the work task.
> 
> Creating a workqueue isn't that expensive. Might as well just always create
> a dedicated workqueue.

OK, I'll just always create one. Thanks.

--
Xin Zhao

