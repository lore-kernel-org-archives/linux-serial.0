Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7EFC433EF
	for <linux-serial@archiver.kernel.org>; Sun, 13 Feb 2022 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiBMUlH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 13 Feb 2022 15:41:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiBMUlG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 Feb 2022 15:41:06 -0500
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 12:40:59 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09E53707
        for <linux-serial@vger.kernel.org>; Sun, 13 Feb 2022 12:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644784858;
        bh=Cpfn90elRMfLDzVx1L0uUsc/bngOYlVfTxhI1KBAubs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R7+/+tiGSqxvmpiTUD0KljXbsxoh2PjFJWcsWa+sc+cGmbcDkbRGqCWi9OSgdYOQG
         LW0ljkV1bIHLkCFa+n/AF3nyk3/tgtZ6MdQGPSA5LLHBnuegw6wTgrvRoIFfG7E3cw
         oZI114SOjSqL+QZxOUSwgt/1R6rcFt2U4Gz0wWJI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.238]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1oFSQQ1Wp3-00wnYQ; Sun, 13
 Feb 2022 21:35:23 +0100
Message-ID: <0baabcbc-196e-08fa-e2db-b7e925993cc1@gmx.de>
Date:   Sun, 13 Feb 2022 21:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] serial: parisc: GSC: fix build when PCI_LBA is not set
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20220213193903.8815-1-rdunlap@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220213193903.8815-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VtVfDMh6PpTirPXZK3QeaRFqqIwIHU/pf/eKlHf4xg8mCtFgPqM
 0un+1BVwxQPBWoD2z9yHZZlDQAqqUZKUXLQUM4+bWHqW493Xbq2ARTFm+YnIeZCWUeA9Npy
 vhHQlWhtBg2ZidCPPkC/pOpMLmcLpy43PKBZyQZqXK/2sljyhd0yyX7zVv39db+Ye+dDYBS
 wo1ZElku24Y2XB23QpP0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mSBbYpEk9Bg=:IRxeuMskzVBcMuo5fTd1dL
 P/dtfW+9IpQnD2kX3qZHRwZs60OZt2PDFx4VR4aIXHOL0jXQW6+ZWugSUd4QDFgldFH48q4YB
 hDvt9U/MbObVICO6fsjRAtAY3j7r2ED5BGzKsfi+qqsGEPb6GG/rsv/fiRWEHg/qynQDJQFWT
 zpFPlJdoNO6yul8sBqftgzFmKpOpW3jaTq8wHFJA0XzR0YJm4GgcHh9E0FIVOOEUaF+hxRx/X
 B9vzksqovy7rMWId7lmxfFal7djfBP1XTkm21ruXOXveGA4PjJJK25JgBlcwIe1klC+JONxNF
 YOruFB9sw+FsjYu/Tef2ev5yysg6WUc0foao6iQX3rAmk4lKzh4djpt65aq1gI7NeHq2g5DW5
 pN5/mftNnuAPz7NG9pXXCGVoE0rRUcOHp2IdQZI/+hrcYA3ZLkrrpgOXQN33lBodGmRLUKAKO
 k2GTT8w5VbhBXe0VCz0bqkUDBTut/an6j9BQ/WKB0Sm3DcXxoqQYoNNUjDfAnNT2Di6rgKmF5
 waobnA+D+Q7kocY0p+c3QcEk6Qw/HGwUT4CRROElHJi5cbQXUStIKE/NZ849sIBEjz+TtpwTo
 6opqmtaRMclqikA6jz97oDMhTGKH0QqEE82Iw9OPr7LSOQgRVP9VXln7rU9uFRKhuwu3iL9bA
 t95f/Sa3fY8KrvOuwSvONgZ+FWVjjEt+mxup2fFvGJ9zFkMRK+mD5k6vjV+JGO/ajKKMVQV8u
 VWu9t7fc53qsHJZOZfpuM7VcUOytepie8xv1lmraBew6vyaXg6bUwJeE3uionDi+XCYeT747K
 H+0y8xsdeDZDAkHTeFAVdJlrvWSYESq2Qv6Y31fk3dl4od+A/i/pDGlZgcX5wOqlwK/oLrFjQ
 lecPCESt5hsOaPNz6sE5/bKXA5yXjzQuAAZWG2Cw4v22jYAwLU79dRu82OZKbzfwgPN1wDWMe
 R/Co2qfLoUMUuU8pTf0iaOHpPC8AV46fqatURQHNUd+wu9xnuM7g0UyVg/cnkEGfnmW35BlL9
 B5YFhc6JJHAAVr4UPm+ALIVsNEq8epYiL/k3IwQFxHZdRCAimjI4n0MVIE7DWwtu0+VAXl29a
 LMl+3LXv9AOLzo=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Randy,

On 2/13/22 20:39, Randy Dunlap wrote:
> There is a build error when using a kernel .config file from
> 'kernel test robot' for a different build problem:
>
> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>
> when:
>   CONFIG_GSC=3Dy
>   CONFIG_SERIO_GSCPS2=3Dy
>   CONFIG_SERIAL_8250_GSC=3Dy
>   CONFIG_PCI is not set
>     and hence PCI_LBA is not set.
>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>
> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.

It maybe makes the build error go away, but ...

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/8250/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>
>  config SERIAL_8250_GSC
>  	tristate
> -	depends on SERIAL_8250 && GSC
> +	depends on SERIAL_8250 && GSC && PCI_LBA
>  	default SERIAL_8250

The serial device is on the GSC bus, so if you make it
dependend on the PCI bus it will not be useable on machines
which only have a GSC bus...

We need another patch.
Do you have a link to the build error?

Helge
