Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF11A262D;
	Fri, 24 Oct 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321376; cv=none; b=cyRdtp+sDiMN1JT+CQU+F2gbpJHkEgZfxTFYPhRsqT5vlSoibK01WKl9QO08YDYEzsdHOtnmlJq0SEM4Kl5ZZ+3HuiXyu+OOE0Y/Do8dApatDPTTR3EqhetqywOQBbw5ZlZ2aWpRGJUehZ2Ex+5dsJlXb84tyRn7iwCTlfc/zEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321376; c=relaxed/simple;
	bh=1tUb6YsHFDkIkXFGpZ1mEVIpkKi8wP4p6aA0CbWkzkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiK0MWVThmzUl+k+MnrmGmMxHogvmXVViw5U6wJkVgUnZ1tu22vV73VAdA+0fw1G4Sql1ScRhbMN5ApQRlDaXxh+BLcFd9XNifPh1oa53c4Dhpb1BmhQ3a261mUzt3NekqfD0shYB3Emeon1Ov4nM5hfHpyCXE+k9SGlXEw1TeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hovQLquU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hovQLquU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=FdL3D5T6GzcuV+Ynz/8e1PaP6UiOMw6TEgBEwi5fXdc=;
	b=hovQLquU3qbhWyho9Zed9m38Fx33dZXbVGhgaWj1l/xwvzbUVoBqfQS0jlkEW6
	JDBRz8n8qvlJyVFQw07RTFXV2SaK/+jMxe9wroiXJ4ub8d3K6dEi433EUH/uMV+9
	7P2qe7RggzYe8GzmDBl/CgEiWAqQCR933g7pEqCEaVONQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3H+p2oftoJpqhBQ--.17665S2;
	Fri, 24 Oct 2025 23:55:34 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org
Cc: hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH] serial: 8250_dma: add workqueue to flip tty buffer
Date: Fri, 24 Oct 2025 23:55:34 +0800
Message-Id: <20251024155534.2302590-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025102434-stoppage-stagnate-5f0e@gregkh>
References: <2025102434-stoppage-stagnate-5f0e@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3H+p2oftoJpqhBQ--.17665S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy5WryUCFW3Zw1fZFyfXrb_yoW8uw48pa
	yftry7tF97Jr47Kw1fCa18Aw4a9Fs3ur45Grn2gry0yr98ZFnava10grWYkFyxCr97Gw4Y
	vFWqqa4kC3ZFvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkR6rUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRxPwCmj7nyoqLAAAsO

On Fri, 24 Oct 2025 13:21:45 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> >  	tty_flip_buffer_commit(buf->tail);
> > -	queue_work(system_unbound_wq, &buf->work);
> > +	queue_work(port->wq_tty_flip ?: system_unbound_wq, &buf->work);
> 
> Why not just do this for all tty ports?  What is the benifit of keeping
> this on the system_unbound_wq for all other tty devices?

Thank you for your reminder. I think we should create a workqueue for all
tty_ports to avoid similar issues that other tty_ports might encounter later.
Creating a workqueue for each tty_port only slightly increases memory usage,
but it allows users to configure it, which should result in benefits far
outweighing the drawbacks.
I plan to allocate the workqueue in tty_port_init and delete it in
tty_port_destroy. I briefly scanned the code and found that currently,
tty_port_init seems to match one-to-one with tty_port_destroy. I’m not sure
if I have checked everything, so I would appreciate your suggestions about
it.
Additionally, I will use the name in tty_struct to differentiate the names
of the nodes created due to WQ_SYSFS flag. If the WQ_SYSFS flag is set and
a duplicate name is detected, a warning will be printed in dmesg, and the
creation will fail. I plan to directly assign system_unbound_wq to the
variable for wq_tty_flip when creation fails. This way, during each flip,
we won’t have to perform '?:' operation; I will only need to check in
tty_port_destroy whether it is system_unbound_wq. If it’s not, I will
destroy the workqueue. I’m wondering if my approach is appropriate, as is
there any case tty_port_destory is called without calling tty_port_init
before?


> You forgot to document this new member, and so the documentation build
> will throw a warning.

I thought about it later, and since this workqueue is related to the logic
of tty_bufhead, which is also used for flipping, I plan to place the
wq_tty_flip workqueue inside tty_buffer. Since it will be placed together
with work in tty_buffer, it is self-explanatory. If I organize it this way,
there shouldn't be a need for additional comments. What do you think?

--
Xin Zhao

