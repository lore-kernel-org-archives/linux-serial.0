Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA61BC433B4
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E826143F
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 12:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhEGM7k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 May 2021 08:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236463AbhEGM7j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 May 2021 08:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620392319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLhWfHwcaV8aKPVU7+Ft0vYJAChyhrhw9hcFw4aRmbo=;
        b=irasaOWxzwPAiNVGanYXsDHtcf9sY2z7n1v37Sjs3pfuQ77zfuc10TPb24hlpF8uPkVjGn
        lZPcZFJtF87vGiYgU5j8XIc9KdKev/8gZZFCGNIZQQaLtPl93H9tE1AG9j2gHfnBthk5NY
        kAe7iNPgxHUVlH26LTDMPrc0lxHv6a0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-RHU5e0fiMa-o0NQtOT6yQw-1; Fri, 07 May 2021 08:58:37 -0400
X-MC-Unique: RHU5e0fiMa-o0NQtOT6yQw-1
Received: by mail-yb1-f198.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so9933742ybo.11
        for <linux-serial@vger.kernel.org>; Fri, 07 May 2021 05:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLhWfHwcaV8aKPVU7+Ft0vYJAChyhrhw9hcFw4aRmbo=;
        b=KYDhqvHiFTfiDfc0uw6+qbpcLi65ebfSo1HJfxIfiTjSo073MlIeBPB4as9sjX6ipX
         ovJF+JHDKlFc9IyEznWiuLhfe/oV+tKGHoySrHhOW4h2UXSGrvEv+Pf1Ky5d4SRMXb6e
         fN+FTZwaI3Nem2sDaVzC0nxnkD+3fzlDmdZvu3cyn+Hknpq2s1GlpqMZ8f/+b/2WFa8E
         8QgF5tnDt9gcojombzsr1weH/jbDrJ1+ipy+ILOnQI7LILYvrnrFFsnEL7+FV0GAvafk
         mF00A2kcrHUeGtFDFdl83UGwL8WolpOMAjzRtqs/Y5n2sB28z8tJA/9gwkE8HHj8cuTR
         +a+A==
X-Gm-Message-State: AOAM530p7XqW4H5j69OIIy+GEdrKBZuc+aEWlCrHX6rKbtPm96Schpqk
        PXvMDsW/EZZFw68+lzjrhdmV1et905huHF93gs327fwx97dGsSlPHfVLxBr9K1hS8VivzE/XPi/
        qXYjRFZRRDKK+XqCwkkYxfPLVhAywzPzt83SE+zCI
X-Received: by 2002:a25:640f:: with SMTP id y15mr13270246ybb.436.1620392317283;
        Fri, 07 May 2021 05:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCaqVgj5WYApshEXCI32XAMx1PCeGQdEs8AyQjiRY6Qh9gAQzI/YAbyK/y3MYqZ6+seWa1q04tEmUBWR4cF20=
X-Received: by 2002:a25:640f:: with SMTP id y15mr13270200ybb.436.1620392316934;
 Fri, 07 May 2021 05:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210507115719.140799-1-omosnace@redhat.com> <YJUyJcNT9RDaJc4P@kroah.com>
In-Reply-To: <YJUyJcNT9RDaJc4P@kroah.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 May 2021 14:58:23 +0200
Message-ID: <CAFqZXNudm1F4pPfhf+tVVikYpY_RPL9z816LS0tKc-4Vs2vjPA@mail.gmail.com>
Subject: Re: [PATCH] serial: core: fix suspicious security_locked_down() call
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 7, 2021 at 2:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 07, 2021 at 01:57:19PM +0200, Ondrej Mosnacek wrote:
> > The commit that added this check did so in a very strange way - first
> > security_locked_down() is called, its value stored into retval, and if
> > it's nonzero, then an additional check is made for (change_irq ||
> > change_port), and if this is true, the function returns. However, if
> > the goto exit branch is not taken, the code keeps the retval value and
> > continues executing the function. Then, depending on whether
> > uport->ops->verify_port is set, the retval value may or may not be reset
> > to zero and eventually the error value from security_locked_down() may
> > abort the function a few lines below.
> >
> > I will go out on a limb and assume that this isn't the intended behavior
> > and that an error value from security_locked_down() was supposed to
> > abort the function only in case (change_irq || change_port) is true.
>
> Are you _sure_ about this?
>
> Verification from the authors and users of this odd feature might be
> good to have, as I am loath to change how this works without them
> weighing in here.

I'm not completely sure and I'm with you on not merging this without
feedback from people involved in the original patch and/or whoever
understands the logic in said function.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

