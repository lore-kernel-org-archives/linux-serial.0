Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E63B9D96;
	Fri, 28 Aug 2026 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896199; cv=none; b=M0fF8qinWCXnpuKSz6ZNCGaOkE/hbbCwfZIyOxisoLSa7EFhc4rOOhN0i1rKNDWifquBP6WpDDo5FzEL9oiAFKZOMP59Vbr+QwkNMPg4sWnW8qe9Yvt6bf9GhfKRUJS9tfascUUhqjQRrZMf+UyDjfoxUhJzaQSV15n6I4GGJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896199; c=relaxed/simple;
	bh=bSdhR5S3AkTzQkyTak/kjnC83qdpRObNJhjUYRIhjbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il1cpIMZJj3y8fj2EKtkS/Wu/27TfGMme+bc1/zsOg3PFCJIFMOAvHRSrH3qT6k2PRsSHhIwrctLGilez+VOsWLYekSkMgOz7wGh1KDAnHKiUTzsl2kPKEe+aEjs5yU0DvlxZPgdtmk+7vM+jsmSsGqQbeDQrERJ9nPbSDqOOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=aIdJQ3GH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUbcIz2Q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aIdJQ3GH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUbcIz2Q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 634EBEC0173;
	Fri, 28 Aug 2026 01:49:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 01:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787896195; x=1787982595; bh=hUuuNKbF7i
	a6LW/61+fyL2pbCSwKKHq6tMLrvuAJie8=; b=aIdJQ3GHBSOhA4RZaeEZu+Qdcm
	SmOmoPi1S0Zhc1C2VXU1MlUZs8AP3p7ba4b69KEMXiNMo0ZASCHt5atQACziOALk
	o8zZii8Fec6hnyYr/KFWKpReU/zL3AGMBxG6ZDCVsMVx0sEZLq80bxHPbc+RzCR4
	+Qh66UItf5MMoCkXtm72OVpKTDKyl3watovBGIaPyoQtt/2+BXrcQUKlXynWH7p0
	W4obcej7nlDQ/yFA4Taz2pHYMHak5kvInkRpIegv5bubqKKOcHTVWPOuSYBBWObr
	eIWRqu4kg/U8U9SW8jtESg/svo5CjUpgYCo9M5C3xLwvGYqrCtfqDdukv3HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787896195; x=1787982595; bh=hUuuNKbF7ia6LW/61+fyL2pbCSwKKHq6tML
	rvuAJie8=; b=UUbcIz2QrzEw0Lzhf/1Rqcw2GmqCiqJiMvnU7KbqoiYly6tV/Q4
	ho2v6OiPePxXg0LUDMfCXXKsukv1Y1T+oYUUkj5eiw/TiL6sbGKK+WfygOTbOpia
	l/1Dk/GrP3AI0WU2gfppUWXHF/hqLB/FqQHM7EPHWZqIorisB7iGg75FAT31vMXb
	es2AFsgaFIItI41nHRArqioaCHdsem698W2vOWlX9aOr6RgTyXWzUXqI3yNiwTSh
	R5qDDAC1tZDnGI8ByvRrglHNVxl1Ijf46vz7fX+Az3YGpF4fZv68UUOi6MkCxmIK
	i+M665V0kK9FKgZgN1kejgIyi5NEdCyCwfQ==
X-ME-Sender: <xms:gyGRavyYDi_GwF_XdyLu_5pkGGO-9VwyAoAZmS5SrNaizc079JXhhA>
    <xme:gyGRaveba3miuE8EqqL70O0usyS_Us-Li5NU10xNVyBTe_pZi8RjJEaMvCnomNIh6
    F9u7sDAMM9UVE4m8jHiSR3KAw0I3V4E9lCbwr9vkTDjOX3INdI>
