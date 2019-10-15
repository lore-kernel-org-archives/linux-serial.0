Return-Path: <SRS0=N/nd=YI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F0ECE58F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Oct 2019 20:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99F920873
	for <linux-serial@archiver.kernel.org>; Tue, 15 Oct 2019 20:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFyIjarC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfJOULG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:11:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36570 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfJOULG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Oct 2019 16:11:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so10113465plk.3
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2019 13:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=gfgRNlSBMuDArnM9WrkHT8iAonunUiE1DNvm69cqm9Q=;
        b=oFyIjarCcM+JvUEnOibvPfV4IgwdSzExgdwb1VNULLZx/A0O/fVxpkuIpfwTMlB2/q
         igdwkc30RR8oOhlHrioHWBkabtYSVpLgOBM1RuRn+vG46hPz/puamZ8KBfNx+iX7X8rg
         fY4p0665JwpIuFNrXy1hoxbE9RgHIMv8g5d1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=gfgRNlSBMuDArnM9WrkHT8iAonunUiE1DNvm69cqm9Q=;
        b=UOqLNe0bLl57JEFIni+YEMQR3JxMw4aPlzK7xVqsk+uofxSJz9cCHO8vK+6V8eQz20
         WJehs3INrgTlDyfgPdI4j9Dy5hiDS0ozgJz0X4EL/X0koNQbUco9+oMeVY4xJ49u0Boz
         0MhKd8wOaKTf8kTU4oyfMd9CDnBwRqkgALaoKJHU0ronG5Qz2qsju9S3ka30D+/uFDYD
         /ZEk36CeFnaCvzIcaIYhMyxE3OOQX3z48W2QDh4NqaW+//a2tsBxx8AGNYKKEiMOqEef
         hiWG1tVhI57yHPbFafXjGmtDAPR6FXPaIsFVSRVjZyZvGXlz8/h7vj2o1ssdsAOmwIHY
         ziYw==
X-Gm-Message-State: APjAAAVLHqoBkg7O/GaYqVUJUo/L52GqLINhlW9FBM/6xaoUMKCSoYiX
        n9ji6BBQFfujTfJ5k2tgQPDcIA==
X-Google-Smtp-Source: APXvYqzVzWLptLblvOAErFGvG3ccz3nn5xkPAnAfkc2zeM2iCnFtoGOf8szncLcImzvlalAtIhCiRQ==
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr13527184pll.241.1571170265257;
        Tue, 15 Oct 2019 13:11:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m68sm24112693pfb.122.2019.10.15.13.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:11:04 -0700 (PDT)
Message-ID: <5da627d8.1c69fb81.82267.2a50@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <010dd569-d172-fdcf-0bfa-8caaf41a4d46@codeaurora.org>
References: <1570700763-17319-1-git-send-email-akashast@codeaurora.org> <5d9f3dfa.1c69fb81.84c4b.30bf@mx.google.com> <010dd569-d172-fdcf-0bfa-8caaf41a4d46@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH V2 1/2] tty: serial: qcom_geni_serial: IRQ cleanup
User-Agent: alot/0.8.1
Date:   Tue, 15 Oct 2019 13:11:03 -0700
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-10-11 00:39:06)
>=20
> On 10/10/2019 7:49 PM, Stephen Boyd wrote:
> > Quoting Akash Asthana (2019-10-10 02:46:03)
> >> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/seria=
l/qcom_geni_serial.c
> >> index 14c6306..5180cd8 100644
> >> --- a/drivers/tty/serial/qcom_geni_serial.c
> >> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >> @@ -1297,11 +1291,21 @@ static int qcom_geni_serial_probe(struct platf=
orm_device *pdev)
> >>          port->rx_fifo_depth =3D DEF_FIFO_DEPTH_WORDS;
> >>          port->tx_fifo_width =3D DEF_FIFO_WIDTH_BITS;
> >>  =20
> >> +       scnprintf(port->name, sizeof(port->name), "qcom_geni_serial_%s=
%d",
> >> +               (uart_console(uport) ? "console" : "uart"), uport->lin=
e);
> > Drop useless parenthesis. Also, it might make more sense to make this a
> > devm_kasprintf() call now.
>=20
> OK
>=20
> >>          irq =3D platform_get_irq(pdev, 0);
> >>          if (irq < 0)
> >>                  return irq;
> >>          uport->irq =3D irq;
> >>  =20
> >> +       irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
> > Is there a reason why we can't always leave the irq enabled and request
> > it later once the uart structure has been fully initialized?
>=20
> According to current design we are requesting IRQ handler in probe, and=20
> we enable and disable it from the startup(port open) and shutdown(port=20
> close) function respectively.
>=20
> We need to call for disable_irq in shutdown function because client has=20
> closed the port and we don't expect any transfer requests after it.
>=20
> >>request it later once the uart structure has been fully initialized?
>=20
>  =C2=A0=C2=A0=C2=A0 Is the ask is to move request irq later in probe afte=
r the uport is=20
> fully initialized?

Yes I'm wondering if we can get rid of the IRQ_NOAUTOEN and
irq_enable/disable bits in here and leave the interrupt enabled all the
time.

