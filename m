Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F271C69D;
	Wed, 10 Dec 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765332538; cv=none; b=buM7txXnFpTaVses2dRf1uW74HlhSFF2DMDoNziSeDbc6YGMuvBzOSMIIOtI2e9+Nl8+jUYpIaqN/H+0PVXdcNiQ2x3ORge36tdxV/k5oRWJaytH+Jm1csxFzj+9IPQQ2Y2M2kHQdrEs5KG3LQnqyZ47xpUlz0zi7f1sX6hVyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765332538; c=relaxed/simple;
	bh=qHIbkjFPWxaSjKu5lnGkFFJMcg0Grzlnzz/K6SpjUsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYOI3JbvphEnghUaLUDouBMfAoP9ltCX/ZfQeUrpUNSJAyNSZurbhz83yET5F9nIHTyh8+iLD+Jwlb/gP4BaSTYcJoDNu48qdL2cCVcZm++HkJw9V+ucK1PVxGTmECtU3copdghEZf3P9bl+VdMW+zMkYBi3U9aE4z0A3n5SdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LvtZFArT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LvtZFArT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OZ
	gTThVa9f2WvEPJkU0lKhuahX9MiY8zmkHaCNUHUzE=; b=LvtZFArTpekQRB1EpH
	EmgVdbKNi4e18SZPtE7HYajpCINHvHFb3DD+oCE9UEvDRoVO6JqdZR/I79x/n4zk
	18M8WKw81X+Qy31LFsPS53gGAW2aY3TdKpmCV9pj3tglTg8jQKOOk/jKxDmxKSac
	luoCSIavF8leDYNAddp0Fo0hI=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDX398R1jhp7uO9HQ--.13064S2;
	Wed, 10 Dec 2025 10:08:18 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v5] tty: tty_port: add workqueue to flip tty buffer
Date: Wed, 10 Dec 2025 10:08:17 +0800
Message-Id: <20251210020817.3703454-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6db427e4-4a82-4c63-b840-92654baf7e6b@kernel.org>
References: <6db427e4-4a82-4c63-b840-92654baf7e6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDX398R1jhp7uO9HQ--.13064S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAw4fKF47Jr1fCFWrZF17trb_yoWxXrg_Cr
	W7X3ZrKF4DCF1UX3WDGry7ua1jy3WDX3Z3ta4YyrW5Z3ySq348JFs3Xr9xXryrXw13XF9r
	AF47ZF95AFnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREjjg5UUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvxIiLGk41hLjdwAA3i

Dear Jiri,

On Mon, 8 Dec 2025 08:26:51 +0100 Jiri Slaby <jirislaby@kernel.org> wrote:

> > +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> > +		driver->flip_wq = alloc_workqueue("%s-flip-wq",
> > +						WQ_UNBOUND | WQ_SYSFS,
> > +						0, driver->name);
> 
> Do you have to wrap the line here?

It looks like I need to add line breaks:

./scripts/checkpatch.pl 0001-tty-tty_port-add-workqueue-to-flip-tty-buffer.patch

WARNING: line length of 104 exceeds 100 columns
#227: FILE: drivers/tty/tty_io.c:3450:
+               driver->flip_wq = alloc_workqueue("%s-flip-wq", WQ_UNBOUND | WQ_SYSFS, 0, driver->name);

--
Xin Zhao

