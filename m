Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB6446DB;
	Wed, 24 Jul 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808459; cv=none; b=oiihkNfd07VpT4Q0jN5TemgRDosjz5VIOuqYMeGClnSswk/g8bkDLZHjLSFt1pWINsC00Wql+JS47EsXNRsf14NfhK59TQeppoonbLgUiwGlAUG/3xqxJHnkQz4fQduuLAWzDtf0r+xQUTdu5vpZJZ+JIrl12WbNF0VX/J1d/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808459; c=relaxed/simple;
	bh=Z8Ijwr27NkdYy0pLl/y9ByAs5lOkihvl1MgnH3tZp3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+GRQZNLQyMURuyvnhgtUl78FKWWQKXaIYK2+pgo4pehY99Rd3dONcZ0S2l51zxgCMnm2eHAy5lgrpCQ/+tRdQeW/yzUQG/fjuZ8sFaOpWz0ATrgbr80gMhl7opedZ2e5Ta90b3xsa88CBzOixrbW8r+LjTW+JvdNaBXKXt66M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=AhA7DBNV; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="AhA7DBNV"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3bca:0:640:d666:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 6CDA060A6D;
	Wed, 24 Jul 2024 11:07:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id W7KMmG0GgqM0-7OUrbMSb;
	Wed, 24 Jul 2024 11:07:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721808453; bh=hfICN/OZQ/OrwtqotMrp7FF8wN3qZsZGOt3Ok0Z+5/U=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=AhA7DBNVhFPcg3rGDO88KlEaq2ESFNq//pbCR1oGDn+fTx1oOO+PzzRWmXFgy2To1
	 1/qipoSqv373IGJftA0jxOv9rzivQv2RCop96B7rXEaSnImZYThc/Kr8036nhX8bWp
	 byxCUE4TDKqWLDDrEa9b2mCe83oqNrcBbztkxup8=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
Date: Wed, 24 Jul 2024 11:07:32 +0300
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
Cc: linux-serial@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <2024072452-pegboard-undying-4245@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

24.07.2024 09:51, Greg KH пишет:
> What caused this change/regression?

I have absolutely no idea.
I've found it by debugging userspace,
and wrote a test-case to make sure the
problem is not in user-space.


>    And does any real-world programs
> rely on this?

dosemu


>    What exactly are you trying to determine with this ioctl
> test?

Whether it is a PTS (Pseudo-Tty-Slave), or
a real comport with MSR signalling.


>    Is there a different way to determine that?
I am not aware of any "canonical" way
of determining this. Maybe you tell me. :)
So far the only fix I know, is to stop checking
errno. But you return ENOTTY for a tty-associated
fd (isatty(fd)==1), so I believe this is a
bug in a kernel.
