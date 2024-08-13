Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFB170A18
	for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569576; cv=none; b=Yx+TmMCArWkYIlfW4KDw7mLe6oJmuWhtEgMdOVL2B1is+sjBxOL9wPGaE4mqF81hnKmy0Aa1AsjqOuFc9EmapmfdrZ4FetuRtt3q/KaGJJhVgmOYsOOk7XoIRyIORMlyFL1WWQZQit+mc24lyfM9T/QNtO6JJa8Uv8RSMdjyB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569576; c=relaxed/simple;
	bh=n4rocdguL189a2v3Hbhy1fUvU6fFb5q9/yRkVisfAaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBDDmG8SbMzzpcT4YQVwDz02BsY8Kcg+j1CckKCjNOh4gd5NlRi9UzlcHT8D+6sDA4uNea6Rxed6gZjpx4+f3/WkbRB8WhPKUgNR/KmyBrGVV6mVRRyjNzMQ3NfM9DKv+peTzkbYeKhoPqtlcuSVUE6g7GBaN6uSrINweO/fays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44ff398cefcso31162911cf.0
        for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 10:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569573; x=1724174373;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBaWjjWjdeVzK81sWSRkkcHN1IJSclwqcGK+OXaY0Aw=;
        b=IbKNsaCh7z+o4xwzXYECe18GcSKvp5lyLVpFrmAg7uiMHNyHJO3EIiPDKfy/ELI3WG
         bNmX5W54WFSkeeXvvAOioVCvb2BZ8AQx86PF2p5QQZfFKO1mFk9SZeMHGzXGYeqMdy5P
         ErmwMSdUAsqkJNx/YWgxxNSJF5o4C+pKoXD0ryDbIsc2dqlyiGnbUsprVAZmjzrqXu+h
         j1fPMrV4En743tQU+3t1Ek3+QdALk7adueO0rLO1wVO57gLA3v+IPiYRKYzHL3xnT9WB
         2hP07wJ98AfJLwJeA8xqZyyiBnZ2K2A/e9ah6UXUBIGVNTRcKldio48RTy1diqFOFje1
         sERA==
X-Forwarded-Encrypted: i=1; AJvYcCVag+H7DxszNpokI9EVMoVFYpzHqr78FvJjGHfL3i2dtu7r9CphlrZ8u0KiVek0YjAQICGuRlReUFSCiLuSoi+5ncIvCM/Tlah/wOy0
X-Gm-Message-State: AOJu0Yz16/5XM0o1lKecMvrQdd4R/P06d2gcASWxHXt+ez+WfTDRp61+
	1UY8QMhPkTpfQBBPoQvgMTJXNuS6VIwOhykfoVUOPngBMj56wRxhcpnuWjLSxO5qJi+UvHtafhM
	S
X-Google-Smtp-Source: AGHT+IFeVnwr8Fk3SCQadoxcA7vLWin+EAJ76RKQlKIUmRcIsCGVP2kJznlT5beVR7VfWzWiH7unLw==
X-Received: by 2002:a17:902:e742:b0:1fd:7b2c:9879 with SMTP id d9443c01a7336-201d6486dafmr2792775ad.51.1723569545086;
        Tue, 13 Aug 2024 10:19:05 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14ac10sm16103935ad.102.2024.08.13.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:19:02 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, jirislaby@kernel.org,
 tony@atomide.com, linux-serial@vger.kernel.org,
 gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <2024081318-litigator-slinky-8f0b@gregkh>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hzfplplfs.fsf@baylibre.com> <2024081318-litigator-slinky-8f0b@gregkh>
Date: Tue, 13 Aug 2024 10:18:57 -0700
Message-ID: <7ha5hgpchq.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg KH <gregkh@linuxfoundation.org> writes:

> On Fri, Aug 09, 2024 at 12:04:23PM -0700, Kevin Hilman wrote:
>> Thomas Richard <thomas.richard@bootlin.com> writes:
>> 
>> > If the console suspend is disabled, the genpd of the console shall not
>> > be powered-off during suspend.
>> > Set the flag GENPD_FLAG_ALWAYS_ON to the corresponding genpd during
>> > suspend, and restore the original value during the resume.
>> >
>> > Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> 
>> Hmm, this patch got merged upstream (commit 68e6939ea9ec) even after
>> disagreements about the approach.
>> 
>> Even worse, it actually causes a crash during suspend on platforms that
>> don't use PM domains (like AM335x Beaglebone Black.)
>> 
>> Details on why this crashes below.
>> 
>> Thomas, could you please submit a revert for this (with a Fixes: tag)
>> and then follow up with the approach as discussed later in this thread?
>
> Did this revert happen yet?

No.

Could you revert it since it's caused regressions?  I will follow up
with Thomas on the right fix for the original issue (as discussed later
in this thread.)

Thanks,

Kevin
