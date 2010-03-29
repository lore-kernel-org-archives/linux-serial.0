From: Xiaofan Chen <xiaofanc@gmail.com>
Subject: Re: Question in regard to generic USB Serial adapters
Date: Mon, 29 Mar 2010 09:17:35 +0800
Message-ID: <a276da401003281817w311c29cek772635357db17a88@mail.gmail.com>
References: <21ed1c371003280630y15f55d7cja28f804b3c97fbf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f188.google.com ([209.85.221.188]:59250 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab0C2BRh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 28 Mar 2010 21:17:37 -0400
Received: by qyk26 with SMTP id 26so596740qyk.19
        for <linux-serial@vger.kernel.org>; Sun, 28 Mar 2010 18:17:35 -0700 (PDT)
In-Reply-To: <21ed1c371003280630y15f55d7cja28f804b3c97fbf7@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Jander <manuel.jander@gmail.com>
Cc: linux-serial@vger.kernel.org

On Sun, Mar 28, 2010 at 9:30 PM, Manuel Jander <manuel.jander@gmail.com> wrote:
> Hi there,
>
> I have an USB Analog to Digital converter which from the USB side
> behaves like a generic USB serial device. I passed its Vendor and
> Device ID as parameters to the generic USB Serial driver, and it
> works. I would like to send a patch so that others can also use this
> ADC device with Linux. Is this here the right place ? Or maybe an USB
> related mailing list ?

>From what I see, people typically submit the patches to the linux-usb
mailing list.
http://vger.kernel.org/vger-lists.html#linux-usb

Eg: http://marc.info/?l=linux-usb&m=126901206619668&w=2

> The device is a "Conrad Electronic" Kit, manufactured by H-Tronic GmbH



-- 
Xiaofan http://mcuee.blogspot.com
