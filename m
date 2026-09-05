Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2C434E21
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601896; cv=none; b=HYHU3LsW8u28LH519u4KRo6OBqUjgBWcR5/R6iJN6zHi7HFBcsZsv9SsGleEPkTsW9VvDYoiQOs0NIiF2CUcmeeSUhIHApfNwc2z1yRbhMoBqaMGm1ZBTXhMos3Azb69w+zNOYpCzFPQFwYpxJPtjiaBneMAyZ2S9moIc7tcYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601896; c=relaxed/simple;
	bh=zSA0H4ZLtydyff95paAd3cuskkkfvpGtC6nyEywvYiE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D5leObh5JwCHtOMajradWwVJ/rfA4D7HqVYemvGhrcJNInm8qQCjQWfzPNTms8Vdsn6EICnWHDwg9FSv+FhE/1T+GBeVtd6UcZ10xEtbtVxdpv4CW77b5OlSaR/aTOhOo/31gQj5ZPWpXu31D3+XCXqc5wljSq5B2MmNuRThBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LCgtJVDt; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Prn8wrTo; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LCgtJVDt";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Prn8wrTo"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788601881; bh=dTpXq4BXqO7rflptFwE20OL
	pU99D0Voh4XpUONsXBDE=; b=LCgtJVDt+HYjwHyhLFCRtEjZJU25V1jUTACxCXJGd7AOdZF6/K
	hU14Hq/6FZ90KlWMuU6pKHU7p7cwkH3pbXRogfHBXycNV3CztFCPrLQIh43DGm+L9ouXQJC53wS
	OYZOG4AyuZBH6MS5zjYNu6PkFAv60Ltmkmgf+sIat9f9u+UGuWBrANlOKoNOiYK/9W13h7ngsVh
	6j1RCVYXa9z7MpNfW1k9pnOL2RVBrnsIp5u94WLSNfGol5ua9vlBnMhSd2zluNysJiSeyv9L9HM
	IP9UdXJ9yyf1goRoenYzdMZb4u9HuigfJkN+7TQA18TQNN15DfMT/lj3a6FbTr1NpWg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788601881; bh=dTpXq4BXqO7rflptFwE20OL
	pU99D0Voh4XpUONsXBDE=; b=Prn8wrToaNqyyLWOs5iMQftrcbQveEesng1WV7gsv6O9Qad9lh
	qtlF5G5j0yFwo0mTwWh5AH7uLeb1PaX30tAg==;
Date: Sat, 05 Sep 2026 10:51:20 +0100
From: Bradley Morgan <brads@mainlining.org>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: linux-serial@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH v2 3/5] tty: sc16is7xx: convert to kthread_run_worker
In-Reply-To: <20260905094036.2E7811F00A3D@smtp.kernel.org>
References: <cover.1788513591.git.brads@mainlining.org> <946a190a64560bbb192d03f5757b8349b97157f9.1788513591.git.brads@mainlining.org> <20260905094036.2E7811F00A3D@smtp.kernel.org>
Message-ID: <522CEDE2-A380-4C1A-9F01-D302AB54EACC@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 10:40:35 BST, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential
>issue(s) to consider:
>
>New issues:
>- [High] The explicitly allocated kthread worker is destroyed before the devm-managed threaded IRQ handler is freed, causing a Use-After-Free.
>

Awesome. Seriously

>Pre-existing issues:
>- [High] Closing any single port cancels the shared polling timer, starving all other active ports on the same multi-port chip.
>--
>
>commit 3bc3e4920cc0fac18e8f989a3296c6b4222d065c
>Author: Bradley Morgan <brads@mainlining.org>
>
>tty: sc16is7xx: convert to kthread_run_worker
>    
>Convert sc16is7xx to use kthread_run_worker() instead of the
>deprecated kthread_run(kthread_worker_fn) pattern. The new API sets
>worker->task before the worker starts.
>
>> diff --git a/drivers/tty/serial/sc16is7xx.c
>b/drivers/tty/serial/sc16is7xx.c
>> index 7107a0fb1e7bb..2cfc1f2900091 100644
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -1186,7 +1185,7 @@ static void sc16is7xx_shutdown(struct uart_port
>*port)
>>  	if (s->polling)
>>  		kthread_cancel_delayed_work_sync(&s->poll_work);
>>  
>> -	kthread_flush_worker(&s->kworker);
>> +	kthread_flush_worker(s->kworker);
>>  }
>
>[Severity: High]
>This is a pre-existing issue, but does closing any single port cancel the
>shared polling timer for all ports?
>
>In polling mode, s->poll_work is shared across all ports on the chip. If
>one port is closed, sc16is7xx_shutdown() unconditionally cancels
>s->poll_work,
>which seems to starve any other active ports on the same chip.
>
>> @@ -1705,8 +1702,8 @@ void sc16is7xx_remove(struct device *dev)
>>  	if (s->polling)
>>  		kthread_cancel_delayed_work_sync(&s->poll_work);
>>  
>> -	kthread_flush_worker(&s->kworker);
>> -	kthread_stop(s->kworker_task);
>> +	kthread_flush_worker(s->kworker);
>> +	kthread_destroy_worker(s->kworker);
>>  
>>  	clk_disable_unprepare(s->clk);
>>  }
>
>[Severity: High]
>Can kthread_destroy_worker() lead to a use-after-free if the threaded IRQ
>handler fires concurrently?
>
>The driver uses devm_request_threaded_irq() in sc16is7xx_probe() to manage
>its
>interrupt, meaning the IRQ handler remains active until after
>sc16is7xx_remove() returns and devres cleans it up.
>
>If an interrupt fires or an in-flight threaded IRQ executes in parallel
>right
>after kthread_destroy_worker() frees s->kworker, the IRQ handler could
>call
>functions like sc16is7xx_ier_clear() which enqueue work:
>
>drivers/tty/serial/sc16is7xx.c:sc16is7xx_ier_clear() {
>    ...
>    kthread_queue_work(s->kworker, &one->reg_work);
>}
>
>This would dereference the freed s->kworker pointer. Previously kworker
>was
>embedded in the sc16is7xx_port struct, so stopping the task was safe from
>a
>use-after-free, but now kthread_destroy_worker() frees the dynamically
>allocated worker before the IRQ handler is disabled.
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
