Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C917993;
	Thu, 25 Jun 2026 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782362320; cv=none; b=d54okcjnDM7jvHRRzJ24GDYurqcEP8hAflT5Y5fjH80BAJP0WAR56cTQLa5e17nKcNtikjdwIgDLJDEolwg0P7qQmLHqFERoVf6NhZYGANxFEcJHAOnoKbsorfLLjL0CFIL62b1t3N2vqNjTStPlWYt18bY1SP8FCavm1suolqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782362320; c=relaxed/simple;
	bh=Ghg+es7PMWHvyIWYOB4GuTY+eeE98RJnbilsdWX5+iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjYPe4xoHfNM1kyvphVg6NqPsjc4UglAEDUoE8WuglsCDw+2k5Wr3aIEKhcMatbKPSiPkZ+gKB5iri9kQEvlcblXKQOCyS3TXME05qj6RHQsszXru3tIuITLdBgSMSjOhS6cWbze6fB3XP+AnT3oGjUO71vW/Xv3myeR+DjIlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUJ6ak8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUJ6ak8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8891F000E9;
	Thu, 25 Jun 2026 04:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782362319;
	bh=en/Q8rhQAhmFAKqfB0zVLLdT4CQGk9nawe4wXWP9Uuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iUJ6ak8K6MVKcWs+XJD/5EipmDKpowL/HRiXNnhTNRTP+ywSq97hI5SCgLaUmAG0q
	 3pHOL65slEh8utRnOqcHdwjgckD1jwYKbvDtk/mSXuGUwVqNHknJKkl1k1X/gf93Mr
	 p2nS8Hhrn1/0r/7mdP11exYhfua6NwN828eOrlz7aJB5QTLFVNtRTiyPQGFBg/lW1i
	 pLeuKGK0z/J8BXZzlwWjs/EM++hBZuz3U/k2d9ziGES/vXSzhyfGGyOaWFZJWS883r
	 HYeSYvXMH1yLI8oPdk25XPgZNVmVSdccWzFEpoVsFp+Kcs0aH5YghsukLrZDKRkcIs
	 E1Dq0Uv2Zagbg==
Message-ID: <80f44ace-9231-4b4e-9e47-cbe49b3e2d3e@kernel.org>
Date: Thu, 25 Jun 2026 06:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] serial: 8250: fix use-after-free in IRQ chain handling
To: Jing Wu <realwujing@gmail.com>
Cc: gregkh@linuxfoundation.org, avorontsov@ru.mvista.com, alan@redhat.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 wangzhaolong@fnnas.com
References: <20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com>
 <b7c51606-e95a-4a15-9aff-d0c293ebe986@kernel.org>
 <20260624084352.2978059-1-realwujing@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260624084352.2978059-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 06. 26, 10:43, Jing Wu wrote:
> From: Qiliang Yuan <realwujing@gmail.com>
> 
> On Wed, Jun 24, 2026 at 05:31:59AM +0200, Jiri Slaby wrote:
>> So what is the reason to switch from guards to manual locking?
> 
> Scope-based guards release the lock at the end of the enclosing block,
> but the fix requires hash_mutex to be held across request_irq() and
> released at different exit points:
> 
>    1. IS_ERR(i) -- release hash_mutex and return error.
>    2. Already in chain -- release i->lock, release hash_mutex, return 0.
>    3. First port, request_irq() fails -- cleanup under hash_mutex, then
>       release it and return error.
>    4. First port, request_irq() succeeds -- release hash_mutex, return 0.
> 
> These paths span different nesting levels and early returns, so scope
> guards cannot express the required lock lifecycle.  The same applies to
> i->lock: it must be dropped before calling request_irq() (cannot hold a
> spinlock while sleeping), but hash_mutex must remain held across the
> call, which also breaks the guard model.

I don't follow, the function now looks like this:

         mutex_lock(&hash_mutex);

         i = serial_get_or_create_irq_info(up);
         if (IS_ERR(i)) {
                 mutex_unlock(&hash_mutex);
                 return PTR_ERR(i);
         }

         /*
...
          */
         spin_lock_irq(&i->lock);
         if (i->head) {
                 list_add(&up->list, i->head);
                 spin_unlock_irq(&i->lock);
                 mutex_unlock(&hash_mutex);

                 return 0;
         }

         INIT_LIST_HEAD(&up->list);
         i->head = &up->list;
         spin_unlock_irq(&i->lock);

         ret = request_irq(up->port.irq, serial8250_interrupt,
                           up->port.irqflags, up->port.name, i);
         if (ret < 0) {
                 serial_do_unlink(i, up);
                 mutex_unlock(&hash_mutex);
                 return ret;
         }

         mutex_unlock(&hash_mutex);

         return 0;

What am I missing?

thanks,
-- 
js
suse labs
