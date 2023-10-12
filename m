Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F54CDB46E
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 12:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378247AbjJLMgC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378561AbjJLMf4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 08:35:56 -0400
Received: from postfix2.imaqliq.com (postfix2.imaqliq.com [93.189.151.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A1BE;
        Thu, 12 Oct 2023 05:35:53 -0700 (PDT)
Received: from verse.imaqliq.com (verse.imaqliq.com [93.189.151.95])
        by postfix2.imaqliq.com (Postfix) with ESMTP id E78D01C2943;
        Thu, 12 Oct 2023 15:35:50 +0300 (MSK)
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <20231012103957.p2faputywfgh776x@CAB-WSD-L081021>
References: <20231012103957.p2faputywfgh776x@CAB-WSD-L081021>,
        <OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru>
Subject: Re: [PATCH] tty: serial: meson: hard LOCKUP on crtscts mode
From:   pkrasavin@imaqliq.ru
To:     "Dmitry Rokosov" <ddrokosov@salutedevices.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@sberdevices.ru>,
        <linux-amlogic@lists.infradead.org>
Date:   Thu, 12 Oct 2023 12:35:45 +0000
Message-ID: <OF69FF15CB.37BD077D-ON00258A46.0044809B-00258A46.004530FF@gdc.ru>
X-Mailer: Lotus Domino Web Server Release 12.0.2 November 03, 2022
X-MIMETrack: Serialize by http on verse/com(Release 12.0.2|November 03, 2022) at 10/12/2023
 12:35:45,
        Serialize complete at 10/12/2023 12:35:45,
        Serialize by Router on verse/com(Release 12.0.2|November 03, 2022) at 10/12/2023
 12:35:50
X-KeepSent: 69FF15CB:37BD077D-00258A46:0044809B;
 type=4; name=$KeepSent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 180564 [Oct 12 2023]
X-KLMS-AntiSpam-Version: 6.0.0.2
X-KLMS-AntiSpam-Envelope-From: pkrasavin@imaqliq.ru
X-KLMS-AntiSpam-Rate: 10
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dmarc=fail header.from=imaqliq.ru policy=none;spf=softfail smtp.mailfrom=imaqliq.ru;dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 539 539 807534d9021bfe9ca369c363d15ac993cd93d4d9, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;gdc.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;verse.imaqliq.com:7.1.1;imaqliq.ru:7.1.1;93.189.151.95:7.1.2, FromAlignment: s, {Tracking_dmark_f}, ApMailHostAddress: 93.189.151.95
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/10/12 11:06:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/12 09:47:00 #22170412
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Dmitry,

----- "Dmitry Rokosov" <ddrokosov@salutedevices.com> писал(а): -----

> Please do not use braces where is single statement. In other words:
> 
> 	if (cflags & CRTSCTS) {
> 		if (port->flags & UPF_HARD_FLOW)
> 			val &= ~AML_UART_TWO_WIRE_EN;
> 		else
> 			termios->c_cflag &= ~CRTSCTS;
> 	} else {
> 		val |= AML_UART_TWO_WIRE_EN;
> 	}


thank you for your note, I will provide v2 without braces.

--
Regards,
Pavel.
