Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373D1CA8B
	for <linux-serial@vger.kernel.org>; Wed,  3 Jan 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TLG34ZUR"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556cd81163fso1036071a12.1
        for <linux-serial@vger.kernel.org>; Wed, 03 Jan 2024 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704309316; x=1704914116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VqpWt6ocefEfDXK+KnHNKXoEM0IL+DB/QDp9HBirG1E=;
        b=TLG34ZUR43Zp8VgaC7Wq+g5+jPAFGjJK0YLdKWHzonNeK5953mQKAqs3zzd/QsWcY0
         o65coPCiMQko2q3DT6t9gp5eYutuxCvMuNOpIYb1wzhv55As3pzUJXxN72jGHG+XxDTB
         r7vveancDPtf0b+ceWCgAdfc7qVa9NUnSd/UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704309316; x=1704914116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqpWt6ocefEfDXK+KnHNKXoEM0IL+DB/QDp9HBirG1E=;
        b=vMcfmGgkXNH9heJ7FpNMYHyUBRZh0cyyH+22wVUyx0dAgrOxXacRfQTCf8nxtXGolm
         8UFlugZKHGoQauxMuwOGUz1ByZbqx9HKACmQZrk38D7zev3hT3meTJaWzBGVtnby1I7g
         DqYtzPK53PNA7JZQi5oYnXzY7yIsmpWAzyALhF61eSLhmyWK6m81NbaTpMuL/dJPyIxW
         tELOYmv1+IL+II30DXUa3nwKI2OyOV92m6o35IiNPkVTIkBDDFIWUaDTpEY+EeqpEw1h
         5qjhZkxEa6PyId59pGCOw3c/IeXvangs4YkXoPInQLHZoQHxwces8aD0NAv/2Gu2zgom
         Hznw==
X-Gm-Message-State: AOJu0YypN0vFDxKnSSkpjubJe8L/Y8jvrODSHE7UiSsTdEFQCzIf9fQ1
	xvR9qrk7qm3dU+jtgrOq13iuRWeHl54TNyfOc75NWiUfBlFqu1mv
X-Google-Smtp-Source: AGHT+IF22liLqBr5Q2olgYVpXzIVI0sBryTb2anon5Woa75giKFiw0ARL6FCInzUXKlZ+Dso83I6JQ==
X-Received: by 2002:a50:8747:0:b0:556:38f6:484d with SMTP id 7-20020a508747000000b0055638f6484dmr2071695edv.112.1704309316799;
        Wed, 03 Jan 2024 11:15:16 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ek20-20020a056402371400b00555f49e7080sm6367421edb.56.2024.01.03.11.15.15
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:15:15 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55559e26ccfso6881133a12.3
        for <linux-serial@vger.kernel.org>; Wed, 03 Jan 2024 11:15:15 -0800 (PST)
X-Received: by 2002:a17:906:ef0c:b0:a27:6fbc:ce3 with SMTP id
 f12-20020a170906ef0c00b00a276fbc0ce3mr3854440ejs.42.1704309315585; Wed, 03
 Jan 2024 11:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org>
In-Reply-To: <6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:14:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
Message-ID: <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] tty: splice_read: disable
To: Jiri Slaby <jirislaby@kernel.org>, Oliver Giles <ohw.giles@gmail.com>
Cc: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 03:36, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> What are those "things" doing that "splice to tty", I don't recall and
> the commit message above ^^^ does not spell that out. Linus?

It's some annoying SSL VPN thing that splices to pppd:

   https://lore.kernel.org/all/C8KER7U60WXE.25UFD8RE6QZQK@oguc/

and I'd be happy to try to limit splice to tty's to maybe just the one
case that pppd uses.

So I don't think we should remove splice_write for tty's entirely, but
maybe we can limit it to only the case that the VPN thing used.

I never saw the original issue personally, and I think only Oliver
reported it, so cc'ing Oliver.

Maybe that VPN thing already has the pty in non-blocking mode, for
example, and we could make the tty splicing fail for any blocking op?

                Linus
