Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A911E5718
	for <linux-serial@vger.kernel.org>; Thu,  1 May 2025 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072664; cv=none; b=ZgpIM4Hq1GBGBWy579a0hRtB7q+rztOmvsXkbN+Isz9WrPiruJLOMYFPJ++f1WBSJxkO0+ULURYCbthxwHfipptmbKOh0A5z+BFmpe5uVwZlr+jSAFVahgRtyUnxjfSf4s6xRCPEOdjVOYJTecUWH8qA2q6w8VdMNoKDXr5ycD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072664; c=relaxed/simple;
	bh=cglhck3ZVlSAKkENCvkXY5/2fG1tC16s4xQjru2vpAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KB1y9J5aiwQ4c4JjrsdY2tj1adISw0LQBAsVfwSNXEjJvKjq12niBcqiBX7jaCkGQqXqbF/ASR5Ov1eKOrSWvxH6fEYRIP04FMDCUc9tetRkw0gNq2N0MC7e8e4qvcEXXdmi8nfXNZGvgFC9xVOnZt0hxGFIxgkshhmkt+7Luzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGVQoAER; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGVQoAER"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b07d607dc83so435901a12.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 21:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746072662; x=1746677462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cglhck3ZVlSAKkENCvkXY5/2fG1tC16s4xQjru2vpAw=;
        b=EGVQoAER4sBQT5vQoNRRKsctIOH5qdiJlL4UNCwSKZwrp5VOBpfwIqkFe5IqRISCmy
         z921e2QY2QG4QuFTDHCDKNysUakFFiVNu20Q3kIesG8d0QhjBSjqOERbXIFkz2K613pP
         I0+os0xNdQSqFjn26HRAsLSwbUeLMwWk9+rYYXBL2I6o9Vzw43E1INFXSbDzLPx7dgmF
         0Q1WZKc8FUt2lN66H8YwzTIz+1GU4sV5B/ibtRDT3Te5KSjIFC/LQ/6e+xEYfdtYpnWX
         hFIc6HV952pAylwu/qnB98M/uLZaVJo2imzslk1QzmWir0tNfjHZToXnehNdYvZmWcal
         cUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746072662; x=1746677462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cglhck3ZVlSAKkENCvkXY5/2fG1tC16s4xQjru2vpAw=;
        b=ODBt978jENBHM4NCMwS1eKSFPhAruWqRlyPCXlZ/MvIDkeBFgOJi9quE5hd2d4m/vU
         WBZhQDdNegs5aUNpRunDsycHLQxsvMY/pgd9qIIU9y8BWkA2xKp/cyO1XRXixj797rSA
         JcId2pvWP+q+/RrbXP46lhI0OJAiCNXyqK3tiMRboO91/lBktz4aeEvhSWcKQVnljoFo
         our5U6303vW2LmMD6JeX/XvxEy7K8judYUH/Ogwe73KYx0NUTADwS00XjcuZbnru64Br
         6KYH3zPMXVdN5z34SczeP2YkGx3tKqOY42G3dLoC5QP/UPw4jIpPtfr9UFMBHXMAhYwI
         hZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNE3hrsK89793B5UQqpkskKS4+QbSFUx1PGuvT5Gb6+fha7I2Fxel2z/3zlb/+3OkcSuLhFMRKd+l2Ss8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZ0NaOPvip2uZVF3UsEJIwG6Ukc4iMgkSmP4jd6WLVa6xsEIs
	x5s4NbmSDGkigHvjVH7vuFmGxC0c2h6EcLpxsgQKNqpnFgs9r2iI
X-Gm-Gg: ASbGncuWO9CPmNvdu8fIQadjHJm43qfA57TcA+p8MZ/zbr3cqw8toWCn6Yxk3csbV+a
	z/1uUq4kn9Yt4t+eV3EttmJQITaCO3Rf3BeTethhDPHPBfdcSpOadnEj8rey1TbebqE36beaup9
	GexCF/ywV9Lhie1dUPn34Z09V7l1UVXANbQCx4/dd2eBszSz+o7fB5nLRnTrsvhQTGAhYkIykEr
	KAybIYE0Kz6rMGw1l0xi2vdoGjVNk5fVqX0MaT9SYo2rumMIDRLdV8yd/ezDI3iDftAgHEKxZmN
	sY16bTl26fkx9iNsFY0oqeVlswgdlK/sslKhPbLm55qMb8+gCYhJov+xzQe4wGFvfAXHpS0uAsm
	FJqKRWWtQnog=
X-Google-Smtp-Source: AGHT+IEy/jmpGgpIyizyxFYlKl0htHFpZ7soOfbtZASR7k6jSxVTqIU2w/1i4rQkzFMZ/p1as5YCOQ==
X-Received: by 2002:a17:90b:2750:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-30a41eb505amr2272046a91.33.1746072662145;
        Wed, 30 Apr 2025 21:11:02 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a5f86esm2563115a91.44.2025.04.30.21.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:11:01 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de,
	pmladek@suse.com
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	ryotkkr98@gmail.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea: BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Date: Thu,  1 May 2025 13:10:55 +0900
Message-Id: <20250501041055.6504-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84y0vhodwy.fsf@jogness.linutronix.de>
References: <84y0vhodwy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Apr 2025 17:47:01 +0206, John Ogness wrote:
>On 2025-04-30, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>>>> The touch_nmi_watchdog() resets the softlockup watchdog. It might
>>>> hide that the CPU did not schedule for a long time.
>>
>> To test the above, I run the rslib test using legacy console(without
>> the John's series) with the touch_nmi_watchdog()s removed as
>> following.
>>
>> The result is that it triggered the softlockup as expected. So I guess
>> we can say that the legacy console was indeed hiding the softlockup
>> scenario as suggested by Petr.
>
>Excellent.
>
>>> With the John's series appied, I guess the kthread were running on a
>>> cpu other than the one running the rslib test as John said[0], and
>>> neither of touch_nmi_watchdog() nor cond_resched() were called that
>>> could prevent the softlockup.
>>
>> To test the above, I removed the touch_nmi_watchdog() mentioned by John[0]
>> on top of the John's series with the printing forced to be done on the same
>> cpu running the rslib test by marking emergency section(below change applied).
>>
>> The result is that it triggered the softlockup as expected. Similar to
>> the first test, the touch_nmi_watchdog() was preventing the softlockup
>> when its marked with emergency section.
>
>Excellent.
>
>> And I believe this implies that the kthread was running on some other cpu
>> as stated above as it should also be calling the touch_nmi_watchdog()
>> when it does printing.
>
>Agreed.
>
>> If sounds good, I will prepare a fix adding cond_resched() to the
>> rslib test later on.
>
>Yes, please add a cond_resched() to the rslib test.

Thank you for checking the results, Got it!

>> I tested with Linus' master on x86 qemu. I was able to see the rslib
>> tests prone to softlockup and the John's series exaggerating it, same
>> as raspberry pi.
>>
>> But I couldn't see the softlockup go away by marking the emergency
>> section around the printk call within the rslib test. Looks like it
>> never calls the touch_nmi_watchdog() in wait_for_lsr(). Maybe because
>> trasmission gets immediatly completed on qemu board?
>
>qemu does not emulate a baudrate, so indeed transmission completes
>immediately. It would need to be tested on real hardware. But I am

Oh I see, that makes sense.

>certain we found the cause and explanation. Thank you for digging into
>this!

Great, my pleasure!

Sincerely,
Ryo Takakura

>John
