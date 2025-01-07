Received: from m32-10.eu.mailgun.net (m32-10.eu.mailgun.net [141.193.32.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB421E47DB
	for <linux-serial@vger.kernel.org>; Tue,  7 Jan 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.193.32.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250285; cv=none; b=BcmAqAhHIP1n4tabRx6TfkeJ7hTFeoA8DdcE0TjTulP5gfcuCVs491S151YKvc5Id4c/nnWgGLUczY5qIPEd/m5MpXNpctVjMrlPuiFznSPpYR92JKhXIgOE3llgvjE8VCTRIvCItYcx5vFUrCuD6EQaTPL55LBfMIvYl+oE3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250285; c=relaxed/simple;
	bh=NAbEQ7nfpfqhEjkHZ9qe8RbQ1lHrImgzCNn2YIKrOfo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TQ1kFCAd5p7PjsO0ENETyf3Bz2l0opPMXoA2V7QbkdAqMCY948p3UIa+V+hlXWDuGiOetjUmTuweoJhKv6kkshyp4CB20fr6H3b/6bmVzbdbqTMvZiPZA/I7YdwcoI3+nYZEqlfJQ5Gfm/j1KbAt+jjEUCeu8wLJ0dIruYUYP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gpost.dk; spf=pass smtp.mailfrom=gpost.dk; dkim=pass (1024-bit key) header.d=gpost.dk header.i=@gpost.dk header.b=qvnWuKpI; arc=none smtp.client-ip=141.193.32.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gpost.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpost.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gpost.dk header.i=@gpost.dk header.b="qvnWuKpI"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=gpost.dk; q=dns/txt; s=mta; t=1736250278; x=1736257478;
 h=To: To: References: Message-Id: Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: From: Subject: Subject: Mime-Version: Content-Type: Sender: Sender;
 bh=NfoTWAIiPRbaqrzNsLlTYJTWXoq0YSfCnl7rW9eubLA=;
 b=qvnWuKpICrzkHADR4zIsoT91OdGMNoZF1HWQr/y58bffIvJdWswxtBUYN8IFaZGQ6FN+Mm5n+Xq4p7kv2Z3XM+M/O2q/8hAv3rx45hUe9hUyCtHx7IkZfSNCUIThcJj6JHuCWIr7tao51Jo/5Bkikq98A3BRPO5IJtgmGT3mVwI=
X-Mailgun-Sending-Ip: 141.193.32.10
X-Mailgun-Sending-Ip-Pool-Name: 
X-Mailgun-Sending-Ip-Pool: 
X-Mailgun-Sid: WyI1MmE4ZSIsImxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmciLCJmODkzZCJd
Received: from smtpclient.apple (11.85.120.188.andels.net [188.120.85.11]) by
 36fc70cb3394 with SMTP id 677d13a6f4e5dedc2cd8a8e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Jan 2025 11:44:38 GMT
Sender: gpdev@gpost.dk
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH 1/1] tty: respond to TIOCGWINSZ when hung
From: Gil Pedersen <gpdev@gpost.dk>
In-Reply-To: <2024122329-jockey-delouse-71a7@gregkh>
Date: Tue, 7 Jan 2025 12:44:28 +0100
Cc: linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <110BE776-AA74-4DDC-87F1-453B164D25D2@gpost.dk>
References: <20241121111506.4717-1-gpdev@gpost.dk>
 <20241121111506.4717-2-gpdev@gpost.dk>
 <2024122329-jockey-delouse-71a7@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

> On 23 Dec 2024, at 18.56, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Thu, Nov 21, 2024 at 12:12:54PM +0100, Gil Pedersen wrote:
>> Userspace libc implementations of the isatty() POSIX system interface
>> are currently unable to reliably determine if a fd is really a tty =
when
>> it is hung.
>>=20
>> Specifically glibc libc returns the success status of a TCGETS ioctl.
>> This will return an incorrect result when the TTY is hung, since an =
EIO
>> is unconditionally returned. Ie. an isatty() will return 0, wrongly
>> indicating that something that definitely is a TTY, is not a TTY.
>>=20
>> Userspace implementations could potentially remap EIO errors to a
>> success to work around this. This will likely work in 99.99% of =
cases,
>> but there is no guarantee that a TCGETS ioctl on a non-TTY fd will =
not
>> also return EIO, making the isatty() call return a false positive!
>>=20
>> This commit enables a specific non-driver, non-ldisc, ioctl to =
continue
>> working after the TTY is hung. The TIOCGWINSZ ioctl was chosen since =
it
>> is readonly, and only access tty_struct.winsize (and its mutex), and =
is
>> already used for the isatty() implementation in musl. The glibc
>> implementation will need to be updated to use the TIOCGWINSZ ioctl,
>> either as a direct replacement, or more conservatively, as a fallback
>> test when the TCGETS ioctl fails with EIO.
>=20
> This is a fun "hack", yes, but now you are encoding an odd "side =
affect"
> into the system that everyone is going to rely on, well, eventually =
rely
> on.  What code needs to be changed in userspace to determine this?

The patch can definitely be considered a hack, but viewed with another
lens: a bugfix.

There is no specific reason that the call should return an EIO on hung
terminals, so making it always return the current value could be
considered more correct. POSIX tcgetwinsize(), which this ioctl maps
to, does not consider hung terminals, and expects it to return suitable
values whenever possible.

Userspace implementations will have to reconsider their handling of an
EIO error, as the isatty() call could still return an EIO if calling
into a non-TTY device. Unconditionally mapping it to a success, like
isatty_safe() in systemd, would be an error. Supporting both versions
would require a runtime check to determine which variant is used, where
the legacy version would accept the risk of a "wrong" EIO, while the
new version would treat it as a proper error.

> Why not just have a new ioctl that tells you if the tty really is hung
> or not?  Why does isatty() need to know this, does POSIX require it?
> And if it does, what does it say the ioctl command should be?

isatty() should not need to know if the TTY is hung, and besides cannot
safely call any ioctl to check this before it knows that it is indeed a
TTY. POSIX does not seem to include the concept of hung terminals.

A case could be made for introducing a new ioctl though, but it would
need a more generic approach, like the BSD FIODTYPE ioctl that exposes
a d_type property on chardev & block driver interfaces. If implemented
before calling into the VFS layer, it could make the isatty() call 100%
safe (on kernels that support the ioctl). Additionally, this would mean
that it can never return EIO, which makes userspace adaptions simpler,
since it can know that any returned EIO means that it is running on an
unpatched/legacy kernel and/or libc.

/Gil

Link: https://pubs.opengroup.org/onlinepubs/9799919799/
Link: =
https://github.com/systemd/systemd/blob/83c0b95f63417a36e67305fe9ad16a89ed=
53ef52/src/basic/terminal-util.c#L63-L79

