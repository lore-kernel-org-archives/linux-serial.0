Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D779309EF9;
	Mon,  5 Oct 2026 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183320; cv=none; b=DAPTaKyW+J4w2KIAIh6fsc/rGfs05cNcrhfdODDKQDvfDT1Y6wUZWDB3n+M7hfracpGYXqEyCAtL/WkgkSfpev8KWvMIV+q9p0PC+hzAcLHxput1XsbpHHWjYku1a+QpS6MFxomX89iTvbReeKU0SRaVoNMxDUX1ggDsNCLApO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183320; c=relaxed/simple;
	bh=2+5aCRKqLwTz8H515JmkRlWIvUqb7saKt0q45ibTiIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZanv1RHYxgw1BUq+CS1PrL/5jF1UuJijWEtbHsUG4FrOtIZQSTNREXVZXOYhDK7FRoR8pnPGK/YM792Um8lgnysJx/5j2jdfKSi6Sxz7k5kVhliLA5sDgDeAFVjXk5+5YKhig/+jRYIUBX6B7mEFN+x0VhZlCVsul95ggF7n44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Oct 2026 15:55:10 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id BB12D2091574;
	Mon,  5 Oct 2026 15:55:10 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 5 Oct 2026 15:55:10 +0900
Received: from [10.213.138.49] (unknown [10.213.138.49])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 06E4810D843;
	Mon,  5 Oct 2026 15:55:10 +0900 (JST)
Message-ID: <632a5ff5-89e3-437d-b89e-dbcef35fbd49@socionext.com>
Date: Mon, 5 Oct 2026 15:55:10 +0900
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
 <3ea1f574-ddb5-46a6-9bc1-7a8ea84c54bd@socionext.com>
 <arZ5KxIp55qA6UA7@ashevche-desk.local>
 <faa1027c-7279-462a-9c6f-f03354b9cfd3@socionext.com>
 <arot4SH3vbDpKC8A@ashevche-desk.local>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <arot4SH3vbDpKC8A@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/09/28 18:05, Andy Shevchenko wrote:
> On Mon, Sep 28, 2026 at 03:51:09PM +0900, Kunihiko Hayashi wrote:
>> On 2026/09/25 22:37, Andy Shevchenko wrote:
>>> On Fri, Sep 25, 2026 at 08:32:20PM +0900, Kunihiko Hayashi wrote:
>>>> On 2026/09/24 23:09, Andy Shevchenko wrote:
>>>>> On Thu, Sep 24, 2026 at 06:07:37PM +0900, Kunihiko Hayashi wrote:
>>>>>> On 2026/09/17 13:05, Malathi A wrote:
> 
> ...
> 
>>> So, in such a case how do you see the scenario when system is resumed
>>> (Right?
>>> Otherwise we can't do anything, like detaching driver from the device.)
>>> and
>>> clock is disabled?
>>
>> Ah, I understand your point. I was assuming that the driver could later
>> be detached after uniphier_uart_resume() failed, leaving the clock disabled.
> 
> I'm not sure, I don't know if I was right. Can you confirm that this scenario
> is not possible? So, it might look like CPU is resumed, some of the devices
> were resumed, but this particular UART failed to resume, and now we want to
> detach it. If this case is possible, I believe tons of the device drivers as
> of today may be affected by the same issue (it doesn't mean that the issue
> is impossible to happen, one needs to investigate deeper)
Sorry for the delayed reply.

Unfortunately, I can't confirm whether this scenario is impossible.
I don't currently have an environment where I can reproduce this system
suspend/resume case either.

I agree that if a device can later be detached after its system resume callback
has failed, this may affect other drivers using the same pattern as well,
and determining that seems to require a deeper look into the PM core behavior.

>> If that sequence cannot happen after a failed system resume, then my concern
>> doesn't apply.
> 
> As pointed out I'm not sure. Last time I experimented with failed resume > long time ago.

So I don't have a definitive answer here either, and can only point out this
as a potential issue for now.

Thank you,

---
Best Regards
Kunihiko Hayashi
