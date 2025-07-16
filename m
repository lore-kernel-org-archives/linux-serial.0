Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CA2727E5;
	Wed, 16 Jul 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678382; cv=none; b=o2KaxPEaxleeRfnkZ6H8ZUAVbcAgqGBAJQQBML0roDYS2EqlHuoXDcPL45v7Gq55RW0OEgVAgVigbFEN4ZIR7a0rAB0zFt+yhe90nBWU9NwGBN99Mf1YjiU8XpmXB6pCRI1LR2KKysdkv0t7ovdhOwyXm2yhTpUZ9PmY11P8GmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678382; c=relaxed/simple;
	bh=Kx6KvPlh1ofSdmFCjKixoOudnflMFht2fe6t0IectFU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iF2ZixsSLcBbTOERYkCErFhZeU0T4afwzFTyD1yKLicFcp9nEDz8NZhUA6rfaJV2WAcqixh4uIt5MfhRwr4PNbyfMFSYIWzlkCtCY9S2R9gHKJdRtvUpJHB6FN0xEBAEuGlavnEk1pAqf7buWMpsdbB4zzy4Hmigj0WnUkwSWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mxAk9pFd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mxAk9pFd"
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56GF6DEX1555693
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 16 Jul 2025 08:06:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56GF6DEX1555693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752678374;
	bh=Zn6hFpgIn1dP/feaC10D15o+3qV/K6KyEB/+fOIAQ+w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mxAk9pFdBMT1RdVKgKdMbK2PJnJ2tsIfengVTi8GPItYSrojC02I9vaPV/ccSH4yD
	 tnP91FzZieWZK9FHLiQqUaMAbsC7ZIq8DCf2R9AakNCk8hcznWHL/VxAKIKo+b1rQS
	 iaFy+9JWPIQy8LZlDnlIf/HkXp+P7cdIUvJktrAH1Dw5ntzYbZbObHSRY1ewTmoCXu
	 j2I5m/CrKt5LFCANYEHlRIpRIY38WjLOJBe+BVnuaDDsLyJl9lQemGPcYhFxckouB3
	 odOd2GyAOJBRF0cYIkq6u8SNXYk+pVO6FRTi5kaHp/YATgqvzm2ZHA8JMapzfVJh3h
	 qE1DKk7qhmZVw==
Date: Wed, 16 Jul 2025 08:06:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Oliver Neukum <oneukum@suse.com>
CC: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: USB cdc-acm driver: break and command
User-Agent: K-9 Mail for Android
In-Reply-To: <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com> <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
Message-ID: <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 16, 2025 1:29:27 AM PDT, Oliver Neukum <oneukum@suse=2Ecom> wrote:
>On 15=2E07=2E25 23:00, H=2E Peter Anvin wrote:
>> Hi,
>>=20
>> I noticed looking at the CDC-ACM driver that it uses the assert/local d=
elay/deassert method of sending BREAK=2E=C2=A0 Given that the CDC model has=
 a delay specifier in the command packet, is there any reason not to set TT=
Y_DRIVER_HARDWARE_BREAK and sending only one packet?
>
>1=2E The existing code is tested and usually works=2E
>2=2E The locking goes away=2E I have no idea what happens if you are
>sending a second break while a break is still going on=2E
>
>> I'm also wondering if it would make sense to support the SEND_ENCAPSULA=
TED_COMMAND and GET_ENCAPSULATED_RESPONSE commands, presumably via an ioctl=
()=2E=C2=A0 I'm not 100% sure because I'm not sure there aren't potential s=
ecurity issues=2E
>
>Well, one of the purposes of the CDC-ACM driver is to hide that
>you are talking to a USB device=2E
>In theory we could do that=2E I don't quite see the value=2E
>Sending arbitrary data from user space to a control endpoint
>does not make me happy=2E
>
>	HTH
>		Oliver
>=20
However, the flipside is that ACM devices are very often used because it i=
s one of the few ways you can avoid requiring device drivers on Windows=2E

This is why some devices do absolutely insane crap like Arduino which trig=
ger a board reset if you set the speed to 1200 baud=2E

SEND_ENCAPSULATED_COMMAND at least takes a command string =E2=80=93 it was=
 intended, I believe, to be able to send AT commands to a modem while onlin=
e without using the +++ escape code and all the potential race conditions (=
and security issues, since it is trivial for a user to generate) associated=
 with that=2E

I am not suggesting that we ought to allow sending *arbitrary USB commands=
*; if that is what's needed then use the USB device interface, which of cou=
rse has its own permission flags=2E The main problem with that is exactly t=
hat it is all-or-nothing (it is also a bit of a pain to find the underlying=
 USB device corresponding to an ACM or USB tty, but that's another matter e=
ntirely; it is at least doable=2E)

As far as BREAK is concerned, there is also the option of locking out a se=
cond BREAK for the delay time; however, this probably should belong in the =
tty core=2E  What do other drivers supporting TTY_DRIVER_HARDWARE_BREAK do?
