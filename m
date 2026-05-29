Received: from sg-3-43.ptr.tlmpb.com (sg-3-43.ptr.tlmpb.com [101.45.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59723366566
	for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022437; cv=none; b=rZ+H8IdsdV8r0H4Q6pCsEHehvf6FQa1QtmkbpsNwEEz3XSzMuTbgBErDMLFuL0fPey8odaRW+5d1S1KeXYNDpobk1xREdIY9GvnIXVFfeNR+eq5o7AjJ85ouoTOGfI9pttWhNh5jBCEqLrUxdkKyvJ+5Hm2EUFxMhpdFY5F5Zr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022437; c=relaxed/simple;
	bh=MpchiZIM/ESk3jNtwKrSo5rA0tzP3jC5u71xlpfGW5s=;
	h=To:Subject:Date:Message-Id:Cc:From:Mime-Version:References:
	 In-Reply-To:Content-Type; b=Co5HfWh0BWo05lBnuzTgmxjBAXLiqExqMNPSb5N1YxbMi2u9VyPm4hZhNGErRBiimR3LBDxD8v//wgI13RRPUt7Mg0E24/YFpB/S8yVl4xMG7ljNwFdTRusiEal+k8/thQoMjjNmf9+28E629SHyWv6zRTfF0HAfFrhJkS6S4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ZYcqGmgv; arc=none smtp.client-ip=101.45.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ZYcqGmgv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780022391;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MpchiZIM/ESk3jNtwKrSo5rA0tzP3jC5u71xlpfGW5s=;
 b=ZYcqGmgveRV2igpLGBQdRd2V6APi7wuKjfH+5wmbYwzTvp47aOs5Jf0R7OI0dEVazQHeUO
 O67ku7i1TVC/vwJqiGqEwCYjEGdkU6NKHVWC/5Y8T90s0MamUsRTJYSYfi6UlvFnXzdrck
 WqzT1O2rfiZwRRrPOUxh3vYikKRwvBEiQbCl0qvvcXa0P/GB3VPj082AO7xjdHHliPlS7d
 jdxMPuSBrlDI15r5QA7QHS3T4dVLnho2z1dvkHfpuEvIgLyB/K66faVh4CkkfOaqk9i9Ix
 ZVfYmaQmQn4XVA0r0kc+fYg9mAgD0VYviy9OBQsi4hncek0R0VJNpNgrUUYHxg==
To: "Qiliang Yuan" <realwujing@gmail.com>
Subject: Re: [PATCH v2] serial: 8250: fix use-after-free in IRQ chain handling
X-Lms-Return-Path: <lba+16a18fc76+f200de+vger.kernel.org+wangzhaolong@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:39:49 +0800
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.fcb6b9d6.c756.40a2.8725.eeba0c99dc42@feishu.cn>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, 
	"Anton Vorontsov" <avorontsov@ru.mvista.com>, 
	"Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>, 
	<linux-serial@vger.kernel.org>, "Qiliang Yuan" <realwujing@gmail.com>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com>
	<5cf37150673ea4d5c28f94db91cdf68504b50522.22df93db.e9a5.40db.a812.14ba5b63f31b@feishu.cn>
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.22df93db.e9a5.40db.a812.14ba5b63f31b@feishu.cn>
Content-Type: text/plain; charset=UTF-8

My patch should cover that link/unlink lifetime race as well.

serial_unlink_irq_chain() already holds hash_mutex before walking irq_lists
and before calling serial_do_unlink(), which can kfree(i).=C2=A0 My patch k=
eeps
hash_mutex held in serial_link_irq_chain() from serial_get_or_create_irq_in=
fo()
through the list update and the first request_irq() completion.

So once serial_link_irq_chain() has found or allocated i, a concurrent unli=
nk
cannot enter serial_unlink_irq_chain() and free that irq_info until the lin=
k
path is done.

The important difference is that the lock is also held across the first
request_irq().=C2=A0 That is required for the reported "Unbalanced enable f=
or IRQ"
race, because publishing i->head before request_irq() completes lets anothe=
r
port join the chain and run the shared-IRQ THRE test while IRQ startup is s=
till
in progress.

Thanks,
Wang Zhaolong
