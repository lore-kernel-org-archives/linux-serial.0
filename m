Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10021E3787
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224665; cv=none; b=sbVbw7pHNyvNGqfBsqqvdrrtCnIiSPOE3DLvAhMc1l3fHlBe2zB4gvJKMWfxjG1PnuZRMmlPVV/GZCOY9ocYileDknJgPVSDwtYQxn8ip0YV2QETCjTAF54CybxptFxaeLJknZzUlWyNybpyuqvF8ZtDftZuO1G/ko+8+lT7mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224665; c=relaxed/simple;
	bh=GL/bQ5r6c9bWsrmtuXgNYYRcGjeSMv6UWL57z9PNotc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IvBYUHI6wsEY0bD1ImAfrA+j+OmA2WySj1jQMM2MgnsbGesmNMau87uvJ2lcEBAF0UYz1p2UaTGgNxp/mQw2oth57Gzjo2xWlZMwhKKid0OogSyXFwvjAZLRC2ahVXRSbdd2Swi8N81BDBvNwN/ARMi1L47zwWCIkZiZl97o9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBQGDoGF; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBQGDoGF"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ee8eaa1694so2333296eaf.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Dec 2024 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733224663; x=1733829463; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sOHbFwHOJSjDxvHaRCi5M6vvE6Bu+ubhCYatqOP8Nfo=;
        b=aBQGDoGFdF52rzSKdvvN5dE9udlRW5I7bxge3hG6eXzFjHtoWeD8+HhtYnq4yTuuU6
         1Rt+wSTey+/QKfloc2zgiScydo+cYm6Kb5bIuDmKzBm1ZYTHBFlRPTrJNkg6Y1Ca0BHr
         SsQGyPOg+l9jwf2mWvFahoCAx0XvftosrMuu1GokKS9dtSqS8gwYEw3yz7zxM4ilrZBy
         YBeYjCr74ksS8xmkKv9EKmDg6MHWV3BvPsRt9ydvmEBoG2MQa39m94LwQFTlOvVyKKVv
         gXFBvi6reaS5EpUBrGug6bzH/ugMSzmPZ/Jrol2G926wmZztw813KjBQc4+LX20AWi8z
         a2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224663; x=1733829463;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOHbFwHOJSjDxvHaRCi5M6vvE6Bu+ubhCYatqOP8Nfo=;
        b=d6xPpTOTOZ6ZyqhtzVafi0f9PR8rV186LxDRevMbtdxQBtXdvKBdjdf2P24slEuO+E
         wumXC3+kynAwYB440zsb0R18JJXbm25isnNm+lgEQgRkjVD590P17bkoiAsDR5xRSE0B
         eBIHvhRWnZoKCM2T9kJg4kNimfI5emo7CeHZuLl68/3vmjCEmjoqNPAQPZqBsbr0WedF
         1J0pQcSou5gA9+reugvU2bpQCm93wCHse6R1I9/s6mc/k4GmQFEF8zByYKhRRxSPLi3X
         1JBGCqFvTkqKVcHyRapVh5BoFZ2YZ18jY8bL+3SxdCMPKQwuGswMiAo6uUDCEVzAzPQ9
         L2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLv7c/uFEibKIl9HD4UBUt4Hh92UZh9vTdC7nwRUVz5nq3tHHKkuI69ZiIV9LGj5CscS1/OLNtNlS8rTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKNp1mXyni/NTjD1qR0IYTfLfI8nWcPjXlfNdS9wuVJhICY9N
	fL/b/kWf6ndf+ITBxt/WI50wbucf06sIInjQeibK+rNeSsv1O642WdJJ1PzM3oBqGwNoZt0Egd9
	qBtnmu2x9iViPTWlhALNsK0Io/NIHld6j
X-Gm-Gg: ASbGncsKJodwqep+cwn+8BwY9+62v4tSmV0e1ERVFVczaiftefJoQQHuIksr7IvYdmQ
	+8Pryp/ZGl+jIcitHc/imZDYx5N/qwOKwSQ==
X-Google-Smtp-Source: AGHT+IElWcAa+7s/KWOEX3M6NEqSMZjVXetIBogY1FxjCwcQAPiylrbSx/A2sQjsTT5Xo4CHb9y1iXEmZUPWlry08aM=
X-Received: by 2002:a05:6820:4c87:b0:5e1:ebf1:816d with SMTP id
 006d021491bc7-5f25adf69c6mr1076836eaf.4.1733224662708; Tue, 03 Dec 2024
 03:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Tue, 3 Dec 2024 16:47:31 +0530
Message-ID: <CAHhAz+jqTxsMipLLnBvRAC8cyN=QhTe5sToh45FN=AyrZ9XnNQ@mail.gmail.com>
Subject: Query Regarding UART Controller Device Driver in Linux Kernel
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, 
	linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Community,

I hope this email finds you well. I need to work on the high speed
UART controller driver in the Linux kernel, and I have a few questions
that I would appreciate your guidance on:

I understand that the Linux kernel tree contains multiple source code
files related to UART controller device drivers. Could you please
point me to the relevant source code paths for these drivers?

What is the maximum supported UART baud rate in the current kernel
driver's supports? For example, if the hardware supports high-speed
baud rates (e.g., 12 Mbps), are there any specific design strategies
or modifications needed in the driver to support such high speeds?

Are there any user-space utilities available for testing UART
interfaces in Linux? If so, could you kindly share details on these
utilities or provide any resources that would be useful for testing?

Thank you for your time and support. I look forward to your response.


-- 
Thanks,
Sekhar
