From: Manuel Jander <manuel.jander@gmail.com>
Subject: Question in regard to generic USB Serial adapters
Date: Sun, 28 Mar 2010 15:30:55 +0200
Message-ID: <21ed1c371003280630y15f55d7cja28f804b3c97fbf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:63258 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab0C1Na4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 28 Mar 2010 09:30:56 -0400
Received: by fxm23 with SMTP id 23so180142fxm.21
        for <linux-serial@vger.kernel.org>; Sun, 28 Mar 2010 06:30:55 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi there,

I have an USB Analog to Digital converter which from the USB side
behaves like a generic USB serial device. I passed its Vendor and
Device ID as parameters to the generic USB Serial driver, and it
works. I would like to send a patch so that others can also use this
ADC device with Linux. Is this here the right place ? Or maybe an USB
related mailing list ?

The device is a "Conrad Electronic" Kit, manufactured by H-Tronic GmbH

Best Regards,
Manuel
