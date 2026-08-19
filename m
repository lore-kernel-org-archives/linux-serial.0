Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AB3AB269
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121089; cv=none; b=H089yVVd7xtK/croe3W11lgzE6bAAzrG83LR0sDi+7hY3ate8xqCEzK9VtsiUZdr2w+ekYzgrgQac7Tp7p7zSfEhM6Aqysyr1bn0dtBa2rWKt29KHhpCqdc87aYLKpqWhPmKN7ZbA8GRP8J3ELxV+h4gLa443leD795NGW9miOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121089; c=relaxed/simple;
	bh=E7U2pdBSzmPRbhEDk1+nhVwIHgjPvU3itGr9fyRVplI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XF5Et8FJzUjusX0gDrJIY7cgA2PPDwgu2bOwZGG9kymzvOgzKcBVBiTYXh2bbqWFbE+Yj46wODhcA4P+jDmJH/+HzrnQpHdVN0fMt6uf6TpvxqD2HsoE0qGRxPv2zz9Bi7OHe9VjLyo7aimRjOHWLKGvDzyXqPncLSyndQC4ub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso4668355e9.0
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 23:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787121085; x=1787725885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeMbRRpxJhABtTKZKYmvLntVqaXrQydJ0AK3LdgfC2k=;
        b=RmhPik3n9BRLfV5GrARlH1GhJo5Ld6JLGkJo9oObVwjuvzv1hjHgCgb0/dUSFA1KuY
         0mdueouf86jh8OgdBqMCLnpG+1Jj100GJ6PlNyzqZPZ5uby3xYWTCVHrLBZFKVtPsTUT
         RSE4OC2b8ky+Wg1fmy4iFm1LTYfBg+SmdNgIjOT/g7st1GIzoO9jtEBXRL3C99Inblmk
         oouRyXCBQWA9dxSlFC40pktvviENR4pJaQgWc77B9CzqXrgd0N1XNJ9VHxgBpAhLYqnI
         dne9pTyKWtCVN4tVh3qjkLQLxHocrW8HG5STOZkcGCFKOWdwxac41FT1vQfj6gpRrLeu
         1o0A==
X-Forwarded-Encrypted: i=1; AHgh+RqEH2a9CnfD3ze/ivOmCC7yfKPjkk5M0YTAVu0+vGY9x6U+W5yZDsFbCGYGp3b0dhug1Z9zn0rbv4Ix0CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBwF/ZnVQVoXZrYHz8tJuGY/WcvuTOiioT5jAYKGGVew9Dxwg
	UOwjDiwFQWWT8m8ksM1qQLd4O+n9CNjPHfNbT9WIKZULp6dgLXjCLVqZWfv8hA==
X-Gm-Gg: AR+sD10iPdT77nrX9958vmYRbKCUXehdHjv3aX9+w4UQiCjennajXWByeOndmX6+ebb
	nM2FwkgpRO/oRbWgPLW0eQOXIGLAGWmXAoyJ/+0fzcfH6yrFENgLbLTwewwjYDpEaXY0NxqIGfe
	lrtNXgSqap7UcCeMjpoVIYH+B9kjbILQt5L+HB5Tvy24e6nVuoI07J8phzFXltXM+BJKA/LVvhS
	UOpPUe0bk1t1cuathCg/cQFl3G5NLCwtuouUZW9bwh9Ka38TY/JnyMtJBlE4rcv3a58ay2IFjY0
	nEK/ZftC3LhtawBCa24wUhL7EmO8ml08T0lWk9CThUWWaioBbNSkMRJ39+xbxj/Xm4xvxknwJdt
	K0FrpgEPXf15+WMnsPyDDPTmw82KkUFrsLQRDToCGSW+1gRR2o1m+R+ki+P5IGKF/0uowMoJYqZ
	XBF6mRp3gfUd4WH/iwuu35LSRe7fBTGgvD08sjT8vb5ffKdEtWckYXPzUZg2L0aJde+FdijKwg+
	qY1z5WL29q1CSfgol93bA==
X-Received: by 2002:a05:600c:4e94:b0:499:84fe:5f3e with SMTP id 5b1f17b1804b1-499aa1b6a0dmr29726595e9.9.1787121084843;
        Tue, 18 Aug 2026 23:31:24 -0700 (PDT)
Received: from [192.168.1.135] ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd5fcsm41013435e9.14.2026.08.18.23.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 23:31:24 -0700 (PDT)
Message-ID: <52d1dcfc-9eea-4786-a7e7-13a011b7f1e9@linux.com>
Date: Wed, 19 Aug 2026 07:31:23 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: don't register ports that have no hardware
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260818185200.10243-1-tanure@linux.com>
 <dd831cb7-7cfc-46cb-a9e4-2899add9518d@kernel.org>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <dd831cb7-7cfc-46cb-a9e4-2899add9518d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2026 05:42, Jiri Slaby wrote:
> On 18. 08. 26, 20:52, Lucas Tanure wrote:
>> The 8250 driver creates a fixed set of port slots at boot and
>> registers a ttyS device for each one, even when the slot describes no
>> hardware. On device tree platforms those slots are empty, but they
>> still take the ttyS0..ttyS3 names.
>>
>> New Amlogic SoCs (S4, T7) name their real UARTs ttyS as well. With
>> both drivers built in, as in arm64 defconfig, the real port fails to 
>> bind:
>>
>>    sysfs: cannot create duplicate filename '/class/tty/ttyS0'
>>    meson_uart fe078000.serial: Cannot register tty device on line 0
>>
>> Skip slots that have no I/O and no memory address. Legacy x86 slots
>> come with resources and are not affected.
>>
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> Assisted-by: Claude:claude-fable-5
>> ---
>>   drivers/tty/serial/8250/8250_core.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/ 
>> serial/8250/8250_core.c
>> index f49862d90eeb..e66e0cdbb210 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -378,6 +378,14 @@ void __init serial8250_register_ports(struct 
>> uart_driver *drv, struct device *de
>>           if (up->port.dev)
>>               continue;
>> +        /*
>> +         * Skip slots that describe no hardware: they would only
>> +         * take up ttyS<n> names. Real ports get their node when
>> +         * they claim a slot in serial8250_register_8250_port().
>> +         */
>> +        if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
>> +            continue;
> 
Hi,
I am working on upstreaming the Khadas VIM4 (Amlogic T7). On that board
the serial console does not come up at all: meson_uart fails to register
because the 8250 stub ports already own the ttyS names.
> So you can no longer set up those ports via TIOCSSERIAL?
> 
> And what about already registered consoles?
> 
> Why does meson register ttyS* in the first place?
Because of commit e71aab9d6132 ("tty: serial: meson: apply ttyS devname
instead of ttyAML for new SoCs"). meson_uart carries two uart_drivers,
ttyAML and ttyS, and A1, S4 and T7 are wired to the ttyS one.
> 
> F*ck AI proposed changes.
> 
> thanks,

I will talk to Amlogic list to see if there is other solution.

thanks,
lucas
