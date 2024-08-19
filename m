Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9881148315;
	Mon, 19 Aug 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064134; cv=none; b=UsAjYIvABkqa5/OchJVBFTYHyhtnhmnW+mIPN11OG8heZ21WfpWDOAPCCk8YevFzi6lfS4OCQUjruOaj5aS4nSgNNCmVBXCe9aK+o9Ph+VCaiIF9HZUtlyn6/lF1Yu2cUQGksIW8mItZW2dsow7SWqAYf+GxeXQP+47LZxVO0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064134; c=relaxed/simple;
	bh=l7Ql1mIGfaPSt2QQTgs1xmnZHKxxOACzYVFRwxsJ9gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obSQYM3q7wW6OR9IIdRgYXTltM6sX9OD6CTPv6zEClJlkER0EasD30Y7It1tyscW8lKnLZAAi8fX4oa2sZ/Q+7j0bdEa4YP3DocztAtYsZsifhiq/iaviEU8P4mRmhtMSdXLpw3NRoYVy3iP6roszSNzhctuM9umhlRY+qPT5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42803bbf842so45738385e9.1;
        Mon, 19 Aug 2024 03:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724064131; x=1724668931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSWAU5qK0iWSsif1szT/JjL1rzCg3Rp3z8a+YH2/aXA=;
        b=rz4E+d3iW7d9NwWDbzFqvCrKkPacPzT5BuOcLiNcmNNjz+sn1rB+XBRUWgAuCx6R0C
         th//N5ED2urnkB4umHz8mctSxLLckrNWYcrBKF8/fw++ErWgD6z6g2KhWSzE0E4ex2dG
         pmaUzPSXW0QG7sGaDpnAsdwIb4q0reRDm4Br59HPMp1Cm/TCzveM4jxLnBUkoKSYQRie
         kXbFzcvhKcO9dYRP18vyL8a7FBFMYabklxVM2six3zTqchT81ZgvjOBkL0QWtNC813Xw
         6O6SJ82xDaHl/yUNOkXs25hZj66bJEnLbW7L5evSTfOxFYVDsf3wX7WwdLlw1DWTBY1S
         vWGA==
X-Forwarded-Encrypted: i=1; AJvYcCVfVNzo6bgqrffaXpEyceYkz/BOXX0mDTM6JAEvwbxrh2Qb/Fxz32A52FQjTBQSzc5WlqSBZ614CpNVbN/zhzviobTVUdBbuTMFNXXdKMV/mAnuWO4++vGqRK7A1fIXyDSQAN34+Fh7yc0MMHjluyzgHjLLnOiKbj4VGpfOdvqtEY3MId87
X-Gm-Message-State: AOJu0YxFV2sU4gFK9A0fT89oH7j8j/AlNAvDiNVTZE9p0ZEOy3mbeU0B
	nfBxSyD/vT4650P+MN4ZCOa25afL4erICy9k+xdbNzhFQX5y7yxribv1tE4+
X-Google-Smtp-Source: AGHT+IFP55HL9ypXyfQTAGXPFvRPfc3j0EFRScDGsW6xJIkj165reDVyseN0xdyShPdrLgbNDIcJsA==
X-Received: by 2002:a05:600c:314a:b0:429:a3e:c786 with SMTP id 5b1f17b1804b1-429ed7d63efmr94341935e9.24.1724064130884;
        Mon, 19 Aug 2024 03:42:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19670sm159508745e9.9.2024.08.19.03.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:42:10 -0700 (PDT)
Message-ID: <dc936358-a718-4f1c-a2a6-695bbae1d2ec@kernel.org>
Date: Mon, 19 Aug 2024 12:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20240807-v6-10-topic-usb-serial-serdev-v1-1-ed2cc5da591f@pengutronix.de>
 <c7a710ec-f391-4726-910e-d7bedbfc6a6f@kernel.org>
 <20240819101946.cf7x7xecdn2pfa4t@pengutronix.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240819101946.cf7x7xecdn2pfa4t@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 08. 24, 12:19, Marco Felsch wrote:
> Hi,
> 
> sorry for not replying earlier.
> 
> On 24-08-08, Jiri Slaby wrote:
>> On 07. 08. 24, 16:08, Marco Felsch wrote:
>>> The purpose of serdev is to provide kernel drivers for particular serial
>>> device, serdev-ttyport is no exception here. Make use of the
>>> tty_kopen_exclusive() funciton to mark this tty device as kernel
>>> internal device.
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>    drivers/tty/serdev/serdev-ttyport.c | 9 ++++++---
>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
>>> index 3d7ae7fa5018..94c43d25ddbe 100644
>>> --- a/drivers/tty/serdev/serdev-ttyport.c
>>> +++ b/drivers/tty/serdev/serdev-ttyport.c
>>> @@ -103,11 +103,14 @@ static int ttyport_write_room(struct serdev_controller *ctrl)
>>>    static int ttyport_open(struct serdev_controller *ctrl)
>>>    {
>>>    	struct serport *serport = serdev_controller_get_drvdata(ctrl);
>>> +	struct tty_driver *tty_drv = serport->tty_drv;
>>>    	struct tty_struct *tty;
>>>    	struct ktermios ktermios;
>>> +	dev_t dev;
>>>    	int ret;
>>> -	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
>>> +	dev = MKDEV(tty_drv->major, tty_drv->minor_start + serport->tty_idx);
>>> +	tty = tty_kopen_exclusive(dev);
>>
>> I believe that the now added tty_lookup_driver() has negligible impact in
>> this anyway slow path, right?
> 
> Can you please elaborate a bit more? I don't see how the
> tty_lookup_driver() is involved in the serdev-ctrl open path anyway.

It's called now in of tty_kopen_exclusive()->tty_kopen(). 
(tty_lookup_driver() is the major difference between the raw 
tty_init_dev() and tty_kopen_exclusive().)

-- 
js
suse labs

