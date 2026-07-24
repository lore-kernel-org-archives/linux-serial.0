Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F139CCF0;
	Fri, 24 Jul 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881937; cv=none; b=jXXi3xRWQr0OaqCPehNd2kPsv+935lm5AbFTFMgGQhBBhMcPvneIornwijBxv2WFkv6YusQuirmK/okuA6ouAr+wu14yaZRQn8FAGl0bhUOjhwJK+C6PMJ2A0RRasLYJKEK4hY/k7GHLU969QLhGeW1ztZT2qX9ayLA5OdF9/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881937; c=relaxed/simple;
	bh=228gmqZFJlbOaI/Bg8f7txpsh/rnoPZw+7mYksOev/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSbmDZIjnrud6HFzzvWT79JpR7TvohwTKkSMsPdVwWoRFGqmdoKpzaU6rZOqDSxAMhtuOvyFU4JlibWan4irzXFxBSVPHYuEv74zp1gGhjYlUlBF9qMW/YmSupUxgqbrDtOrtLN6lwVBXv+bg3YSrctxroT9r685rJkOC0DB0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYZ18tB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zgBZIT9R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYZ18tB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zgBZIT9R"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784881922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=228gmqZFJlbOaI/Bg8f7txpsh/rnoPZw+7mYksOev/M=;
	b=WYZ18tB+Sfrh5+XYr1IiW5TGNqkFZQAIAEbyA8ATJUHl3Lc/ePC87okR51o2KZ3Rs1RYQ6
	R+d8P0fQg8GQJIeCllnk+wnCrz2L7O6vU74a+z467JIH60gda5Z26fTfv+BeF1bfMcs6Zr
	svIvxfj5Y2TpBpHi1S3QTm2HGC2N9dLN4yieFOZu/oegrIujIRsLiFbHN9rQUZXPjq75Uv
	rBwU4B3yHXHQVbKPS/of4vYzGpbulv9irkboekamMcUZC87BKvmkWWLDhP0cVUqmqanM8j
	UM1pZK4MOKs8koe/4uzxgHi0TRkadk6QRA8b3wPmR1YK4DXtW/h9qC9LesT7Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784881922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=228gmqZFJlbOaI/Bg8f7txpsh/rnoPZw+7mYksOev/M=;
	b=zgBZIT9RAeAT/Jvqp2iY70BwR8pbLcmzX75lA2wbwR7lP+e23rtH52r7aMlbIYvaCxqx8h
	/VtmrIfeJnGijJDw==
To: Fushuai Wang <fushuai.wang@linux.dev>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, osama.abdelkader@gmail.com, jackzxcui1989@163.com,
 asrinivasan@oss.tenstorrent.com, andy.shevchenko@gmail.com,
 broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Fushuai Wang
 <wangfushuai@baidu.com>
Subject: Re: [PATCH] Revert "serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration"
In-Reply-To: <20260724072452.40455-1-fushuai.wang@linux.dev>
References: <20260724072452.40455-1-fushuai.wang@linux.dev>
Date: Fri, 24 Jul 2026 10:38:02 +0206
Message-ID: <874ihookjh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-24, Fushuai Wang <fushuai.wang@linux.dev> wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
>
> This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.
>
> This may cause some boot logs to be lost on some platforms.
>
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> Link: https://lore.kernel.org/all/20260522101042.21976-1-fushuai.wang@linux.dev/
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

I also recently stumbled on commmit d338ab1d9060 ("serial: 8250: Clear
CON_PRINTBUFFER on port re-registration") and was surprised to see it
was accepted.

If the double-printing is happening for certain cases with 8250_pnp, I
would expect 8250_pnp (not 8250_core) to detect and handle that
case. 8250_core is the base for a lot of 8250 variants.

John Ogness
