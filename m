Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCDBC43334
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jun 2022 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiFBRDK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiFBRDK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jun 2022 13:03:10 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911B1FA67;
        Thu,  2 Jun 2022 10:03:09 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ec42eae76bso57793717b3.10;
        Thu, 02 Jun 2022 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tOyhHrccKEe42HVZG3/loPKJzOL1E5L81bn2HsTKWV4=;
        b=Lj1mogPfiekNzIq2p5Zzi8Pfg5Ow7ooj3ntEFokLmC+TnxOOq085vPC8pz4hLv22zC
         EJv25ivsh2w8Qg/ccxCFMsbyvhsYtEerOIl7SWA5SDM1JAm+EenbWcWD+1SOzOtHF9PX
         ucVahjG2bPbPPXHyKovkOmfgFTqlMWQ7bhQgFGAU1nFv02dM6HHGsIQ2MOYWi73SlmrG
         HI2hjzh29RZTFRsr+RXiEEY97eRPpoFrIEog1KGWFQ5SOEjzaSnAzA2GbTe9OHVVhDdw
         yruflPonvsho/eOr8S7yxl09k6ryD0SuZAhypaEI1vIYPjteQeQOucP4A8n9STJe5Ca2
         GwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tOyhHrccKEe42HVZG3/loPKJzOL1E5L81bn2HsTKWV4=;
        b=IfM/NlIa9rzaigjn90GiznqaL9G7gMmAxabv9yz7rFz5cUDAVG69D6rgGuD3AtNLjB
         W4FwTIhnJRVCrsQGR00eQwMlIlWkbwWeaqWCOux01yHz+scyKDyd6+GjOhkU3nRtqhw1
         fJhxcQHBzhJuFG7N3WZoFPlIAcEDepDo4n1LC3tIfqrzhQ19qWaSrzVrLN6M18JECmeb
         jqFPxvxBmnmxzYVXSvR6Vs5pWC2MOrT6x+tD0Qk5GlxsWZckJDo1MSSR42c2nlRBeTWH
         ncWcLSZk50AZ+LeWxo643bRj+CuBG1880C+dNK7idWJ0J8mllKxMdHHUml00dvI2WAQW
         zbvw==
X-Gm-Message-State: AOAM533FF57VAycBAl0Ns26/3ymfX9beKA/v5ns9ATCXCKou0bMCM9/U
        SwRUQfvbIzcAOrx3dRgTlIBF/j0LewUHeNlXjlw=
X-Google-Smtp-Source: ABdhPJzX5JCdVYOv0aLjT6oZN1D77hW+EZECwabMIrptLdgW9ZAmWGH6rNEd4i1GfwqxiL/W4nR1ly4peukVQOH7aXQ=
X-Received: by 2002:a81:c44b:0:b0:2d6:4726:ef4b with SMTP id
 s11-20020a81c44b000000b002d64726ef4bmr6711751ywj.184.1654189388664; Thu, 02
 Jun 2022 10:03:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7aa7:0:0:0:0 with HTTP; Thu, 2 Jun 2022 10:03:08
 -0700 (PDT)
In-Reply-To: <22ccc180-a3ab-77cf-a771-00113e712ac4@kernel.org>
References: <20220531043356.8CAB637401A9@freecalypso.org> <20220531043655.DDF783740232@freecalypso.org>
 <dbec85f5-7b28-3d0b-6b39-bd4296a49a70@kernel.org> <CA+uuBqacb3X+km-3EtdRxaWi0FvxZWCv8RpCo-+qaNkT-=JAgw@mail.gmail.com>
 <22ccc180-a3ab-77cf-a771-00113e712ac4@kernel.org>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Thu, 2 Jun 2022 09:03:08 -0800
Message-ID: <CA+uuBqbEpdUBxxAEsGypExP5ag7Ue7Z9MvWmCrSYxvWDiOfTdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] serial: core: add sysfs attribute to suppress
 ready signalling on open
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Jiri Slaby wrote:

> As long as you break no currently supported devices.

This condition is a given, and has always been satisfied in all of my
patch proposals, including those patches which I currently instruct my
users to install locally to work with my GSM devices.

> I've just noticed the double negative "!tty_port_nordy()" on both calls of
> that function. I guess there was already a discussion about the naming,
> but wouldn't it make more sense to dub it like tty_port_do_rtscts()?

There are two aspects to this naming issue:

1) names of internal flags and functions that exist only inside the
kernel;

2) name of the sysfs attribute exported to userspace.

The latter part constitutes ABI, hence it is the one that calls for
serious reflection on the choice of name.  The sysfs portion of the
present patch series (as opposed to the USB VID:PID-keyed portion)
originates from Johan, and the nordy name for the sysfs attribute
(and for the internal flag and function for consistency) was his
choice.

My own preferred choice for the sysfs attribute name would be something
like manual_rtsdtr rather than nordy; I feel that a name such as
manual_rtsdtr conveys what is being done: asking the kernel to put
these modem control outputs under manual control (TIOCMBIS & TIOCMBIC)
instead of automatic assertion on open.  Johan argued a year and a
half ago that nordy was a better name as it indicated "please suppress
ready signaling" - it's a different perspective.  Johan, are you still
around?  Do you still favor nordy as the sysfs attribute name?

At the end of the day, I will be happy with _any_ name for the sysfs
attribute - to end users it's the functionality that matters, not the
name - and because it's ABI, once the sysfs attribute is implemented
with some given name, it will stay.  So, can some authoritative people
please weigh in on how this sysfs attribute should be named?  Should
it be nordy?  manual_rtsdtr?  Something else?

M~
