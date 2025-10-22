Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F828CF5D;
	Wed, 22 Oct 2025 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153672; cv=none; b=kl6HBpVhGM7z9WIK4wvIMPKZ9nvaONmjFs+EVGeHZn1OxRjTPnAwHXj+kzDtOxCOwBasHlsyaNr+AYbqqhL6NBh88FcYH0V+AO8y8MPpebVXpBgBa50NzUXiVbxfjyMf7UBZm4DyyAmWsunpU60NVyKwyjOQeWacRky/PEmgd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153672; c=relaxed/simple;
	bh=LBefbmw4616+376sfZMbW3lv7q0G4roDVAAh+MdkzUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIfCW85nDfKOizXlUk6IY5Tm3uIn+QHewWTwf3ziC/7LAMBqe6k2V00aU9fhrfAjCy8wEuWuf1QOctaNCqfrGOuy6deCmx+m5FuwzbeOg1O+xR9VuVN2qCvyIe+bu3fcq0WAuwJ5P9aRGrA9NmwMqBQqyBEgyABRp5ob+M/iHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YM7AaoKl; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YM7AaoKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g+
	nScme2MevmIso+eTUNAPIi+B6hKiSNgdidKFavCH8=; b=YM7AaoKlWsCqTUBacP
	r3rSL4EwVmWho/mOG3XQ9TjYGsJIRiK75dqGDMIRUBoY/BkR0RXCv+VVY63uAV53
	7+UhkjHt2cuEVq0th+D2/SKx5FYBtI5Sdc5BHz2fRI3t2p2dXqA+hneTwy+PV0tN
	VxzzNu7sdEOubc7kmF/X7xMsU=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3P89oEvlopqpoBA--.12218S2;
	Thu, 23 Oct 2025 01:20:41 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org
Cc: hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on specific cpu
Date: Thu, 23 Oct 2025 01:20:40 +0800
Message-Id: <20251022172040.262718-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102206-gainfully-chariot-407d@gregkh>
References: <2025102206-gainfully-chariot-407d@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3P89oEvlopqpoBA--.12218S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFWkCryUGF48AryfCryUJrb_yoW8Jr48pF
	WrGanF9r4DKa13t3W7ua1Iq3W3C3s3KrZxGr13GrW2y3s5Ww1fKFy7KFWj9a4fWr48Wa42
	qr4j9343WFyqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi75r5UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwk3QWj5EmlDBQAA3s

On Wed, 22 Oct 2025 18:59:05 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> > > This should come from a hardware definition somewhere in your DT, not as
> > > a user-selectable option.  And again, why not just tie it to the cpu
> > > where the irq came from automatically?
> > 
> > I don't think binding the work task to the CPU that handles the interrupt is feasible,
> > because, in practice, this hardware interrupt is evenly distributed across all cores
> > in our system.
> 
> I suggest fixing that, that's ripe for lots of latency as cores hit
> cache misses and the like.  Learn from the networking people, you want
> the cpu that handled the irq to handle the data processing too.  They
> learned that years ago.
> 
> > Moreover, from the ftrace data we captured, the IRQ handler thread that
> > wakes up the kworker threads in RT-Linux is also distributed across various CPUs by
> > default.
> 
> Again, don't do that, bind things to cpus that previously handled the
> data if at all possible to avoid these latencies.  That's what you are
> trying to do here anyway, so you kind of have proof of that being a
> viable solution :)

Thank you for your suggestion. I will perform the relevant interrupt affinity binding on
our system.

--
Xin Zhao

