Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23563148AE
	for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497150; cv=none; b=dK+9QtSO83aM6xaj0k2MNZGVY+NAZu1BiXdT6wYEH3hF+sPjx8O9JaGEESPT5O6HFLJzbZ5rHvuLF4QAqDmnp/LXUa1LCFMYbfDvrHT2X1+wRi6vED0vV17PouZfX9rgn7jWI8CF5QuY0FpoI0c1XPeAUt9aW13t0EqUX46AfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497150; c=relaxed/simple;
	bh=voI0LrAh+Mg3MRUmoR4HlMdNEOFeh5ZQ3j7pUivLups=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPmMabbeJruzbiJQ7+7/O7V8zItzBJsINUhzy6cXPPG6HJFlFw4hM19LSvJZ8w0r5mv710WDfmR9os2zeHdaW3xV2nIPq6r4p1tEVe+Q+dt2ATnm0wpwii8MM9hnHhZ8qfFTAEF15kd5EL1fht6lqrpKfM6c5eFDiBraYqhJQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqty6mJC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/e2lZhFS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqty6mJC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/e2lZhFS"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757497146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6DaOxidtfL28kdqx3hjTmpo/yBtOpYCmYQP/boGl6DI=;
	b=nqty6mJCB9IQP5MBMXYUg5X4nrGVGZXbreFLB/NlzunWPiWkc6GBcbEo+VswEfUz6eZ4ys
	SVGdweB097QXBp1GJtxd83hhfaGd2XTSM4YxWflSOGiK1u0CPQ2DibNubI1DqNks4uL78t
	tWs794P0FJ6EzBv9VuuYTomdMeew1joKVXaDMIqFehc9YfGQ6Pt17aoU4A00im6a0Q0FQZ
	i8h+D/oRV6g/Pc2+p9MgnKfhGgZA88tEIKpVsT+veOgFdSAu3wI2mQhioQ5h2WU5pp1IaY
	Q3FxVM27HLElBTFyvWjD1qXKvsqMhCzW/9u7EzixZVVzSI0HRhSeCMkyb7Cnkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757497146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6DaOxidtfL28kdqx3hjTmpo/yBtOpYCmYQP/boGl6DI=;
	b=/e2lZhFSVfXJIzKeAVZ7NQnCMMQTw/PWZ3uU+YVpjux7LMSxQWogY1DIOfVxFWgUxLwYWo
	5UpvcxnYcdXFdLBA==
To: Petr Mladek <pmladek@suse.com>, Andrew Murray
 <amurray@thegoodpenguin.co.uk>
Cc: senozhatsky@chromium.org, rostedt@goodmis.org,
 linux-serial@vger.kernel.org, Michael Cobb <mcobb@thegoodpenguin.co.uk>
Subject: Re: Lock contention with console kthreads
In-Reply-To: <aMFBWJWqv3KsaaZU@pathway.suse.cz>
References: <CALqELGwr=XWA2iD-7wa1jOigx3pfEnTnaGWUMQX_A5MWe3DN_g@mail.gmail.com>
 <aMFBWJWqv3KsaaZU@pathway.suse.cz>
Date: Wed, 10 Sep 2025 11:45:06 +0206
Message-ID: <84a5326405.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-10, Petr Mladek <pmladek@suse.com> wrote:
>> Since commit 5f53ca3ff83b ("printk: Implement legacy printer kthread
>> for PREEMPT_RT"), and only when PREEMPT_RT is enabled, legacy consoles
>> use a kthread to write out to the device. This is beneficial for boot
>> time when using a slow console such as a serial port. However, this
>> gain can be short-lived as console_on_rootfs in init/main.c appears to
>> act as a synchronisation point.
>> 
>> legacy_kthread_func holds console_lock when flushing, and is held for
>> a long period of time during boot.

[...]

> I would suggest to modify legacy_kthread_func() and flush one
> record-per-cycle and get/release the console_lock() in each cycle.

Agreed. This is an excellent suggestion!

John
