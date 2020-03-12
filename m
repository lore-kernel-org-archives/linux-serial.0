Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313BC10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3064D206EB
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgCLISX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:18:23 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLISX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 04:18:23 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MPGiR-1ixeyW1XrB-00PfGV; Thu, 12 Mar 2020 09:18:21 +0100
Received: by mail-qk1-f174.google.com with SMTP id f198so4800468qke.11;
        Thu, 12 Mar 2020 01:18:21 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1r8eylYx5ZZgyOYeaWDUr2YY6K/7mHqhZigjsuOFYPBL+rGaPb
        18RFSsZ1o8s758nUVCgeVpU+Por0NG+K10uQ6/8=
X-Google-Smtp-Source: ADFU+vsNBs5U8MSP0AIhbOTyNZM5zKZbj9kd12yMxihKBGNpLlSYTCDKKw9EkzMHsXQTWNCKK3QEcXCPnNyHrsJ3iYg=
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr6736993qke.352.1584001100024;
 Thu, 12 Mar 2020 01:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200311225736.32147-1-rdunlap@infradead.org> <20200311225736.32147-2-rdunlap@infradead.org>
In-Reply-To: <20200311225736.32147-2-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Mar 2020 09:18:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ah3hJOJugJmYGcr48fN1SR6crSgAgGocZxqAgL5r0ew@mail.gmail.com>
Message-ID: <CAK8P3a1ah3hJOJugJmYGcr48fN1SR6crSgAgGocZxqAgL5r0ew@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] char: group dev configs togther
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sPAakDjeihxQelG+jj4ZoHRdrd6ZRt0zJa1JTqtWPNmrThhOUmQ
 xlZ+f1nOTUOX0o8JF+rW/IlEflQltQT//UV8V3tq/0i7xWt/nFi7/IgCLwuWPggDFc/UpQa
 ScY7sRmOPoenjx2DCZmJFqejkcJSq0GXH6L01Y3Bu/E+CAdG3pGi/IWIljaY4pvZs6uWj6v
 S/3xdcjbIH5lXXAx8FgVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2WA180O+chk=:kNlHsfIKuGyMDvxPtcylCJ
 23YGUee/0URwHDkLBQL2s4ckQVM1MWY2MB45pTXzbsMO1GGDfoSPVnkgW2RaQ12wohTesWQki
 2E70qCWXiwZL1js8K8WqliE6RyorNy7F19Tv0Uj9jAlwYyzTigGbv5gynS1my7XO9gapUVj5h
 zxvobFzP6iQCSm16uTRpgPx2rDUPSuuDRiFpuhPabJhO6LLI2ktyi9MJztXbgqQuejf+1n1JM
 bNVDbbV5iIsc3i0KcJ9EG27Lqp7b0O6Dm41C5KlSs0KdppAlT9qkYIFuM5v+FVWEKjeVql7x5
 uiZi9ESqh62Ras2zRqJS1gAkhfQmljCo3W+dPGI5rFJLhXP+6Aq95l/h6YffV3CJ8EwoR+aeo
 YnoPPxhKTubjjK/2WeSD0hArDU6/OFL2gDkM+2lSRsoM8P/FNp8qZiG1zECSove1llC4Cl3Mb
 jheQkatWnTNgUeu/Br9chLmpQL+m2oaWGiIeKlDCwGRLkaWPgcl6mHIwf53OkZcArJzb+hNOI
 j4hPsiV7rIlP+O9URXh/Bogcaz2OYCNO8VacncFFcdQJhqb6mCJ4GMJagpUpI9bJtYfiJp1T6
 jOIX50RVhmxVRppZ8UvmD70bLbg0NVJXlZuu7odkwOUwnxIHooS13grn6X7f6k1eBAivDZe3S
 bzaVGEvf0zcBXyMDRqZD7JpEf9i+oBoL0/H2guwstpUOCmphu+VJNP4z/t/cUveh21piQpIlS
 K6jcvgnuzhmpT/oagt6U+hmr0Nu8mqF/lA+TbLxRmYzUZxsPXV3pzBR4C9K1cFGCrusSjXm4X
 657SpbMqORTQw3thky3B7tc7OBye00AaX4ZglfkCmiTwOhUc9Q=
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 11, 2020 at 11:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Group /dev/{mem,kmem,nvram,raw,port} driver configs together.
> This also means that tty configs are now grouped together instead
> of being split up.
>
> This just moves Kconfig lines around. There are no other changes.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org

Looks good to me. /dev/raw might not fit into this list, but it's hard
to come up with a clear definition anyway, and this is definitely
better than before.

Acked-by: Arnd Bergmann <arnd@arndb.de>
