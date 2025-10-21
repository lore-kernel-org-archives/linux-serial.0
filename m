Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878B288C20
	for <linux-serial@vger.kernel.org>; Tue, 21 Oct 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035866; cv=none; b=aPIuxcsKvO2fplxB/jC0CCnoJu6K+qtlu57qqLP1FYEfF66ztyiVvOZlepsQSrW9hD5lPASWhmYS/uY9RcgtzFXb32ADLHPfD3mliAaOzBC+2GXDAcFDYxF8lORjs7/HFWRjaWFg3Uq/duAVEd9I8hJT0tdSUtWz6bxRCuP2uao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035866; c=relaxed/simple;
	bh=QjyCWM2eaOA0G4njqmL1QXzj7R90sfd0dteSirTsca4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExEqzVYp5QUknQvsmHqXfcZKwPQw8zJlOKfJDLCdntEL8w2cYdc9e4PIdKr6GEnpC64Is14bOlWWgZXQ8YKil8dTzGZbIq96CEGMzS1gjauuDFWGckRIwTRb37sxp1XFY7f5UM9Dp7y+0/xCa53Sm0tzdNPske8VTvz2HXyUUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx36LVtm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx36LVtm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4736e043f9so897218166b.0
        for <linux-serial@vger.kernel.org>; Tue, 21 Oct 2025 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761035863; x=1761640663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QjyCWM2eaOA0G4njqmL1QXzj7R90sfd0dteSirTsca4=;
        b=Gx36LVtmNIzqM8hPLu5g2RBt9sKc3Xr8z4YXyajQafsm8z+85hYTIcZUHC4o0qHgzw
         Kmj4C2v6qaauSPZnF1wYOt78WB9dJvsiwmXjHEkLP76V45M/cpZdTyu4wAXkPHR6YJGB
         KQ1Ab2eZp5Pl1oUxuF5xZdR64/uQNax2P4tEs0gM9s9m4wGfUAX9ZQnWzf8G9kIARh/3
         Jmd7yHDN5Ipy5P1irI+lgmGQYYyYwUfZYj2+Vjg9JcD4lBIVMoGlQtYWC4JBfgiu7fUU
         w+hY+fNdmrx3FAr54JWk/0CPr52x3/qktPr6h6nbJf4R2wP+R1pBQrU8wxnuS/1lz28L
         UeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035863; x=1761640663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjyCWM2eaOA0G4njqmL1QXzj7R90sfd0dteSirTsca4=;
        b=YKGVwGV2kTwV7i09BNcgSsmXbxZtVizR1TjLX7B/d+MIaSxC2cm7wtJe0qqE/jZF4D
         JJtIBQZLi3or9M8GZc4315iSuSLteElEc/fgFY0u4UKarYUaBpdWPvUOY+ifTgboxiGc
         x7in+RNnuj/Er6luqgohDw+1edinZA1oKZ+KOu2MJVUG0m5oQa9o1hfICmT1sce697Vw
         tc+iwUw4kh47A1jy6gaJl7qPLBlejzuErovi1LMKGOV5xXjLb8/mwOuJDLPQA2MN+w7K
         S5Eg3RW2bev9VxQ87WcpgEvgTWxJQoRWWEmMUodOeu9Sxq0ciPWAxJdQLug3FFZuyZJc
         tgMw==
X-Forwarded-Encrypted: i=1; AJvYcCU9S1B9dloKPyJnu3+qnpP99TVQWVEFQwzfKsTMfWgoBSSJbO41BxkTjLPGkMG3VogZ9LWeDKdaKGcOEmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PhF8mp4BGyNiE5dSbK7IHR7hi/FsQg1MdwjCXJJfzSOQH10x
	y2Vq4Atk/GsvoN7v4tEOfx9jYdS7U/Npl4yfWBITQkxeXBbbAYvHgPJ3lMtvIS+NfZeOojsSXW9
	PGkwIqKdoCFbMPyXOyaHKquXqOp/P5Q==
X-Gm-Gg: ASbGncubZk7y61QWwmzH+VL+5l9SdyW9Q+3dXufy5D5qQtUttcfEF0FlJsRQZ6jY3jt
	KDtnb9HVpGsNvlRpEMcoghSGg3fSCWfswgXeO5SWxPy0U+L0vwmJ10IOJQBe+nKYiifiAFBbNzY
	dDgDTUwUQS+uBdQ1uwNjzdCjzMXAimKHVX/d3TDovsjkxZJMCKJK+8fc8Pc3hjk0NnLnEbai/5N
	WmbHdLcOoFD6TetfaXYqB65nQ6SpjXusJEf9izgzeL29LzgMeNMQrrQzw==
X-Google-Smtp-Source: AGHT+IEtZxUVPjSc2WqOyAjA7Fte4RrVXHEh4i2Gbt2zB79A/SDrGDESaIChW2EoFUntYRwCfCiMlt+Yi0KqlqbopSU=
X-Received: by 2002:a17:907:3dac:b0:b45:8370:ef10 with SMTP id
 a640c23a62f3a-b647245845bmr1951550566b.22.1761035862848; Tue, 21 Oct 2025
 01:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016103609.33897-2-bagasdotme@gmail.com> <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
 <CAH2-hc+XQR7v9Z28yH_CTWZ4ieaF5eQFKBVut1idULP=4w03fQ@mail.gmail.com> <6b8e7935-6b80-4f00-9a44-7003071d1a21@infradead.org>
In-Reply-To: <6b8e7935-6b80-4f00-9a44-7003071d1a21@infradead.org>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Tue, 21 Oct 2025 10:37:30 +0200
X-Gm-Features: AS18NWAkzMEdIZQ7IEi0fFSxQKz8uPinwHCWF-5cnXsFVeY8YpgVfIMAZOdWQSE
Message-ID: <CAH2-hc+M-CyXL1HtHkD9o_Q_8PP_OkYLvjqhdBiCnHVBQspedQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>, Jiri Slaby <jirislaby@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Content-Type: text/plain; charset="UTF-8"

In that case, can we use some short form? Something like
"extra characters are ignored for now, which might change in future".

Thing is that i wanted to add handling of extra characters, but
maintainer said it cannot be done because people might currently rely
on characters being ignored as written in documentation.
