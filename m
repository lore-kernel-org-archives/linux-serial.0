Return-Path: <SRS0=yeGP=Y6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2438C5DF65
	for <linux-serial@archiver.kernel.org>; Wed,  6 Nov 2019 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63D62067B
	for <linux-serial@archiver.kernel.org>; Wed,  6 Nov 2019 16:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B6O+Xc9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfKFQdM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:33:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38115 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfKFQdM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Nov 2019 11:33:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so11671996plq.5
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2019 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=00V3WJFb5rO82O7XfR0kzDjatLtK55P+gD7GWSvuxzw=;
        b=B6O+Xc9zGMlVC1YNQXYFKtnVpIBbZxa3Ii/+adCcenjr/PWjvgerHxjCzOc9ccsy5L
         SwdURhnl/eiUtGKg95qOGHzUrLQ8vLCt4H5ZDOO426HPCLfs4749oFrwa5qUdnAz0/An
         V1PfOdjsKeADhGFvSV04CV4W68I8r2+wEcGMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=00V3WJFb5rO82O7XfR0kzDjatLtK55P+gD7GWSvuxzw=;
        b=lCM8wKb1+wsuQxV8yLWS+GW2K6w6CSTVyutq0Kj1+w0Pit45Qb+hRjXkvdMV5w1EPB
         HoCqpIU4Xswp0xW/AjJacoa1GBm+xiAFJ+fXGm2L9NBQ2ZONglrb7pH6eN+3c37PbkDy
         z4AQgj75AXrbE6fu/fKf/hPYHMeLpLh/oii+TuqQfDpWVv5s9/EhPs+2OwnH42I4DOB1
         m9r0KmG04qSfj/C1sCdV8j7Q4PXcELIzBZsYyxVPvnocxytvlVsqx+MPXwbsqF/7Vx+b
         eXQABnJDEf6A41Zoaea8rlSMofGqL/BdEPskJFVdR02mGpxGM8LwKEGSUme5YN3guzun
         KlYQ==
X-Gm-Message-State: APjAAAXBkJx18PIfKrC4+2lf3xlNTjyTO6AE+eNzhigHd0ZVRwQiAJTu
        EuljebcnzOUcxJfup7CgcIOqjP4ld9z9Lg==
X-Google-Smtp-Source: APXvYqwHOEOe6CHxy2Z9R86lbCs0kFodo0CzKU9DU05UAn8fpB29aTVrwpNDhSZ/swcEhvQ1LUhMVw==
X-Received: by 2002:a17:902:521:: with SMTP id 30mr3515849plf.37.1573057991258;
        Wed, 06 Nov 2019 08:33:11 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w62sm26735110pfb.15.2019.11.06.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:33:10 -0800 (PST)
Message-ID: <5dc2f5c6.1c69fb81.3483d.c535@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106121600.GA3105139@kroah.com>
References: <1572947835-30600-1-git-send-email-akashast@codeaurora.org> <20191105171705.GB2815774@kroah.com> <5dc21b1d.1c69fb81.8f924.e6e1@mx.google.com> <20191106121600.GA3105139@kroah.com>
Subject: Re: [PATCH v4 1/2] tty: serial: qcom_geni_serial: IRQ cleanup
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 08:33:09 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Greg KH (2019-11-06 04:16:00)
> On Tue, Nov 05, 2019 at 05:00:12PM -0800, Stephen Boyd wrote:
> > Quoting Greg KH (2019-11-05 09:17:05)
> > > On Tue, Nov 05, 2019 at 03:27:15PM +0530, Akash Asthana wrote:
> > > > @@ -1307,7 +1307,21 @@ static int qcom_geni_serial_probe(struct pla=
tform_device *pdev)
> > > >       port->handle_rx =3D console ? handle_rx_console : handle_rx_u=
art;
> > > >       if (!console)
> > > >               device_create_file(uport->dev, &dev_attr_loopback);
> > > > -     return uart_add_one_port(drv, uport);
> > > > +
> > > > +     ret =3D uart_add_one_port(drv, uport);
> > > > +     if (ret)
> > > > +             return ret;
> > >=20
> > > What is going to remove the sysfs file you just created above (in a r=
acy
> > > way, it's broken and needs to be fixed, but that's a different issue
> > > here...)?
> > >=20
> > >=20
> > > > +
> > > > +     irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
> > > > +     ret =3D devm_request_irq(uport->dev, uport->irq, qcom_geni_se=
rial_isr,
> > > > +                     IRQF_TRIGGER_HIGH, port->name, uport);
> > > > +     if (ret) {
> > > > +             dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret=
);
> > > > +             uart_remove_one_port(drv, uport);
> > > > +             return ret;
> > >=20
> > > Does this remove the sysfs file?
> > >=20
> >=20
> > The loopback file isn't documented. It isn't removed when the driver is
> > removed either. Can we just remove the whole thing? It would be nicer if
> > that sort of thing was supported in the tty layer somehow. Is it?
>=20
> I don't know what that file does, so yes, please delete it :)
>=20
> And as for support in the tty layer itself, if you figure out what it
> does, sure, we can add support if needed.
>=20

I think it may be supported in the tty layer with TIOCM_LOOP already.
Akash, can you confirm?

