Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822B3E639D;
	Fri, 24 Jul 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883668; cv=none; b=cE2nD6qjC2jXhkTChR9hTIBJe3cVI62atmxe56uTgeh137L364rkYLhpKM1y0pmgoFswkIKRoucqREpAElqyMcLUqUwqa5GUyZi49oZkTeOAjB1nLgIwxUqmoeYERHHSs5eFZl8d37Cz3Zb7+jiNQL5I4Osdi5CBx5WBxlsd2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883668; c=relaxed/simple;
	bh=9TThFW8xGmUDS3LYz2EZQroCbQd3pXX2HnUB22CXGrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHcfP5a9kVM3g2rNiwnl7+P/PbZ+9l0/uu/YDV+XuQBuS98ZeS5/tqDZ34iLrhTTWoSaJvI/JsjtH+dZoY7Pz8wIeOIXQlsRS4ghXma37MoC0UaWfpv5ejoar4E5VKfcrZpAhNcZ2nzfUNDq3nPKWxafgMg+bsjlMARcpEeO6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZfOqwBF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGVuw2Ka; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZfOqwBF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGVuw2Ka"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784883664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQovclDBxLs5OLMR4uTnmrwnoBEP4nVfhLnLF0L+Hak=;
	b=yZfOqwBF7eC3PDXDcqRdpQlZ+AXiCbmdBr5UisYCvdQKiI1PV5/6ILdPgmay2MjdnJChF0
	PYNgLx4RzzC92XqzakGjqzRhrpq1WxjHqnjJcpMoiX5scxMfDAkFinRoyFu1NqEJaqyzby
	5wOua8f1DYfGcOMkYrbQeWzvEZPWluB18fkxthp/HsfxQW+1qBOp2prY7XI0gulTiW2bQX
	L2Ag/uYtMjxtD2BLhAZXqdCAfPHmgtRdkD7C5CZ+sX6DPvIjGIR+QlmDCCK7qDggHBpHOs
	b9JtwhN8ABlrBWS+h6PfS+SZCfCxkvz6IYuMpYRzBox2ViSBbWOc5OSgnnfOPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784883664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQovclDBxLs5OLMR4uTnmrwnoBEP4nVfhLnLF0L+Hak=;
	b=VGVuw2Kapm4Efn0PVwMzsbMZzNTQyUdtSsniMA2J7by4FZO9fh6u9zT1YXy6ALn/bc/bpU
	hJm95Rpih3ubXVCA==
To: Greg KH <gregkh@linuxfoundation.org>, Fushuai Wang <fushuai.wang@linux.dev>
Cc: jirislaby@kernel.org, osama.abdelkader@gmail.com, jackzxcui1989@163.com,
 asrinivasan@oss.tenstorrent.com, andy.shevchenko@gmail.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>
Subject: Re: [PATCH] Revert "serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration"
In-Reply-To: <2026072454-eccentric-flatfoot-a6b4@gregkh>
References: <20260724072452.40455-1-fushuai.wang@linux.dev>
 <2026072454-eccentric-flatfoot-a6b4@gregkh>
Date: Fri, 24 Jul 2026 11:07:04 +0206
Message-ID: <871pcsoj73.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-24, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Jul 24, 2026 at 03:24:52PM +0800, Fushuai Wang wrote:
>> From: Fushuai Wang <wangfushuai@baidu.com>
>> 
>> This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.
>
> What tree has this commit?

tty/tty-next
tty/tty-testing

John