X-ME-Received: <xmr:gyGRak4UIORU75psIz3eLaZstUzyjJlHN_9aVt6BJREBK-gC8voEarbarkJc6GYUvtD_lPskWbzEL12vHa7Sky7nTO7Oab9SwjuJNSG_XSM>
X-ME-Proxy-Cause: dmFkZTEwdERN5tuXiXY2JgpmJsfNP8Jt5mZl9BTviXkB4bIcyt9492f0lm5XtfnlrBBYhq
    /1DHaY0sJ8pm4g3Pg7eQRpOS7AWpfKzExaW3hEJRapO9G4Nf7XXHMBU7UP5b7yEgJyT8iY
    p1iEyvlYQQ6KVtazYmuQ71nVT78DI8UK/UO787z/eTx/Y3r/w2boNAd2hc1YUzZVWs7E3r
    XvBaR2gfQ5tYwXb26vVkA8bCxxfTEkjbHdEje4x0mOau6sNam0YebkWks1zQtNITyJ9KvH
    p13oAEXwWFknyclGO2UMFZjljkbIVXcRalCJjkC/TyKsQIBJFVS68HLOHam05j0Iy13/Vy
    iNbih18PDoTJcwqhD03EpujmTQMGVq8yn7OUq0Kkds/yo3z5yGCnLud/bGlwQiTfM7faqx
    WkDuHAyWtiAI4utij8gGkvc+NPPbKW3KckZbEPluUFbGQHhx/AoNX+OOxDMyhINykViPPt
    jmgepO8PQSmXvYMSgVre5Dl201ZReeOQdACwIByIgTSnsUO6eoPmtQEWKqq1MpQjRW6XiT
    J4DYz/pg3RnsPpY/VjdxeAhKwAOpQCzTd+SYbT0EODGDUv0onl4HXOjfvf7R1Z1l77e3CN
    vi8vv1qZpTzWu7SdU03GbuztnvAqEvNxmc9QvqpKhSG/Xw6zNpBaMcdsOtwQ
X-ME-Proxy: <xmx:gyGRakI_R7JVTWbVlZVTHRgUue8CuFMC1BPrW-Kl2s6Xx0me9o5zKg>
    <xmx:gyGRasx-UW-sAp_4vZJf_Tnf9-g2ik5F6wEHRNZQ-jN5RCzTQnNYpQ>
    <xmx:gyGRasIXk2BhIB3JWStrNrIB-dP0AjJvLHDHZd9bei81rAkq3nS6VA>
    <xmx:gyGRarWEnDgjxpERVv45G-2ndSkJ2K09guCnvFg2M_mKFFceF0P-Rg>
    <xmx:gyGRaqW7MeDPf2TzGGDLNVcPTIHKHkgaE27uFODIYV27nmXBhA21LVVP>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 01:49:54 -0400 (EDT)
Date: Fri, 28 Aug 2026 07:49:52 +0200
From: Greg KH <greg@kroah.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Jiri Slaby <jirislaby@kernel.org>, falemi@asu.edu,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] nozomi: missing BAR-TYPE check -- writew() on an IOPORT
 cookie
Message-ID: <2026082848-subdivide-yield-b210@gregkh>
References: <CA+0ovCh_phuo7TsORd9dZGA3joG6rAOyXm=cv9+BrGgQb4w33Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCh_phuo7TsORd9dZGA3joG6rAOyXm=cv9+BrGgQb4w33Q@mail.gmail.com>

On Thu, Aug 27, 2026 at 10:33:24PM -0700, Farhad Alemi wrote:
> Hello,
> 
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/148-tty-nozomi-writew-on-ioport-cookie/
> 
>   nozomi 0000:00:02.0: Card type is: 8192
>   BUG: unable to handle page fault for address: 000000000001d044
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   Oops: Oops: 0002 [#1] SMP KASAN NOPTI
>   RIP: 0010:nozomi_card_init+0x9fe/0x14c0
>   Call Trace:
>    nozomi_card_init+0x9fe/0x14c0
>    pci_device_probe+0x436/0xc90
>    really_probe+0x267/0xaf0
>    __driver_probe_device+0x1e2/0x350
>    driver_probe_device+0x4f/0x240
>    __device_attach_driver+0x270/0x410
>    bus_for_each_drv+0x258/0x2f0
>    __device_attach+0x2c5/0x450
>    drivers_probe_store+0x11c/0x220
>    kernfs_fop_write_iter+0x3af/0x540
>    ksys_write+0x150/0x270
> 
> Our reproducer.c is available upon request.
> 
> Happy to test a patch if that would help.

Please send a patch, thanks.

Oh wait, why are you attempting to force drivers to random fake devices?
You have seen this patch set which will taint your kernel if you attempt
such a broken thing to do, right:
	https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org

Please test that patch set (well, after fixing up the obvious problems
with it...)

greg k-h
