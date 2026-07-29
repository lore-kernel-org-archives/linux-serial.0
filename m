Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210A473C6D
	for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324407; cv=none; b=NoND/FGSJ4oJ2DKp9sVy1WCiDZyc3DO6DbcgRVUI/D5yyyLJycCZF++2iz7x6yPLTRLBkdkuhxVCYhWyvHjSdUaKU2af42wAknqX2nt6TsXnfAyVT80IbZDs7ry+7anrOwpNMTEFR8sIlO+sPzndcSy6yzkCRUKR0I8w9PhRMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324407; c=relaxed/simple;
	bh=APe9iUqSOAsuaQv1btRgyowYCJtjGA02G8TajhTIebE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDllZ2J2O6bafhVyA3BOPGC8c4aOn8DiuKtcjJWiPoGEYC1f9SfjuHSF3KXx69ztRP8WgFg7qNHBETAUGRfeh/D4q4pqwNTiaExoyI9kqRxeHZJkcdSn9wOUN/y3D1Q/pa8PH+Q9g5nDlKWbdlElcqkMiNKJyDgg/M2AIHZImGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QjssBNOd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QjssBNOd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785324393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ms7TjNbqHRA4P5HZZQpw8gHBi1StBQU2oI5cQslDjks=;
	b=QjssBNOdYMRQ7JTkGNl5tbZa4PiqZHfSQGsIllWJkEdchuffhmKcjne02HJ2yPWia2G1WK
	2jb0AOVVEIEvSKS4qN/tUJZ0/9VhMTkSO7TmTdOqfIiyNTcD5YjBROrfM2qojFL6HB6q6f
	Wwmqk8t+viFb7cSZepmOQeCKc6JExO4=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: broonie@kernel.org
Cc: andy.shevchenko@gmail.com,
	asrinivasan@oss.tenstorrent.com,
	fushuai.wang@linux.dev,
	gregkh@linuxfoundation.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com,
	wangfushuai@baidu.com
Subject: [PATCH v2] Revert "serial: 8250: Clear CON_PRINTBUFFER on port re-registration"
Date: Wed, 29 Jul 2026 19:26:05 +0800
Message-Id: <20260729112605.11764-1-fushuai.wang@linux.dev>
In-Reply-To: <e086c2da-e08b-4d53-abb1-e7a5cfd0d6f6@sirena.org.uk>
References: <e086c2da-e08b-4d53-abb1-e7a5cfd0d6f6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> > From: Fushuai Wang <wangfushuai@baidu.com>
> > 
> > This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.
> > 
> > uart_console() only indicates that the port is selected as the console.
> > It does not mean that the console has already been registered or has
> > printed the buffered messages.
> 
> The multi-system boot regression this fixes is still present in -next.

Hi, Greg

Just a ping.

Mark has confirmed that the regression is still present in -next.
Could you please take a look and consider applying it to tty/tty-testing 
and tty/tty-next?

-- 
Regards,
Fushuai
