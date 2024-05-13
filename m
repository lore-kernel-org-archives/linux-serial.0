Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16D14AD29
	for <linux-serial@vger.kernel.org>; Mon, 13 May 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586664; cv=none; b=EJ4rqRN/0ZJeCl1TEDblGqLmFooz+KVmlon370FS7F875iGFVULIXKDoI4wKjcpvbBQfJspTvwhFU/dTOXgC7jGoimcLH3fH3y34R24bWgysXP2LTBerx1i5nkCn2ZaKNw3CSpSCZOuDuQOSlsS5bKQEHEfdGrJWXH4+znCOjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586664; c=relaxed/simple;
	bh=sd8RwfCQQ0625j7c4dL2YanT9l001o+OAibE/UMt+kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNxMICfLNEtDtP+ORjHbaytA8PA2FcvIj4y4NpetdtVDkjn5b/h0glPM6VJxgwHkWOarz1NCtS5dIziFfv4AWXRhKd6b3BHvBbhSlMEWv/47YfOivLw4CyUeax4dk6CvNu8mwAMLfGq8HHzBryOrM40yFuU+EcyZYHYvzx0J08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF5HHQY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF5HHQY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715586661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij7Ce+1vjj4AF4LhtW6l4Sryy06Ixrd5OMMpflY/6vc=;
	b=bF5HHQY/jwzukh7Kgu7a65s0LquHIJJn/qLHCH+xqy4BKhbeiCy5VWJRis6MH6eYKo2uMB
	FTvqAdaCmRWyGGjRRqWVPRVXB1dDMAx7oIUcMNavdWeivvfUAgSMQu9DoMhgqmmwHdnzUZ
	fGpz7SZWlujMjWM+zqaDDqOWRE6EaDw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Wp1LxQHLMvqlOi5S5nKuuQ-1; Mon, 13 May 2024 03:44:11 -0400
X-MC-Unique: Wp1LxQHLMvqlOi5S5nKuuQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52348f2e47cso281238e87.1
        for <linux-serial@vger.kernel.org>; Mon, 13 May 2024 00:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586250; x=1716191050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij7Ce+1vjj4AF4LhtW6l4Sryy06Ixrd5OMMpflY/6vc=;
        b=Q2Hh96PS0SUK5LPX6TZyMKz9zLTb/vEoJAdHGKG5BabdcyP7VuJBFeGEbBft5xLnkX
         l/DR//N/hiXVZSxIMHOHKA6gSmgavVMdnbzG1WL+GUUH/8adFpNC5tjddvcBWgzIPPDL
         e5Cb8uihpq/XX4wivhFtHViOm9y/YcdYKoP4hUYbl/PL9X3SqNa5HYiKPwg5NNRaNwae
         yc08vBwyLHr4rNUiAXN8RsNRt/rfUR9aBqUQ1h7bpe5CYBxZfZCmrMxz9NBYxjjekieP
         6DlF7x+nILc1jM+EBUzQIkDx7hOBRBOG/pbIKC2TejRuBQE80VAY+lLJrKrLnP8cRr6X
         ZNjw==
X-Forwarded-Encrypted: i=1; AJvYcCVHggsjO3vd8H7jn+EwuJJXm7l7CIlOS5SKvZScjF9EKSffNi6TSpWr9eTFuW4tSsjUB5zY5AC5DzJ2bZDuiHdOV7nYD9QaEwddLq3g
X-Gm-Message-State: AOJu0YyPxLuOYtoMZwWnXDJBn7K00WZeBn/iJ52DUhz4AGY1LTTXkb3/
	FeQiKbwAd7eDXGXrzcabyolJHUG//7K/wVvvqiZDLIgwYTiR7Qa0usXb+9/fzrglA63HUFLYKuc
	HSCFzW8SgtF0RgsYw+r03lB5esTp3oL+UINSnKE2sWuH110SWx/Vnqf83BWvQsQ==
X-Received: by 2002:a05:6512:3441:b0:51e:150e:2c45 with SMTP id 2adb3069b0e04-5220ff738acmr4529283e87.63.1715586250194;
        Mon, 13 May 2024 00:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnqbDyj1A/OtnPBMpsqzH5/1o5Scx5us7rY3h0CnOagZbIoLYrkcSHKWYZjEYdW6zPUFrv2w==
X-Received: by 2002:a05:6512:3441:b0:51e:150e:2c45 with SMTP id 2adb3069b0e04-5220ff738acmr4529270e87.63.1715586249741;
        Mon, 13 May 2024 00:44:09 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7e18sm5890099a12.76.2024.05.13.00.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:44:09 -0700 (PDT)
Message-ID: <02d826fe-2db6-4d7c-a599-0af4b4740a07@redhat.com>
Date: Mon, 13 May 2024 09:44:08 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vt: keyboard: Use led_set_brightness() in LED trigger
 activate() callback
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 linux-leds@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240511152030.4848-1-hdegoede@redhat.com>
 <3658e1d0-913c-4f31-aa92-06fbd8b717c1@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3658e1d0-913c-4f31-aa92-06fbd8b717c1@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiri,

On 5/13/24 7:09 AM, Jiri Slaby wrote:
> On 11. 05. 24, 17:20, Hans de Goede wrote:
>> A LED trigger's activate() callback gets called when the LED trigger
>> gets activated for a specific LED, so that the trigger code can ensure
>> the LED state matches the current state of the trigger condition.
>>
>> led_trigger_event() is intended for trigger condition state changes and
>> iterates over _all_ LEDs which are controlled by this trigger changing
>> the brightness of each of them.
>>
>> In the activate() case only the brightness of the LED which is being
>> activated needs to change and that LED is passed as an argument to
>> activate(), switch to led_set_brightness() to only change the brightness
>> of the LED being activated.
> 
> LGTM, but could you elaborate on what behavior this fixes? Should it be backported to stable?

It does not really fix any user visible behavior. This is just something which
I noticed while looking at all LED trigger activate callbacks because of some
LED core patches I was writing.

The code before this patch gets the job done, it syncs the VT capslock/numlock/etc
status to the LEDs of a newly registered input device.

But it also ends up calling led_set_brightness() on all already registered
capslock/numlock/etc LEDs which is not necessary.

So this is just a small optimization, not a bug fix.

Regards,

Hans


> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/tty/vt/keyboard.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
>> index a2116e135a82..804355da46f5 100644
>> --- a/drivers/tty/vt/keyboard.c
>> +++ b/drivers/tty/vt/keyboard.c
>> @@ -1033,9 +1033,7 @@ static int kbd_led_trigger_activate(struct led_classdev *cdev)
>>         tasklet_disable(&keyboard_tasklet);
>>       if (ledstate != -1U)
>> -        led_trigger_event(&trigger->trigger,
>> -                  ledstate & trigger->mask ?
>> -                    LED_FULL : LED_OFF);
>> +        led_set_brightness(cdev, ledstate & trigger->mask ? LED_FULL : LED_OFF);
>>       tasklet_enable(&keyboard_tasklet);
>>         return 0;
> 
> thanks,

