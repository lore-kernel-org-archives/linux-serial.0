Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6E384243
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332281; cv=pass; b=TpllLmjKGYyI0YvtLT0wx9n2ZbKfjYFuExkDS5kAWWYJVHd/FKCosEmLm3rjgfRw5SY7Z4eqeim4dxt9zwIl2CXX0lq8r+47qlp7iKojUHE8dgRZDvYKkN6q5fGNbyS7e1ibwDFypjwwOt/inKPh9buzqKc0y2w06ALy+IqrSLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332281; c=relaxed/simple;
	bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxq6BUb/jXNvAbCV4xGivLdMfhtjVO8oOSDHJUOrA4Uppm1BgdVnTZWZMGwx1wUiBzU0k3i5a/5H9sYGMsBqTywJqLRsFYKyCsyUZTetSkD3ABBouDAmz5Hso5L1LFzi90UE3VIcLrdrzZp34kc3UqI/hvCHrO3R9hEKYd+HklM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Wjlrtn; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Wjlrtn"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651cfaa21e6so381584d50.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 02:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776332279; cv=none;
        d=google.com; s=arc-20240605;
        b=aI/P0N7Hn8npUaW9r1xccqxv0rQIHFM+DpQ3cYR3LARIF+WxWp9zCouW7LWpc6BK64
         Njt+ZyxT623ESFJrLXbQ3+jka5tkjBY432UyV05fLCqq3Rjx3PZk9GlEaWoqoREm343W
         +JOMpv3oygPkrAvTH9LENmpJC+prrnY4gcBz5sIwCmkggw0XEr/wu4Wp07vbjI98a9TM
         vt9fk9tCbqvv2q+GxDLN1CQVSrpsY1Pn/0QR6aISA6kSRFdRahIKQwzD9f85FaIpLxQF
         XSD5XO/bnr4GkzuqRlUO0xxTaH3AGCc650sp43gDm345L1MelHMc/xoZeeWgw7m70xVI
         8UeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
        fh=2+p+eI6P68JF5RIcgrOniCRRVv4R/Q61rYODH25idmA=;
        b=M5eidkJCkTxrAMpu8/AkXkaNk4NWqERHHGKGLMLhP/P+tG2/ev4oZxY/ZYAMiuA2q5
         ZcV7JTHKVSTxt9H+09gMFxzxi6CTLi0UICJ6L8yfi3aJHYbZla6bXO3Eb6FwVFs309yj
         K2uwWiI4/fZLQHcT+ohUWIa4ukkZ1CLD9NrJ7AQkcbwRVOkriAEVWwxe3z8yjqZvb9i9
         S6u3n88ej+AoNcII/Ac0y0zKO7ar5PoCudC5vwfLyFEPVmMqMXHEmlshprg3PcdWVNDm
         6oNapF/GvhLB3p7daEHv+qdxNTRrbuG+NE6+vjp0HfctnDVH+vjsDm/C9UjyczZmiqg3
         GQlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776332279; x=1776937079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
        b=K4WjlrtnGT+kHmk3EFGbJVMDeE3Injo2mXfwN3TQwGWJzPYUpQkh8VmFo6ANxaiUXh
         IXZIVMXWgZgIe3h2AwsL6JbA+uSU6Dk5qn6OTwMg0hbmk8G9A+Ys7JcKJVPtO/Y/7Yoa
         /gfVB1pbM5it3DnwAjrPfQkixqOd0jMAsPpMjQ1ZswOpm65isWyH+pYwCS5DFnZG2Sop
         jYS+WsT2y/ZT27VTp+iWcW00ac67rnTOf+inUDDmjr8gTVG+6XCyND2pCjKTHLuGZH6j
         /eoSGnTju7ynCKsvtzfAmfX7yLmSnTSNsP0XnKjcwo1jR2zzkoQK0ECgUXlTZO8gBovg
         s76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776332279; x=1776937079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
        b=kmYwxeAIa3UWS6DDj9dDQ4DM89dbjPeBml+rpQHOeOsffbZr3KoD69tQ4AlKTmoAgk
         i34HP+/a7CgR7m0cE/lPKQIVTzh2mvjnv2bgXld0AT2LGZjj7S79UBo7qwEKDoh/2dof
         1oam/hyOx3wYjTM9MlojfMQzFQPuuwDXaNhkw1ie84Qn/tK+WYWVo2X7woiEmPoSDFgX
         mmmfqGiIFJHCW6sLxCUGq9BSVOLNBDr214vu9v8/G4liTNKYfugmebBUA/gy92TMsggq
         ILyzFYmBqvuZHvrLp5GxF/4k4k350g7+iuGSDvzSkfgNWqvkl6E8EgmTklLUUDWOrpHJ
         i0yw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ug242EPKbSHGZLVnlVmZc4nzhPTEcmw5OwJ9U5KB/SrquP/lpqjtCszCcdp5+q7jj/NseasywGW8AxxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZL4tv2Z+P4I/suOnBrMvTrixKbWavvpksmPpOFYZCtEC4aiWQ
	vYgGiExkourKINQFbdhcn9gEKKU8G3Yg694y1AOqu0yanYXquwXGsDGYxpKGQL9LiEpZHISBzHZ
	PwBRCqrwNs4Vx5E9nNRCQZ4I1uVYE3r4=
X-Gm-Gg: AeBDieuAolCOWE1HTXzoH/yPYqvBUfUcMzAUg/Dk2iAJ1Uy3QHK3brQIaUm+Nx9DNm+
	ebdRFYDYBPxwIPGJmQ/YMEh97OCOeho+V96iMvmVp7lk0YWlY2fAPkbRRj3ITtDU3Pl1xgkRhzx
	Gmy6wiXexc7l4jJGayJYJf9gNmT14AsslX7qaJhUF0gHDbQZaMJCc8z8Q4k/TFtoa+VD065vih2
	QGRl60RDvPRj4h3JWzlskNJ4DuZlAv2aKasn6+ZfzmqUCixqkZU4q2FYWiJvwBHM76BFd3GUhZ5
	LjvgbHDJKzCinQDxldbAJvYpflILzuQ=
X-Received: by 2002:a05:690e:1188:b0:651:b61a:4b5f with SMTP id
 956f58d0204a3-652f625fbfamr2412360d50.17.1776332279554; Thu, 16 Apr 2026
 02:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183436.3763871-1-lgs201920130244@gmail.com> <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
In-Reply-To: <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 17:37:45 +0800
X-Gm-Features: AQROBzA4RGhu8VBKDmPs79TXu417TZV9byeGIgxEv-ztLHgyODn2qEOjxkJSt_U
Message-ID: <CANUHTR9toK-PS8qrTd-=ATpSi8xbnXmF87sfRaMDp_jG_eiVMg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

Thanks for the review.

On Thu, 16 Apr 2026 at 14:14, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
>
> What reference exactly?
I was referring to the device reference initialized by
device_initialize() inside
platform_device_register(). My reasoning was that when
platform_device_add() fails, platform_device_register() returns the
error directly and does not drop that reference on the failure path.

>
> How did you verify you did the right change?

After my tool reported this case, I manually audited the relevant
source code and
checked the related core API definitions. However, I did miss the
special handling needed for a static device in this case.

> In particular, what does put_device() do on a static device, even
> initialized, ie. with no device::release? Try it...

Sorry, I should have considered and verified that
more carefully before sending the patch.

Thanks,
Guangshuo
