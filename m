Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8418AED;
	Wed, 24 Jul 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814937; cv=none; b=VMr2Nc0OPEkPYfFfbSgJmAkZ5tO2f4zmfJEJnQEgdgiw+Ak5sOxwG4tLJgRqDZMjutJaMKisntgweQ24PPaFW8qV855IFI4LqTkwYs9gwJ9jEGodIN+0gQwS4HxF9z4rNfASjysi1M0TyuIzFiN0NksxOT3TqWlxrCv/i7sgSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814937; c=relaxed/simple;
	bh=VogWaYCACd7sFrDa6lcA/J3/8DvHY/X9FUqwXWQjbLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVDJKwhy5j23naa/e2y4XMIN3pxyVo/w7Zza+TSxzR5rAl31SxiX9u0b1rq42v7h7PEYj3zw/f+9/D2QAtXhHtx5tQQr2A1ssgosCgjZ7sacabCHDGuRRNhr8oSFQWibIBUpj+T8F0xcAXkRRBL1baIVZXV2Xqj/frACBe8x7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=XdsSs46Y; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XdsSs46Y"
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:289:0:640:97f7:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 2884061E3E;
	Wed, 24 Jul 2024 12:55:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MtLNp91oIeA0-7MCn9dYI;
	Wed, 24 Jul 2024 12:55:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721814924; bh=G+UeraewCmtASX0SxKoBgqhWhwyz4G1npU/x0euo08s=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=XdsSs46Y7eBcd+Sb6SGWaFWWnifJsP/UoS7DpvKIgOVTgFmYqlyXuaNSLRMzczgzn
	 4hnPvi4CW1ZGkSCHtju6COetJpjdd5LQFOUqgPxH4b9Bg/F3AMGhsPGe1sYBLMBR3w
	 wxhNBxcEHMRzo/Iy3/Ny2kOJiwRZOdkADSLpJGaI=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <be1a3839-23a6-4726-9018-3d18a27163be@yandex.ru>
Date: Wed, 24 Jul 2024 12:55:22 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] ENOTTY returned for tty fds
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Linux kernel
 <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Johan Hovold <johan@kernel.org>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
 <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
 <2024072401-spearfish-gnarly-a09e@gregkh>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <2024072401-spearfish-gnarly-a09e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

24.07.2024 12:08, Greg KH пишет:
> On Wed, Jul 24, 2024 at 11:07:32AM +0300, stsp wrote:
>> 24.07.2024 09:51, Greg KH пишет:
>>> What caused this change/regression?
>> I have absolutely no idea.
>> I've found it by debugging userspace,
>> and wrote a test-case to make sure the
>> problem is not in user-space.
> So this has always worked this way?  Or has it changed?  If changed,
> when did it work before?

OK, I did some extensive digging, and
now am pretty sure its this one:

commit 1b8b20868a6d64cfe8174a21b25b74367bdf0560
Author:     Johan Hovold <johan@kernel.org>
AuthorDate: Wed Apr 7 11:52:02 2021 +0200
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Sat Apr 10 10:36:34 2021 +0200

     tty: fix return value for unsupported ioctls

     Drivers should return -ENOTTY ("Inappropriate I/O control operation")
     when an ioctl isn't supported, while -EINVAL is used for invalid
     arguments.

>>>     And does any real-world programs
>>> rely on this?
>> dosemu
> It does this today or wants to do this in the future?

It does so since 2003/03/15, according
to a change-log (so for 21 year now).
Adding Herbert Xu to CC as an author of
that feature.

>>>     What exactly are you trying to determine with this ioctl
>>> test?
>> Whether it is a PTS (Pseudo-Tty-Slave), or
>> a real comport with MSR signalling.
> Why is that needed?

To fake modem status lines, mustly DCD.


>    And why not do it how other programs (like stty)
> does it?

I am not sure stty is interested in faking
modem status lines. It doesn't seem to be
using TIOCM ioctls at all.

>>>     Is there a different way to determine that?
>> I am not aware of any "canonical" way
>> of determining this. Maybe you tell me. :)
>> So far the only fix I know, is to stop checking
>> errno. But you return ENOTTY for a tty-associated
>> fd (isatty(fd)==1), so I believe this is a
>> bug in a kernel.
> isatty() is a libc provided function, not a kernel call.
It seems to be using TCGETS ioctl() and looks
for it to not return an error.
I still think returning ENOTTY where TCGETS
succeeds, is more than strange.
I looked at the tty code of current linux kernel,
and it returns EOPNOTSUPP in most such cases.
At least that makes sense, but ENOTTY?
