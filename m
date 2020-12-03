Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F55C63777
	for <linux-serial@archiver.kernel.org>; Thu,  3 Dec 2020 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEA5206A4
	for <linux-serial@archiver.kernel.org>; Thu,  3 Dec 2020 09:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgLCJVX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:21:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40105 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLCJVX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Dec 2020 04:21:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id y10so1741185ljc.7;
        Thu, 03 Dec 2020 01:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Haixfnk0EClHPuSrxRGUPorYEv9GlFW9Rbqw9Fo43CM=;
        b=l6XCu63IusFuyiWNOj4OWkOpLLJPy3/k85AURZOSWq4pK+oZP4UEwbbz9Nh1vMwGxn
         f6cwUcqwQG0wJePjvq0PPkYylagQqEupic9N6iwM21JfB4tkMgnSqaYNAZAh+nO0RjhF
         H/grx2odk+X3jswIYZT4duwzB0njPXdjorDn5F+t4iW/zCAafViRxiYpjJK9ZDrccm7O
         GXfO5kh8/57DYKrSU+AczW7WSExkjWsY2IXVrsFmw7I1MeuON4KU1oZXzkPan/VfwZEX
         hVDe1beP8hIeI9VffuixW9lBo6RnVBcpMzPsNynQ07aSdELA7HAxh3xBlj5/Ttpxc0D8
         bJIw==
X-Gm-Message-State: AOAM532aIymhoNpuMXTa1hzY33JNbmrynK9czgLwdp0k+Er0To7WCxKf
        rBXcuL7BMwUsgZ3LHvIlJf8=
X-Google-Smtp-Source: ABdhPJwXwFCBA1+gnIb4rvykgEvMcC8IDEn2NNk7T2dMVFASY6oJFDyLHVeUpNlCtlmo6gtu6SncLw==
X-Received: by 2002:a05:651c:228:: with SMTP id z8mr831527ljn.216.1606987241706;
        Thu, 03 Dec 2020 01:20:41 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 136sm296673lfn.193.2020.12.03.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 01:20:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kkknZ-0003Nr-S4; Thu, 03 Dec 2020 10:21:14 +0100
Date:   Thu, 3 Dec 2020 10:21:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X8iuCXYhOBVMGvXv@localhost>
References: <20201202113942.27024-1-johan@kernel.org>
 <CA+uuBqZ-EnsOU-UiufXo+oxmrgM3=2eu9C_50tpBHLKjcfxdgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+uuBqZ-EnsOU-UiufXo+oxmrgM3=2eu9C_50tpBHLKjcfxdgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 02, 2020 at 10:07:58AM -0800, Mychaela Falconia wrote:
> On 12/2/20, Johan Hovold <johan@kernel.org> wrote:
> > Also let me know if you prefer to hold this off for 5.12. The change is
> > minimal, self-contained and low-risk, but it is a new interface and late
> > in the release cycle as Andy pointed out.
> 
> Hold off for 5.12? Did you perhaps mean 5.11? I understand how this
> change may be too late for 5.10, but surely it can go into 5.11 merge
> window, why hold off for 5.12?

No, I meant 5.12, even if I still think this could go into 5.11.

Generally new features should brew a bit in linux-next. It's mostly bots
testing linux-next, and they wouldn't be able to catch anything beyond
potential build issues as this feature is off by default anyway. So I
don't think that needs to be an issue in this case.

But we don't have deadlines and if, say, for one reason or another Greg
doesn't have time to review this in the next couple of weeks, we'll just
hold it off.

Johan
