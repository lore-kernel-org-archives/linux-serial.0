Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ACF37F010;
	Fri, 25 Sep 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335952; cv=none; b=CfX3dzk9DCTuYwQRlmqjAA7owlPq5Ha/7pzzq6V8sIeSt1dh/0CHdsiiE3Wx4ZejERQjh3jTlwi5sVZhTN0J61J6fAgViXKG8t2BKTCSHKkhMk6DliSAJvKgbPb5ybeS/ia9mKdKdgJ9sUdwS8AIkRHC9tFwTl4EgbbQFKFUtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335952; c=relaxed/simple;
	bh=5Ho/K7bhetxQPsC5UHBNMIAfBcnZpjD4Gpi4boFNHkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAFfVktHOtbWcmDHEX0uvlf6eeZfHgqJSKwZkAmiHGBuL6csGjToeNp9z/AuQaIsSbHmpc8LcNM7VA0OoHe8Gx5td0nTgquwDg4xPkn81F0x1zdaLugXFQMpLSg2A1HNAfW/H6Du4UOWTK9yFfIJ0zow8CGLzwm6XfqOuYm0kRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Sep 2026 20:32:22 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 9C1BF20695D1;
	Fri, 25 Sep 2026 20:32:22 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Fri, 25 Sep 2026 20:32:22 +0900
Received: from [10.212.247.157] (unknown [10.212.247.157])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 2932A10A019;
	Fri, 25 Sep 2026 20:32:22 +0900 (JST)
Message-ID: <3ea1f574-ddb5-46a6-9bc1-7a8ea84c54bd@socionext.com>
Date: Fri, 25 Sep 2026 20:32:20 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Malathi A <malathi.a2000@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
 <97e4ab26-b147-4cf4-97f9-307903f14e61@socionext.com>
 <arUvJyvChXXcasSu@ashevche-desk.local>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <arUvJyvChXXcasSu@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/09/24 23:09, Andy Shevchenko wrote:
> On Thu, Sep 24, 2026 at 06:07:37PM +0900, Kunihiko Hayashi wrote:
>> On 2026/09/17 13:05, Malathi A wrote:
>>> uniphier_uart_probe() enables priv->clk by hand and is then
> responsible
>>> for disabling it again on every error path. It misses one: when
>>> uart_read_port_properties() fails the function returns directly,
> leaving
>>> the clock prepared and enabled. The neighbouring path, taken when
>>> serial8250_register_8250_port() fails, does call
> clk_disable_unprepare(),
>>> which shows the leak is an oversight rather than intent.
>>>
>>> Rather than adding another manual unwind, switch to
>>> devm_clk_get_enabled() so the clock is released by devres. That
> removes
>>> the error path entirely, along with the explicit disables in the
>>> register failure path and in uniphier_uart_remove().
>>>
>>> The clock is still disabled and re-enabled by hand across system
> sleep,
>>> which stays balanced: only SET_SYSTEM_SLEEP_PM_OPS is used, so the
>>> device cannot be unbound while suspended and devres always sees an
>>> enabled clock at detach.
> 
> ...
> 
>> I'm a bit concerned about the error path in uniphier_uart_resume().
>> The clock may have been disabled in uniphier_uart_suspend(), and
>> clk_prepare_enable() can fail when trying to enable it again.
>>
>> In that case, wouldn't devres try to disable an already disabled
>> clock on detach?
> 
> Isn't there is a guarantee that the .remove() is called with PM runtime on
> and
> get, meaning it's called with the enabled clock? But if not the case, we
> might
> use PM runtime force operations (resume and suspend in the respective
> cases.
> 

My concern was just the case where clk_prepare_enable() in the system
resume callback fails, leaving the clock disabled before devres cleanup.

This driver currently only uses SET_SYSTEM_SLEEP_PM_OPS(), so I wasn't
considering runtime PM here.

I don't have a strong opinion on whether runtime PM should be involved,
but if it guarantees that the clock is enabled before .remove(),
that would address my concern.

Thank you,

---
Best Regards
Kunihiko Hayashi
