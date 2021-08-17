Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8352C4338F
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9012760FDA
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 17:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhHQRco (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhHQRcn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 13:32:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F364C061764;
        Tue, 17 Aug 2021 10:32:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa17so249793pjb.1;
        Tue, 17 Aug 2021 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8V0aBEAXUKbzNyPVGyzX8W8ZO8Yk8w8Fat1TgUdEyOM=;
        b=VFWEXu36GOT7GiAwtAR0sqlNFX6kbdt0fnk3299s0fHbfObDFws6Qmmi0dIG+n1YCU
         SkvdrUHzspkab5MnoEl8z9/M9YMXSMfQUYpcTed9Z9oeE/AC619mK8FeS1CibO3Qup0F
         Kf0m9UR9RhGIu8J9XvRfP2GKvxf0sK8EUSxK1NfgaQWN6TuoNcZrT+d7tueuwcfk/AGW
         SePPSNqC0k09gjEBvpwe0R5L6tcD0/UxnuM2lZEpmjokb5b5nZcd7pM64cBia3LyjTqQ
         mRAtlXv6nX/rUHdEiFnmsJi6EK5DrE3yxbO8mn18A+e+fxho5HkxsfJPAemRL5WCXXyB
         y4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8V0aBEAXUKbzNyPVGyzX8W8ZO8Yk8w8Fat1TgUdEyOM=;
        b=Ewim8+BBoZ8fqLe7hHtc7l5i7+gB7RSCRz58blqDJm9G12CO7/NAMV5LThE4Lq8RoN
         seYtxs1TGTqOxSCrVCswtXAPth2oBvOsaGoGiRA3v4cSSMvZ2stsDHOkhgXR+lEx2qqi
         /i0u1PQPDD8t+Y2wjNj9Xs8mN/CADKtKQsb6lWpQ7lRlaKoPipYkSrwpAKb5lysIZm8b
         piHAvEx/QQf2egPSuylusKVX0/AA8HuCVZA6RsLtt8ktHIgjC1zPEFaoOeLY9gdw9re0
         d7IYSGymHR57h0PhHBsfZLIW/Ve86TP1LAUBVp1jZlopHRYLelgNp6WJAmuDKNNDQI0j
         f38g==
X-Gm-Message-State: AOAM531VCThBM6y7tgOahe2aoKBRctUn+iGWo6+Jmofcja/rIY5GNG7S
        W706KR7J57JRf+76mn+LB+XpgkOV1RVPCvYGrM4=
X-Google-Smtp-Source: ABdhPJzT40SDroXs6VsQp6G+dEmQxUKECNAXIOOK47Jr9nFZl1vdZDQsxCddYvk3dxVTjDRV+nwqi8FDJb672Orhu4Y=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr3648635pls.17.1629221529919; Tue, 17 Aug
 2021 10:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210817170057.16783-1-utkarshverma294@gmail.com>
In-Reply-To: <20210817170057.16783-1-utkarshverma294@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Aug 2021 20:31:30 +0300
Message-ID: <CAHp75Vc49M-bdRviytZojK8+vMWJPXA_7zmLx3EvyQNXh8veZA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_exar: Add missing call to pci_free_irq_vectors()
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valmer Huhn <valmer.huhn@concurrent-rt.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 17, 2021 at 8:05 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> Free the pci irq vectors if the call to pci_alloc_irq_vectors() fails
> or if the device is removed.

+Cc: Bjorn

This patch adds no value for all the code. This needs simply better
semantics on allocations (because freeing is happening here
implicitly).
Bjorn, this is an exact example why we need pcim_alloc_irq_vectors().

> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 3ffeedc29c83..38b65d6980f5 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -627,8 +627,10 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>         pci_set_master(pcidev);
>
>         rc = pci_alloc_irq_vectors(pcidev, 1, 1, PCI_IRQ_ALL_TYPES);
> -       if (rc < 0)
> +       if (rc < 0) {
> +               pci_free_irq_vectors(pcidev);
>                 return rc;
> +       }
>
>         memset(&uart, 0, sizeof(uart));
>         uart.port.flags = UPF_SHARE_IRQ | UPF_EXAR_EFR | UPF_FIXED_TYPE | UPF_FIXED_PORT;
> @@ -677,6 +679,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
>
>         if (priv->board->exit)
>                 priv->board->exit(pcidev);
> +       pci_free_irq_vectors(pcidev);
>  }


-- 
With Best Regards,
Andy Shevchenko
