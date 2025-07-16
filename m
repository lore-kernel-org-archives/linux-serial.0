Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399922EA72F
	for <linux-serial@vger.kernel.org>; Wed, 16 Jul 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654572; cv=none; b=Lozj95MrhsC9NczY1wXNDlIdm5qL29artLpVGEmnTYorBCClBblipUUlYjXN/PFVzVE50zmuZ8uyybgMKxw9suDNMRy9yhliuUnwzp5jmYoO/EcIlGlSSw84QzmWTIzT1X6jkRQDjbKs0i6yBVguKV+eUIIWtTnMU8FuvCwNA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654572; c=relaxed/simple;
	bh=/dVOnKYB8CD/wyyHbMWcCAYLrsRBtnjmn40w6cFnUfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaPWa6x9LhpD+W9jSUKyYugxIpxs9y7qcIkNCNvtXxi5MFOuMtABToDQZF95btdyJpwmQ4DR2097OeiI4jb0JkRtJxHbG9w/dgqHY5wU4NspFUYtIEqmuDV4inbNNyts7Mw11ivArYKM9bz8pyGcz/aZC5zrpbiqLIbLAytqris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TJ+DqaZf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TJ+DqaZf"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3872139f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 16 Jul 2025 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752654568; x=1753259368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTS987hZr2/BPWLmY8oveEZ2X67lASpu1Bb54ts50jo=;
        b=TJ+DqaZfl0zIkqswkSGb6b5pGV9HjXtR9W602M0rVQSG5DF65rjluDPe+4ILj9b0xD
         dQdGk+32aL1h6rxwo/lmrOc4pUZ/8LUMZ9u/noYWD8KZMRM/qJS6PorYHnu35IVMgeyS
         9tmAiw9zyY+Y4or08t2QxQm3vpQiZKYyy4yfMlJ8QqYvxbXa1q5KVodNevEzG0lpvLWf
         zVyAR/H006nurUAGEEZx0AmFMCLmEPeXsYjPfhOW9OASpo3W5S1WX5WSgE1/ZhwYWtlo
         EDtoSWGFOyIDh2xOD0LCgtbPQhm3fDnEMIg9faXtbQICCpUH3uJflijVdayK9HDzQGbj
         ZyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654568; x=1753259368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTS987hZr2/BPWLmY8oveEZ2X67lASpu1Bb54ts50jo=;
        b=m5pS1MuDXlJ8UPo3eUz/Wx9gKNW0ujWQIa+hApX5GAmXbAyxI8b8/3rvl4JjJiT8Lv
         N0JY1d6gmP5cUM5Xixu0hESOMjfzB0w4jW28kqcTCNqS1BE8PdYOfWGRk4kUOnN0FjRR
         vtU24WPIIkeVlV1Pt40Ebw9NFl/Uapxph0FKquPeaGbTPQqgLF+Kc2wWPlLclR61BboR
         z9TXdIavomAbfGW7Isx9lfdlaZb+FX+LO/5s88E5mKni2yjP+nQplf+E3HYOTt+jm7Lo
         Ke6Bkrsqpl1ty7NrcWospgrmGzsjhbYUhB2C+TXrnT08LqRo/uqnOxuEyz4Eqv06g7Xs
         G0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWqgr1DSPEYk+ICQXhADu54MeVaKws62xasnyH5N/EwUir61c5DfNBeKo4I0AN8ebfdeRdlTcT9PXv5dd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqIXmnoB+/kLn6K0PS33yGVG63VRUa0F3FGO+DOF9glX/bAYV
	bKzX6vlcfAf8rNfddPhbfLVAKGGHQGR4VES326gDTQqI+muCWEfqRfue/8gAqFzcwaA=
X-Gm-Gg: ASbGncs4E1XKrkc/rWRR3P0pfxErOv3kHKi7l+L9Qwe+ZSWIxl82pwq2JfD11b84pf1
	EkCY0eW3Ad7KipQmj9Hc/xMlK+Y7BD2BeOOSwjo/g+TMm4C8COX8pDO8DpEfagueVo8E5DPE+I8
	TMi5Iqh+3N5GIu6BjJ0qa5Lzthank9C/13MUzHahY4sCMkvw+T75Vz5aqfK++mwnMQfKejTw6Dm
	IIbE5RRj9vV9tAPpAR0b7h8o3KdZNVyXjZ5mMacoM8fAY4gVTuldA/AdqfXjJp7uwfkN2lMuAAY
	cgo2zDO5JunJr6nRc6l6+jci4XrEOvtmeO41exEfAdMDy7/rYzLEO6s3SljGJ8HShhyuq7kmEh5
	Kr+uNrIud6Qwab1pVHg0tSrKUmBY736FyI6fsog2HNw3fDjLDrH8qhDzglygx5Tx4xQ==
X-Google-Smtp-Source: AGHT+IFSZH4omeTXZAl7Lh2gjNFC0tMnhjbsZXaH62GbzEcddv2hbbklP4Avf1fLgsmVBRMpxR52/g==
X-Received: by 2002:adf:9ccb:0:b0:3a5:39d7:3f17 with SMTP id ffacd0b85a97d-3b60dd898c7mr1162606f8f.47.1752654568473;
        Wed, 16 Jul 2025 01:29:28 -0700 (PDT)
Received: from ?IPV6:2001:a61:133f:9e01:b1a5:79c8:d196:e761? ([2001:a61:133f:9e01:b1a5:79c8:d196:e761])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e332sm17275063f8f.79.2025.07.16.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:29:28 -0700 (PDT)
Message-ID: <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
Date: Wed, 16 Jul 2025 10:29:27 +0200
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
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.07.25 23:00, H. Peter Anvin wrote:
> Hi,
> 
> I noticed looking at the CDC-ACM driver that it uses the assert/local delay/deassert method of sending BREAK.  Given that the CDC model has a delay specifier in the command packet, is there any reason not to set TTY_DRIVER_HARDWARE_BREAK and sending only one packet?

1. The existing code is tested and usually works.
2. The locking goes away. I have no idea what happens if you are
sending a second break while a break is still going on.

> I'm also wondering if it would make sense to support the SEND_ENCAPSULATED_COMMAND and GET_ENCAPSULATED_RESPONSE commands, presumably via an ioctl().  I'm not 100% sure because I'm not sure there aren't potential security issues.

Well, one of the purposes of the CDC-ACM driver is to hide that
you are talking to a USB device.
In theory we could do that. I don't quite see the value.
Sending arbitrary data from user space to a control endpoint
does not make me happy.

	HTH
		Oliver
  
