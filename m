Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022493A9871;
	Mon, 31 Aug 2026 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196909; cv=none; b=G3jbgFruCivsY85Y2COHr/Ep82YUJiIagaawOppfAtQcevqKzeSKrqShpCYl+D6OKFSA6nRJz4HeCgZdHtQhcO6uS0FmPXaWa1DO81h4XVD5wmvzHGra5VLhg1PBZ6/AUMN9nC/0hzYpgdC3NDMI4pRdrJ/LiemAn7m/Dg8eRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196909; c=relaxed/simple;
	bh=1ZjERwx4T3dlN3pF4wyvgM4UGWyrKiyCq6dNS/xCsN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA+0mMh6QZuPwSRzWiY4LcdG92FKuDcjwHLvYG1l1kuPbGTOxKD3+64Yrm/6cdoHWWW4AMepbPxRTvMXJBHoqydnwBvSuvjS8aMJRxhY0lyaf/88tdp9+1+Myf18ef2fNZ5Pws+sd++8uv6+TiNxvYcN2BiBebQumKdM652FwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KqQEJCf2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KqQEJCf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788196892; x=1788801692; i=deller@gmx.de;
	bh=kPZTsyoSmtIH7Bh6d02s7nJ2LKgDbP77DS7VYIUAFNg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KqQEJCf2t6JQEsIK+OqpNlMdPvF99TvtprMZcvSQ8cPkwQd415CMq6SwzTEe/3uT
	 HUW/2mRlJh83wiwdDLquFuzLFF7r3rR/Apkl7/HapITH7zcjzWY9dN+TRHlBThhZn
	 APB7b2O8BLX++lEdf910Cu+81W5wE5vtZ+pE+9cKmvufp1G141GN6qgqKMqh0FHTW
	 OvYRt/lNUR5uuY6bZhAddIphG6D26eZyKxEpc9ixtotgWZM8q0QDXjKitXWdLRt1+
	 s2tyiHLRlDKJocbWU6IlCz6s7YmH76Asx1ssiUsPY5r81t352258mjkazNNnR+Rcb
	 3haWZ/Kd6kwJL9ZryA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKyI-1xTiPD3VSy-00Vzom; Mon, 31
 Aug 2026 19:21:32 +0200
Message-ID: <ae1ae01a-677e-4c51-bf9a-ebe7b2e91e4f@gmx.de>
Date: Mon, 31 Aug 2026 19:21:30 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vt: Enlarge the framebuffer glyph size from 16 to 32 bits
To: Alan Mackenzie <acm@muc.de>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <145be2e3-a8c0-4f4f-a701-af2696cec461@suse.de>
 <apGc4y8ApYWh4Yr4@MAC.fritz.box> <2026082938-spray-shimmer-9389@gregkh>
 <apLvO-8YJmQG7T0Z@MAC.fritz.box>
 <7c199c7f-d89b-48ca-a777-85585d2eb624@suse.de>
 <apWTg6mNZrdBm2-D@MAC.fritz.box>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <apWTg6mNZrdBm2-D@MAC.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MCDte+8136bcbBp5B9LwPvLuGJftDptkVyGyOfL4WgqJf2fza7+
 pSbjUXDKGDoN96QndG/fLTN/JoHgiDiOkDl5Vf3ahhZSi8jBz9PfmW0UYvmIYgrg3eRl/RZ
 9hiAjY1k17cSRg7eNOPy5cneMsFNPt6ZaZpM5VI98DFd8yqGkoQimiUKG2jopb4g5AFtU3z
 PKJojAzfU1HdZsWvYtwhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XMfjuN92Y/Q=;B7JNJlqrp7OwOkOhi9MCEL6+t3E
 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

On 8/31/26 16:45, Alan Mackenzie wrote:
> On Mon, Aug 31, 2026 at 08:20:10 +0200, Thomas Zimmermann wrote:
>> Am 29.08.26 um 16:39 schrieb Alan Mackenzie:
>>>> This has nothing to do with KDE or Gnome, if you have issues with tho=
se
>>>> projects, please take it up with them and contribute to them to resol=
ve
>>>> those issues.  I know they can always use the help.
>=20
>>> My point is that the kernel's console is rock solid and dependable.
>=20
>> That is a bold statement.
>=20
> I've been using the console for around 28 years, now.  I don't recall it
> crashing at all.  My current font and keyboard files are in exactly the
> same form as they were 28 years ago.  These formats are stable and
> dependable.
>=20
>> I've spend the last years working on related code (fbcon) and it
>> mostly feels dated and unmaintained. Our prime implementation (again
>> fbcon) has been de-facto unmaintained for years.  We recently had
>> contributors who are pushing the ioctls semantics and found bugs in
>> fbcon for a number of corner cases.
>=20
> Something like:
>=20
> commit ef7656e85f1a4400999625cd398b655517368e7e
> Author: Zizhi Wo <wozizhi@huawei.com>
> Date:   Wed Jul 29 10:12:04 2026 +0800
>=20
>      fbdev: Fix out-of-bounds access when rotating console after font re=
size
>=20
>>> Things like kmscon are subject to the vagaries of fashion.
>=20
>>>>> As is clear, I think the console's limitations should be eliminated.
>=20
>>>> And the rest of us feel the kernel console's code should be eliminate=
d
>>>> entirely, when ever possible :)
>=20
>>> The rest of you don't appear to be console users.  It's easy to advoca=
te
>>> for removal when you don't use it yourself.
>=20
>> FTR I'm not at all interested in eliminating the kernel's console.
>=20
> Other people, in particular Greg KH, have said this is the current aim.
> I'm worried for myself.  It is far from clear that there is a suitable
> replacement for the kernel's console, and its elimination could easily
> happen without that replacement.  I suppose I could always (laboriously)
> maintain the console for myself personally.  Or there's always the BSDs.
> I just don't know what I'd do.

Alan, I really appreciate your efforts to enhance the kernel console code!
And I'm not interested to eliminate the kernel console either.

>> But there are must-have features and nice-to-have features. IMHO for
>> the kernel console i18n really belongs in the later category.
>=20
> It's 2026, four decades after VGA was the latest thing, and Unicode
> support is merely a nice-to-have?
No. IMHO Unicode support would be great.

Thanks!
Helge
