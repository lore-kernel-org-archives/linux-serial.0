Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC93932F7
	for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731591; cv=none; b=kO5RQHO5OMwy7yWecCIWaXqSV9fAG+81DljHFDRBHxZRwk7PbZrO4A/yRyN1anLEw4H3XWYAgpe6s90mZTGel4yOuk3cY/japnYw+QL/uwIo/ZqJWqH8D5xJIC4FIoDaFxIfmS4r4jZ9t+lAu+N2m/aJUeexOvdJykIVQzzStG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731591; c=relaxed/simple;
	bh=mIVc+27luKXxYN8m1A9ZFRB4DjjTlFOX4P5cdCWbcDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTN0FiQ+ael/O49KnOIgbmI+kaheKuj9nYEx64lkW5d4e2BoLRWPu9OSWfL8uaenTpLGuv3RFEPkW2m7nqkKpZHAkMXtM9xXfgLTNWwCnpCEe3hltCAcLmj9Woq56UGOGZT9BXejdqa7ECrnpn1mzs1c8l+GjFr+gV+YjGOY+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6qD9Ml6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6qD9Ml6"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1600d040e4so103821766b.1
        for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731589; x=1788336389; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJAve/ikP1v0T3xdVPEDONKs2L7oCeoGp7TwH3nXlKo=;
        b=Z6qD9Ml6fxhQ0tSavrm7YKBR0XMzgMM6n2MPe2SVDLAAiYJ+NA5kh9qchfsZRdUut0
         sOE4Fg+iVY+Ss3ZizsNnG51xMTjvgtWmrPl+tom8SqVZti1kNZMb5M9p1/0gJymAAxbM
         wzhOCjodQd9zT8L2kJY0bwA1oY4l2DsX/ogHYwfMYmCljx5q13bjRgbtuzv1CnpvyT3X
         Txxpt2WETp2u6rdQd2ebxNzYQUQ9KnKtH0OFN808W+BIVYDI4aA3hkMgyliAJ5W4oJ+T
         cHP9W7VuJGHLlqvtI35VdvZXePxUyFAybw3kMu1el0F7xpqufd3wKbL7ck+g0pwUvO00
         SArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731589; x=1788336389;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJAve/ikP1v0T3xdVPEDONKs2L7oCeoGp7TwH3nXlKo=;
        b=nH5twfkWp4iiQEXpaEhHm5k3AQBhmT7yNgMNFJD3cTnCMU063YwA3xymKjhWOa40hM
         zVFwq1WdvF212UQ0WlnX/nhUggoo8mWApn8qPsWAf6JcMD7nDrjI6oFHy7ZTHJtRhLMM
         vo1+cwa5WFwOVCPJYARM770wl+LDjLJc0RY3PNagEebgNUt5sxqvL8grlEeVrQvxauhE
         2MwfbLhsTumou0kGEhQzQwIVpHgmvnl7KYodmNR8DXMERQYqegjjUwSbDmipaWqSKBJR
         7X0iYKZAaOVAG1uIeHwghwMV1YrlWtI7fAgEXubdj9KhRMEuY5S8Yy7d94wBnQ71A5ZY
         GuJA==
X-Forwarded-Encrypted: i=1; AHgh+RqBdIYT2HZULQGiWCgaifgkooknD/JpVCe5TsdHpk25a8MNfPnIX9riRw+WFWuFyTyGfKZmfKg5f8U9K1M=@vger.kernel.org
X-Gm-Message-State: AFuF++knjywT+oQeQ19ioc5dK8+KgI8B3wds/XVcE6aoKzghfQQY9DD4
	62flzqtNOpKBUn0lCMDUZQQS6NQUpcdobSByTv4ZEtv7D4oJ9wiCJ6qQ
X-Gm-Gg: AR+sD132yyYygA6GjarujTbyjcVYAanJRamrFtI1h0xmvbLlvb0xQxOQ984rsa5x1gY
	tMg4pOFtXCBe5gQ4In8rKMu8jI9HP+th0jiCi2GPis4GyjtwxpO0rD/FL+kDw8I+5dQBGBWwcMD
	kiAXZ8S0gV/2WoYFerLg9F9xBR/07qheE5Vp9KSxBdO8oqM4WZWdpi/Ly6B0CTzW3VDN48UVOTR
	xWAFQgLc37EORzBv5J/KPlfAfl1guG3Gyc5B/amZJL2Sbr2YgoZ4dtwyZZv/OoHvzbywS6tH3vv
	ceHYLlTsxvETnE/7LtARePGyhnvfbAUEtWYNrwsHpHXo7n7y1IQi1wesHEBwnKNLKhgkDtlSezl
	2rJT5471tctqeK3lcCfe0OWuEkt5CvSx5ak34F5/1U1udYZgnGL2AIXK/+ZCUOx7WaSPep1GmHY
	8D1VRkS4mQrt2bYpLjSw2ScJP8SfG0Ia+QwktqtQ6ehpRWEliq9L8P0vg1EW22dzFiMg==
X-Received: by 2002:a17:907:844:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c24e2aa48bemr1491171966b.2.1787731588513;
        Wed, 26 Aug 2026 01:06:28 -0700 (PDT)
Received: from [127.0.1.1] ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b10cesm364143066b.48.2026.08.26.01.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:06:28 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 John Ogness <john.ogness@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
 Gerhard Engleder <eg@keba.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Date: Wed, 26 Aug 2026 10:06:26 +0200
Message-ID: <178773158689.1384029.3121943722878545406@gmail.com>
In-Reply-To: <2026082645-stench-backpack-6e07@gregkh>
References: <20260826073237.1377668-1-linuxoid@gmail.com>
 <2026082645-stench-backpack-6e07@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Aug 26, 2026 at 09:53:34AM +0200, Greg Kroah-Hartman wrote:
> It's an invalid syzbot reproducer, if root tells the kernel to unbind
> from a device when it is being used, it gets to keep the pieces when
> things break :(
>
> Let me go polish off my "taint the kernel if bind/unbind runs" patch to
> keep this from happening...

Understood, thanks for looking at it so quickly. I'll drop the patch.

> Did you forget an Assisted-by: tag?

Yes. The patch was AI-assisted and should have included

  Assisted-by: Claude:claude-opus-5
  Assisted-by: Codex:gpt-5.6-sol

I worked from submitting-patches.rst for the tag order and did not read
coding-assistants.rst. My mistake, and it will be on anything I send in future.

Thanks,
Ruslan
