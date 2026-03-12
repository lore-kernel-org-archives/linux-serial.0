Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D73C871A
	for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329418; cv=none; b=hZm4E7K8WkI1xQ2WJBWEOOvrGzSHHFQC2kX+l0vYV9EyqAhjMVw3r7kD3INUrK+ZDxn5ngYWKZSxKSZgo+ngRqnZPk/GLv/QkLZEhNB3/jVBZDfiHgAXHqt1+/sUbOQ8Hrik2MjKnTe6CMc3CvmAhXQFZAhNKlm7CpMMybOM8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329418; c=relaxed/simple;
	bh=HCDn4QL9sfBlwqAgSti+qp8TXV9ZLB0HDHr8FvPtOtg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DJ+vZ7SMAiwYaOC8F462+2wmkXxANmmm0ewTG1Uzkb3O2jt6cL9EHn0AONU7LbRjQvifcZK2VgWzD5ONv9HDzC5cUFs/nkkYikZOkYgeLa0gTiDqMzDkbrVnbqUjt03lOUAxqdRGbZrFcZl8U0uQN8nEoEoba9XDVVZnXVtMlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fsa79Iwi; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fsa79Iwi"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773329413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx2B4WOqPzCd7GXqIrMQwhx12Kzp52jg+OjVOEy5iwo=;
	b=Fsa79IwiHhA1CxpeCQQrvk+2JznQBMRlhZFuQ6cA5THmxUsufCtkGamo4YZ7nXJa/YSV3v
	yVVIiHa4uP7EMKVovnisUqI4u+aRPzY8ls18QUeu/a1IjYOnBk5eA549mK6Kq2s10yk/76
	9DuIe5gccMSrR/W4GJk6vXdzKiCXocc=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v2] tty: vt/keyboard: Hoist and reuse variable in
 vt_do_kdgkb_ioctl
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2026031255-rudder-amusable-1d10@gregkh>
Date: Thu, 12 Mar 2026 16:30:00 +0100
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Alexey Gladkov <legion@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
 Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AD2F599-396F-42B5-B918-DC5A2CB7B64B@linux.dev>
References: <20260302153255.6278-2-thorsten.blum@linux.dev>
 <2026031255-rudder-amusable-1d10@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 12. Mar 2026, at 15:18, Greg Kroah-Hartman wrote:
> On Mon, Mar 02, 2026 at 04:32:52PM +0100, Thorsten Blum wrote:
>> Hoist 'len' and use it in both cases.
>=20
> Why?  And what is "both cases"?

To reuse 'len' in both switch cases (KDGKBSENT and KDSKBSENT) instead of
defining 'len =3D sizeof(user_kdgkb->kb_string)' in KDGKBSENT and =
inlining
sizeof(user_kdgkb->kb_string) in KDSKBSENT.

>> Add a comment explaining why reassigning 'kbs' is intentional.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> Changes in v2:
>> - Keep 'kbs' reassignment and add a comment why it's required (Jiri)
>> - Link to v1: =
https://lore.kernel.org/lkml/20260226123419.737669-1-thorsten.blum@linux.d=
ev/
>> ---
>> drivers/tty/vt/keyboard.c | 14 ++++++++++----
>> 1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> I feel you just made the code harder to understand, as you added
> complexity :(

Not sure how reusing a local variable adds complexity? Would renaming
'len' to 'kb_string_len' help?

>> 		guard(spinlock_irqsave)(&func_buf_lock);
>> +
>> +		/*
>> +		 * Ownership transfer: vt_kdskbsent() returns a pointer
>> +		 * that must be freed (new buffer, old buffer, or NULL).
>> +		 */
>> 		kbs =3D vt_kdskbsent(kbs, kb_func);
>=20
> That's fine, but what does it have to do with len?

It's unrelated to 'len' and just a drive-by change while I was at it.

Thanks,
Thorsten

