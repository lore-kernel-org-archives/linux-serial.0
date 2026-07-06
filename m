Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2B3FF1B8
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349528; cv=none; b=nQ15BgkAzmz3bE9RZhAyb6Mt3NuL3wt2cfwUY0pxfShcLZLR3YDLs9SC3rgkOqATSwu7sNJUY7/I9y9a5mLVTr+nyHxAwcAGk+veUcZ8+W8aF9YPT4nM/Psxu5Qvy2o3ryOeJ7uCVqubrZ33ZOEqcnENKAXSRIJbrgltd46HlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349528; c=relaxed/simple;
	bh=PH9LQ+qNqjrf3AjrdADFFOYBRrffXAqWad+Kcpvweqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKo+BKIAuwGSUv0at/pQ5OJlaHwMCmEA/kEcyrj84KUBxv/JiuVQTgZtmBPPiwA3O8PLpZsWLsVN8nC9zFlJj04ti0fAxjKqKS+K3pmEoh6TyHx3pmrfgzmBl2OEFsadql0lxvGOtxxhEM+OTSXStXtGRnOnjKzBTWOK6nSCdz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DcyAsiBs; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DcyAsiBs"
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:489c:0:640:8d6b:0])
	by forward500b.mail.yandex.net (postfix) with ESMTPS id 6323EC0AB3;
	Mon, 06 Jul 2026 17:51:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp) with ESMTPSA id qpIXNivg1Cg0-58ZWrqbp;
	Mon, 06 Jul 2026 17:51:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783349513; bh=D/panZsQ9rcfajcgXOhlViIhYZaFyMHh+HrFvlmh/+s=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=DcyAsiBsU4Ezo36eXw0e8YWyvzpZ1FlCq2C0vO2aP3cOUseFZwp712RYWzLjLfW3M
	 wZ+vDR5VcZQvZ3I07BLkhlYg7ERVJeSxMHdytOMqZ4R7mxWefaEKwC7gElV+4agWJY
	 mIggCOYWN9Ud3ristczy+69wOEas7uegED/JS68c=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <16b08a3e-4b31-4941-a0aa-0b53a0dc4cec@yandex.ru>
Date: Mon, 6 Jul 2026 17:49:38 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tty: n_gsm: avoid reactivation without previous
 cleanup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
References: <20260706142016.3385636-1-dmantipov@yandex.ru>
 <2026070611-pamperer-traps-84d4@gregkh>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <2026070611-pamperer-traps-84d4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 5:35 PM, Greg Kroah-Hartman wrote:

> We've had loads of syzbot "issues" reported in this code, and unless it
> actually shows up in a real device or operation, I'd just leave it alone
> please as there are lots of subtle issues involved in it.
> 
> Have you tested this in real hardware?

No. But I don't see any practical reasons doing ioctl(..., GSMIOC_SETCONF_EXT, ...)
more than once (without GSM_FL_RESTART) without doing anything else. Worse, an
attempt to do it simultaneously from multiple threads is obviously racy.

> Why unlikely()?  Can you measure it with/without that?  If not, it
> should never be used.

See above. IIUC "real" userspace program which talks to the device is unlikely
to bomb the device driver with the weird sequences of ioctl()s like syzkaller
usually does.

Dmitry

