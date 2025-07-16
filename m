Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD92F5319
	for <linux-serial@vger.kernel.org>; Wed, 16 Jul 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682645; cv=none; b=kkZD8b1sk/yUFh45lx70/39euKJ5bav3TrzekCi/BOhzidCJ9pfPCt1kKjR9AkKhXKRpReDF/Eks5WgEc/mEu1UTDXebBPAjK6TDbx5z9wFs8vgkAI5D/TG2+rrK05Htf5GQfzM1hITAIXuLLSsyN4BtooybVJW8VfAKfXKIcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682645; c=relaxed/simple;
	bh=2S29ztdoZu+lSUgDZARUDIlqmdD/4e2XN6yo3Ko0Ql0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9kXfx6eDzzVkJeU4JhU6bny5PtF/lG2j90cK3fLgUXW7LY+13hY0JtDUKI2aOhC/MtY919p8xEn6vh2+WhEVxPSXmW8jpHa8bJyRVxpW93Kzds0WcUO0hJEOZwbWrBGTgI96SFmWsl4sPby7kivD77DZKYw/oe3NHorYyRTdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RSSbQdYM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RSSbQdYM"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0d7b32322so2382366b.2
        for <linux-serial@vger.kernel.org>; Wed, 16 Jul 2025 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752682642; x=1753287442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjOQCdqS8qm4/VhAwfJZCG868dIz30V0TAdtgEhaExw=;
        b=RSSbQdYMO/iI6veaXAFcYRmlv8/RkBru6JY25ZHVxGVRhffTsPhMYQJwyjOSIb2+pV
         NZHz/T6J4zgS/Xfa/jqIUH3Rtr+vHS2rfhOOxqmC4Xza2Y2X52s+2ljRrrY2gUuVTxv8
         VjQs74SX4kdnZxdnIN/0tJPghctpGHHIhY10+4WG3/h/DwJsZDG7N1GzeJEx+xyNER8W
         96+RsuqpS9pJlZA+qWEaD/PCWuhrZjjXwsNI6ZL2RvGaKPfplpnUGsgEsqOzkcfmQPv9
         /7lNecwafYQnQyBhPm+Sz4mWTIUVshZtqftNyLujcYOaWMdoNskc+/QGp5zPerMcSQGf
         JWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682642; x=1753287442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjOQCdqS8qm4/VhAwfJZCG868dIz30V0TAdtgEhaExw=;
        b=BT8oe2Zek44MInZZ7z9uhSejb2IlTtXCdqIPWeXZTrvG8xXPd1jKk9V1V4ndNi1Dkk
         9QtCxF87c6tIi6onTsoUrZIS6RBtaFHc/T2ryrwvGQp8aXi98lTOvutFcmkVvKugCCcq
         KuVltrxusf5Vfr4VRRJfdFYDMQ7YUgHvf7iR79+N+V0BkMeI0rZQwDQyIEZlM57bZuZM
         We8NlDaa7ohIXtL/apq3TmCazfis8lgdQBL5kOMEGiiwxgYZoZsy1JCbayLnWL5OBwX6
         Y0qGcHySJLmxSBdqoI9MdflUYmye3KCyELs0uurpMDkywphwsIB2rnVn22Pr4KyWNWSp
         j/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRuSXLIjbRicR/CagFX99d6sJlGh2oOI2tgukbkNeMi+GZls6byo1BmeLDvNqgn5CL1Cr8gPnNWhlrOfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOcVsVZXcbN7wGC8v5Rsv+XBxthzRD6dLYscM7PPWeXDgv97h
	y5CfjWiJr1OcLDQtUYdcXosiuWc4FzB0wJbZ/smBALkGhd/7mplPVqkoTXwKhmxUcjg=
X-Gm-Gg: ASbGncvWfY3R8uXilmx+E0UapWe5R+1fAqGG291VxbEbozyueEdr31tAQ9AkZBXGNnB
	ngXu4dB+Ia38ZtvDu6I/KeD2rgOxJ2Xqbt/Z2b4Gx/PLt4rvVJbcyIFElKeqgbYDpyYml2vGAuG
	leKd549ks+zwmB3ZP7j41DPpmr4+h+toN0pBy73kbieUyW7zgnLSUiFRkxPM8v0HAVUV6c2CIBw
	PIPs5UPnOKlsdJo+Lo9btav0NY7EmRCZ7KzgHOPTeVmnYKHbsmnVjw4b/9mWJQwoguKnbLABVvS
	9baDret+Uj1H4DaDFfFc9b2Vv4EeSNA+EQ6og4x9w2mJCt1jAAP6/AxBsHuIFJtydG889LsHuhs
	xjkPv6DBoF+Wm81wRxYWYVmLYp8lwrxRktBzWB+/r0KH/5jbn4NNHNACcsxkMI8t4B5g=
X-Google-Smtp-Source: AGHT+IF5iXIUmrdCM8FhNB0jGX3DsNw6jrLVe+lQO/cwacf3GaTVn0cynfyX1i5HLYqqcIiwQr7RfA==
X-Received: by 2002:a17:906:f114:b0:ae0:da16:f550 with SMTP id a640c23a62f3a-ae9ce167b10mr288616566b.49.1752682641624;
        Wed, 16 Jul 2025 09:17:21 -0700 (PDT)
Received: from ?IPV6:2001:a61:133f:9e01:3f5f:8464:37ea:5571? ([2001:a61:133f:9e01:3f5f:8464:37ea:5571])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91c81sm1224581066b.37.2025.07.16.09.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:17:21 -0700 (PDT)
Message-ID: <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
Date: Wed, 16 Jul 2025 18:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB cdc-acm driver: break and command
To: "H. Peter Anvin" <hpa@zytor.com>, Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
 <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
 <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.07.25 17:06, H. Peter Anvin wrote:

> SEND_ENCAPSULATED_COMMAND at least takes a command string – it was intended, I believe, to be able to send AT commands to a modem while online without using the +++ escape code and all the potential race conditions (and security issues, since it is trivial for a user to generate) associated with that.

Understood. It still seems dirty to me. If you want to send strings to a device
the proper way is to use a device node and write().
  
> As far as BREAK is concerned, there is also the option of locking out a second BREAK for the delay time; however, this probably should belong in the tty core.  What do other drivers supporting TTY_DRIVER_HARDWARE_BREAK do?

I know of no driver but n_gsm which uses it. That driver needs to use it,
because it cannot switch off a break.

If you really wanted to use that API as it is right now, you'd
have breaks racing with each other and, worse, with open()
and close().
Are you sure POSIX says nothing about how to handle such cases?

You'd probably have to start a timer in the driver in send_break().
That timer would need to be properly handled in disconnect(),
pre/post_reset() and suspend()
That API is really not nice to use.

	Regards
		Oliver


