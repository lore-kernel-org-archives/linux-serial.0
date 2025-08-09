Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6A21FF2E
	for <linux-serial@vger.kernel.org>; Sat,  9 Aug 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752752; cv=none; b=JRzqYqpTrt3CBmIm1v6vM4wgQh93wL790mKH4s7IDZKlc2hesLkUkgLZBqr+3ml2OWmxhiUax6HhIdeXzoLDRv1vCQciA/kywKrQnESQtIno9T3FXIhR8vH6oXmBChuckVVlxdDKa4x3kdA2CKlR6KVDAMxXZ5xqoe8wLW43DdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752752; c=relaxed/simple;
	bh=jWrFp0VACy/jwUGdIKEGBtzaZtLOLb7m7M+U6jIER88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpjrnrwV5pcwKEhMjAq1scYjF0BaaJl29C/gaQu5fJOwS5vGbIigzQTGzUe56Gd8SgDaF+AGX6oB2nHvrGtoG2zusWYoy7SKSB/qT0vdn4xvDkckghtGHhn3oqSE3y17SYJNf+HtDJ6+28rZU/i3QIRSxQZvV25hX5BMzfL7Pjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aF/iIJdd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aF/iIJdd"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af934d7c932so420851366b.3
        for <linux-serial@vger.kernel.org>; Sat, 09 Aug 2025 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754752748; x=1755357548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ13LHBQOzt+n2A3OJyCYhNSYL6AioGfdBRApCEKEJc=;
        b=aF/iIJddwfKyIofc0ZqcIempqNYVY4NUl3nd1qNbr9KNS9ofZYksA/Xhp4ZvFxvMdW
         uroHwJcnZ+wIP5ejHM+Sl8xzv6ZAF4ot6R8Q/GH8TQDm6KYRctkIF4Nq3w6jbUIokTAb
         hp5ACuywM7Ai5T8P/7C7ZF0flwyrZVo2ZxniQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754752748; x=1755357548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ13LHBQOzt+n2A3OJyCYhNSYL6AioGfdBRApCEKEJc=;
        b=Yrpec6GkuOXuBNUBEsG5ewOnryA+axF+i90BaOYGOYpUc3rI6FUd/9n1PlqvlRDCkK
         RQCoZZWlG7/k9IVwEaXMa6oho+1xKnnseonGmL10U/Ehkh5SeSqisljRLS3m2RP9jtIu
         rhipkPz8SzLBCYZORJYUKWlUz9kMHniT7ZpxxPw6Shd0+XXFbHC/qnJ4hrSnfocRORbS
         i5hGMpzCnWytc+E0y7QUQcgdW6e1ZdsgNAOAJoTEOJPRniof6RwyavGMZB+Qvzvl0qBx
         hr8LNaD+x8mU4UcVKVG/ojubK1Tr2DOHlk4K5G+SD5zIbTKKtvJbeuOxoABRl0HiFPfy
         tFcg==
X-Forwarded-Encrypted: i=1; AJvYcCVcrnM5KGlBG1ra5AqCGC970QPy3fM0d1bhDTiv8EJ7Dzod/CzThWyfq7ckyHpBrFJHp/qxjUS21x0Me6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCgIGlnd1fCvn5LlFIumVkPsZOLZdfsj0KA2enoMjqKMyiOGN
	TIb5SCyGaVoJhnGqiV2f/P6o3JAYHX1tVAD0G4co7hYRC/1FF/wnra0LxXwPslT7WFbZiHpBkwX
	P79KzeWS2eA==
X-Gm-Gg: ASbGncuaYVpeqssfmtDpnlIMavbJf3cyTuG8Jxq4O0eimX6GMtO8zwoS1PnI2aXwual
	n/MJXF4p39CnR77SNYGIV69pvHMdGm5aYSIA9Yw6C40q0PStdW4uF26S0Qnxz5mdGlcVuutVjj9
	AEl3MDv00PUZfpjuDDxahNCOk8E+lcaJjOu6Zt8M/7B79bZXkQX3ZZXupISjarGOUklC7eOux9F
	Qn2OYv6DnYtAx/R0hqjHZrtqGlSdQUAsiGC3Vxui6vx4tx8hohV1Ibold3pHHUYJ0YKz4e4OKZy
	GmLFKvV1Xnx+u5F7errTdcdG1whcrjqA5Z51jg1LBbjAcu9LM+JCMKNIBKcBG4olo1wULY199YQ
	O4domCIfDdjqHN/Xy7bs7fY+sVtmSZJsI5P+I99hpME1ylwBMujyhwL4okv9JVAf03L0/m3ji
X-Google-Smtp-Source: AGHT+IFKVGGuLgadu+Q/N5kEK1EQaWStfIgvKU/nGRl4BwUc0+giXGvsX3sGafT7b4TEXYKeenQpoA==
X-Received: by 2002:a17:907:72c9:b0:af2:7ccd:3429 with SMTP id a640c23a62f3a-af9c634faccmr590589566b.9.1754752748023;
        Sat, 09 Aug 2025 08:19:08 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm15112320a12.52.2025.08.09.08.19.07
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 08:19:07 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso5445967a12.1
        for <linux-serial@vger.kernel.org>; Sat, 09 Aug 2025 08:19:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdsB8VuagvRB371xUvyB3gQvb2BzCXrThSfBcAGvdzB1WpSdp6EyvK4z/ZHXhHGKidvm8kXuMXnbGuBVM=@vger.kernel.org
X-Received: by 2002:a05:6402:1804:b0:617:c692:ff7b with SMTP id
 4fb4d7f45d1cf-617e2b93381mr3865979a12.9.1754752746814; Sat, 09 Aug 2025
 08:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJdf0rAZ5x5klUhX@kroah.com> <2025080937-hardly-facial-cde0@gregkh>
In-Reply-To: <2025080937-hardly-facial-cde0@gregkh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Aug 2025 18:18:50 +0300
X-Gmail-Original-Message-ID: <CAHk-=wh-x5kbjAZHK4Xto_Qpf55iMrAvKhAzGpoHT6fDZfkzJg@mail.gmail.com>
X-Gm-Features: Ac12FXzWqvgaaDvUXb7tbXt6pIGbNKB-lyRrYbBxBlDw3FaPalqV4PinmFQHYow
Message-ID: <CAHk-=wh-x5kbjAZHK4Xto_Qpf55iMrAvKhAzGpoHT6fDZfkzJg@mail.gmail.com>
Subject: Re: [GIT PULL] TTY / Serial driver fix for 6.17-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Aug 2025 at 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> And, as proof I shouldn't send pull requests a few mere hours after
> getting home from a week long vacation, I got the version number wrong
> here, it's 6.17-rc1, but the tag and the text all are correct, this
> affects your tree now.

It's not like I even look at the tag name, so I wouldn't have noticed
if you hadn't mentioned it.

My workflow checks the tag signing for validity, not some kind of
name. Some people just use random dates in the tag names, so the
numbers tend to be meaningless anyway.

So no worries. If the *contents* of the tag have issues, holler.

Or when sending pull requests for the *next* merge window early, then
the subject and tag names might matter, because they might be what
distinguishes a "this is a fix for this release" from "this is what I
want you to pull next week for the merge window".

But even for that case I say "might matter", because most of the time
I go by the contents of the pull request anyway (fixes pulls for the
last week of a release tend to look *completely* different from the
merge window pulls).

            Linus
