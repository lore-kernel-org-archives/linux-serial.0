Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B221DA28
	for <linux-serial@vger.kernel.org>; Wed,  3 Jan 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PYexyR7V"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556aa7fe765so1912637a12.2
        for <linux-serial@vger.kernel.org>; Wed, 03 Jan 2024 13:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704319069; x=1704923869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B48exi/vSSjCNhOi4YzTWDyLBVxd7y5kwoUyxHuxs+c=;
        b=PYexyR7Vs88C4ZS1mySK/GGGhratC6m+WmCjSxHuoTCpciRkv8zZrNbLLgOlzQuJ0/
         zDdKKqXMaW+xYvHcX6Rq8vUWY+eBF4hLR81e+ruo3CwmpBo0kkGIwT4fOEAX/h8b8krr
         mKXlhoceK71iHUM0wRdJqe8qzZAOHAlBEvqFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319069; x=1704923869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B48exi/vSSjCNhOi4YzTWDyLBVxd7y5kwoUyxHuxs+c=;
        b=QDwMgA+9oBjuNMhLyD7MIsbSBJArEIfp94joHfR+E9jo1mWEBISd+qyHz6VXkIri2k
         h2aLM/DLmn+iWsz7eINNng936ApE6XzL7AQFlGmrbSABAB6sDFpKdyR9RTdaV3nigPQX
         8q+LjoggUKEKrsFzGK3j+dmGv2xdmvEbl6OAOKvh+m8G7GNo0IH7WDa7euHLt/I7jfjx
         MoqJmP/BMQjcXXzpMQp/76R9oo3H2U4mn1iBYs2npWbn+6AvuayzofUjVFDpExZqol4d
         VqY14y2mnd5jByBl5ErvpqRox3/bZhIHIU0/qfYyR8ljj+ism5jv2mb+KEK11kou6ktG
         Z8Pg==
X-Gm-Message-State: AOJu0YxfZJz5X03wGxWE/Hs55/IIFFvDCjXr5wUw/dIIzm8Gp7OvZYwY
	0AB+kr79kQ9yQ5UloB/LYFkYkbHoAWCwiapN3/+ZeDiD4ppvOENZ
X-Google-Smtp-Source: AGHT+IH1b2uQUrGV1LA78qAj+FMJtHVXAbFFzf9CFu2rw+go0jE1UTjtes+D2ao1OsC+OsLxN3HEsA==
X-Received: by 2002:a17:906:348c:b0:a23:6493:7211 with SMTP id g12-20020a170906348c00b00a2364937211mr8466666ejb.114.1704319068873;
        Wed, 03 Jan 2024 13:57:48 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id ad21-20020a170907259500b00a26af11a335sm7806004ejc.2.2024.01.03.13.57.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 13:57:47 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336f2c88361so6324054f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 03 Jan 2024 13:57:47 -0800 (PST)
X-Received: by 2002:a7b:c405:0:b0:40d:6299:3b6d with SMTP id
 k5-20020a7bc405000000b0040d62993b6dmr5498997wmi.212.1704319067258; Wed, 03
 Jan 2024 13:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org> <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
 <2XFP6S.GINKQ8IKAA1W1@gmail.com>
In-Reply-To: <2XFP6S.GINKQ8IKAA1W1@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 13:57:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGfiJS692Gh1sRkqGpZ87Ra-Rvg46EciSU3fUDD3HDug@mail.gmail.com>
Message-ID: <CAHk-=wjGfiJS692Gh1sRkqGpZ87Ra-Rvg46EciSU3fUDD3HDug@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] tty: splice_read: disable
To: Oliver Giles <ohw.giles@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 13:34, Oliver Giles <ohw.giles@gmail.com> wrote:
>
> I'm happy to report that that particular SSL VPN tool is no longer
> around.

Ahh, well that simplifies things and we can then just remove the tty
splice support again.

Of course, maybe then somebody else will report on some other odd
user, but ... fingers crossed.

                Linus
