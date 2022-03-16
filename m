Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A29C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Mar 2022 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbiCPP2q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbiCPP2p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Mar 2022 11:28:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5938673F5
        for <linux-serial@vger.kernel.org>; Wed, 16 Mar 2022 08:27:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-38-f6wgHKZ6OgqCN6WP2rtJ0g-1; Wed, 16 Mar 2022 15:27:27 +0000
X-MC-Unique: f6wgHKZ6OgqCN6WP2rtJ0g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 16 Mar 2022 15:27:26 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 16 Mar 2022 15:27:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Wander Lairson Costa' <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andre.goddard@gmail.com" <andre.goddard@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "phil@raspberrypi.com" <phil@raspberrypi.com>
Subject: RE: [PATCH v4 1/5] serial/8250: Use fifo in 8250 console driver
Thread-Topic: [PATCH v4 1/5] serial/8250: Use fifo in 8250 console driver
Thread-Index: AQHYOUNg+UxO79+xmUuDTD6Kl8POG6zCIVEg
Date:   Wed, 16 Mar 2022 15:27:26 +0000
Message-ID: <bb5f03ec092f462c9656f224895bb224@AcuMS.aculab.com>
References: <20220316143646.13301-1-wander@redhat.com>
 <20220316143646.13301-2-wander@redhat.com>
In-Reply-To: <20220316143646.13301-2-wander@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Wander Lairson Costa
> Sent: 16 March 2022 14:37
> 
> Note: I am using a small test app + driver located at [0] for the
> problem description. serco is a driver whose write function dispatches
> to the serial controller. sertest is a user-mode app that writes n bytes
> to the serial console using the serco driver.
> 
> While investigating a bug in the RHEL kernel, I noticed that the serial
> console throughput is way below the configured speed of 115200 bps in
> a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> I got 2.5KB/s.
> 
> $ time ./sertest -n 2500 /tmp/serco
> 
> real    0m0.997s
> user    0m0.000s
> sys     0m0.997s
> 
> With the help of the function tracer, I then noticed the serial
> controller was taking around 410us seconds to dispatch one single byte:

Did you verify the baud rate?

Or is there some horrid serial redirection going on.
It is even possible there is a bios smm interrupt
chugging through on another cpu core.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

