Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F057CC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD62523AAC
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgLIPKx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:10:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38759 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgLIPKx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 10:10:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id w13so3557548lfd.5;
        Wed, 09 Dec 2020 07:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jP1J4ziuKFQP6qMuiqWuGJM1FU49hl1u2cz1iOJBsj8=;
        b=JQuSljS8mKxLlwIEHKUN9YZxqusyNsd3JWtS0Ud3NymglFFvTbiYIrJjOTyS4KSKw/
         ZyvAgpBo5OUi9G7vAxYhqXn5TnP14HtJBxppv0r7ARtAjXerGf9qy+QtTRWXlmT8zFCc
         vjnlwgmhCNcSObWR3Hi5aCT83vyJGZsC73LvugHxmWznJxWXKqhXp7S5ZO62/nFs6f9G
         /sAmvv79Ts7s5pYg59s/VzEp3Ish0zCesGl/xed5APeHGqvVomObuB2Wx7SGMJI0XReG
         XBNbzuxrL7oSAsHiyGnUcGGBz0/cOINccuyccyNL9lQIrmgfhFboffZ15QLNB/UMN9vM
         rNCw==
X-Gm-Message-State: AOAM531LnFNB00cgh1KXe64aNPehZDIVdIrUM00PK8RLPmw7pSJ1pxb3
        hl0HrkUds+Gs6/YS33gqa40=
X-Google-Smtp-Source: ABdhPJx6r7UsgNFRDx+GjQcmhqBhZNSgKGaFvGgnz7h5ra+ZYzTzU4VS8PNJ4WfsOMLtLQe0yrUtwA==
X-Received: by 2002:a19:197:: with SMTP id 145mr1112949lfb.483.1607526609405;
        Wed, 09 Dec 2020 07:10:09 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id b12sm263014ljj.133.2020.12.09.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:10:08 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kn17B-0005TG-CV; Wed, 09 Dec 2020 16:10:50 +0100
Date:   Wed, 9 Dec 2020 16:10:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9Do+b5+xxjrywVN@localhost>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9Dficb8sQGRut+S@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 09, 2020 at 03:30:33PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 02, 2020 at 12:39:35PM +0100, Johan Hovold wrote:
> > This series adds a new NORDY port flag to suppress raising the
> > modem-control lines on open to signal DTE readiness.
> > 
> > This can be used to implement a NORDY termios control flag to complement
> > HUPCL, which controls lowering of the modem-control lines on final
> > close.
> > 
> > Initially drivers can export the flag through sysfs, which also allows
> > control over the lines on first open. Such an interface is implemented
> > for serial core and USB serial.

> > Also let me know if you prefer to hold this off for 5.12. The change is
> > minimal, self-contained and low-risk, but it is a new interface and late
> > in the release cycle as Andy pointed out.
> 
> I took the first 2 patches now, that was easy :)
> 
> I think we need more review for the rest of the series.  This does
> change the way serial ports work in a non-traditional way (i.e. using
> sysfs instead of terminal settings).  So I want to get a bunch of people
> to agree that this is ok to do things this way now before taking this
> new user-visible api.

Sounds good, thanks.

Johan
