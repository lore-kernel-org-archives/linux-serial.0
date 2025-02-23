Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ECA2111;
	Sun, 23 Feb 2025 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740286613; cv=none; b=mAevNnKnX8bjJcgCfboSRup5IG8xqqqPBCbF13SqLwKrjfZMEcauFMd+XB3QgntvGymYt9FDBMUQKmuMXafaP085G5G+K1mPlVpaA3XwYaAInWURCroK80BPaL9tSoUOg4aBfBF4ID2C08t+iRP0683pP8bqPAcdqtSknHQlv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740286613; c=relaxed/simple;
	bh=qOtmpq6Kn/bx68wjyPlHMVkHYUO4AaaQVZr5vaOzrJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBZZkQutFcrgyjEzwvKXs9q1Wc8oMC2PTnmkVVVuo0ajxulZRhCo40rV3FvDVDQIKTWgqzWJ2YPPaZlg4N1vzVeU8hCq5rY3aG+JP/erMZ9ZBOeV6tnGzvLB2VRdu7lBdjfjOjds2GLLwYy6GkNrKXBqULMNODYoce3Ld/c9m8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdeojEYG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdeojEYG"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c08f9d0ef3so215371985a.2;
        Sat, 22 Feb 2025 20:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740286611; x=1740891411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DVe9AIae0UBiMWAPJhlgjyvPeRD+ylP6Mta15Skotg=;
        b=VdeojEYGv/CFcZ6pfOjbcTm1xSfTbqdjK4ANLjMwtd3zaHPTlkVoFJZHHWb/bHT+/S
         8Pd4nlTvCOoGwaZXmQEH3+BsT2BSpGRtMc0Gr3Zq0eJllqyLNhLRtoRQW6mbD+2vgepG
         ZClEA0HznZftglLGWEqilYvBX3xOzBpj6Ui4ByTStozeS5ujHv+WPNmBNpv1ST9QPTR3
         /+9QfLLf/XiNs3vUvGd14iMjJ37YOcqwhuCJZ1NEv+OysGkL/DDWpXR6CLcWdldrkedB
         6v8NcD4OUqydr1FnnL6Y6vijOA0NhvM+CXcPbxephwuk/Lqp9wMTCQ+iONJ17J2Vksbq
         Vz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740286611; x=1740891411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DVe9AIae0UBiMWAPJhlgjyvPeRD+ylP6Mta15Skotg=;
        b=PhNCw2MZk64Ku2pIyCdFjyFVhtz3ldkD981AKHboM9Bk+6h9Xq4pJ8KOBvSY4HoU5f
         pSqG8GyzcqviTPiUcLq6YrEjK7l/d5iStNJk213WEhQ3sBZrcZPPnevUsjUnZ7yI6Kgn
         gx1twmlzXCCu+RayNBdcR3HmEjNct+KiwIjNlMhXIaosB8b6r3wSTa35WDyDHe0nbh1Y
         RAt/vPVDcM7EGVI2P3Q5Ls8Nf5Pjl0W7pTZiUAwXVmYo7a9ItIK1XjbgMD5FlEZ072da
         24jHYnYKi8L7ebzT9bGAaKAMqFMeHK4t04vs761/rk2/7lihgaUFbmN60f3hcfeYJ4xA
         OzSw==
X-Forwarded-Encrypted: i=1; AJvYcCVS05E1xLkgelltBSb7qXGZ8XgqXSgjXRj/WlNr3V6v+y60buOKhK8R27vtP1uKhZKoql6Rxv1QQjnSb40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3E1ybYBhE9ArpVpZ3PfQbkqYs0+HKeQd91oee6UiThhLXgDFg
	2C47OxIzzm3FkBud7CXWBjSP4A6wPG7DzQmP6/ApQEYfjNrtiP5d
X-Gm-Gg: ASbGncs859HvF6vhXZbP3T8Fh/C+UJ0/DHHDpig3RKfWUsjfAc4DltA1shmE1Al0BeX
	I6JJFnQ2Z+gGr8MyD3Q1xOJP37Hf/7Tp57QidMccDFTFNTVr9rH46JFJtHO4wppNUd//kt6GJ+f
	rnArKxsWtIMfc5SkpGSHBDMYAkiTiDC5Q6cOPHATGZC6t3qN1d3DOj0f7Oy4ZVBKVw8KSWu7+YP
	aZEOO838mx1zeZvUFmtxJC+lbCTOHQRI9HRpRQO3JqyyT0xsba0RWCj7dVAov0bpXQLNbGKm0cO
	6mrTvIVsywkjdECXnZFx33ymLOSzdSkIJE2EYXjybCVpQ4s=
X-Google-Smtp-Source: AGHT+IGbd646ykaMg1S0WZNg+V+zr5Lv3mEvm4mIw5xeadGijDjJjMn247ac93CQKG451CQiCGoO6g==
X-Received: by 2002:ad4:5bae:0:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6e6ae7cae9fmr120114636d6.2.1740286610890;
        Sat, 22 Feb 2025 20:56:50 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:104d:377c:5733:f5b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7791cdsm117409616d6.9.2025.02.22.20.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 20:56:49 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 2/2] tty: Change order of ttynull to be loaded sooner.
Date: Sat, 22 Feb 2025 23:56:47 -0500
Message-ID: <8413152.MhkbZ0Pkbq@nerdopolis2>
In-Reply-To: <2025021957-babble-delivery-3035@gregkh>
References:
 <20250217040748.2017975-1-adamsimonelli@gmail.com>
 <20250217040748.2017975-3-adamsimonelli@gmail.com>
 <2025021957-babble-delivery-3035@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 19, 2025 9:03:08 AM EST Greg Kroah-Hartman wrote:
> On Sun, Feb 16, 2025 at 11:07:48PM -0500, adamsimonelli@gmail.com wrote:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
> > will become the default primary console device, based on the load order.
> 
> You mean "link order" right?
Yeah, I'm sorry, I will change that.
> 
> > Users and distributions that are migrating away from CONFIG_VT will
> > benefit from this as /dev/console would not suddenly become /dev/ttyS0
> > which could otherwise cause some user space behavior changes, namely the
> > TCGETS ioctl failing, which causes libc's isatty() to incorrectly return
> > false when /dev/ttyS0 is disabled, and will prevent a device that is
> > connected to a user's /dev/ttyS0 to suddenly start getting kernel log
> > messages.
> 
> I'm sorry, but I can not parse that very long sentance.  If CONFIG_VT is
> not enabled, this isn't going to change anything with ttynull, it will
> just happen to have this console loaded before all others, right?
> 
> Which implies that this might break existing systems when this loads
> before the expected platform-specific drivers.  Was this tested on those
> systems?
> 
OK, next version of the patch, I think the commit message should be more more
clear I hope.
> > 
> > Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> > ---
> >  drivers/tty/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> > index 07aca5184a55..03bb47e11e1c 100644
> > --- a/drivers/tty/Makefile
> > +++ b/drivers/tty/Makefile
> > @@ -11,6 +11,8 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
> >  obj-$(CONFIG_N_GSM)		+= n_gsm.o
> >  
> >  obj-y				+= vt/
> > +obj-$(CONFIG_NULL_TTY)		+= ttynull.o
> 
> If you are going to rely on link order here, and HAVE to have this above
> all other consoles, please document it as such so that people have a
> hint as to why you are doing this in the file so it dosn't change again.
> 
> thanks,
> 
OK. I will add some comments
> greg k-h
> 




