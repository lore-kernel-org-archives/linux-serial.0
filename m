Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091ADC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 15:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E070360F38
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 15:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbhKPPew (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbhKPPeu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 10:34:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DCCC061570
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 07:31:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so89791592edd.10
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAUfSK/ACtJxRklSj1UhOrA23mqp41/Z2rb8BGk1uMk=;
        b=B+b1BV7KckgPHVLbWhck1+BGDtbJpoOTHaM3EYJsPp5K/sRWJWr3yfxiCR1UUbo+/Y
         Rqk/R+V5EvMoFqy0LHK2npfpZwzyV7hpUdKvLBRla1TZWDyJHyjwj305psxHTK1/VGRm
         sQQEFh2P3zqkiL7FR8V4ml1+SkMDlG15Udq2cPFL3VTH8L4tvr0n1p6WUHUGu4QtYtLR
         TW6QSe76Jem8fMVIdvWtT6Jw0F0ywGK+augkiyUbJaf5sg+QqKSWGbV1KpkZIHMbYNcm
         8KI5nH32XGhcVRlvL3NDM8TB8e71u5Ma4lBMjbfSSkjL2UjznVinf5/6u/JHYXokdOCG
         RLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAUfSK/ACtJxRklSj1UhOrA23mqp41/Z2rb8BGk1uMk=;
        b=Ey7GQ8jm0uqReU6bw4lCCeezmQh7SF6d1wWMujCkXp3+lWepydzZeFqFYGdbCOv68X
         oJJvXC43urc3YS+YYSHGMpiD0x2O/qTaNHrM6zyjsRkfHOIip/QnN0GwQo0kByqj4Px9
         F54ANTTlrfpIOc66hqufZlvRRkM47ApBnykn1IM654voe/9oOPna8Ka994ZYbg7SqukA
         W+WrY3kHAHmEw7toMHUiPs00kSoLR3mopLXiLhxIxZqAUhcyMwktW35GS9iplXVPQg/b
         pFj00zjKMJOn/pFsy1vrFrzdVDoUF7nLqo6WAe/h1uDcEAAmCIDF46YcAjLkOBWG4i9q
         HBgw==
X-Gm-Message-State: AOAM533uU3Tw+3Q6Ytl0a5LUBP56anHTynhe/I+rS4s4u/tkISpyOpa1
        i5ijdK0eKkkra3BegPsGG4YuxyjZTzNn2enoDdLKMgSMt5M=
X-Google-Smtp-Source: ABdhPJzVb47krpcvkjMFauN2Mpmb+nc7wvhyJUxVF2USNNUNzZ9gd3uZ5LCMjR+obeZyXD1aMFv+GqjmLt75oxI6T7w=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr10946506ejb.377.1637076711656;
 Tue, 16 Nov 2021 07:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20211114183908.444923-1-jay.dolan@accesio.com> <20211114183908.444923-4-jay.dolan@accesio.com>
In-Reply-To: <20211114183908.444923-4-jay.dolan@accesio.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 17:31:10 +0200
Message-ID: <CAHp75Vfp-wuaK+QkQzkuQkxSJpRwQ2s8er47mr2QyEeC46wgwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: 8250_pci: Fix ACCES entries in
 pci_serial_quirks array
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 14, 2021 at 8:40 PM Jay Dolan <jay.dolan@accesio.com> wrote:
>
> Fixes: 78d3820b9bd39028727c6aab7297b63c093db343

Wrong position and wrong format of this tag.

> Fix error in table for PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S that caused it
> and PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4 to be missing their fourth port.

Yeah, I have a fix in my local tree, but... see comment to the cover letter.

> Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 5615ac1d2352..3f792cb44805 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -2302,12 +2302,19 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
>                 .setup      = pci_pericom_setup_four_at_eight,
>         },
>         {
> -               .vendor     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
> +               .vendor     = PCI_VENDOR_ID_ACCESIO,
>                 .device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
>                 .subvendor  = PCI_ANY_ID,
>                 .subdevice  = PCI_ANY_ID,
>                 .setup      = pci_pericom_setup_four_at_eight,
>         },
> +       {
> +               .vendor     = PCI_VENDOR_ID_ACCESIO,
> +               .device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
> +               .subvendor  = PCI_ANY_ID,
> +               .subdevice  = PCI_ANY_ID,
> +               .setup      = pci_pericom_setup_four_at_eight,
> +       },
>         {
>                 .vendor     = PCI_VENDOR_ID_ACCESIO,
>                 .device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
