Received: from va-2-47.ptr.blmpb.com (va-2-47.ptr.blmpb.com [209.127.231.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F53AA4F9
	for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039666; cv=none; b=B/eSSqmTcIIgPNth5CNQMDofoN5JgNP4T/LLzLBkr/64YjHP/6N5EReUHQiHWWmZL+gpEdqjZNzgDiGbjJyVnuPr9tNeCqbGAsMKNWKbFvLsdXQhPgJLsziFk149s7ZH7VuCzRftewqp4IKAg3RJ8roL2+SOVVxq/RaMr/oKJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039666; c=relaxed/simple;
	bh=1yaAm1OfsIqjp1Erqe+yMKB16VDHn+N9v8k2/NYDu7w=;
	h=Content-Type:From:Subject:References:To:Mime-Version:
	 Content-Disposition:Cc:Date:Message-Id:In-Reply-To; b=d8n6VN3GbTBQz/UjxXdqKXed+kYwc/7hOn3pueD934duyjATg8E1bEsPTxHsChJc/hR3wnNzgQZgmLfRWfjj6HWezJEmJpb7il+Z6M1vPzTU2z3/w9sQymX8dBDzczMPZkn3KSI1pwnaEnVoABw0pSFN8yHdUmsULTyF7C8ysBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=YvMcK3S7; arc=none smtp.client-ip=209.127.231.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="YvMcK3S7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780039658;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=91gGPMxBdwoqjcYmIKzxAsRiLvN8xUFZ+BqC3OinMyw=;
 b=YvMcK3S7tWlc/7CU0leLt74mpry+SXYUrekaC/BEkYuVxAoOn78Iwi3/kFinabMUtb7ZyK
 FkbsFd7Vla+SSXmKW6DZdZOt2yResvFhS0JFD8eARRSuZuez8X4FIyOYjLt8hdQyjH6T9X
 /71A8j/Mi0g9M5M4EEO4xGxbNByNWxvyTg4F0+XzabT1TKil6sdBLJ1I6RSeQR+RicnxDU
 rC09DtCbFIfhewxjkshGI5P77dAmm3FI0Vnkyyot7RC99Y1Ylr+ihmfMwga8jy6Ofd3ay5
 6RQu0Ej95nP3KEIhJPGoFwaEO5OuMQZWYKnCv6kFAJ0yNJoR7ARwYshRHz4J1w==
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a193fe8+f0bf7a+vger.kernel.org+wangzhaolong@fnnas.com>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Subject: Re: [PATCH v3] serial: 8250: fix use-after-free in IRQ chain handling
References: <20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com>
To: "Qiliang Yuan" <realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
Received: from MiniServer ([183.34.164.43]) by smtp.feishu.cn with ESMTPS; Fri, 29 May 2026 15:27:35 +0800
X-Original-From: Wang Zhaolong <wangzhaolong@fnnas.com>
Content-Transfer-Encoding: 7bit
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, 
	"Anton Vorontsov" <avorontsov@ru.mvista.com>, 
	"Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>, 
	<linux-serial@vger.kernel.org>
Date: Fri, 29 May 2026 15:27:33 +0800
Message-Id: <ahk_5U5QAuavMA9U@MiniServer>
In-Reply-To: <20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com>

v3 fixes the Bugzilla reproducer on my setup.

But this error path is still racy:

> +
> +	ret = request_irq(up->port.irq, serial8250_interrupt,
> +			  up->port.irqflags, up->port.name, i);
> +
> +	mutex_unlock(&hash_mutex);
> +
>  	if (ret < 0)
>  		serial_do_unlink(i, up);
>  
> 

i is already in irq_lists and i->head is already visible here.  On
request_irq() failure, another port can join the chain and return success
without any IRQ handler installed.

The cleanup must happen before dropping hash_mutex.

> Dropping hash_mutex before request_irq() completes also allows another
> port sharing the same IRQ to join the chain and run the shared-IRQ THRE
> test while IRQ startup is still in progress, which can also trigger the
> "Unbalanced enable for IRQ" warning (kernel/irq/manage.c:774) because
> irq_shutdown() in the premature free_irq() path hard-sets desc->depth
> to 1, breaking the disable_irq/enable_irq pairing in
> serial8250_THRE_test().

The changelog is also still inaccurate: irq_shutdown() does not hard-set
desc->depth to 1 on current mainline; it increments desc->depth.

Best regards,
Wang Zhaolong
