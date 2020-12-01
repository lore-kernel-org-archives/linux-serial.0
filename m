Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC173C64E7A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67620216C4
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLAIq2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:46:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45895 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgLAIq1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 03:46:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id z21so2486770lfe.12;
        Tue, 01 Dec 2020 00:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kx5VQRPsE23X8BsQ1MAGZtQ/+4VWIP6o0cNUR+vHfLU=;
        b=OLD9lzMwee6+PTPsDR4jI3uE8XQwEumzet4D4mxomcBAdZbctVVZJ2piWvAcfs9tx/
         NFGW4r4zAItP+A+ndjBF4tFvE7EjtUAhDQ7q0cDabpdQ4j2l4Wb6D0E6Jw7P1C+gxGLu
         SiWJ+WkIxDRB4rDuMFkLPtJo8ApZnuVldcj7UCn1bMCx6qaYW+w/oKscsTpFXeVgAx+X
         KlSpLg6iOOjY/cZaHjo4Axr+55K8cMtJm3LUUy4V+pcrrNuKKktUi14J54RpR6eCnhAT
         ec2N6oqihz9K8vM4XW+v23xRD8DVw7FF5nhTloMVcCzKK6umzgl+Fwewr5PJ+nuC5Gcb
         w2pA==
X-Gm-Message-State: AOAM532rNonwVQJWF4PGRQcDmD9cqKjXjGAzNjyvqb6OMrjrpf0pyDiZ
        e3oP1EEyIUCCBNS98XiKLL4=
X-Google-Smtp-Source: ABdhPJzzgeTdY9lRHfHKsNi/eKdCmDH5mnNsSBJ+2KGs1prOGoJi5FtVW8FGqbqbixB41KvbWgxHeA==
X-Received: by 2002:a19:983:: with SMTP id 125mr725555lfj.36.1606812345097;
        Tue, 01 Dec 2020 00:45:45 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id g130sm126061lfd.227.2020.12.01.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 00:45:44 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk1Ib-0003Fu-3a; Tue, 01 Dec 2020 09:46:13 +0100
Date:   Tue, 1 Dec 2020 09:46:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tty: add port flag to suppress ready signalling on
 open
Message-ID: <X8YC1UGSfaarKMcV@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-2-johan@kernel.org>
 <ffec9dbe-a238-4411-acdb-41bd33719288@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffec9dbe-a238-4411-acdb-41bd33719288@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 06:49:07AM +0100, Jiri Slaby wrote:
> On 30. 11. 20, 16:37, Johan Hovold wrote:
> > --- a/include/linux/tty.h
> > +++ b/include/linux/tty.h
> > @@ -683,6 +684,19 @@ static inline void tty_port_set_kopened(struct tty_port *port, bool val)
> >   		clear_bit(TTY_PORT_KOPENED, &port->iflags);
> >   }
> >   
> > +static inline bool tty_port_nordy(struct tty_port *port)
> 
> port can be const here.

Sure, but see below.

> > +{
> > +	return test_bit(TTY_PORT_NORDY, &port->iflags);
> > +}
> > +
> > +static inline void tty_port_set_nordy(struct tty_port *port, bool val)
> > +{
> > +	if (val)
> > +		set_bit(TTY_PORT_NORDY, &port->iflags);
> > +	else
> > +		clear_bit(TTY_PORT_NORDY, &port->iflags);
> 
> We have assign_bit() for these cases these days.

Right, but for both your comments this follows the pattern used by the
other port-flag helpers.

I can add a preparatory patch updating the current helpers, but I don't
think this needs to be a blocker.

Johan
