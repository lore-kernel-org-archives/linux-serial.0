Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D733F9
	for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759121677; cv=none; b=sGccRQ+mPTQTBjk3VdWyPPMdb3BJ9L+DKC4bWaCKG8QbBj3bqGnNVB2juzprZvtGTAwWN2wvY/nS9GlMT8IqBZnV5vXB6wI4gZ5qEkaMUTtTJ0XIvGepm5MoybElsDMXJVlguKoWKchS6J0SobtzjsPVuf/oN96bOOSIrp3Z5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759121677; c=relaxed/simple;
	bh=xSspKJ54Bxlkmwcu2AMNYc4Jg+Rq35XtdgNjnFRQ6AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsPyd/UbWj0XRMcQzSLteKpmQpMMce6XkoQKYOL8b+CfwPZQRgkS+jc+ewfyeSHg+bN9dB3MKxUjXicQjZi/EgaanYgdGDwYJ7Djdn7A1ooTEXbE34P6qJx/EWrajCo1qmH0UZUG9IiSyocU/+M3IbeS/NCxNDiRnGwl03xUJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKKZ9zOp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKKZ9zOp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782e93932ffso948710b3a.3
        for <linux-serial@vger.kernel.org>; Sun, 28 Sep 2025 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759121675; x=1759726475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiGEc+bWHibq3FL8i9zZEO5Fku5US3xDhKukJhzni5k=;
        b=CKKZ9zOpfbtbyX542FTzltHwKsaKvVA0AN37NMIAhA6pyefMWyjwBqnvvhU9wwdGOj
         3UlgKoCxS89UNuas6dhdzkFnBEk6NrqIRMwMW4r9n655eHigJynTZFntSK/Wnye8wCsZ
         5Vh7jpPf9VlWRUZv8h9QA3WBY9RBE1s85MYXcenavtMVVIffZC9KbFnumVob2xztSNTC
         baqqLhMpoIUav/ax5h08o+gQtdendnNl742V19lc980b+YtLnmmbfhA59jasl7x8OeXL
         bWy89GLT5GTXQJynFiymlLuQ5zWgUxVDegtc6LPKco3M3W84QVMC1wSSdh2Fskb4xvNJ
         isUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759121675; x=1759726475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiGEc+bWHibq3FL8i9zZEO5Fku5US3xDhKukJhzni5k=;
        b=o23LvugM15nl5TdNF/hzglqy20tkma6l0CrhtDlEcguESfd7PVHx98CRj2yOdkzlno
         w7u+NYxc3xH2QlucfdCGlv3Fs7lItNB3VedbSEai8nauzxi7C5dFnZtMbKoy0rt0pAT0
         TjEP9EXpL9uA9T3+tFfVBhk1b2Yns/wVveMbR2qgjCrhV9+e42Fr8UlF6CUCgyEKQf1B
         /+T1UI/2VxGO7BCVxPHpoH4gpLiJ79vVnMmPiIKgoZnzaLh7tWThNw/r3AkGevHb1e/g
         Aw7YI9IIEoA45+Ay4tSeO70EG0SgXrNd4oXbMrSc9mxiRW2BEixKbwZiCbYfvOELqghS
         tmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaOs+grVHi5I5s8uEXqkqyNto5Da6cjfQGKVzfPwHSjq4iUTGVZCsb6TMEytlPhZed3PBvoQOmSUSIm9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YRruSqY8bTtgxXdWAug9PYbSziczVbOoSYah6Rhkkd48N3Fm
	aPmn68cz0qCH0I80UJNhXDc8HOdD6sbJ7znUbCDibIbApc/vG7git5ed
X-Gm-Gg: ASbGncubi0NMi2YVrun7mzHWpqqC9z97/DHkpGdtJJLIeo6r7wBmFGiUMf9ajL146Av
	SAVb9xzlfKMgM2YeFsbg9vMzwSqLZsFWFbMXlVSowTK7tVRLKmYTaRlS8jYqGWbuMfhMsQRQ834
	OcFKzMXW0kpWkRsnJcrACLWRYxH2VPzTuwq1aNd53CgpU7U9IcZjE3dqZjH99Vgg96uCAm4/zJL
	F01/KrSFSp1+qB5nhlfdQ+JZ7NA9furpEF0EtUHrgn67X1XXpUvioY9VDLt9bJOIgXxYYmvfhoV
	q1RvN+BylzNd1HtRC5YGCgmmiT/XLp2aUvZ9vhaPypkMxkn+AH4QUC+g0hIBQvULEXXWq0kuJMu
	48gVcelGW8Uu0PEbNHOlAZxnIp0peOwGJA9+rSVMs0hRquaoefzi19Wv9G0l4YYJhM7GUc9I+50
	MHza+X3Qu4
X-Google-Smtp-Source: AGHT+IHlnIMKveRuj+7NJDShOnf/WRzuKghr7uizOQzNqC04F7WkjGrUa4ubUJ/Uj9RfnZMzr1+iOg==
X-Received: by 2002:a05:6a20:244f:b0:2df:b68d:f73 with SMTP id adf61e73a8af0-2e7cdd9aba1mr20672654637.34.1759121674981;
        Sun, 28 Sep 2025 21:54:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:78a6:bdf8:e03d:d9ea])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c5574e99sm10062601a12.35.2025.09.28.21.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 21:54:34 -0700 (PDT)
Date: Sun, 28 Sep 2025 21:54:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: pengyu <pengyu@kylinos.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, legion@kernel.org, 
	mingo@kernel.org, myrrhperiwinkle@qtmlabs.xyz, tglx@linutronix.de, 
	changlianzhi@uniontech.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty/vt: Fix possible deadlock in input_inject_event
Message-ID: <dltckle3ksus7qojkpiirvush5khk52o36yhqnlfpiymrjjwzt@ev46jjxjhi3p>
References: <20250928130819.383808-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928130819.383808-1-pengyu@kylinos.cn>

Hi,

On Sun, Sep 28, 2025 at 09:08:19PM +0800, pengyu wrote:
> syzkaller testing revealed a potential deadlock involving keyboard 
> handling:
> 
> CPU0                       CPU1                      CPU2
> ----                       ----                      ----
> read_lock(tasklist_lock);  evdev_write
>                           input_inject_event     write_lock(tasklist_lock);
>                          lock(&dev->event_lock);
>                         read_lock(tasklist_lock);
> <Interrupt>
> kbd_bh() / kd_sound_helper()
> input_inject_event
> lock(&dev->event_lock); // Deadlock risk
> 
> The deadlock occurs because:
> 1. Both kbd_bh and kd_sound_helper run in interrupt context
> 2. tasklist_lock is interrupt-unsafe
> 3. When evdev_write holds both dev->event_lock and tasklist_lock,
>    interrupt context attempts to acquire dev->event_lock create deadlock 
>    risks
> 
> Convert both kbd_bh and kd_sound_helper to use workqueues. This moves
> input_inject_event execution to process context, where it's safe to 
> acquire locks that may be held by code using interrupt-unsafe locks.

So if we ignore the input code and instead look at the send_sigio()
(which input core ends up calling) and do_wait() we see that
send_sigio() disables interrupts and takes the owner's spinlock
before taking the tasklist_lock, while do_wait() takes the tasklist_lock
first, without disabling interrupts. This is root of the issue as far as
I can tell and no amount of changes to the keyboard handler (which is
just happens to be in the middle) will not solve for all potential cases
and code paths. 

I believe either do_exit() or send_sigio() have to be changed to fix
this properly. 

Thanks.

-- 
Dmitry
