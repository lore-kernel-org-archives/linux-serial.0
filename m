From: William Fagan <willf@commtech-fastcom.com>
Subject: Special Character Detection (SCD)
Date: Thu, 2 May 2013 10:49:54 -0500
Message-ID: <CAGyNnbgWBaqC12TmtbgbDcqZC3twczSNuC+MawTe=JPxSBnMcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:53769 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759734Ab3EBPuQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 May 2013 11:50:16 -0400
Received: by mail-vc0-f176.google.com with SMTP id ib11so613807vcb.35
        for <linux-serial@vger.kernel.org>; Thu, 02 May 2013 08:50:15 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have a 16C550 UART that is registered with the Linux serial driver
and I am hoping someone can give me advice on how to be alerted that
the Special Character Detection (SCD) interrupt has happened.

I'm not sure if there is a way I can configure termios to send the
user-space program a signal, or what the correct route is.

Thank you very much for any help you can give.

Will
