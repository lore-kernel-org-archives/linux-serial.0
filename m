Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A042C83017
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0655921D46
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgLAIzY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:55:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33613 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgLAIzW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 03:55:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id l11so2660462lfg.0;
        Tue, 01 Dec 2020 00:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eoetxd+qqAcyLnHuOQq9xz3lgBRMqPTNCIsZn7BlTow=;
        b=CrloEC4C4fX0PK81hafRhybHV5IjWJ4r/byi35KM7qm0cWdpXRlierTIGEKt2BQjue
         pvjfBW9y65uhrR90C3ERqygTRwobevfipU6raP5qFuVxJ2MvMgs1zzrW1cRmH+fddsWA
         60YdN3ePMhSa4o0WlRUotflnFbCyAxxAnyuHJKkdtS2VbHAMnAoValKB3OBchYm88qAF
         NxlEcWsX6DxhkGufDMAEqYPuHHGg0x7gQQ1cQ9BrtjDWPLiOjWeLQkuN6864xUEgjDTe
         cEh76FoDk1yQvH1tegfm5jyi1UtYHhiY/qyB1/eWL2x7Vn9ePM8pvUEiXQW0Vja/7AG1
         8+dw==
X-Gm-Message-State: AOAM531xGk+65b3SKIvrKXri1doNPd7dvHdBINiE4JjtzAHDwbGA7tnI
        e/7nvWqliC+6ZeZH84959T50NG2KD1opdg==
X-Google-Smtp-Source: ABdhPJxLCzSdAHeLx4XymxVK0xA/59fNMrQKvCStaSPG1w1jdiRvsXhiblFe3hOduVIORHOF4fNOcg==
X-Received: by 2002:a19:c658:: with SMTP id w85mr706881lff.560.1606812879829;
        Tue, 01 Dec 2020 00:54:39 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id i14sm131927ljj.24.2020.12.01.00.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 00:54:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk1RE-0003Kk-Pm; Tue, 01 Dec 2020 09:55:08 +0100
Date:   Tue, 1 Dec 2020 09:55:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] USB: serial: ftdi_sio: add support for FreeCalypso
 DUART28C adapter
Message-ID: <X8YE7H+hdUY0WS9B@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-6-johan@kernel.org>
 <8f38320e-0f1c-c8a0-208e-2fa689be52f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f38320e-0f1c-c8a0-208e-2fa689be52f0@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 07:54:10AM +0100, Jiri Slaby wrote:
> On 30. 11. 20, 16:37, Johan Hovold wrote:
> > --- a/drivers/usb/serial/ftdi_sio.c
> > +++ b/drivers/usb/serial/ftdi_sio.c
> ...
> > @@ -2386,6 +2393,21 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
> >   	return 0;
> >   }
> >   
> > +/*
> > + * FreeCalypso DUART28C is an FT2232D-based USB to dual UART adapter
> > + * with a special quirk: Channel B RTS and DTR outputs (BDBUS2 and BDBUS4
> > + * on the chip) have been repurposed to drive PWON and RESET controls.
> > + */
> > +static void ftdi_duart28c_setup(struct usb_serial_port *port)
> > +{
> > +	struct usb_serial *serial = port->serial;
> > +	struct usb_interface *intf = serial->interface;
> > +	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
> > +
> > +	if (ifnum == 1)
> > +		tty_port_set_nordy(&port->port, 1);
> 
> So s/1/true, provided the parameter is defined as bool now.

Also here I'm following the convention used for the other port-flag
helper which are used with numerical constants (just about) consistently
throughout the tree. 

Johan
