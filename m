Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE63BC4361B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFFE224B8
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 13:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgLONgs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 08:36:48 -0500
Received: from smtp.asem.it ([151.1.184.197]:63398 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgLONgl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 08:36:41 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000670418.MSG 
        for <linux-serial@vger.kernel.org>; Tue, 15 Dec 2020 14:35:32 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 14:35:31 +0100
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Tue, 15 Dec 2020 14:35:31 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Ji-Ze Hong <hpeter@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Thread-Topic: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Thread-Index: AQHW0hsm4LBjpzgBaEuoNhCE3PXG1an2iQoAgAGZwAA=
Date:   Tue, 15 Dec 2020 13:35:31 +0000
Message-ID: <ff8f6af85d27448d93d1220545f163be@asem.it>
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com>
In-Reply-To: <X9dr2IvOgPyhsalE@kroah.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F16.5FD8BBA4.0043,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

> >
> >  	switch (chip) {
> >  	case CHIP_ID_F81865:
> > +		chip_name = "F81865";
> > +		break;
> >  	case CHIP_ID_F81866:
> > +		chip_name = "F81866";
> > +		break;
> >  	case CHIP_ID_F81966:
> > +		chip_name = "F81966";
> > +		break;
> >  	case CHIP_ID_F81216AD:
> > +		chip_name = "F81216AD";
> > +		break;
> >  	case CHIP_ID_F81216H:
> > +		chip_name = "F81216H";
> > +		break;
> >  	case CHIP_ID_F81216:
> > +		chip_name = "F81216";
> >  		break;
> >  	default:
> >  		return -ENODEV;
> >  	}
> >
> >  	pdata->pid = chip;
> > +
> > +	pr_info("%s%s%s Fintek %s\n",
> > +		uart->port.dev ? dev_name(uart->port.dev) : "",
> > +		uart->port.dev ? ": " : "",
> > +		uart->port.name,
> > +		chip_name);
> 
> Drivers, if all goes well, should not print anything to the kernel log.
> This isn't ok.
> 
> And even if it was, dev_info() would be the correct thing to do...

Ok, too many information in the driver.

But what do you think about the possibility to introduce
a new additional field, in "serial8250_config" structure,
such as "extra_name" or something like this:

struct serial8250_config {
	const char		*name;
	const char		*extra_name;
	unsigned short	fifo_size;
	unsigned short	tx_loadsz;
	unsigned char	fcr;
	unsigned char	rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
	unsigned int	flags;
};

In this way, if required, each driver can fill this
additional field, for example adding the name of
the particular uart chip or other useful info.

As result, for example, the "uart_report_port" function output
could be something like this:

00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A - Fintek F81216AD
00:02: ttyS3 at I/O 0x2e8 (irq = 11, base_baud = 115200) is a 16550A - Fintek F81216AD

where the "extra_name", if not empty, is printed
at the end of the line.
For practical space reasons, the "extra_name" length
can be limited to 16 chars.

> 
> thanks,
> 
> greg k-h

Thanks and best regards,

Flavio
